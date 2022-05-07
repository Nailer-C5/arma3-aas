
_count = 0;

_vehWest = "B_Heli_Light_01_dynamicLoadout_F";

_vehEast = "O_Heli_Light_02_dynamicLoadout_F";

_howMany = 1;

switch(playerSide) do {



    case west: {




_count =  _vehWest countType vehicles;

_heliFnc = 

{


_pos = getPosATL B_A_heliSpawn;
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


_pos = getPosATL O_A_heliSpawn;
_veh = _vehEast createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh setObjectTextureGlobal [0, "\A3\Characters_F\Common\Data\basicbody_black_co.paa"];
player moveInDriver _veh;

};



if (_count == _howMany) then {hint "Got enough already";} else

{call _heliFnc;};

    };
};

