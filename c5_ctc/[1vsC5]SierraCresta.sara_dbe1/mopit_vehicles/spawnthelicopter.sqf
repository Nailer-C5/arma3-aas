// Varibles---------------

_count = 0; // Do not change

_vehWest = "B_Heli_Light_01_F";

_vehEast = "O_Heli_Transport_04_bench_F";

_howMany = 1;

private _texture = "#(rgb,8,8,3)color(0.3,0.7,0.1,0.05)";
private _texture_1 = "#(rgb,1,1,1)color(0,0.4,0.01,0.05)";

// Code--------------------------

switch(playerSide) do {
    case west: {

_count = _vehWest countType vehicles;

_heliFnc = 

{


_pos = getPosATL B_T_heliSpawn;
_veh = _vehWest createVehicle [_pos select 0, _pos select 1, _pos select 2];
player moveInDriver _veh;

};



if (_count == _howMany) then {hint "Got enough already";} else

{call _heliFnc;};

    };

    case east: {
_count = _vehEast countType vehicles;

_heliFnc = 

{


_pos = getPosATL O_T_heliSpawn;
_veh = _vehEast createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh setObjectTexture [0, _texture];
_veh setObjectTexture [1, _texture_1];
player moveInDriver _veh;


};



if (_count == howMany) then {hint "Got enough already";} else

{call _heliFnc;};

    };
};

