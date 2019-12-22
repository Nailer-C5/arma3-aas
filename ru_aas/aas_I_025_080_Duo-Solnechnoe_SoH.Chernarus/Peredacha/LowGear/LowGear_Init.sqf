private ["_currentVeh","_veh"];

if (isDedicated) exitWith {};

RIPLOWGEARON = false;
RIP_LOWGEARACTON = nil;
RIP_LOWGEARACTOFF = nil;
_currentVeh = vehicle player;

while {true} do {

		sleep 0.003;
		_veh = vehicle player;
		if ((player == (driver _veh)) && (canMove _veh)) then {
			if (_veh isKindOf "Tank" || _veh isKindOf "rhs_bmp_base" || _veh isKindOf "rhs_bmd_base" || _veh isKindOf "rhs_btr_base"  || _veh isKindOf "Truck_01_base_F" || _veh isKindOf "Wheeled_APC_F" || _veh isKindOf "rhs_tigr_base" || _veh isKindOf "RHS_UAZ_Base") then {
				if (!RIPLOWGEARON && (isNil "RIP_LOWGEARACTON")) then {
					RIP_LOWGEARACTON = _veh addAction [localize "STR_RIP_LOWGEARON", "Peredacha\LowGear\LowGearOn.sqf", "", 0, true, true, "", "driver  _target == _this"];
					_currentVeh = _veh;
				};
			};
		};
		if ((player != (driver _currentVeh)) && !(isNil "RIP_LOWGEARACTON")) then {_currentVeh removeAction RIP_LOWGEARACTON;RIP_LOWGEARACTON = nil;};

};   