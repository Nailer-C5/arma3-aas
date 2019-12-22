#include "globalDefines.hpp"
array _cdata = toArray v1;	// compressed data
bool _recalc=false;
int _cb=1;
for[ { _cb=1 } , { _cb < count _cdata } , { _cb = _cb + 3 } ] do
	{
	int _curBaseNo   =  _cdata select (_cb + 0);
	int _curTeam     =  _cdata select (_cb + 1);
	int _curCapLevel = (_cdata select (_cb + 2)) - 1;
	
	if( BASEA(_curBaseNo,TEAM) != _curTeam ) then
		{
		SETBASEA(_curBaseNo,TEAM,_curTeam);
		_recalc=true;
		};
	SETBASECACHEA(_curBaseNo,CAPLEVEL,_curCapLevel);
	};
if( _recalc ) then
	{
	call cmdRecalcDependentBases;
	call cmdRecalcBattleFronts;
	diag_log "CLI unpackStateSAAS.sqf : client recalculating battle fronts";
	};
array _sdata = toArray v2;
v2 = "";		// this is an intermittent message!
int _sd=1;
for[ { _sd=1 } , { _sd < count _sdata } , { _sd = _sd + 2 } ] do
	{
	
	if( (_sdata select (_sd+0)) == myPlayerQID ) then
		{
		serverAuthorisedSpawn=true;
		serverSpawnLocation=_sdata select (_sd+1);
		};		
	};
array _qdata = toArray v3;
v3 = "";		// this is an intermittent message!
int _qd=0;
for[ { _qd=0 } , { _qd < count _qdata } , { _qd = _qd + 0 } ] do
	{
	int _curBase = _qdata select _qd;
	_qd = _qd + 1;
	int _curTimer = (_qdata select _qd) - 1;
	SETBASECACHEA(_curBase,STIMER,_curTimer);	
	_qd = _qd + 1;
	int _sqlen = (_qdata select _qd) - 1;
	_qd = _qd + 1;
	int _sdc=0;
	array _tqueue=[];
	for "_sdc" from 0 to (_sqlen - 1) do
		{
		_tqueue set [count _tqueue,_qdata select (_qd + _sdc)];
		};
	SETBASECACHEA(_curBase,SQUEUE,_tqueue);
	_qd = _qd + _sqlen;
	};