private ["_aiUnitHit","_shooter","_hasSmokeGrenade"];
_aiUnitHit = _this select 0;

// unit inside a vehicle?
if (_aiUnitHit != vehicle _aiUnitHit) exitWith {};

// Check for smokeshell
_hasSmokeGrenade = false;
_magazinesUnit = magazines _aiUnitHit;
{
	if (_x in _magazinesUnit) exitWith {_hasSmokeGrenade = true;};
} forEach ["SmokeShell","SmokeShellYellow","SmokeShellRed","SmokeShellGreen","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange"];

if ((alive _aiUnitHit) && (_hasSmokeGrenade)) then
{
	_shooter = _this select 1;
	if (!(isNil "_shooter")) then
	{
		_aiUnitHit doWatch _shooter;
		sleep 3;
	};
	if (alive _aiUnitHit) then
	{
		_aiUnitHit fire "SmokeShellMuzzle";
	};
};