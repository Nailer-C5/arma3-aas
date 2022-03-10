#include "globalDefines.hpp"
if (AAS_Params_AISupportMode == SUPPORT_OFF) exitWith {};
array AAS_WestAIsquads = [];
array AAS_EastAIsquads = [];
//TODO: spawn some code that cleans up these DUI arrays periodically.
array _west_dui_special_track = [];
array _east_dui_special_track = [];

for "_i" from (1) to (AAS_Params_NumberOfAIgroups) do
{
	call compile format
	["
		AAS_WestAIsquad%1 = createGroup west;
		AAS_WestAIsquad%1 setVariable ['AAS_SquadInUse',false];
		AAS_WestAIsquad%1 setVariable ['AAS_SquadInQueue',false];
		AAS_WestAIsquads set [count AAS_WestAIsquads,AAS_WestAIsquad%1];
		AAS_EastAIsquad%1 = createGroup east;
		AAS_EastAIsquad%1 setVariable ['AAS_SquadInUse',false];
		AAS_EastAIsquad%1 setVariable ['AAS_SquadInQueue',false];
		AAS_EastAIsquads set [count AAS_EastAIsquads,AAS_EastAIsquad%1];
	",_i];
};
array AAS_ZoneUnitsQueueAI = [];
array AAS_ZoneQueueTimer = [];
array AAS_ZoneOwnership = [];
array AAS_ZoneDefendingGroups = [];
for "_i" from (0) to ((count saas_baselist) - 1) do
{
	AAS_ZoneUnitsQueueAI set [count AAS_ZoneUnitsQueueAI,[]];
	AAS_ZoneQueueTimer set [count AAS_ZoneQueueTimer,0];
	AAS_ZoneOwnership set [count AAS_ZoneOwnership,BASEA(_i,TEAM)];
	AAS_ZoneDefendingGroups set [count AAS_ZoneDefendingGroups,grpNull];
};
bool AAS_ZoneOwnershipChanged = false;
float AAS_LastTimeZoneOwnershipChanged = time + 30;
array _blueAttackList = [];
array _redAttackList = [];
array _blueDefendList = [];
array _redDefendList = [];
int _mostForwardWestZone = 0;
int _mostForwardEastZone = 0;
array _westUnits = ["B_Soldier_A_F", "B_Soldier_CQ_F", "B_Soldier_GL_F", "B_soldier_AR_F", "B_Soldier_SL_F", "B_Soldier_TL_F", "B_soldier_M_F", "B_soldier_LAT_F", "B_soldier_AT_F", "B_soldier_AA_F", "B_medic_F", "B_soldier_repair_F", "B_soldier_exp_F", "B_engineer_F", "B_crew_F", "B_Pilot_F", "B_helicrew_F", "B_officer_F", "B_spotter_F", "B_sniper_F", "B_recon_F", "B_recon_CQ_F", "B_recon_LAT_F", "B_recon_exp_F", "B_recon_medic_F", "B_recon_TL_F", "B_recon_M_F", "B_recon_JTAC_F", "B_soldier_AAR_F", "B_soldier_AAT_F", "B_soldier_AAA_F", "B_diver_exp_F","B_diver_F"];
array _eastUnits = ["O_Soldier_A_F", "O_Soldier_CQ_F", "O_Soldier_GL_F", "O_Soldier_AR_F", "O_Soldier_SL_F", "O_Soldier_TL_F", "O_soldier_M_F", "O_Soldier_LAT_F", "O_Soldier_AT_F", "O_Soldier_AA_F", "O_medic_F", "O_soldier_repair_F", "O_soldier_exp_F", "O_engineer_F", "O_crew_F", "O_helipilot_F", "O_helicrew_F", "O_officer_F", "O_spotter_F", "O_sniper_F", "O_recon_F", "O_recon_M_F", "O_recon_CQ_F", "O_recon_LAT_F", "O_recon_medic_F", "O_recon_TL_F", "O_soldierU_AR_F", "O_soldierU_AAR_F", "O_soldierU_LAT_F", "O_soldierU_AT_F", "O_soldierU_AAT_F","O_diver_TL_F","O_diver_F"];
int _playerLimit = switch (AAS_Params_AISupportMode) do
{
	case (SUPPORT_LTE4):	{4};
	case (SUPPORT_LTE6):	{6};
	case (SUPPORT_LTE8):	{8};
	case (SUPPORT_LTE10):	{10};
	case (SUPPORT_LTE12):	{12};
	default			{9999};
};
_westAttacking = false;
_eastAttacking = false;
AAS_Params_AttackAndDefend = netObjNull;
switch (AAS_Params_AttackAndDefend) do
{
	case 1: {_westAttacking = true;};
	case 2: {_eastAttacking = true;};
};
if (!(isClass(configFile>>"CfgPatches">>"VFTCAS"))) then
{
	AAS_TCAS = compile preprocessFileLineNumbers "features\VFTCAS\TerrainCollisionAvoidanceSystem.sqf";
};
_isVFAI_SmokeshellAddonPresent = false;
if (isClass(configFile>>"CfgPatches">>"VFAI_Smokeshell")) then {_isVFAI_SmokeshellAddonPresent = true;};
if (!(_isVFAI_SmokeshellAddonPresent)) then
{
	AAS_VFAI_Smokeshell = compile preprocessFileLineNumbers "features\VFAI_Smokeshell\makeAIuseSmokeshells.sqf";
};
_cmdFillQueue =
{
	private["_currentAIgroup","_XRayZone","_nextZone","_mostForwardZone","_team","_defendList","_defender"];
	_currentAIgroup = _this select 0;
	int _XRayZone = _this select 1;
	int _nextZone = _this select 2;
	int _mostForwardZone = _this select 3;//unused
	int _team = _this select 4;
	array _defendList = _this select 5;
	bool _defender = _this select 6;
	if (((!(_currentAIgroup getVariable "AAS_SquadInQueue")) && (!(_currentAIgroup getVariable "AAS_SquadInUse"))) || ((_currentAIgroup getVariable "AAS_SquadInUse") && isNull(leader _currentAIgroup))) then
	{
		private["_currentZone","_spawnFound"];
		_currentAIgroup setVariable ["AAS_SquadInUse",false];
		_currentAIgroup setVariable ["AAS_SquadInQueue",true];
		int _currentZone = _defendList select (random((count _defendList) - 1));
		bool _spawnFound = false;
		while {!(_spawnFound)} do
		{
			private["_spawnAtXRay"];
			bool _spawnAtXRay = false;
			if ((random 100) < 20) then
			{
				private["_zoneHasVehicles"];
				bool _zoneHasVehicles = false;
				_zoneHasVehicles = [_XRayZone] call AAS_fCheckIsUsableVehicleInTheZone;
				if (_zoneHasVehicles) then {_spawnAtXRay = true;};
			};
			if (_spawnAtXRay) then
			{
				private["_content"];
				array _content = AAS_ZoneUnitsQueueAI select _XRayZone;
				_content set [count _content,_currentAIgroup];
				AAS_ZoneUnitsQueueAI set [_XRayZone,_content];
				_spawnFound = true;
			}
			else
			{
				private["_zoneToDefend"];
				_zoneToDefend = false;
				if (_defender) then
				{
					if (_currentZone in _defendList) then {_zoneToDefend = true};
				};
				if ((BASEA(_currentZone,SPAWNTYPE) == SPAWN_XRAY)
					|| (((count (AAS_ZoneUnitsQueueAI select _currentZone)) < 6) && (SRVBASECACHEA(_currentZone,CAPLEVEL) == 100) && (!(_zoneToDefend)))) then// make AI queue length a param
				{
					private["_content"];
					array _content = AAS_ZoneUnitsQueueAI select _currentZone;
					_content set [count _content,_currentAIgroup];
					AAS_ZoneUnitsQueueAI set [_currentZone,_content];
					_spawnFound = true;
				}
				else
				{
					waitUntil
					{
						_currentZone = _currentZone + (_nextZone);
						((BASEA(_currentZone,SPAWNTYPE) == SPAWN_XRAY) || ((BASEA(_currentZone,TEAM) == _team) && (SRVBASECACHEA(_currentZone,CAPLEVEL) == 100)));
					};
				};
			};
		};
	};
};
_fKillAllUnitsInArrayOfGroups =
{
	private["_groups"];
	_groups = _this select 0;
	{
		{
			if (_x != (vehicle _x)) then
			{
				if (alive (vehicle _x)) then {(vehicle _x) setDamage 1;};
			};
			_x setDamage 1;
			sleep 0.1;
		} forEach (units _x);
		sleep 1;
	} forEach _groups;
};
_fUpdateWaypointsOfGroups =
{
	private["_attackList","_currentAIgroup","_marker","_newTargetPosition","_index","_waypoints","_waypointType"];
	_attackList = _this select 0;
	_currentAIgroup = _this select 1;
	if (!(isNull(leader _currentAIgroup))) then
	{
		{
			if (("StaticWeapon" countType [vehicle _x]) > 0) then
			{
				unassignVehicle _x;
				_x action ["EJECT",(vehicle _x)];
				_x stop false;
				sleep 0.1;
			};
		}
		forEach (units _currentAIgroup);
		_marker = format ["zone%1",_attackList select (random((count _attackList) - 1))];
		_newTargetPosition = getMarkerPos _marker;
		_index = currentWaypoint _currentAIgroup;
		_waypoints = _currentAIgroup addWaypoint [_newTargetPosition,_index];
		if ((("Air" countType [vehicle (leader _currentAIgroup)]) > 0) || (("Tank" countType [vehicle (leader _currentAIgroup)]) > 0)) then
		{
			_waypointType = "SAD";//DESTROY,SAD,SENTRY,SENTRY,GUARD
			_waypoints setWaypointType _waypointType;
		}
	};
};
AAS_fCheckIsUsableVehicleInTheZone =
{
	private["_zone","_return","_markerName","_zoneRadius","_allVehicles"];
	_zone = _this select 0;
	_return = false;
	_markerName = format["zone%1",_zone];
	_zoneRadius = (getMarkerSize _markerName) select 0;
	_allVehicles = nearestObjects [getMarkerPos _markerName,["AllVehicles"],(_zoneRadius)];
	{
		if ((alive _x) && (canMove _x) && ((count (crew _x)) == 0) && ((_x isKindOf "Tank")|| (_x isKindOf "Helicopter")|| (_x isKindOf "Ship")|| (_x isKindOf "Bike")|| (_x isKindOf "Car"))) exitWith {_return = true;};
	} forEach _allVehicles;
	_return;
};
[] spawn
{
	private["_updateTime","_i","_unit","_inVehicle","_lastPositionX","_lastPositionY","_unitPosition","_unitPositionX","_unitPositionY","_same","_positionCounter"];
	sleep 1;
	_updateTime = time + 30;
	while {true} do
	{
		if (time > _updateTime) then
		{
			{
				_unit = _x;
				_inVehicle = false;
				if (_unit != (vehicle _unit)) then
				{
					if (("StaticWeapon" countType [vehicle _unit]) > 0) then {_inVehicle = true;};
				};
                        publicVariableServer "spawnPosition";
				if ((alive _unit) && (!(isPlayer _unit)) && (!(_inVehicle))) then
				{
					_unit setVariable ["AAS_LastPositionX",spawnPosition select 0];
					_unit setVariable ["AAS_LastPositionY",spawnPosition select 1];
					_lastPositionX = _unit getVariable "AAS_LastPositionX";
					_lastPositionY = _unit getVariable "AAS_LastPositionY";
					_unitPosition = getPosATL _unit;
					_unitPositionX = _unitPosition select 0;
					_unitPositionY = _unitPosition select 1;
					_same = false;
					if (((abs(_lastPositionX - _unitPositionX)) < 1) && ((abs(_lastPositionY - _unitPositionY)) < 1)) then
					{
						private["_unitInZone","_zoneMarker","_flagPosition","_diameter"];
						_unitInZone = false;
						{
							_zoneMarker = BASENAME(_x);
							_flagPosition = getMarkerPos _zoneMarker;
							_diameter = (getMarkerSize _zoneMarker) select 0;
							if ((_unit distance _flagPosition) < _diameter) exitWith {_unitInZone = true;};
						} forEach curBaseList;
						if (!(_unitInZone)) then {_same = true;};
					};
					if (_same) then
					{
						_positionCounter = (_unit getVariable "AAS_PositionCounter") + 1;
						if (_positionCounter > 10) then
						{
							if (EditorModeSP || (AAS_Params_AIDebugMode != 0)) then
							{
								AAS_CleanedUpAIDebugMarkerID = AAS_CleanedUpAIDebugMarkerID + 1;
								_debugMarker = createMarker [format["AAS_CleanedUpAIDebugMarkerID_%1",AAS_CleanedUpAIDebugMarkerID],getPosATL _unit];
								_debugMarker setMarkerShape "mil_dot";
								_debugMarker setMarkerType "hd_objective";
								_debugMarker setMarkerColor "ColorGreen";
								[_debugMarker] spawn {sleep 30; deleteMarker (_this select 0);};
							};
							_unit setDamage 1;
						}
						else
						{//update counter
							_unit setVariable ["AAS_PositionCounter",_positionCounter];
						};
					}
					else
					{
						_unit setVariable ["AAS_LastPositionX",_unitPositionX];
						_unit setVariable ["AAS_LastPositionY",_unitPositionY];
						// set counter to zero as position is different
						_unit setVariable ["AAS_PositionCounter",0];
					};
				};
			} forEach allUnits;
			_updateTime = time + 5;
		};
		sleep 1;
	};
};

sleep 5;
GameOver = netObjNull;
while {true} do
{
	if (GameOver) exitWith
	{
		[AAS_WestAIsquads] call _fKillAllUnitsInArrayOfGroups;
		[AAS_EastAIsquads] call _fKillAllUnitsInArrayOfGroups;
	};
	if (((playersNumber west) + (playersNumber east)) > _playerLimit) then
	{
		[AAS_WestAIsquads] call _fKillAllUnitsInArrayOfGroups;
		[AAS_EastAIsquads] call _fKillAllUnitsInArrayOfGroups;
		sleep 10;
		_exit = false;
		while {(!(_exit))} do
		{
			sleep 5;
			if (((playersNumber west) + (playersNumber east)) <= _playerLimit) then
			{
				_exit = true;
			};
		};
		if (GameOver) then {_exit = false;};
	};
	_blueAttackList =+ blueAttackList;
	_redAttackList =+ redAttackList;
	if (AAS_ZoneOwnershipChanged && ((time + 30) > AAS_LastTimeZoneOwnershipChanged)) then
	{
		AAS_ZoneOwnershipChanged = false;
		AAS_LastTimeZoneOwnershipChanged = time;
		for "_i" from (0) to ((count saas_baselist) - 1) do
		{
			AAS_ZoneDefendingGroups set [_i,grpNull];
		};
		{
			_currentAIgroup = _x;
			_squadInUse = _currentAIgroup getVariable "AAS_SquadInUse";
			if (isNil "_squadInUse") then {_currentAIgroup setVariable ["AAS_SquadInUse",false];};
			[_blueAttackList,_currentAIgroup] call _fUpdateWaypointsOfGroups;
		} forEach AAS_WestAIsquads;
		{
			_currentAIgroup = _x;
			_squadInUse = _currentAIgroup getVariable "AAS_SquadInUse";
			if (isNil "_squadInUse") then {_currentAIgroup setVariable ["AAS_SquadInUse",false];};
			[_redAttackList,_currentAIgroup] call _fUpdateWaypointsOfGroups;
		} forEach AAS_EastAIsquads;
	};
	_i = 0;
	{
		if (!(isNull(_x))) then
		{
			if (isNull(leader _x)) then
			{
				AAS_ZoneDefendingGroups set [_i,grpNull];
			};
		};
		_i = _i + 1;
	} forEach AAS_ZoneDefendingGroups;
	for "_i" from (1) to ((count saas_baselist) - 1) do
	{
		if ((BASEA(_i,TEAM) == TEAM_BLUE) && (SRVBASECACHEA(_i,CAPLEVEL) == 100)) then {_mostForwardWestZone = _i;};
	};
	// find first east zone with 100%
	for "_i" from (1) to ((count saas_baselist) - 1) do
	{
		if ((BASEA(_i,TEAM) == TEAM_RED) && (SRVBASECACHEA(_i,CAPLEVEL) == 100)) exitWith {_mostForwardEastZone = _i;};
	};
	_blueDefendList = [];
	_redDefendList = [];
	{
		if ((BASEA(_x,TEAM) == TEAM_BLUE) && (SRVBASECACHEA(_x,CAPLEVEL) == 100)) then {_blueDefendList set [count _blueDefendList,_x];};
	} forEach blueDefendList;
	_redDefendList = [];
	{
		if ((BASEA(_x,TEAM) == TEAM_RED) && (SRVBASECACHEA(_x,CAPLEVEL) == 100)) then {_redDefendList set [count _redDefendList,_x];};
	} forEach redDefendList;
	if ((count _blueDefendList) == 0) then
	{
		for "_i" from (1) to ((count saas_baselist) - 1) do
		{
			if ((BASEA(_i,TEAM) == TEAM_BLUE) && (SRVBASECACHEA(_i,CAPLEVEL) == 100)) then {_blueDefendList = [_i];};
		};
	};
	if ((count _redDefendList) == 0) then
	{
		for "_i" from (1) to ((count saas_baselist) - 1) do
		{
			if ((BASEA(_i,TEAM) == TEAM_RED) && (SRVBASECACHEA(_i,CAPLEVEL) == 100)) exitWith {_redDefendList = [_i];};
		};
	};
	_XRayZone = 1;
	_nextZone = -1;
	_mostForwardZone = _mostForwardWestZone;
	_defendList = _blueDefendList;
	_team = TEAM_BLUE;
	_defender = false;
	if (_eastAttacking) then {_defender = true;};
	{
		[_x,_XRayZone,_nextZone,_mostForwardZone,_team,_defendList,_defender] call _cmdFillQueue;
	} forEach AAS_WestAIsquads;
	_XRayZone = (count saas_baselist) - 1;
	_nextZone = 1;
	_mostForwardZone = _mostForwardEastZone;
	_defendList = _redDefendList;
	_team = TEAM_RED;
	_defender = false;
	if (_westAttacking) then {_defender = true;};
	{
		[_x,_XRayZone,_nextZone,_mostForwardZone,_team,_defendList,_defender] call _cmdFillQueue;
	} forEach AAS_EastAIsquads;
	int _currentZone = 0;
	{
		if ((count _x) > 0) then
		{
			array _content = _x;
			_fromerZoneOwner = AAS_ZoneOwnership select _currentZone;
			_currentZoneOwner = BASEA(_currentZone,TEAM);
			if ((_currentZoneOwner != _fromerZoneOwner) || (SRVBASECACHEA(_currentZone,CAPLEVEL) != 100)) then
			{
				AAS_ZoneOwnership set[_currentZone,_currentZoneOwner];
				AAS_ZoneUnitsQueueAI set [_currentZone,[]];
				{
					_x setVariable ["AAS_SquadInQueue",false];
				} forEach _content;
			}// try to spawn units
			else
			{
				private["_unitsArray","_attackList","_defendList","_defender","_attacker"];
				_done = true;
				_spawnOnce = false;
				_defender = false;
				_attacker = false;
				switch (_currentZoneOwner) do
				{
					case TEAM_BLUE:
					{
						_unitsArray = _westUnits;
						_attackList = _blueAttackList;
						_defendList = _blueDefendList;
						if (_westAttacking) then {_attacker = true;};
						if (_eastAttacking) then {_defender = true;_attackList = _blueDefendList;};
					};
					case TEAM_RED:
					{
						_unitsArray = _eastUnits;
						_attackList = _redAttackList;
						_defendList = _redDefendList;
						if (_eastAttacking) then {_attacker = true;};
						if (_westAttacking) then {_defender = true;_attackList = _redDefendList;};
					};
					default
					{
						throw "invalid _currentZoneOwner";
					};
				};
				if (!(((AAS_Params_AISupportMode == SUPPORT_EAST) && (_currentZoneOwner == TEAM_BLUE))
					|| ((AAS_Params_AISupportMode == SUPPORT_WEST) && (_currentZoneOwner == TEAM_RED)))) then
				{
					_sizeUnitsArray = count _unitsArray;
					_xRaySpawn = ((BASEA(_currentZone,SPAWNTYPE)) == SPAWN_XRAY);
					if (_xRaySpawn) then {_done = false;};
					if (time > (AAS_ZoneQueueTimer select _currentZone)) then
					{
						AAS_ZoneQueueTimer set [_currentZone,(time + 10)];
						_spawnOnce = true;
					};
					waitUntil
					{
						if ((!(_done)) || (_spawnOnce)) then
						{
							_currentAIgroup = _content select 0;
							_content = _content - [_currentAIgroup];
							AAS_ZoneUnitsQueueAI set[_currentZone,_content];
							spawnPosition = getPos (flags select _currentZone);
							for "_j" from (1) to (AAS_Params_NumberOfAIunitsPerGroup) do
							{
								_unitType = _unitsArray select (round (random(_sizeUnitsArray - 1)));
								if (_xRaySpawn) then
								{
									spawnPosition =
									[
										((spawnPosition select 0) + (random 50) - (random 50)),
										((spawnPosition select 1) + (random 50) - (random 50)),
										spawnPosition select 2
									];
								};
								//{deleteWaypoint _x;} forEach (waypoints _group);
								_markerName = format["zone%1",_currentZone];
								_vehicleSeekingDistance = (getMarkerSize _markerName) select 0;
								_currentAIgroup setVariable ["UPSMON_VehicleSeekingDistance",_vehicleSeekingDistance];
								_unit = _currentAIgroup createUnit [_unitType,spawnPosition,[],0,"NONE"];
								[_unit] joinSilent _currentAIgroup;
								_unit setVariable ["AAS_LastPositionX",spawnPosition select 0];
								_unit setVariable ["AAS_LastPositionY",spawnPosition select 1];
								_unit setVariable ["AAS_PositionCounter",0];
								if (!(_isVFAI_SmokeshellAddonPresent)) then
								{
									_unit addEventHandler ["hit",{_this spawn AAS_VFAI_Smokeshell;}];
								};
								sleep 0.1;
								if (((getPosATL _unit) select 2) > 2) then {_unit setPos [(getPos _unit) select 0,(getPos _unit) select 1,0.3];};

								//NAILER PUT AI ON DUI SQUAD RADAR
								if (side _unit == west) then {
								  _west_dui_special_track pushBackUnique _unit;
								  missionNamespace setVariable ["west_diwako_dui_special_track", _west_dui_special_track, true];
								};
								if (side _unit == east) then {
								  _east_dui_special_track pushBackUnique _unit;
								  missionNamespace setVariable ["east_diwako_dui_special_track", _east_dui_special_track, true];
								};
							};
							_currentAIgroup setBehaviour "AWARE";//STEALTH
							_currentAIgroup setSpeedMode "FULL";//NORMAL
							{_x setUnitPos "AUTO";} forEach (units _currentAIgroup);
							_defendingGroup = AAS_ZoneDefendingGroups select _currentZone;
							if ((!(_xRaySpawn)) && (!(_attacker)) && ((random 100) < 50) && (isNull(_defendingGroup)) && (_currentZone in _defendList)) then
							{
								_marker = format ["zone%1",_currentZone];
								AAS_ZoneDefendingGroups set [_currentZone,_currentAIgroup];
								[(leader _currentAIgroup),_marker,"fortify","noslow","showmarker","delete:",10,"notrigger"] spawn UPSMON;
								
							}
							else
							{
								_marker = format ["zone%1",_attackList select (random((count _attackList) - 1))];
								if (((!(_xRaySpawn)) && ((random 100) < 40)) || ((_xRaySpawn) && ((random 100) < 20))) then
								{
									sleep 0.1;
									_currentAIgroup move (getMarkerPos _marker);
									{
										_x addEventHandler ["killed","[_this select 0] spawn {sleep 10; deleteVehicle (_this select 0);};"];
									} forEach (units _currentAIgroup);
								}// group to move to enemy zones
								else
								{
									
									[(leader _currentAIgroup),_marker,"move","noslow","nowait","reinforcement","showmarker","delete:",10,"notrigger"] spawn UPSMON;
								};
							};
							_currentAIgroup setVariable ["AAS_SquadInUse",true];
							_currentAIgroup setVariable ["AAS_SquadInQueue",false];
						};
						sleep 0.01;
						if ((count _content) == 0) then {_done = true;};
						(_done);
					};
				};
			};
		};
		_currentZone = _currentZone + 1;
	} forEach AAS_ZoneUnitsQueueAI;
	sleep 0.1;
};