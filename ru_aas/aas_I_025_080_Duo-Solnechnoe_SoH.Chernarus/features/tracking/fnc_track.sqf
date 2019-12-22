#define __colorAqua [0,1,1,1]
#define __colorBlack [0,0,0,1]
#define __colorBlue [0,0,1,1]
#define __colorFuchsia [1,0,1,1]
#define __colorGray [0.5,0.5,0.5,1]
#define __colorGreen [0,0.5,0,1]
#define __colorLime [0,1,0,1]
#define __colorMaroon [0.5,0,0,1]
#define __colorNavy [0,0,0.5,1]
#define __colorOlive [0.5,0.5,0,1]
#define __colorOrange [0.5,0.5,0,1]
#define __colorPurple [0.5,0,0.5,1]
#define __colorRed [1,0,0,1]
#define __colorSilver [0.75,0.75,0.75,1]
#define __colorTeal [0,0.5,0.5,1]
#define __colorWhite [1,1,1,1]
#define __colorYellow [1,1,0,1]

private ["_unit","_objects","_particles","_markers","_color","_color1","_color2","_particle","_marker","_lastTime","_logic","_debugMarker","_firstElement"];
_unit = _this;
_objects = [];
_particles = [];
_markers = [];

_side = side _this;
_color = [[__colorBlue,"ColorBlue","ColorWhite"],[__colorYellow,"ColorYellow"]];
if (_side == EAST) then {_color = [[__colorRed,"ColorRed","ColorBlack"],[__colorOrange,"ColorOrange"]]};
_color1 = _color select 0;
_color2 = _color select 1;

_particle = [_unit,_color1 select 0] call AAS_fnc_particle;
_particles set [count _particles,_particle];

AAS_AIDebugMarkerID = AAS_AIDebugMarkerID + 1;

_marker = createMarkerLocal [format["AAS_AIDebugMarkerID_%1",AAS_AIDebugMarkerID],getPosASL _unit];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "DOT";
_marker setMarkerColorLocal (_color1 select 1);
_marker setMarkerTextLocal (format["%1",typeOf(_unit)]);
_marker setMarkerSizeLocal [1,1];
_markers set [count _markers,_marker];

_lastTime = time;
waitUntil
{
	_position = getPosASL _unit;

	if (time > (_lastTime + 10) && (_unit == (vehicle _unit))) then
	{
		_logic = "Logic" createVehicleLocal (getPos _unit);
		_logic setPosASL _position;
		_objects set [count _objects,_logic];
		_particle = [_logic,_color2 select 0] call AAS_fnc_particle;
		_particles set [count _particles,_particle];

		if ((count _particles) > 10) then
		{
			_firstElement = _particles select 0;
			_particles = _particles - [_firstElement];
			deleteVehicle _firstElement;
		};

		AAS_AIDebugMarkerID = AAS_AIDebugMarkerID + 1;
		_debugMarker = createMarkerLocal [format["AAS_AIDebugMarkerID_%1",AAS_AIDebugMarkerID],_position];
		_debugMarker setMarkerShapeLocal "ICON";
		_debugMarker setMarkerTypeLocal "DOT";
		_debugMarker setMarkerColorLocal (_color2 select 1);
		//_marker setMarkerTextLocal format["%1",_unit];
		_markers set [count _markers,_debugMarker];
		_lastTime = time;
	};
	if (_unit == (vehicle _unit)) then
	{
		_marker setMarkerPosLocal _position;
		_marker setMarkerColorLocal (_color1 select 1);
	}//inside a vehicle
	else
	{
		_marker setMarkerColorLocal (_color1 select 2);
		if ((isFormationLeader _unit) || ((("StaticWeapon" countType [vehicle _unit]) > 0))) then
		{
			_marker setMarkerPosLocal _position;
		}// hide marker of crew to avoid stacking markers; only one per vehicle is enough
		else
		{
			_marker setMarkerPosLocal [10,10];
		};
	};
	_unitType = switch (typeOf(vehicle _unit)) do
	{
		case "RU_Commander":		{"C"};
		case "RU_Soldier":		{"R"};
		case "RU_Soldier_AA":		{"AA"};
		case "RU_Soldier_AR":		{"AR"};
		case "RU_Soldier_AT":		{"AT"};
		case "RU_Soldier_GL":		{"GL"};
		case "RU_Soldier_HAT":		{"HAT"};
		case "RU_Soldier_LAT":		{"LAT"};
		case "RU_Soldier_Medic":	{"M"};
		case "RU_Soldier_MG":		{"MG"};
		case "RU_Soldier_Officer":	{"O"};
		case "RU_Soldier_SL":		{"SL"};
		case "RU_Soldier_SniperH":	{"SH"};
		case "RU_Soldier_TL":		{"TL"};
		case "USMC_Soldier":		{"R"};
		case "USMC_Soldier_AA":		{"AA"};
		case "USMC_Soldier_AR":		{"AR"};
		case "USMC_Soldier_AT":		{"AT"};
		case "USMC_Soldier_GL":		{"GL"};
		case "USMC_Soldier_HAT":	{"HAT"};
		case "USMC_Soldier_LAT":	{"LAT"};
		case "USMC_Soldier_Medic":	{"M"};
		case "USMC_Soldier_MG":		{"MG"};
		case "USMC_Soldier_Officer":	{"O"};
		case "USMC_Soldier_SL":		{"SL"};
		case "USMC_Soldier_TL":		{"TL"};
		case "USMC_SoldierS":		{"S"};
		case "USMC_SoldierS_Engineer":	{"ENG"};
		case "USMC_SoldierS_SniperH":	{"SH"};
		default				{getText (configFile/"CfgVehicles"/typeOf(vehicle _unit)/"displayName");};
	};
	_marker setMarkerTextLocal _unitType;
	sleep 0.01;
	(!(alive _unit));
};

sleep 10;

{
	deleteVehicle _x;
} forEach _particles;
{
	deleteVehicle _x;
} forEach _objects;
{
	deleteMarkerLocal _x;
} forEach _markers;