//Varibles

_count = 0;                                //Do not change from 0
_vehWest = "C_Kart_01_F";
_vehEast = "C_Kart_01_F";
_howMany = -1;


//Code

switch(playerSide) do {



    case west: {



_count = _vehWest countType vehicles;

_spawnFnc = 

{


_pos = getPosATL B_kartSpawn;
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


_pos = getPosATL O_kartSpawn;
_veh = _vehEast createVehicle [_pos select 0, _pos select 1, _pos select 2];
player moveInDriver _veh;




};



if (_count == _howMany) then {hint "Got enough already";} else

{call _spawnFnc;};

    };
};

