/*/
File: fn_lootPoints
Description: 
Domain: Client
/*/
_target = _this select 0;
_player = _this select 1;

[_player, 5000] remoteExecCall ["buls_fnc_add", 2];
[_player, "pointsLootSound"] remoteExec ["bulc_fnc_say3D", 0];
_target remoteExec ["deleteVehicle", 2];
