
_count = 0;

switch(playerSide) do {



    case west: {



_count = "B_LSV_01_armed_F" countType vehicles;

_heliFnc = 

{


_pos = getPosATL B_HMG_bugSpawn;
_veh = "B_LSV_01_armed_F" createVehicle [_pos select 0, _pos select 1, _pos select 2];
player moveInDriver _veh;


};



if (_count == 3) then {hint "Got enough already";} else

{call _heliFnc;};

};





    case east: {


_count = "O_LSV_02_armed_F" countType vehicles;

_heliFnc = 

{


_pos = getPosATL O_HMG_bugSpawn;
_veh = "O_LSV_02_armed_F" createVehicle [_pos select 0, _pos select 1, _pos select 2];
player moveInDriver _veh;


};



if (_count == 3) then {hint "Got enough already";} else

{call _heliFnc;};

    };
};

