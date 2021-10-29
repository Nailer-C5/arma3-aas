call arsenalItems;

//Create players virtual ammobox if it doesn't already exist
_playerAmmoBox = nearestObject [[0,0,0], "B_supplyCrate_F"];
if (isNull _playerAmmoBox) then { _playerAmmoBox = "B_supplyCrate_F" createVehicleLocal [0,0,0]; };

//Remove any default items
[_playerAmmoBox, _playerAmmoBox call BIS_fnc_getVirtualWeaponCargo]		call BIS_fnc_removeVirtualWeaponCargo;
[_playerAmmoBox, _playerAmmoBox call BIS_fnc_getVirtualMagazineCargo]	call BIS_fnc_removeVirtualMagazineCargo;
[_playerAmmoBox, _playerAmmoBox call BIS_fnc_getVirtualItemCargo]		call BIS_fnc_removeVirtualItemCargo;
[_playerAmmoBox, _playerAmmoBox call BIS_fnc_getVirtualBackpackCargo]	call BIS_fnc_removeVirtualBackpackCargo;
sleep 1;

//Items for west players...
if (side player==west) then {
   [_playerAmmoBox, west_uniforms, false, false] call BIS_fnc_addVirtualItemCargo;
   [_playerAmmoBox, west_vests, false, false]    call BIS_fnc_addVirtualItemCargo;
   [_playerAmmoBox, west_helmets, false, false]  call BIS_fnc_addVirtualItemCargo;
   [_playerAmmoBox, west_glasses, false, false]  call BIS_fnc_addVirtualItemCargo;
   [_playerAmmoBox, west_packs, false, false]    call BIS_fnc_addVirtualBackpackCargo;
};

//Items for east players...
if (side player==east) then {
   [_playerAmmoBox, east_uniforms, false, false] call BIS_fnc_addVirtualItemCargo; 
   [_playerAmmoBox, east_vests, false, false]    call BIS_fnc_addVirtualItemCargo;
   [_playerAmmoBox, east_helmets, false, false]  call BIS_fnc_addVirtualItemCargo;
   [_playerAmmoBox, east_glasses, false, false]  call BIS_fnc_addVirtualItemCargo;
   [_playerAmmoBox, east_packs, false, false]    call BIS_fnc_addVirtualBackpackCargo;
};

//Items for both sides...				   
[_playerAmmoBox, all_weapons, false, false] call BIS_fnc_addVirtualWeaponCargo;
[_playerAmmoBox, all_ammo, false, false]    call BIS_fnc_addVirtualMagazineCargo;
[_playerAmmoBox, all_attach, false, false]  call BIS_fnc_addVirtualItemCargo; 
[_playerAmmoBox, all_misc, false, false]    call BIS_fnc_addVirtualItemCargo; 
[_playerAmmoBox, all_glasses, false, false] call BIS_fnc_addVirtualItemCargo; 

// Inititialize the ammobox
// _null = ["AmmoboxInit",[_this]] spawn BIS_fnc_arsenal;
// _wait = [] spawn BIS_fnc_arsenal;
_wait = ["Open",[nil, _playerAmmoBox, player]] spawn bis_fnc_arsenal;

//Using the uiNameSpace variable BIS_fnc_arsenal_cam will tell you whether 
//the arsenal is open or not, its objNulll if its not open.
//Detect open/close of arsenal in order to reset hud.
waitUntil { !(isNull (uiNamespace getVariable ["BIS_fnc_arsenal_cam", objNull])) };
waitUntil { (isNull (uiNamespace getVariable ["BIS_fnc_arsenal_cam", objNull])) };
resetHUD = true;
