params['_vehicle'];
_weaponsData= [[],[]];
_allwpns=[];
{
	_mags= _x select 0;
	_turretPath= _x select 1;
	_ammoCount= _x select 2;
	_weapon= _vehicle weaponsTurret _turretPath;
	(_weaponsData select 1) pushBack [_mags, _turretPath, _ammoCount];
	_allwpns pushBackUnique [_weapon, _turretPath];
	
} forEach (magazinesAllTurrets _vehicle);
_weaponsData set [0, _allwpns];

_weaponsData;