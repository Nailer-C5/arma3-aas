// Varibles

_count = 0;
_vehWest = "B_LSV_01_armed_F";
_vehEast = "O_LSV_02_armed_F";
_howMany = 3;

// Code

switch(playerSide) do {



    case west: {



_count = _vehWest countType vehicles;

_spawnFnc = 

{


_pos = getPosATL B_HMG_bugSpawn;
_veh = _vehWest createVehicle [_pos select 0, _pos select 1, _pos select 2];
player moveInDriver _veh;


};



if (_count == _howMany) then {hint "Got enough already";} else

{call _spawnFnc;};

};





    case east: {


_count = _vehEast countType vehicles;

_spawnFnc = 

{


_pos = getPosATL O_HMG_bugSpawn;
_veh = _vehEast createVehicle [_pos select 0, _pos select 1, _pos select 2];
player moveInDriver _veh;


};



if (_count == _howMany) then {hint "Got enough already";} else

{call _spawnFnc;};

    };
};

