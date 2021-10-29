#include "globalDefines.hpp"
array _playableUnits = allUnits;
for "_basenumber" from (0) to ((count curBaseList) - 1) do
{
	_zoneMarker = BASENAME(curBaseList select _baseNumber);
	pos _flagPosition = getPos (flags select (curBaseList select _baseNumber));
	_diameter = (getMarkerSize _zoneMarker) select 0;
	int _numbersEast = 0;
	int _numbersWest = 0;
	{
		if ((alive _x) && ((_x distance _flagPosition) < _diameter)) then
		{
			switch (side _x) do
			{
				case east: {_numbersEast = _numbersEast + 1;};
				case west: {_numbersWest = _numbersWest + 1;};
			};
		};
	} forEach _playableUnits;
	if( isServer ) then
		{
		SETSRVBASECACHEA(curBaseList select _baseNumber,NUMBLUE,_numbersWest);
		SETSRVBASECACHEA(curBaseList select _baseNumber,NUMRED,_numbersEast);
		};
	if( local player ) then
		{
		if ((player distance _flagPosition) < _diameter) then
            {
            SETBASECACHEA( curBaseList select _baseNumber , PLAYERPRESENT, true );
            }
        else
            {
            SETBASECACHEA( curBaseList select _baseNumber , PLAYERPRESENT, false );
            };
		SETBASECACHEA(curBaseList select _baseNumber,NUMBLUE,_numbersWest);
		SETBASECACHEA(curBaseList select _baseNumber,NUMRED,_numbersEast);
		};
	};