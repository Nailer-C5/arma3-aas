//Varibles
_count = 0;

_vehWest = "B_UAV_01_F";

_vehEast = "O_UAV_01_F";

_howMany = 1;

//Code

switch(playerSide) do {



    case west: {




_count =  _vehWest countType vehicles;

_heliFnc = 

{


_pos = getPosATL B_UAVSpawn;
_veh = _vehWest createVehicle [_pos select 0, _pos select 1, _pos select 2];
createVehicleCrew _veh;



};



if (_count == _howMany) then {hint "Got enough already";} else

{call _heliFnc;};

};





    case east: {


_count = _vehEast countType vehicles;

_heliFnc = 

{


_pos = getPosATL O_UAVSpawn;
_veh = _vehEast createVehicle [_pos select 0, _pos select 1, _pos select 2];
createVehicleCrew _veh;


};



if (_count == _howMany) then {hint "Got enough already";} else

{call _heliFnc;};

    };
};

