//by Bon_Inf*
//Modified by Moser 07/20/2014

BON_RECRUIT_PATH = "bon_recruit_units\";


//bon_max_units_allowed = 1;

_maxSize = ["ParamsUnitLimit",1] call BIS_fnc_getParamValue;

switch (_maxSize) do
{
	case 1: {bon_max_units_allowed = 1;};
	case 2: {bon_max_units_allowed = 2;};
	case 3: {bon_max_units_allowed = 3;};
	case 4: {bon_max_units_allowed = 4;};
	case 5: {bon_max_units_allowed = 5;};
	case 6: {bon_max_units_allowed = 6;};
	case 7: {bon_max_units_allowed = 7;};
	case 8: {bon_max_units_allowed = 8;};
	case 9: {bon_max_units_allowed = 9;};
	case 10: {bon_max_units_allowed = 10;};
};

bon_recruit_queue = [];

//Select false if you want to use a a static unit list
//You can customize static lists in recruitable_units_static.sqf
bon_dynamic_list = true;

if(isServer) then{
	"bon_recruit_newunit" addPublicVariableEventHandler {
		_newunit = _this select 1;
		[_newunit] execFSM (BON_RECRUIT_PATH+"unit_lifecycle.fsm");
	};
};
if(isDedicated) exitWith{};


// Client stuff...