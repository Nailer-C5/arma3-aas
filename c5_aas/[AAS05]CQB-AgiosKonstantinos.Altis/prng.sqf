#include "globalDefines.hpp"
_theResult = 0;

if( count _this == 1 ) then
	{
	seed = (format [ "%1" , _this select 0 ]) call cmdHashString;
	}
else
	{
	int _lowerBound = _this select 0;
	int _upperBound = _this select 1;	
	int _actualRange = _upperBound - _lowerBound;
	array _seedArray = toArray seed;
	int _number1 = (_seedArray select 0) + (_seedArray select 1) + (_seedArray select 2) + (_seedArray select 3);
	int _number2 = (_seedArray select 4) + (_seedArray select 5) + (_seedArray select 6) + (_seedArray select 7);
	int _number3 = (_seedArray select 8) + (_seedArray select 9) + (_seedArray select 10) + (_seedArray select 11);
	int _number4 = (_seedArray select 12) + (_seedArray select 13) + (_seedArray select 14) + (_seedArray select 15);
	if( _actualRange > 0 ) then
		{
		_theResult = ((_number1 + _number2 + (_number3 * _number4)) % _actualRange) + _lowerBound;
		}
	else
		{
		_theResult = _lowerBound;
		};
	seed = (format [ "%1" , seed ]) call cmdHashString;	
	};
_theResult