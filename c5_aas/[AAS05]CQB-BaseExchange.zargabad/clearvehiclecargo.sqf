#include "globalDefines.hpp"
sleep 1;
while {true} do
{
	{
		clearWeaponCargo _x;
		clearMagazineCargo _x;
	} forEach vehicles;
	sleep 1;
};