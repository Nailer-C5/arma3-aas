//#include "globalDefines.hpp"
//#include "mapname.hpp"

#define DEFAULT_FREPAIR_VER "1P"

#define DEFAULT_FIELDREPAIR_EACH_PART_TIME 30
#define DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME 40
#define DEFAULT_FULLREPAIR_LENGTH 25
#define DEFAULT_REPAIR_TRUCK_USES 15

zlt_repair_loop = [_this, 0, false] call BIS_fnc_param;

/*
if (isServer) then {
	[] spawn {
		_first = true;
		while {_first or zlt_repair_loop} do {
			{ 
				if (getRepairCargo _x > 0) then {
					_x setRepairCargo 0;
					_x setVariable ["zlt_repair_cargo", 1, true]; 
				};
			} foreach vehicles;
			_first = false;
			sleep 26.1;
		};
	};
};
*/

zlt_fnc_partrepair = {
	private "_veh";
	_veh = [_this, 0] call BIS_fnc_param;
	if (isNil {_veh} ) exitWith {}; 
	{
		_dmg = (_veh getHitPointDamage _x);
		if (not isNil {_dmg}) then {
			if ( _dmg > 0.64 ) then {
				if (_x in zlt_hardRepairParts) then {
					_veh setHitPointDamage [_x,0.64];
				} else {
					_veh setHitPointDamage [_x,0];
				};
			};
		};
	} foreach zlt_repair_hps; 
};

zlt_fnc_fullrepair = {
	private "_veh";
	_veh = [_this, 0] call BIS_fnc_param;
	_veh setDamage 0;
};

zlt_repair_hps = ["HitLFWheel","HitLBWheel","HitLMWheel","HitLF2Wheel","HitRFWheel","HitRBWheel","HitRMWheel","HitRF2Wheel" ,"HitEngine", "HitLTrack","HitRTrack"] + ["HitFuel","HitAvionics","HitVRotor","HitHRotor", "HitTurret", "HitGun"];
zlt_hardRepairParts = ["HitEngine", "HitLTrack","HitRTrack"] + ["HitFuel","HitAvionics","HitHRotor", "HitTurret", "HitGun"];

if (isDedicated) exitWith {};
waitUntil {player == player};
zlt_mutexAction = false;

zlt_fnc_vehicledamaged = {
	private ["_veh","_vehtype","_flag"];
	_veh =  [_this, 0] call BIS_fnc_param;
	if (isNil {_veh}) exitWith {false};
	_vehtype = typeOf _veh;
	_flag = false;
	if (true) then {
		{
			_cdmg = _veh getHitPointDamage (_x);
			if (not isNil {_cdmg} ) then {
				if (_cdmg > 0.64) exitWith {_flag = true};
			};
		}  forEach zlt_repair_hps;
	};
	_flag;
};



zlt_frpr_getPartsRepairTime = {
	private ["_veh","_vehtype","_flag"];
	_veh =  [_this, 0] call BIS_fnc_param;
	if (isNil {_veh}) exitWith {1};
	_rprTime = 0;
	{
		_cdmg = _veh getHitPointDamage (_x);
		if (not isNil {_cdmg} ) then {
			diag_log str ["REPAIR ", _x, _cdmg];
			if (_cdmg > 0.64) exitWith {_rprTime = _rprTime + ( if (_x in zlt_hardRepairParts) then {DEFAULT_FIELDREPAIR_EACH_HARDPART_TIME} else {DEFAULT_FIELDREPAIR_EACH_PART_TIME}); };
		};
	}  forEach zlt_repair_hps;
	_rprTime;
};

zlt_fnc_notify = {
	 [ format["<t size='0.75' color='#ffff00'>%1</t>",_this], 0,1,5,0,0,301] spawn bis_fnc_dynamicText;
};

zlt_prc_repairvehicle = {
	private ["_veh"];
	_veh = (nearestObjects [player,["LandVehicle","Air","Ship"], 7]) select 0;
	if (isNil {_veh}) exitWith {};
	if (zlt_mutexAction) exitWith {
		localize "STR_AAS_Another_action" call zlt_fnc_notify;
	};
	if (not alive player or (player distance _veh) > 7 or (vehicle player != player) or speed _veh > 3) exitWith {localize "STR_AAS_Bad_conditions" call zlt_fnc_notify;}; 
	
	_repairFinished = false;
	zlt_mutexAction = true;  
	_lastPlayerState = animationState player;
	player playActionNow "medicStartRightSide";
	sleep 0.5;
	_maxlength = _veh getVariable["zlt_longrepair",[_veh] call zlt_frpr_getPartsRepairTime];
	_vehname = getText ( configFile >> "CfgVehicles" >> typeOf(_veh) >> "displayName");
	_length = _maxlength;
	_cycle = 0;
	while {alive player and (player distance _veh) < 7 and (vehicle player == player) and speed _veh < 3 and not _repairFinished and zlt_mutexAction and (_cycle < 3 or (["medic",animationState player] call BIS_fnc_inString))} do {		
	 
		(format[localize "STR_AAS_will_be_repaired", _length, _vehname] ) call zlt_fnc_notify;
		if (_length <= 0) then {_repairFinished = true;};
		_length = _length - 1;
		sleep 1;
		 
		_cycle = _cycle + 1;
	};
	if (_repairFinished) then {
		 
		localize "STR_AAS_Repair_finished" call zlt_fnc_notify;
		[_veh,"zlt_fnc_partrepair", _veh] call bis_fnc_MP;
		 
		_veh setVariable["zlt_longrepair",nil, true];
		_veh setVariable["zlt_longrepair_times", (_veh getVariable ["zlt_longrepair_times",0]) + 1 , true ];
	} else {
		localize "STR_AAS_Repair_interrupted" call zlt_fnc_notify;
		_veh setVariable["zlt_longrepair",_length, true];
	};
	zlt_mutexAction = false;  
	player playActionNow "medicstop";
};


