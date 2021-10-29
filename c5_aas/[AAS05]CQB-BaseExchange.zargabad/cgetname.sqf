#include "globalDefines.hpp"
private["_name"];
string _name = _this getVariable "AAS_UnitName";
if (isNil "_name") then
{
	if (alive _this) then
	{
		_name = name _this;
	}
	else
	{
		_name = " (" + ( "Dead") + ")";
	};
};
_name;