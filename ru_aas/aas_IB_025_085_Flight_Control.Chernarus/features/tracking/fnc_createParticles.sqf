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

private ["_unit","_side","_color","_particle"];

_unit = _this select 0;

_side = side _unit;
_color = [__colorBlue,__colorYellow];
if (_side == east) then {_color = [__colorRed,__colorOrange]};

_particle = [_unit,_color select 0] call AAS_fnc_particle;
_unit setVariable ["AAS_AIdebugParticle",_particle,false];

sleep 0.1;

_unit addEventHandler ["killed",
{
	_unit = _this select 0;
	_particle = _unit getVariable "AAS_AIdebugParticle";
	deleteVehicle _particle;
}];
