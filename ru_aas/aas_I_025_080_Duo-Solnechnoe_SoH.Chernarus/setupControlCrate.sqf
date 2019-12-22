#include "globalDefines.hpp"
obj _vec = _this select 0;
_vec allowDamage false;
clearWeaponCargo _vec;
clearMagazineCargo _vec;
waitUntil { CLIENT_initialised };
_vec addAction ["RESPAWN"     ,"actionMenuHandler.sqf", ["RESPAWN"]  , 50 , false,true,""];
int _sctr=1;
for "_sctr" from 1 to ((count my_fireteams) - 1) do
{
_vec addAction [format["$STR_AAS_Team",my_fireteams select _sctr] ,"actionMenuHandler.sqf", [ "SET_TEAM", FIRETEAM_BASE + _sctr ] , (49-_sctr) , false,true,""];
};
_vec addAction ["NO TEAM"     ,"actionMenuHandler.sqf", [ "SET_TEAM", FIRETEAM_NONE ] , 1 , false,true,""];