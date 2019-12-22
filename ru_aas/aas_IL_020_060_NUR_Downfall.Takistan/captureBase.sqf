#include "globalDefines.hpp"
int _lmctr=0;
int _capBase = _this;
pos _bpos = getPos (flags select _capBase);
array _capturers = [];
array _playableUnits = allUnits;
	{
	bool _sameSide = false;
	if( WESTSIDE(_x) and BASEA(_this,TEAM) == TEAM_BLUE ) then { _sameSide = true; };
	if( EASTSIDE(_x) and BASEA(_this,TEAM) == TEAM_RED  ) then { _sameSide = true; };
	
	if ((_x distance _bpos) < CAPTURE_RADIUS && _sameSide) then {_capturers set [count _capturers,_x];};
	} forEach player_units_all;

if (count _capturers > 0) then
{
unit _capPlayer=_capturers select (floor random (count _capturers));	
_capPlayer addScore 10;		// give that man 10 points!
//srvCommand = format[localize "STR_AAS_captured_base",_capPlayer call getName];		
//publicVariable "srvCommand";

//chatCommand = format[localize "STR_AAS_captured_base",_capPlayer call getName, base_names select _capBase];	
chatCommand = [_capPlayer call getName, base_names select _capBase];  	
publicVariable "chatCommand";
};
_flagTextures = [ "pictures\dummy.jpg", "pictures\flagRed2.jpg", "pictures\flagBlue2.jpg" ];
int _lctr=0;
for "_lctr" from 1 to (count saas_baselist) do
	{
	_lname=BASENAME(_lctr);
	_lname setMarkerColor (teamColors select BASEA(_lctr,TEAM));	
	(flags select _lctr) setFlagTexture (_flagTextures select BASEA(_lctr,TEAM));				
				
	if( !(_lctr in curBaseList) ) then
		{
		SETSRVBASECACHEA(_lmctr,CAPLEVEL,100);
		};
	};
int _redBase = 0;
	{
	if( BASEA(_x,SPAWNTYPE) == SPAWN_XRAY ) then
		{
		KRON_UPS_WEST = 0;
		KRON_UPS_EAST = 0;
		if( BASEA(_x,TEAM) == TEAM_RED ) then
			{
			goWestWin=true;
			publicVariable "goWestWin";
			sleep 3;
			triggerWestWin=true;
			}
		else
			{
			goEastWin=true;
			publicVariable "goEastWin";
			sleep 3;
			triggerEastWin=true;
			};
		};
	} forEach curBaseList;
