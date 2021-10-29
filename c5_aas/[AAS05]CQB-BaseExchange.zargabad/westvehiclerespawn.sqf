#include "globalDefines.hpp"
#define MAX_DAMAGE 0.9
RULES_initialised = netObjNull;
waitUntil { RULES_initialised };
private [ "_respawnDelay", "_theVehicle", "_startDirection", "_startPos", "_typ", "_lastUsedTime", "_abandoned", "_threadUID" ];

fn_westtexture =
{
	_unit = _this select 0;
	_texture = _this select 1;
	_unit setobjecttexture _texture;
};

if( isServer ) then
	{
	int _respawnDelay = _this select 1;
	obj _theVehicle   = _this select 0;
	_startDirection = getDir _theVehicle;
	pos _startPos   = getPos _theVehicle;
	_typ            = typeOf _theVehicle;
	bool _abandoned = false;
	float _lastUsedTime = time;
	int _threadUID = round (random 10000);
	DEBUG_LOG format["SRV vehicleRespawn.sqf (UID %1) : init",_threadUID];
	if( RULES_overrideVehicleSpawnTimes ) then
		{
		_respawnDelay = RULES_vehicleRespawnDelay;
		if( _theVehicle isKindOf "Tank"       ) then { _respawnDelay = RULES_tankRespawnDelay;    };
		if( _theVehicle isKindOf "Helicopter" ) then { _respawnDelay = RULES_chopperRespawnDelay; };
		if( _theVehicle isKindOf "Plane"      ) then { _respawnDelay = RULES_planeRespawnDelay;   };
		};
	while { true } do
		{
		sleep 5 + (random 10);
		if( (_theVehicle distance _startPos) < 20 ) then { _lastUsedTime = time; };	
		if ( ({alive _x} count (crew _theVehicle)) > 0) then { _lastUsedTime = time }; 
		if( (_theVehicle distance _startPos) < 10 and !(canMove _theVehicle) ) then
			{
			_abandoned = true;
			};
		if( (time-_lastUsedTime) > RULES_abandonedVehicleTimeLimit ) then
			{
			DEBUG_LOG format["SRV vehicleRespawn.sqf (UID %1) : Vehicle %2, _lastUsedTime = %3, time =%4, abandoned",_threadUID, _theVehicle,round _lastUsedTime,round time];
			_abandoned = true;
			};
		if( ((damage _theVehicle) > MAX_DAMAGE) or _abandoned ) then
			{
			DEBUG_LOG format["SRV vehicleRespawn.sqf (UID %1) : Vehicle %2, damage = %3, canMove = %4, _abandoned = %5, deleting vehicle",_threadUID, _theVehicle, damage _theVehicle,canMove _theVehicle,_abandoned];
  			if ({alive _x} count (crew _theVehicle) > 0) exitWith {};
			sleep (_respawnDelay / 2);
			if ({alive _x} count (crew _theVehicle) > 0) exitWith {};
			deleteVehicle _theVehicle;
			_theVehicle = objNull;
			sleep (_respawnDelay / 2);					
			_theVehicle = _typ createVehicle _startPos;
			_theVehicle setPos _startPos;                                   
			_theVehicle setDir _startDirection;
			[[_theVehicle,[0,'pictures\ausarma_logo.jpg']], "fn_westtexture",nil,false] spawn BIS_fnc_MP;
			AAS_PublicAddActionsAndEH = _theVehicle;
			publicVariable "AAS_PublicAddActionsAndEH";
			if (!(isDedicated)) then
			{
				_theVehicle disableTIEquipment true;
			};
			if ((_theVehicle isKindOf "Helicopter") || ((typeOf _theVehicle) == "B_MH9_F")) then {_theVehicle addEventHandler ["GetIn","_this spawn AAS_fnc_Lift;"];};
			DEBUG_LOG format["SRV vehicleRespawn.sqf (UID %1) : Created new vehicle %2",_threadUID, _theVehicle];
			_abandoned = false;
			_lastUsedTime = time;
			};
				
		};
		
	};
	