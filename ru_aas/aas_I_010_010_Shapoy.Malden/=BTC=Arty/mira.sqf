_vehicle = _this select 0;
_weapon = _this select 1;
enableEngineArtillery false;

while {player == (gunner _vehicle) && alive(player)} do {
_dirs = [_vehicle weaponDirection _weapon] call compile preprocessFileLineNumbers ("=BTC=Arty\get_dir.sqf");
_azimuth = _dirs select 0;
_elevation = _dirs select 1;

hintSilent format ["Choose CHARGE to press F.  Settings: %1 Azimuth: %2 Elevation: %3", getArtilleryComputerSettings select 0, _azimuth, _elevation];
//hintSilent format [localize "STR_AAS_CHARGE", getArtilleryComputerSettings select 0, _azimuth, _elevation];
};

hintSilent "";
enableEngineArtillery true;
if(true) exitWith {}; 
