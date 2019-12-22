#include "globalDefines.hpp"
obj _vec = _this select 0;
int _rank = _this select 1;

clearWeaponCargo _vec;
clearMagazineCargo _vec;
clearBackpackCargo _vec;
clearItemCargo _vec;
clearWeaponcargoglobal _vec;
clearMagazinecargoglobal _vec;
clearBackpackcargoglobal _vec;
clearItemcargoglobal _vec;

if (isDedicated) exitWith {};
waitUntil {!isNull player};
waitUntil {player == player};
waitUntil {(local player)};	

RULES_initialised = netObjNull;
waitUntil {RULES_initialised};
_vec allowDamage RULES_allowDamageToAmmoCrates;
int _qlctr=0;

//object addAction [title, script, arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection, memoryPoint]

//NAILER[C5] - REMOVE CLASS SELECT OPTIONS FOR NOW
//for "_qlctr" from 0 to ((count RULES_classList) - 1) do {
//	array _thisClass = RULES_classList select _qlctr;
//	_vec addAction [_thisClass select CL_NAME, "doQuickLoadout.sqf", [true, _qlctr], 20-_qlctr, false, true, "", "true", 2];
//};

if (RULES_canCustomiseLoadout) then {
	_vec addAction ["<t color='#ff1111'>Save loadout</t>", "doQuickLoadout.sqf", [true,LOADOUT_SAVE], 3, false, true, "", "true", 2];
	_vec addAction ["<t color='#0099ee'>Load Gear</t>", "fnc_loadGear.sqf", [true,LOADOUT_CUSTOM], 4, false, true, "", "true", 2];
	//NAILER[C5] - use virtual arsenal
	_vec addAction["Virtual Arsenal", "VirtualArsenal.sqf", nil, 6, true, true, "", "true", 2];
};

if (RULES_canHealAtArmoury) then {
	_vec addAction ["<t color='#ff8822'>Heal Thyself</t>", "actionMenuHandler.sqf", ["SELF_HEAL"], 2, false, true, "", "true", 2];
};

if (AAS_Params_GoToSquadLeader == 1) then {
	_vec addAction ["<t color='#ffff22'>Teleport to Squad Leader</t>", "SquadLeaderTeleport.sqf", nil, 2, false, true, "", "true", 2];
};

if (AAS_Params_GoToSquadLeader == 2) then {
	_vec addAction ["<t color='#ffff22'>Parachute on Squad Leader</t>", "SquadLeaderParachute.sqf", nil, 2, false, true, "", "true", 2];
};

if (AAS_Params_SASHALO == 1) then {
	_vec addAction ["<t color='#ffcc66'>HALO</t>", "actionMenuHandler.sqf", ["HALO"], 9, false, true, "", "true", 2];
};

//NAILER[C5] - REMOVE TEAM SELECT OPTION 
//_vec addAction ["<t color='#ffcc66'>Team Select</t>", "actionMenuHandler.sqf", ["SELECT_TEAM"], 10, false, true, "", ,2];

//--------------------------------- Add the detailed crate contents -------------------
