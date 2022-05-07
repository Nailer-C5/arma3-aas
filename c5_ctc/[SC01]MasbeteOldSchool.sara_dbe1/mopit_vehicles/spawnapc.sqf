// Varibles 

_count = 0;                                                          // do not change from 0
_vehWest = "B_APC_Wheeled_01_cannon_F";
_vehEast = "CUP_O_BTR90_RU";
_howMany = 2;

//Code

switch(playerSide) do {



    case west: {



_count =  _vehWest countType vehicles;

_spawnFnc = 

{


_pos = getPosATL B_APCSpawn;
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


_pos = getPosATL O_APCSpawn;
_veh = "CUP_O_BTR90_RU" createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh disableTIEquipment true;
_veh setObjectTexture [0, "\A3\Characters_F\Common\Data\basicbody_black_co.paa"];
_veh setObjectTexture [1, "\A3\Characters_F\Common\Data\basicbody_black_co.paa"];
player moveInDriver _veh;

};



if (_count == _howMany) then {hint "Got enough already";} else

{call _spawnFnc;};

    };
};

