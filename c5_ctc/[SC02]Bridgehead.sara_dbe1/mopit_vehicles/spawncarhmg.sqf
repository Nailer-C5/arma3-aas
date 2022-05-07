//Varibles

_count = 0;                                //Do not change from 0
_vehWest = "B_MRAP_01_hmg_F";
_vehEast = "O_MRAP_02_hmg_F";
_howMany = 6;


//Code

switch(playerSide) do {



    case west: {



_count = _vehWest countType vehicles;

_spawnFnc = 

{


_pos = getPosATL B_HMG_carSpawn;
_veh = _vehWest createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh disableTIEquipment true;
_veh setDir 180;
player moveInDriver _veh;


};



if (_count == _howMany) then {hint "Got enough already";} else

{call _spawnFnc;};

};





    case east: {


_count = _vehEast countType vehicles;

_spawnFnc = 

{


_pos = getPosATL O_HMG_carSpawn;
_veh = _vehEast createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh disableTIEquipment true;
_veh setObjectTextureGlobal [0, "\A3\Characters_F\Common\Data\basicbody_black_co.paa"];
_veh setObjectTextureGlobal [1, "\A3\Characters_F\Common\Data\basicbody_black_co.paa"];
_veh setObjectTextureGlobal [2, "\A3\Characters_F\Common\Data\basicbody_black_co.paa"];
player moveInDriver _veh;



};



if (_count == _howMany) then {hint "Got enough already";} else

{call _spawnFnc;};

    };
};



