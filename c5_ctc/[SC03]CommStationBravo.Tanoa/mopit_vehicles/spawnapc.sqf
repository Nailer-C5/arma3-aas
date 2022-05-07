
_count = 0;

switch(playerSide) do {



    case west: {



_count = "B_APC_Wheeled_01_cannon_F" countType vehicles;

_heliFnc = 

{


_pos = getPosATL B_APCSpawn;
_veh = "B_APC_Wheeled_01_cannon_F" createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh disableTIEquipment true;
player moveInDriver _veh;

};



if (_count == 1) then {hint "Got enough already";} else

{call _heliFnc;};

};





    case east: {


_count = "CUP_O_BTR90_RU" countType vehicles;

_heliFnc = 

{


_pos = getPosATL O_APCSpawn;
_veh = "CUP_O_BTR90_RU" createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh disableTIEquipment true;
_veh setObjectTextureGlobal [0, "\A3\Characters_F\Common\Data\basicbody_black_co.paa"];
_veh setObjectTextureGlobal [1, "\A3\Characters_F\Common\Data\basicbody_black_co.paa"];
player moveInDriver _veh;

};



if (_count == 1) then {hint "Got enough already";} else

{call _heliFnc;};

    };
};