zlt_fnc_repair_cond = {
	private ["_veh","_ret"];
	_ret = false;
	_veh = (nearestObjects [player,["LandVehicle","Air","Ship"], 7]) select 0;
	if (isNil {_veh}) exitWith {_ret};
	_dmged = _veh call zlt_fnc_vehicledamaged;
	_repairman=false;
	if (playerclass!=100) then
	{
		_repairman= (RULES_classList select playerclass select 0)== localize "STR_AAS_repairman";//return true or false
	};
	_ret = (alive player and {(player distance _veh) <= 7} and {(vehicle player == player)} and {speed _veh < 3} and {not zlt_mutexAction} and {_dmged} and {alive _veh}and {_repairman});
	_ret;
};



zlt_fnc_heavyRepair = {

	_caller = player;
	_truck = vehicle _caller;
	_veh = cursorTarget;
	if (isNil "_veh" or {isNull _truck} or {isNull _veh}) exitWith {	systemchat 'ERROR: u must be in truck (driver)'; false};
	
	
	_dmg=0;
	_allHp= (getAllHitPointsDamage _veh) select 2;
	{ _dmg= _dmg+ _x} forEach _allHp;
	_dmg= _dmg/ count _allHp;
		
	if (zlt_mutexAction) exitWith {
		localize "STR_AAS_Another_action" call zlt_fnc_notify;
	}; 
	
	if (not alive player or vehicle player == player or speed _veh > 3 or _veh distance _truck > 15 ) exitWith 
	{
		systemchat 'Bad conditions'; 
		"STR_AAS_Bad_conditions" call zlt_fnc_notify;
		localize "STR_AAS_Bad_conditions" call zlt_fnc_notify;
	};
	
	_repairFinished = false;
	zlt_mutexAction = true;	
	_maxlength = _veh getVariable["zlt_longrepairTruck",DEFAULT_FULLREPAIR_LENGTH];
	_vehname = getText ( configFile >> "CfgVehicles" >> typeOf(_veh) >> "displayName");
	_length = _maxlength;
	while { alive player and alive _truck and alive _veh and vehicle _caller != _caller and speed _veh <= 3 and not _repairFinished and zlt_mutexAction and _veh distance _truck <= 15 } do {			
		(format[localize "STR_AAS_will_be_repaired", _length, _vehname] ) call zlt_fnc_notify;
		if (_length <= 0) then {_repairFinished = true;};
		_length = _length - 1;
		sleep 1;
	};
	
	if (_repairFinished) then {
		localize "STR_AAS_Repair_finished" call zlt_fnc_notify;
		[_veh,"zlt_fnc_fullrepair", _veh] call bis_fnc_MP;
		_truck setVariable ["zlt_repair_cargo", ( (_truck getVariable ["zlt_repair_cargo", 0] )- (1 / DEFAULT_REPAIR_TRUCK_USES) ), true] ;
		
		_veh setVariable["zlt_longrepairTruck", nil, true];
		_veh setVariable["zlt_fullrepair_times", (_veh getVariable ["zlt_fullrepair_times",0]) + 1 , true ];
	} else {
		localize "STR_AAS_Repair_interrupted" call zlt_fnc_notify;
		_veh setVariable["zlt_longrepairTruck",_length, true];
	};
	zlt_mutexAction = false;  	
};

zlt_pushapc = {
	private ["_veh","_unit"];
	_veh = vehicle player;

	if (zlt_mutexAction) exitWith {};
	zlt_mutexAction = true;
	sleep 1.;
	_spd = 3;
	_dir = direction _veh;
	_veh setVelocity [(sin _dir)*_spd, (cos _dir)*_spd, 0];  
	zlt_mutexAction = false;
};


