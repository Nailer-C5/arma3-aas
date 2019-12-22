#include "globalDefines.hpp"
if( (time - lastTime) >= 1 ) then
{
array _reviveInstruction = [];
diag_log format[localize "STR_AAS_update_spawn",count player_units_all];
int _pidx=0;
xmit = objnull;
for "_pidx" from 0 to ((count player_units_all) - 1) do
{
string _recvCmd = "";
_unit = player_units_all select _pidx;
if ( !(isNull _unit) ) then
{
call compile format["_recvCmd = xmit%1;",_unit];
array _recvArray = toArray _recvCmd;

if( count _recvArray == 2 ) then
{
if( (_recvArray select 0) == CMD_PLAYERSPAWNSELECT ) then
{
int _desiredSpawnLoc = _recvArray select 1;
if( SRVBASECACHEA(_desiredSpawnLoc,CAPLEVEL) == 100 ) then
{
_playerQID = _unit call getPlayerQID;

if (!(_playerQID in SRVBASECACHEA(_desiredSpawnLoc,SQUEUE))) then
{
int _qridx = 1;
for [{_qridx = 1},{_qridx < count saas_baselist},{_qridx = _qridx + 1}] do
{
if (_playerQID in SRVBASECACHEA(_qridx,SQUEUE)) then
{
array _newQueue = SRVBASECACHEA(_qridx,SQUEUE) - [_playerQID];
SETSRVBASECACHEA(_qridx,SQUEUE,_newQueue);
};
};
if (_desiredSpawnLoc != AAS_CANCEL_RESPAWN_LOCATION) then
{
array _newQueue = SRVBASECACHEA(_desiredSpawnLoc,SQUEUE) + [_playerQID];
SETSRVBASECACHEA(_desiredSpawnLoc,SQUEUE,_newQueue);
};
};
};
};
if( (_recvArray select 0) == CMD_ADDSCORE ) then
{
_unit addScore (_recvArray select 1);
};
if( (_recvArray select 0) == CMD_PLAYERTEAMSELECT ) then
{
_playerQID = _unit call getPlayerQID;
_arrPlayerTeams = toArray playerTeams;
_arrPlayerTeams set [ _playerQID , _recvArray select 1 ];            
playerTeams = toString _arrPlayerTeams;
publicVariable "playerTeams";
};
if( (_recvArray select 0) == CMD_REVIVEPLAYER ) then
{
_reviveInstruction set [count _reviveInstruction,(_recvArray select 1)];
_reviveInstruction set [count _reviveInstruction,BASEID_REVIVE];
_unit addScore RULES_reviveScore;		// trial of add score to player
};
};						
call compile format["xmit%1 = """";",_unit];
};
};
_spawnInstruction = [ xmitseq + 1 ];
_spawnQueueUpdate = [];
int _cb=0;
for "_cb" from 1 to ((count saas_baselist) - 1) do
{		
int _curSpawnTimer = SRVBASECACHEA(_cb,STIMER);
if( _curSpawnTimer > 0 ) then { _curSpawnTimer = _curSpawnTimer -1 };
SETSRVBASECACHEA(_cb,STIMER,_curSpawnTimer);
if( SRVBASECACHEA(_cb,CAPLEVEL) < 100 ) then
{
SETSRVBASECACHEA(_cb,SQUEUE,[]);
};
array _sQueue = SRVBASECACHEA(_cb,SQUEUE);
_spawnQueueUpdate = _spawnQueueUpdate + [ _cb , _curSpawnTimer + 1, (count _sQueue)+1 ] + _sQueue;
if( _curSpawnTimer == 0 and (count _sQueue) > 0 ) then
{		
int _playerQID = _sQueue select 0;
_sQueue = _sQueue - [ _playerQID ];
SETSRVBASECACHEA(_cb,SQUEUE,_sQueue);			
SETSRVBASECACHEA(_cb,STIMER,BASE_QUEUE_INTERVAL);
_spawnInstruction = _spawnInstruction + [ _playerQID , _cb ];
};
};
if( debugDoReviveAll ) then
{
debugDoReviveAll=false;
_reviveInstruction = [];
{
_reviveInstruction set [count _reviveInstruction,(_x call getPlayerQID)];
_reviveInstruction set [count _reviveInstruction,BASEID_REVIVE];
} forEach player_units_all;
};
_spawnInstruction = _spawnInstruction + _reviveInstruction;
if( count _spawnInstruction > 1 ) then
{
string _info = format["SRV updateSpawnQueues.sqf : _spawnInstruction = %1",_spawnInstruction];
v2 = toString _spawnInstruction;
publicVariable "v2";		
};
v3 = toString _spawnQueueUpdate;
publicVariable "v3";
lastTime = time;
};
