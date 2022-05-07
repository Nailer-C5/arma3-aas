

//diag_log "C5_DEBUG: Now entering populateammocrate.sqf";


//diag_log "C5_DEBUG: populateammocrate.sqf about to exit if is dedicated";
if (isDedicated) exitWith {};
//diag_log "C5_DEBUG: populateammocrate.sqf about to wait until not isnull player";
waitUntil {!isNull player};
//diag_log "C5_DEBUG: populateammocrate.sqf about to wait until player equals player";
waitUntil {player == player};
//diag_log "C5_DEBUG: populateammocrate.sqf about to wait until local player";
waitUntil {(local player)};


_vec = _this select 0;


clearWeaponCargo _vec;
clearMagazineCargo _vec;
clearBackpackCargo _vec;
clearItemCargo _vec;
clearWeaponcargoglobal _vec;
clearMagazinecargoglobal _vec;
clearBackpackcargoglobal _vec;
clearItemcargoglobal _vec;



	

//diag_log "C5_DEBUG: populateammocrate.sqf done wating - moving on to actions";

_vec allowDamage false;
//int _qlctr=0;

//object addAction [title, script, arguments, priority, showWindow, hideOnUse, shortcut, condition, radius, unconscious, selection, memoryPoint]

//NAILER[C5] - REMOVE CLASS SELECT OPTIONS FOR NOW
//for "_qlctr" from 0 to ((count RULES_classList) - 1) do {
//	array _thisClass = RULES_classList select _qlctr;
//	_vec addAction [_thisClass select CL_NAME, "doQuickLoadout.sqf", [true, _qlctr], 20-_qlctr, false, true, "", "true", 2];
//};



_vec addAction["Virtual Arsenal", "VirtualArsenal.sqf", nil, 6, true, true, "", "true", 2];

_vec addAction["<t color='#ff9900'>Recruit Infantry</t>", "bon_recruit_units\open_dialog.sqf", nil, 6, true, true, "", "true", 2];

//_vec addAction["Spawn a Go Cart (No Limit)", "mopit_vehicles\SpawnKart.sqf", nil, 6, true, true, "", "true", 2];

//_vec addAction["Spawn ATV (No Limit)", "mopit_vehicles\SpawnATV.sqf", nil, 6, true, true, "", "true", 2];

//_vec addAction["Spawn a Buggy HMG (LIMIT 3)", "mopit_vehicles\SpawnBuggyHMG.sqf", nil, 6, true, true, "", "true", 2];              

//_vec addAction["Spawn an APC (LIMIT 1)", "mopit_vehicles\SpawnAPC.sqf", nil, 6, true, true, "", "true", 2];					

//_vec addAction["Spawn a Tank (LIMIT 1)", "mopit_vehicles\SpawnTank.sqf", nil, 6, true, true, "", "true", 2];

//_vec addAction["Spawn AAA Tank (LIMIT 1)", "mopit_vehicles\SpawnAAA.sqf", nil, 6, true, true, "", "true", 2];

//_vec addAction["Spawn an Armored Transport Helicopter (LIMIT 1)", "mopit_vehicles\SpawnTHelicopter.sqf", nil, 6, true, true, "", "true", 2];

//_vec addAction["Spawn an Attack Helicopter (LIMIT 1)", "mopit_vehicles\SpawnAHelicopter.sqf", nil, 6, true, true, "", "true", 2];

//_vec addAction["Spawn an Attack Plane (LIMIT1)", "mopit_vehicles\SpawnAttackPlane.sqf", nil, 6, true, true, "", "true", 2];

