//Varibles

_count = 0;
_vehWest = "CUP_B_MH60L_DAP_2x_USN";
_vehEast = "CUP_O_Mi24_V_Dynamic_CSAT_T";
_howMany = 1;

//Varibles to Change Vehicle Colors

// private _texture = "#(rgb,8,8,3)color(0.3,0.7,0.1,0.05)";
// private _texture_1 = "#(rgb,1,1,1)color(0,0.4,0.01,0.05)";

switch(playerSide) do {
    case west: {

_count = _vehWest countType vehicles;

_spawnFnc = 

{


_pos = getPosATL B_T_heliSpawn;
_veh = _vehWest createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh disableTIEquipment true;
player moveInDriver _veh;

};



if (_count == _howMany) then {hint "Got enough already";} else

{call _spawnFnc;};

    };

    case east: {
_count = _vehEast countType vehicles;

_spawnFnc = 

{


_pos = getPosATL O_T_heliSpawn;
_veh = _vehEast createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh disableTIEquipment true;
player moveInDriver _veh;


};



if (_count == _howMany) then {hint "Got enough already";} else

{call _spawnFnc;};

    };
};

