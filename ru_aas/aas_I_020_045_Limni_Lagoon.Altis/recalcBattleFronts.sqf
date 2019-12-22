#include "globalDefines.hpp"
code synched =
	{
	bool _isSynched=true;
		{
		if( BASEA(_x,TEAM) != BASEA(_this,TEAM) ) then { _isSynched=false; };
		} forEach BASEA(_this,SYNC);
	_isSynched
	};
code diffteambases =
	{
	bool _diffBaseTeam=false;
	if( BASEA(_this select 0,TEAM) != BASEA(_this select 1,TEAM) ) then { _diffBaseTeam = true; };
	_diffBaseTeam
	};
array _links = [];
array _neutralBases = [];
array _attList = [ [] , [] , [] , [] ];
array _defList = [ [] , [] , [] , [] ];
int _bfCtr=0;
for "_bfctr" from 0 to ((count saas_baselist) - 1) do
	{
	bool _skip = false;
	if( count (saas_baselist select 0) > 6 ) then
		{
		if( BASEA(_bfCtr,DEPQTY) > 0 ) then { _skip = true; };
		};
	if( !_skip ) then
		{		
		if (BASEA(_bfCtr,TEAM) == TEAM_NEUTRAL) then
		{
			_neutralBases set [count _neutralBases,_bfCtr];
		};
		{
			_links set [count _links,[_bfCtr,_x]];
		} forEach BASEA(_bfCtr,LINK);
		};
	};
	{
	if (((_x select 0) call synched) && ((_x) call diffteambases)) then
		{
        _tlist = _attList select BASEA(_x select 0,TEAM);
        _tlist = _tlist - [ _x select 1 ];
        _attList set [ BASEA(_x select 0,TEAM) , _tlist + [ _x select 1 ] ];
		};
	} forEach _links;
_defList set [ TEAM_BLUE , ( _attList select TEAM_RED  ) - _neutralBases ];
_defList set [ TEAM_RED  , ( _attList select TEAM_BLUE ) - _neutralBases ];
blueAttackList = _attList select TEAM_BLUE;
blueDefendList = _defList select TEAM_BLUE;
redAttackList  = _attList select TEAM_RED;
redDefendList  = _defList select TEAM_RED;
curBaseList = blueAttackList - redAttackList;
curBaseList = curBaseList + redAttackList;
curBaseList = curBaseList - redDefendList;
curBaseList = curBaseList + redDefendList;
curBaseList = curBaseList - blueDefendList;
curBaseList = curBaseList + blueDefendList;
diag_log "CLI ========= recalcBattleFronts.sqf === RESULTS ===========";
diag_log format[ " blueAttackList = %1" , blueAttackList ];
diag_log format[ " blueDefendList = %1" , blueDefendList ];
diag_log format[ " redAttackList = %1"  , redAttackList ];
diag_log format[ " redDefendList = %1"  , redDefendList ];
diag_log format[ "curBaseList = %1", curBaseList ];
diag_log "CLI ========================================================";
