if (player == player && vehicle player == player) then {
_mags = magazinesAmmo player;
_inv = _mags select {(_x select 0) in getArray (configFile >> "cfgWeapons" >> currentWeapon player >> "magazines")};
if (count _inv > 1) then {
_sort = [_inv,[],{_x select 1},"ASCEND"] call BIS_fnc_sortBy;
_lowest_mag = _sort select 0 select 0;
_lowest_cnt = _sort select 0 select 1;
_mags_space = _sort select [1, count _sort - 1];
_full_tot = 0;
_remain_tot = 0;
{_full_tot = _full_tot + getnumber (configFile >> "cfgmagazines" >> _x select 0 >> "count")} forEach _mags_space;
{_remain_tot = _remain_tot + (_x select 1)} forEach _mags_space;
_full_space = _full_tot - _remain_tot;
if (_lowest_cnt <= _full_space) then {
for "_i" from 0 to count _mags_space - 1 do {
if (_lowest_cnt > 0) then {
_current_mag = _mags_space select _i select 0;
_current_ammo = _mags_space select _i select 1;
_current_space =  getnumber (configFile >> "cfgmagazines" >> _current_mag >> "count") - _current_ammo;
if (_current_space > 0) then {
_mags_space set [_i,[_current_mag,_current_ammo + _lowest_cnt]];
_lowest_cnt = _lowest_cnt - _current_space;
			};
			};
			};
{player removeMagazineGlobal (_x select 0)} forEach (magazinesAmmo player select {(_x select 0) in getArray (configFile >> "cfgWeapons" >> currentWeapon player >> "magazines")});
{player addMagazine _x} forEach _mags_space;
		};
	}};
player playAction "reloadMagazine";
hintsilent "Mags Repacked";
