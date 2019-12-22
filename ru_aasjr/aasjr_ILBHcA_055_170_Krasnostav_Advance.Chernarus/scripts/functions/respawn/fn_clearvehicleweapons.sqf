params['_vehicle'];
{
	_magazineName= _x select 0;
	_turretPath= _x select 1;
	
	//First clear mags
	_vehicle removeMagazinesTurret [_magazineName, _turretPath]; 
	//Next remowe weapons
	_weapons= _vehicle weaponsTurret _turretPath;
	{ _vehicle removeWeaponTurret [_x, _turretPath] } forEach _weapons;
	
} forEach (magazinesAllTurrets _vehicle);