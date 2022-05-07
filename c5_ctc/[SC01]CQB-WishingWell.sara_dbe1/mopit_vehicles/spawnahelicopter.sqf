// Varibles
_count = 0;

_vehWest = "B_Heli_Attack_01_dynamicLoadout_F";

_vehEast = "CUP_O_Ka50_DL_RU";

_howMany = 1;

// Code

switch(playerSide) do {



    case west: {




_count =  _vehWest countType vehicles;

_spawnFnc = 

{


_pos = getPosATL B_A_heliSpawn;
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


_pos = getPosATL O_A_heliSpawn;
_veh = _vehEast createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh disableTIEquipment true;
player moveInDriver _veh;

};



if (_count == _howMany) then {hint "Got enough already";} else

{call _spawnFnc;};

    };
};

