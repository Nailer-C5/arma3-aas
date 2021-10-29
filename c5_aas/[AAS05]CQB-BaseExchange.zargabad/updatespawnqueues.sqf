// File Description
// Name           : updateSpawnQueues.sqf
// Called by      : Server main thread on each iteration
// Referenced by  : ServerMainThread.sqf
// Client/Server  : server side
// Function area  : game mechanics (spawning)
//
// Description
// This function updates the spawn queues on the server. There is
// a queue for every base, including the x-ray  bases, although those
// queue give pretty much instant spawn. The numbering is as follows:
//
// 0    = West Xray
// 1--6 = Alpha...Foxtrot
// 7    = Eaast Xray

// ----------------------------------------------------------------------------
//                            DEFINES
// ----------------------------------------------------------------------------

#include "globalDefines.hpp"

// ----------------------------------------------------------------------------
//                          MAIN ROUTINE
// ----------------------------------------------------------------------------

if( (time - lastTime) >= 1 ) then
	{
	//------------------ handle spawn instructions -----------------------

	array _reviveInstruction = [];
	//NAILER[C5] - LESS VERBOSE DIAGNOSTIC LOG...
	//diag_log format["update spawn queues count player_units all = %1",count player_units_all];
	int _pidx=0;
	xmit = objnull;
	for "_pidx" from 0 to ((count player_units_all) - 1) do
		{
				// process incoming transmission
		string _recvCmd = "";
		_unit = player_units_all select _pidx;
		if ( !(isNull _unit) ) then
			{
			call compile format["_recvCmd = xmit%1;",_unit];
			//missionNamespace setVariable [format ["xmit%1", _unit], _recvCmd];
			//call compile format ["unit%1 = _whatever", _i];
			
			//diag_log format["_recvCmd = xmit%1;",_unit];
			
			array _recvArray = toArray _recvCmd;
	
			if( count _recvArray > 0 ) then
				{
				DEBUG_LOG format["SRV updateSpawnQueues.sqf : RECV %1 = %2",_unit,_recvArray];
				};
			
			if( count _recvArray == 2 ) then
				{
				
				// player command to select a spawn location
				if( (_recvArray select 0) == CMD_PLAYERSPAWNSELECT ) then
					{
					// player wishes to spawn
					int _desiredSpawnLoc = _recvArray select 1;
					
					if( SRVBASECACHEA(_desiredSpawnLoc,CAPLEVEL) == 100 ) then
						{
						_playerQID = _unit call getPlayerQID;
						DEBUG_LOG format["SRV updateSpawnQueues.sqf : enqueuing %1 with QID %2",player_units_all select _pidx,_playerQID];
						
						// if player not already in the queue
						if (!(_playerQID in SRVBASECACHEA(_desiredSpawnLoc,SQUEUE))) then
						{
							// remove player from all queues
							int _qridx = 1;
							for [{_qridx = 1},{_qridx < count saas_baselist},{_qridx = _qridx + 1}] do
							{
								if (_playerQID in SRVBASECACHEA(_qridx,SQUEUE)) then
								{
									array _newQueue = SRVBASECACHEA(_qridx,SQUEUE) - [_playerQID];
									SETSRVBASECACHEA(_qridx,SQUEUE,_newQueue);
								};
							};
							// only add to queue, if not 'cancel' button
							if (_desiredSpawnLoc != AAS_CANCEL_RESPAWN_LOCATION) then
							{
								// add player to requested queue (at end)
								array _newQueue = SRVBASECACHEA(_desiredSpawnLoc,SQUEUE) + [_playerQID];
								SETSRVBASECACHEA(_desiredSpawnLoc,SQUEUE,_newQueue);
							};
						};
					};
				};
				// player command to earn a point
				if( (_recvArray select 0) == CMD_ADDSCORE ) then
					{
					_unit addScore (_recvArray select 1);
					DEBUG_LOG format["SRV updateSpawnQueues.sqf : player %1 earned %2 point(s)",player_units_all select _pidx,_recvArray select 1];
					};
				 
				// player command to select team
				if( (_recvArray select 0) == CMD_PLAYERTEAMSELECT ) then
					{
					_playerQID = _unit call getPlayerQID;
					_arrPlayerTeams = toArray playerTeams;
					_arrPlayerTeams set [ _playerQID , _recvArray select 1 ];            
					playerTeams = toString _arrPlayerTeams;
					publicVariable "playerTeams";
					};
				
				// player command to revive another player
				if( (_recvArray select 0) == CMD_REVIVEPLAYER ) then
					{
						_reviveInstruction set [count _reviveInstruction,(_recvArray select 1)];
						_reviveInstruction set [count _reviveInstruction,BASEID_REVIVE];
					DEBUG_LOG format["SRV updateSpawnQueues.sqf : player %1 revived player QID %2, added to revive instruction" ,player_units_all select _pidx,_recvArray select 1];
					_unit addScore RULES_reviveScore;		// trial of add score to player
					};
						
				};						
				
			// clear the transmission local copy once received
			call compile format["xmit%1 = """";",_unit];
			};
		};

	//-------------------- process spawn queues ----------------------------------


	_spawnInstruction = [ xmitseq + 1 ];
	_spawnQueueUpdate = [];
	
	int _cb=0;
	for "_cb" from 1 to ((count saas_baselist) - 1) do
		{		
		int _curSpawnTimer = SRVBASECACHEA(_cb,STIMER);
			
		// decrement timer
		if( _curSpawnTimer > 0 ) then { _curSpawnTimer = _curSpawnTimer -1 };
		SETSRVBASECACHEA(_cb,STIMER,_curSpawnTimer);

		// capture level for base has fallen below 100, so empty queue
		if( SRVBASECACHEA(_cb,CAPLEVEL) < 100 ) then
			{
			SETSRVBASECACHEA(_cb,SQUEUE,[]);
			};
			
		// timer is zero, so remove one person from the queue if the queue is non-empty
		array _sQueue = SRVBASECACHEA(_cb,SQUEUE);
		_spawnQueueUpdate = _spawnQueueUpdate + [ _cb , _curSpawnTimer + 1, (count _sQueue)+1 ] + _sQueue;
		
		if( _curSpawnTimer == 0 and (count _sQueue) > 0 ) then
			{		
			int _playerQID = _sQueue select 0;
			 _sQueue = _sQueue - [ _playerQID ];
			SETSRVBASECACHEA(_cb,SQUEUE,_sQueue);			

			// set the timer up
			SETSRVBASECACHEA(_cb,STIMER,BASE_QUEUE_INTERVAL);
			
			// add them to the spawn instruction list
			_spawnInstruction = _spawnInstruction + [ _playerQID , _cb ];
			};
				
		};

	// debugging facility - if requested, send a message to revive everyone
	if( debugDoReviveAll ) then
		{
		debugDoReviveAll=false;
		_reviveInstruction = [];
		{
			_reviveInstruction set [count _reviveInstruction,(_x call getPlayerQID)];
			_reviveInstruction set [count _reviveInstruction,BASEID_REVIVE];
		} forEach player_units_all;
		DEBUG_LOG "SRV updateSpawnQueues.sqf : DEBUG sending revive all players message";
		};
		
	// add to the list of spawners the list of anyone who has been revived
	_spawnInstruction = _spawnInstruction + _reviveInstruction;
		
	// send the spawn message and queue list
	if( count _spawnInstruction > 1 ) then
		{
		string _info = format["SRV updateSpawnQueues.sqf : _spawnInstruction = %1",_spawnInstruction];
		DEBUG_LOG _info;
		//serverHint = _info;
		//publicVariable "serverHint";
		v2 = toString _spawnInstruction;
		publicVariable "v2";		
		};
	
	v3 = toString _spawnQueueUpdate;
	publicVariable "v3";
	
	lastTime = time;
	};
	