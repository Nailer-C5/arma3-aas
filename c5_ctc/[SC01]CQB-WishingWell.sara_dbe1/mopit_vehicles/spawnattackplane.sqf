// Varibles
_count = 0;

_vehWest = "CUP_B_Su25_Dyn_CDF";

_vehEast = "CUP_O_Su25_Dyn_TKA";

_howMany = 1;

// Code

switch(playerSide) do {



    case west: {




_count =  _vehWest countType vehicles;

_spawnFnc = 

{


_pos = getPosATL B_A_Plane;
_veh =  createVehicle [ _vehWest, _pos, [], 0, "FLY"];
player moveInDriver _veh;



};



if (_count == _howMany) then {hint "Got enough already";} else

{call _spawnFnc;};

};





    case east: {


_count = _vehEast countType vehicles;

_spawnFnc = 

{


_pos = getPosATL O_A_Plane;
_veh =  createVehicle [ _vehEast, _pos, [], 0, "FLY"];
player moveInDriver _veh;




};



if (_count == _howMany) then {hint "Got enough already";} else

{call _spawnFnc;};

    };
};

