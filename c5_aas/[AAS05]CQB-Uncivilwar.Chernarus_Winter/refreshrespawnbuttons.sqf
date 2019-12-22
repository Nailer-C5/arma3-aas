#include "globalDefines.hpp"
	if( serverHint != "" ) then
	{
		hintSilent serverHint;
		serverHint="";
	};
call processServerCommand;	
_myTeam = TEAM_RED;
if( WEST_PLAYER ) then { _myTeam = TEAM_BLUE; };
string _medmsg = "No medic nearby.";
float _distMedic = NEARBY_MEDIC_DISTANCE;
	{
	bool _tplayerIsMedic=false;
	int _tplayerClass=(_x getVariable "playerclass");
	if( _tplayerClass != LOADOUT_CUSTOM ) then
		{
		if( (RULES_classList select _tplayerClass) select CL_CANREVIVE ) then { _tplayerIsMedic = true; };
		};
	if( _tplayerIsMedic and (_x distance positionOfDeath) < _distMedic ) then
		{
		_distMedic = (_x distance positionOfDeath);
		_medmsg = format["Nearest medic (%1) %2m away.",name _x,round _distMedic];
		};
	} forEach player_units_myteam;
bool _buttonsReady = true;
if( (time-lastDeathTime) < RULES_minSpawnDelay and !deliberateSpawn) then
	{
	int _sssecs = round (RULES_minSpawnDelay-(time-lastDeathTime));
	_medmsg = _medmsg + format[" Spawn select in %1 sec.",_sssecs];
	_buttonsReady = false;
	};
ctrlSetText [ IDCMEDICINFO , _medmsg ];
ctrlShow    [ IDCMEDICINFO , true ];
if (clickedSpawnButton == AAS_CANCEL_RESPAWN_BUTTON) then
{
	playerSelectedSpawn = AAS_CANCEL_RESPAWN_ID;
	clickedSpawnButton = -1;
};
int _maxRows=MAX_SPAWN_ROWS;
int _thisCtrl=0;
int _ctr=1;
for "_ctr" from 1 to ((count saas_baselist) - 1) do
	{
	if( BASEA(_ctr,TEAM) == _myTeam and BASECACHEA(_ctr,CAPLEVEL) == 100 and _buttonsReady ) then
		{		
		if( clickedSpawnButton == _thisCtrl ) then
			{
			playerSelectedSpawn = _ctr;
			DEBUG_LOG format["refreshRespawnButtons.sqf : clickedSpawnButton = %1",clickedSpawnButton];
			DEBUG_LOG format["refreshRespawnButtons.sqf : playerSelectedSpawn = %1",playerSelectedSpawn];
			clickedSpawnButton=-1;
			};
		if( BASEA(_ctr,SPAWNTYPE) == SPAWN_XRAY or BASEA(_ctr,SPAWNTYPE) == SPAWN_INSTANT ) then
			{
			ctrlSetText [ IDCSPAWNQUEUEBASE + _thisCtrl , "No Queue" ];
			ctrlShow    [ IDCSPAWNQUEUEBASE + _thisCtrl , true ];	
			ctrlSetText [ IDCSPAWNBUTTONBASE + _thisCtrl , base_names select _ctr ];
			ctrlShow    [ IDCSPAWNBUTTONBASE + _thisCtrl , true ];
			};
		if( BASEA(_ctr,SPAWNTYPE) == SPAWN_QUEUE ) then
			{
			_queueString = format["%1 in %2 sec : ",base_names select _ctr, BASECACHEA(_ctr,STIMER)];
				_playerQueueList = BASECACHEA(_ctr,SQUEUE);
				_sizeOfQueue = count _playerQueueList;
				if (_sizeOfQueue > 0) then {_queueString = format["%1 (%2)",_queueString,_sizeOfQueue];};
				{
				_pname = (_x call getUnitFromQID) call getName;
					_queueString = _queueString + "," + _pname;
				} forEach _playerQueueList;
			ctrlSetText [ IDCSPAWNQUEUEBASE + _thisCtrl , _queueString ];					
			ctrlShow    [ IDCSPAWNQUEUEBASE + _thisCtrl , true ];				
			ctrlSetText [ IDCSPAWNBUTTONBASE + _thisCtrl , base_names select _ctr ];
			ctrlShow    [ IDCSPAWNBUTTONBASE + _thisCtrl , true ];
			};
			
		_thisCtrl = _thisCtrl + 1;
		};	
	if( _thisCtrl == _maxRows ) then { _ctr = 99; };
	};
while { (_maxRows - _thisCtrl) > 0 } do
	{
	ctrlShow [ IDCSPAWNBUTTONBASE + _thisCtrl , false ];
	ctrlShow [ IDCSPAWNQUEUEBASE  + _thisCtrl , false ];
	_thisCtrl = _thisCtrl + 1;
	};