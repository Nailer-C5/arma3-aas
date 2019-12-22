#include "globalDefines.hpp"
specialisationPercentRed = 0; 
specialisationPercentBlue = 0; 
array _classCountRed = [ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
array _classCountBlue = [ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];
	{ 
	int _classId = playerClasses select (_x call getPlayerQID);
	if (!(isNil "_classId")) then
		{
		if( _classId == LOADOUT_CUSTOM ) then { _classID = 20; };
		_classCountRed set [ _classId , (_classCountRed select _classID) + 1 ];
		};
	} forEach player_units_east;
	{ 
	int _classId = playerClasses select (_x call getPlayerQID);
	if (!(isNil "_classId")) then
		{
		if( _classId == LOADOUT_CUSTOM ) then { _classID = 20; };
		_classCountBlue set [ _classId , (_classCountBlue select _classID) + 1 ];
		};
	} forEach player_units_west;
string _classReport = "";


int _clidx=0;
for "_clidx" from 0 to ((count RULES_classList) - 1) do
	{
	_classReport = _classReport + format["%1 : %2R %3B    ",((RULES_classList select _clidx) select CL_NAME),_classCountRed select _clidx,_classCountBlue select _clidx];
	if( !((RULES_classList select _clidx) select CL_SPECIALISED) ) then
		{
		specialisationPercentRed  = specialisationPercentRed  + (_classCountRed  select _clidx);
		specialisationPercentBlue = specialisationPercentBlue + (_classCountBlue select _clidx);
		};
	};
int _numRed = playersNumber east;
if( _numRed == 0 ) then { _numRed = 1; };			
int _numBlue = playersNumber west;
if( _numBlue == 0 ) then { _numBlue = 1; };
specialisationPercentRed  = 100 - round (specialisationPercentRed  / _numRed  * 100);
specialisationPercentBlue = 100 - round (specialisationPercentBlue / _numBlue * 100);
if( specialisationPercentRed  < 0 or specialisationPercentRed  > 100 ) then { specialisationPercentRed  = 0; };
if( specialisationPercentBlue < 0 or specialisationPercentBlue > 100 ) then { specialisationPercentBlue = 0; };
int _scopedCount = 0;
	{
	if( (currentWeapon _x) in scopedWeapons ) then { _scopedCount = _scopedCount + 1; };
	} forEach player_units_all;
	
scopedPercent = round ( _scopedCount / (_numRed + _numBlue) );
diag_log format["SRV ServerMainThread.sqf ----------- REPORT at %1 secs",round time];
diag_log format["SRV ServerMainThread.sqf PLAYERS        ... RED %1 vs BLUE %2",playersNumber east,playersNumber west];
diag_log format["SRV ServerMainThread.sqf CLASSES        ... %1 ",_classReport];
diag_log format["SRV ServerMainThread.sqf SPECIALISATION ... RED %1, BLUE %2",specialisationPercentRed,specialisationPercentBlue];
publicVariable "specialisationPercentRed";
publicVariable "specialisationPercentBlue";
publicVariable "scopedPercent";

