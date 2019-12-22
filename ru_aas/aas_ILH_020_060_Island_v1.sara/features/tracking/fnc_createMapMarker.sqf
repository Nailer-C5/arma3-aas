
private ["_unit","_markers","_side","_color","_marker","_lastTime","_unitInfantryType"];

_unit = _this select 0;

_markers = [];
_side = side _unit;
_color = ["ColorBlue","ColorWhite","ColorYellow"];
if (_side == east) then {_color = ["ColorRed","ColorBlack","ColorOrange"]};

AAS_AIDebugMarkerID = AAS_AIDebugMarkerID + 1;

_lastTime = time;

_marker = createMarkerLocal [format["AAS_AIDebugMarkerID_%1",AAS_AIDebugMarkerID],getPosASL _unit];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "mil_dot";
_marker setMarkerColorLocal (_color select 0);
_marker setMarkerTextLocal (str(typeOf _unit));
_marker setMarkerSizeLocal [1,1];
_markers set [count _markers,_marker];


_unitInfantryType = switch (typeOf _unit) do
{
	case "B_soldier_M_F":		{"aMG"};
	case "B_soldier_LAT_F":		{"AT"};
	case "B_Soldier_lite_F":		{"R"};
	case "B_Soldier_F":		{"R"};
	case "B_soldier_repair_F":	{"REP"};
	case "B_soldier_AR_F":		{"MG"};
	case "B_soldier_exp_F":	{"EX"};
	case "B_Soldier_SL_F":		{"SL"};
	case "B_medic_F":		{"MED"};
	case "B_Soldier_GL_F":	{"GL"};
	case "B_Soldier_TL_F":	{"TL"};
	case "O_medic_F" :		{"MED"};
	case "O_soldier_repair_F":		{"REP"};
	case "O_Soldier_lite_F":		{"M"};
	case "O_Soldier_F":		{"M"};
	case "O_Soldier_AR_F":		{"AR"};
	case "O_Soldier_LAT_F":		{"AT"};
	case "O_soldier_exp_F":		{"EX"};
	case "O_soldier_M_F":		{"MG"};
	case "O_Soldier_GL_F":	{"GL"};
	case "O_Soldier_TL_F":		{"TL"};
	case "O_Soldier_SL_F":		{"SL"};
	default					{getText (configFile/"CfgVehicles"/typeOf(vehicle _unit)/"displayName");};
};

while {alive _unit} do
{
	private["_position","_unitType"];

	_position = getPosASL _unit;

	if ((time > (_lastTime + 10)) && (_unit == (vehicle _unit))) then
	{
		private["_debugMarker"];

		AAS_AIDebugMarkerID = AAS_AIDebugMarkerID + 1;

		_debugMarker = createMarkerLocal [format["AAS_AIDebugMarkerID_%1",AAS_AIDebugMarkerID],_position];
		_debugMarker setMarkerShapeLocal "ICON";
		_debugMarker setMarkerTypeLocal "mil_dot";
		_debugMarker setMarkerColorLocal (_color select 2);
		_markers set [count _markers,_debugMarker];
		_lastTime = time;
	};
	if (_unit == (vehicle _unit)) then
	{
		_marker setMarkerPosLocal _position;
		_marker setMarkerColorLocal (_color select 0);
	}//inside a vehicle
	else
	{
		private["_vehicle"];

		_marker setMarkerColorLocal (_color select 1);
		_vehicle = vehicle _unit;
		if ((driver _vehicle) == _unit) then
		{
			_marker setMarkerPosLocal _position;
		}
		else
		{
			if ((isNull (driver _vehicle)) && ((_unit in (crew _vehicle)) || ((gunner _vehicle) == _unit))) then
			{
				_marker setMarkerPosLocal _position;
			}
			else
			{// sole passenger
				_marker setMarkerPosLocal [-1000,-1000];
			};
		};
	};
	_unitType = switch (true) do
	{
		case ((vehicle _unit) isKindOf "CAManBase"):	{_unitInfantryType};
		default						{getText (configFile/"CfgVehicles"/typeOf(vehicle _unit)/"displayName");};
	};
	_marker setMarkerTextLocal _unitType;
	sleep 0.1;
};

_marker setMarkerTypeLocal "hd_warning";

sleep 5;

{
	deleteMarkerLocal _x;
} forEach _markers;