#include "globalDefines.hpp"
private["_playerName","_nameArray"];
string _playerName = _this select 0;
array _nameArray = toArray _playerName;
#define AAS_MINIMUMNAMELENGTH	3
#define AAS_MAXNAMELENGTH	5
#define AAS_SPACECHARACTER	32
if (((count _nameArray) - 1) > AAS_MAXNAMELENGTH) then
{
	_nameArray resize AAS_MAXNAMELENGTH;
};
if (((count _nameArray) - 1) > AAS_MINIMUMNAMELENGTH) then
{
	for "_i" from (AAS_MINIMUMNAMELENGTH) to ((count _nameArray) - 1) do
	{
		if ((_nameArray select _i) == AAS_SPACECHARACTER) exitWith {_nameArray resize _i;};
	};
};
_playerName = toString _nameArray;
_playerName;