// obsolete
zlt_fnc_heavyRepairCOnd = {
	_truck = vehicle player;
	_veh = cursorTarget;
	if (isNull _truck or isNull _veh) exitWith {false};
	_isRepair = _truck getVariable ["zlt_repair_cargo", -1];
	if (_isRepair == -1) exitWith {false};
	
	_res = _veh distance _truck <= 15 and {player == (driver _truck)} and {(_veh isKindOf "LandVehicle" or _veh isKindOf "Ship" or _veh isKindOf "Air")} and {alive _truck} and {alive player} and {alive _veh} and {not zlt_mutexAction} and {speed _veh <= 3} and {(damage _veh != 0)};
	_res;

};

zlt_fnc_heavyRepairCOnd2= {
	_truck = vehicle player;
	_veh = cursorTarget;

	
	_res= (player getUnitTrait 'engineer' and player == (driver _truck) and _truck distance _veh <= 30 and _truck getVariable ['zlt_repair_cargo', -1] != -1 and alive _veh and 
	(_veh isKindOf 'LandVehicle' or _veh isKindOf 'Ship' or _veh isKindOf 'Air') and !zlt_mutexAction and speed _veh <= 3 ); // and damage _veh > 0
	_res;
	//true;
};

if (isNil "zlt_cancelActionId") then {
	zlt_cancelActionId = player addAction[localize "STR_AAS_Cancel_action", {zlt_mutexAction = false}, [], 10, false, true, '',' zlt_mutexAction  '];
	player addAction[localize "STR_AAS_Field_repair", zlt_prc_repairvehicle, [], -1, false, true, '','[] call zlt_fnc_repair_cond'];
	//player addAction[localize "STR_AAS_Full_repair", zlt_fnc_heavyRepair, [], -1, false, true, '','_truck=(vehicle player);_truck getVariable ["zlt_repair_cargo", -1] != -1 and {alive cursorTarget} and {_truck distance cursorTarget <= 15} and {(cursorTarget isKindOf "LandVehicle" or cursorTarget isKindOf "Ship" or cursorTarget isKindOf "Air")} and {not zlt_mutexAction} and {speed cursorTarget <= 3} and {(damage cursorTarget != 0)}'];
	
	player addAction[ localize "STR_AAS_Full_repair", zlt_fnc_heavyRepair, -1, 0, true, true, '',"call zlt_fnc_heavyRepairCOnd2"];
	
	player addAction[localize "STR_AAS_Push_vehicle",zlt_pushapc,[],5,false,true,"","canMove (vehicle player) and ((vehicle player) isKindOf 'Wheeled_APC_F') and player == driver (vehicle player) and surfaceIsWater getpos (vehicle player)  and abs(speed (vehicle player) ) < 3 and not zlt_mutexAction"];   
	player addAction [localize "STR_AAS_Domkrat", {cursorObject setVelocity ( (vectorDir player) vectorMultiply 5)}, 0, 0, true, false, "","_CO = cursorObject; vectorup _CO select 2 < 0.5 and _CO iskindOf 'LandVehicle' and player distance _CO < 5 and player getUnitTrait 'engineer' "];

};

	player addEventHandler ["Respawn", {
	zlt_cancelActionId = player addAction[localize "STR_AAS_Cancel_action", {zlt_mutexAction = false}, [], 10, false, true, '',' zlt_mutexAction  '];	
	player addAction[localize "STR_AAS_Field_repair", zlt_prc_repairvehicle, [], -1, false, true, '','[] call zlt_fnc_repair_cond'];
	//player addAction[localize "STR_AAS_Full_repair", zlt_fnc_heavyRepair, [], -1, false, true, '','_truck=(vehicle player);_truck getVariable ["zlt_repair_cargo", -1] != -1 and {alive cursorTarget} and {_truck distance cursorTarget <= 15} and {(cursorTarget isKindOf "LandVehicle" or cursorTarget isKindOf "Ship" or cursorTarget isKindOf "Air")} and {not zlt_mutexAction} and {speed cursorTarget <= 3} and {(damage cursorTarget != 0)}'];
	
	player addAction[ localize "STR_AAS_Full_repair", zlt_fnc_heavyRepair, -1, 0, true, true, '',"call zlt_fnc_heavyRepairCOnd2"];
	
	player addAction [localize "STR_AAS_Domkrat", {cursorObject setVelocity ( (vectorDir player) vectorMultiply 5)}, 0, 0, true, false, "","_CO = cursorObject; vectorup _CO select 2 < 0.5 and _CO iskindOf 'LandVehicle' and player distance _CO < 5 and player getUnitTrait 'engineer' "];

	//player addAction[localize "STR_AAS_Push_vehicle",zlt_pushapc,[],5,false,true,"","canMove (vehicle player) and ((vehicle player) isKindOf 'Wheeled_APC_F') and player == driver (vehicle player) and surfaceIsWater getpos (vehicle player)  and abs(speed (vehicle player) ) < 3 and not zlt_mutexAction"];   
}];
