
_count = 0;

switch(playerSide) do {



    case west: {



_count = "B_MRAP_01_hmg_F" countType vehicles;

_heliFnc = 

{


_pos = getPosATL B_HMG_carSpawn;
_veh = "B_MRAP_01_hmg_F" createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh disableTIEquipment true;


};



if (_count == 6) then {hint "Got enough already";} else

{call _heliFnc;};

};





    case east: {


_count = "O_MRAP_02_hmg_F" countType vehicles;

_heliFnc = 

{


_pos = getPosATL O_HMG_bugSpawn;
_veh = "O_MRAP_02_hmg_F" createVehicle [_pos select 0, _pos select 1, _pos select 2];
_veh disableTIEquipment true;



};



if (_count == 6) then {hint "Got enough already";} else

{call _heliFnc;};

    };
};

