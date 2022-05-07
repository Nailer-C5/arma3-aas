
_count = 0;

switch(playerSide) do {



    case west: {



_count = "B_Heli_Light_01_dynamicLoadout_F" countType vehicles;

_heliFnc = 

{


_pos = getPosATL B_A_heliSpawn;
_veh = "B_Heli_Light_01_dynamicLoadout_F" createVehicle [_pos select 0, _pos select 1, _pos select 2];
player moveInDriver _veh;


};



if (_count ==1) then {hint "Already got one";} else

{call _heliFnc;};

};





    case east: {


_count = "O_Heli_Light_02_dynamicLoadout_F" countType vehicles;

_heliFnc = 

{


_pos = getPosATL O_A_heliSpawn;
_veh = "O_Heli_Light_02_dynamicLoadout_F" createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh setObjectTexture [0, "\A3\Characters_F\Common\Data\basicbody_black_co.paa"];
player moveInDriver _veh;

};



if (_count ==1) then {hint " Already got one";} else

{call _heliFnc;};

    };
};

