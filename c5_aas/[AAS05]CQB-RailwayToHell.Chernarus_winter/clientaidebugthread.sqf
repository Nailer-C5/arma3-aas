#include "globalDefines.hpp"
if (AAS_Params_AIDebugMode == 0) exitWith {};
AAS_AIDebugMarkerID = 0;
AAS_CleanedUpAIDebugMarkerID = 0;
AAS_ZoneNames = ["X-Ray"] + name_stock;
AAS_ZoneNames set [(count saas_baselist) - 2,"X-Ray"];
code AAS_fnc_particle = compile preprocessFileLineNumbers "features\tracking\fnc_particle.sqf";
code AAS_fnc_createMapMarker = compile preprocessFileLineNumbers "features\tracking\fnc_createMapMarker.sqf";
code AAS_fnc_createParticles = compile preprocessFileLineNumbers "features\tracking\fnc_createParticles.sqf";
sleep 1;
[] spawn
{
	sleep 30;
	while {true} do
	{
		waitUntil {sleep 1;(AAS_Params_AIDebugMode != 0)};
		waitUntil
		{
			sleep 0.1;
			AAS_ZoneOwnershipChanged;
		};
		player groupChat "Zone ownership change for AI";
		sleep 0.1;
		waitUntil
		{
			sleep 0.1;
			(!(AAS_ZoneOwnershipChanged));
		};
		sleep 0.1;
	};
};

while {true} do
{
	_eastInfantry = 0;
	_eastCars = 0;
	_eastStatics = 0;
	_eastTanks = 0;
	_eastAir = 0;
	_westInfantry = 0;
	_westCars = 0;
	_westStatics = 0;
	_westTanks = 0;
	_westAir = 0;
	{
		if (!(isPlayer _x) && (alive _x)) then
		{
			_active = _x getVariable "AIPositionTracking";
			if (isNil "_active") then
			{
				if ((AAS_Params_AIDebugMode == 2) || ((AAS_Params_AIDebugMode == 1) && (playerSide == side _x))) then
				{
					_x setVariable ["AIPositionTracking",true];
					[_x] spawn AAS_fnc_createMapMarker;
					[_x] spawn AAS_fnc_createParticles;
				};
			};
			_vehicle = vehicle _x;
			switch (side _x) do
			{
				case EAST:
				{
					_eastInfantry = _eastInfantry + 1;
					switch (true) do
					{
						case (("Air" countType [_vehicle]) > 0):	{_eastAir = _eastAir + (1 / (count (crew _vehicle)));};
						case (("Tank" countType [_vehicle]) > 0):	{_eastTanks = _eastTanks + (1 / (count (crew _vehicle)));};
						case (("StaticWeapon" countType [_vehicle]) > 0):{_eastStatics = _eastStatics + (1 / (count (crew _vehicle)));};
						case (("LandVehicle" countType [_vehicle]) > 0):{_eastCars = _eastCars + (1 / (count (crew _vehicle)));};
					};
				};
				case WEST:
				{
					_westInfantry = _westInfantry + 1;
					switch (true) do
					{
						case (("Air" countType [_vehicle]) > 0):	{_westAir = _westAir + (1 / (count (crew _vehicle)));};
						case (("Tank" countType [_vehicle]) > 0):	{_westTanks = _westTanks + (1 / (count (crew _vehicle)));};
						case (("StaticWeapon" countType [_vehicle]) > 0):{_westStatics = _westStatics + (1 / (count (crew _vehicle)));};
						case (("LandVehicle" countType [_vehicle]) > 0):{_westCars = _westCars + (1 / (count (crew _vehicle)));};
					};
				};
			};
		};
	} forEach allUnits;
	_debugText = format ["East - Inf: %1.",_eastInfantry];
	if (_eastCars > 0) then {_debugText = _debugText + format [" Cars: %1.",ceil(_eastCars)];};
	if (_eastStatics > 0) then {_debugText = _debugText + format [" Statics: %1.",ceil(_eastStatics)];};
	if (_eastTanks > 0) then {_debugText = _debugText + format [" Tanks: %1.",ceil(_eastTanks)];};
	if (_eastAir > 0) then {_debugText = _debugText + format [" Air: %1.",ceil(_eastAir)];};
	player groupChat _debugText;

	_debugText = format ["West - Inf: %1.",_westInfantry];
	if (_westCars > 0) then {_debugText = _debugText + format [" Cars: %1.",ceil(_westCars)];};
	if (_westStatics > 0) then {_debugText = _debugText + format [" Statics: %1.",ceil(_westStatics)];};
	if (_westTanks > 0) then {_debugText = _debugText + format [" Tanks: %1.",ceil(_westTanks)];};
	if (_westAir > 0) then {_debugText = _debugText + format [" Air: %1.",ceil(_westAir)];};
	player groupChat _debugText;

	_debugText = "";
	_i = -1;//to skip dummy zone
	{
		if ((count (units _x)) > 0) then
		{
			_debugText = _debugText + format[" %1 (%2).",AAS_ZoneNames select _i,side (leader _x)];
		};
		_i = _i + 1;
	} forEach AAS_ZoneDefendinGroups;
	if (_debugText != "") then {player groupChat (format ["AI defending:%1",_debugText]);};

	_debugText = "";
	_i = -1;//to skip dummy zone
	{
		if ((count _x) > 0) then
		{
			_side = "WEST";
			if (BASEA((_i + 1),TEAM) == TEAM_RED) then {_side = "EAST";};
			_debugText = _debugText + format[" %1 (%2: %3).",AAS_ZoneNames select _i,_side,count _x];
		};
		_i = _i + 1;
	} forEach AAS_ZoneUnitsQueueAI;
	if (_debugText != "") then {player groupChat (format ["AI Queue:%1",_debugText]);};
	sleep 10;
};