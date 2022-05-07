
_count = "B_Heli_Transport_01_F" countType vehicles;

_heliFnc = 

{


_pos = getPosATL B_T_GHspawn;
_veh = "B_Heli_Transport_01_F" createVehicle [_pos select 0, _pos select 1, _pos select 2];
player moveInDriver _veh;

};



if (_count == 1) then {hint "Got enough already";} else

{call _heliFnc;};