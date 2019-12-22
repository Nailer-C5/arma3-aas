#include "globalDefines.hpp"
float _factor = 0.285 * captureSpeedFactor;
if( RULES_enableProportionalCaptureSpeed ) then
	{
	float _serverFullProportion = ((playersNumber west) + (playersNumber east)) / (MAX_PLAYERS_PER_SIDE * 2);	
	float _adjustor = RULES_captureSpeedMaxCapacity;
	_adjustor = _adjustor + ((1-_serverFullProportion) * (RULES_captureSpeedMinCapacity-RULES_captureSpeedMaxCapacity));
	_factor = _factor * _adjustor;
	};
bool _aBaseHasBeenCaptured=false; // flag to ensure that only one base can be captured per calculation cycle (prevents crossover capture)
	{
	_baseCapLevel = SRVBASECACHEA(_x,CAPLEVEL);
	int _numb = SRVBASECACHEA(_x, NUMBLUE);
	int _numr = SRVBASECACHEA(_x, NUMRED);
	if( !(_x in (redAttackList + redDefendList)) ) then { _numr = 0; };
	if( !(_x in (blueAttackList + blueDefendList)) ) then { _numb = 0; };
	if( BASEA(_x,TEAM) == TEAM_BLUE ) then
		{
		_baseCapLevel = _baseCapLevel + (_factor * (_numb - _numr));
		};
	if( BASEA(_x,TEAM) == TEAM_RED ) then
		{
		_baseCapLevel = _baseCapLevel + (_factor * (_numr - _numb));
		};
	if( BASEA(_x,TEAM) == TEAM_NEUTRAL ) then
		{
		_baseCapLevel = _baseCapLevel - (_factor * (_numb + _numr));
		};
	if( _baseCapLevel < 0   ) then { _baseCapLevel = 0;  };
	if( _baseCapLevel > 100 ) then { _baseCapLevel = 100; };
	if( _baseCapLevel == 0  and !_aBaseHasBeenCaptured ) then
		{
		//pos _bpos = getPos (flags select _x);
		pos _bpos = getPosATL (flags select _x);//888
		array _playableUnits = allUnits;
		int _capred = 0;
		int _capblue = 0;
		{
			if ((alive _x) && ((vehicle _x) == _x) && ((_x distance _bpos) < CAPTURE_RADIUS)) then
			{
				switch (side _x) do
				{
					case east: {_capred = _capred + 1;};
					case west: {_capblue = _capblue + 1;};
				};
			};
		} forEach _playableUnits;
		if ((_capred > _capblue) && ((BASEA(_x,TEAM) == TEAM_BLUE) || (BASEA(_x,TEAM) == TEAM_NEUTRAL))) then
			{
			SETBASEA(_x,TEAM,TEAM_RED);
			call cmdRecalcDependentBases;
			call cmdRecalcBattleFronts;
			_x call cmdCaptureBase;
			_aBaseHasBeenCaptured=true;
			AAS_ZoneOwnershipChanged = true;
			};
		if( _capblue > 0 and _capred == 0 and (BASEA(_x,TEAM)==TEAM_RED or BASEA(_x,TEAM)==TEAM_NEUTRAL) ) then	
			{
			SETBASEA(_x,TEAM,TEAM_BLUE);
			call cmdRecalcDependentBases;
			call cmdRecalcBattleFronts;
			_x call cmdCaptureBase;
			_aBaseHasBeenCaptured=true;
			AAS_ZoneOwnershipChanged = true;
			};								
		};
	SETSRVBASECACHEA(_x,CAPLEVEL,_baseCapLevel);
	} forEach curBaseList;
