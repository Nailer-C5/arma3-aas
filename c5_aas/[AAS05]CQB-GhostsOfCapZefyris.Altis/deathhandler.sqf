#include "globalDefines.hpp"
if (!(local player)) exitWith {};
_magazinesAtDeath = [];
_weaponsAtDeath = [];
death_cam = objNull;
deliberateSpawn=false;
activateSpawnMenu=false;
while {true} do 
	{
	diag_log "CLI deathHandler.sqf : KILL HANDLER WAITING";
	waitUntil { !(alive player) or DEBUG_create_death or activateSpawnMenu };   
	DEBUG_create_death=false;
	pos positionOfDeath = getPos player;
	PositionOfDeath = [PositionOfDeath select 0,PositionOfDeath select 1,0];
	pos _positionAboveGround = getPosATL player;
	float _height = _positionAboveGround select 2;
	bool _isPlayerInTheAir = false;
	if (_height > 2) then {_isPlayerInTheAir = true;};
	_deliberateSpawn = false;
	if (deliberateSpawn) then {_deliberateSpawn = true;};
    deliberateSpawn=false;
	if( activateSpawnMenu ) then { deliberateSpawn = true; };
	activateSpawnMenu=false;
	unit _deadUnit = player;    
	bool _reallyDead=false;
    if( !(alive player) ) then
        {
		_reallyDead=true;
        spawnPrecursorMessage = "You are unconscious and waiting to be revived";
		_magazinesAtDeath = magazines player;
		_weaponsAtDeath = weapons player;
        };
	pos _savedPlayerPos = getPos player;
	diag_log "CLI deathHandler.sqf : KILL HANDLER ACTIVE";	
	lastDeathTime=time;					// now we just died, log timespawn for anti-spawncamp
	if (surfaceIsWater getPos player and WEST_PLAYER ) then
		{
		player setPos getMarkerPos "respawn_west";
		};
	if (surfaceIsWater getPos player and EAST_PLAYER ) then
		{
		player setPos getMarkerPos "respawn_east";
		};
	enableRadio false;
	titlecut [" ","BLACK OUT",10];
	sleep 0.2;			
	diag_log "CLI deathHandler.sqf : running cam follow";
	spawnDialogReady=false;
	_bee = "butterfly" createVehicle [0,0,0];
	[_bee, _savedPlayerPos ] execVM "createSpawnDialog.sqf";
	sleep 0.123;
	waitUntil {alive player};
	classChangeLocked=false;   
	_args = [false,playerClass];
	[0,0,0,_args] spawn cmdDoQuickLoadout;	
	sleep 0.05;
	waitUntil { spawnDialogReady };
	diag_log "CLI deathHandler.sqf : entering spawn loop";
	clickedSpawnButton = -1;		
	playerSelectedSpawn = -1;
	serverAuthorisedSpawn = false;
	int _baseToSpawnAt = -1;
	bool _spawned = false;
	while { !_spawned } do
		{
		call cmdRefreshRespawnButtons;		
		if( playerSelectedSpawn != -1 ) then
			{
			switch (BASEA(playerSelectedSpawn,SPAWNTYPE)) do
			{
				case SPAWN_XRAY:
				{
				preloadCamera (getMarkerPos BASENAME(playerSelectedSpawn));
				DEBUG_LOG format["deathHandler.sqf : player authorised spawn at Xray/Instant base"];
				_baseToSpawnAt = playerSelectedSpawn;
				_spawned=true;
				};
				case SPAWN_QUEUE:
				{
				preloadCamera (getMarkerPos BASENAME(playerSelectedSpawn));
				DEBUG_LOG "deathHandler.sqf : transmitting spawn request.";
				array _xmitCmd = [ CMD_PLAYERSPAWNSELECT , playerSelectedSpawn ];					
				 _xmitCmd call cmdPlayerTransmitCmd;				 
				};
				case AAS_CANCEL_RESPAWN_ID:
				{
					array _xmitCmd = [CMD_PLAYERSPAWNSELECT,AAS_CANCEL_RESPAWN_LOCATION];
					_xmitCmd call cmdPlayerTransmitCmd;
				};
			};
			playerSelectedSpawn = -1;
			};
		if( serverAuthorisedSpawn ) then
			{
			serverAuthorisedSpawn = false;
			_spawned=true;
			DEBUG_LOG format["deathHandler.sqf : spawn authorised by server"];
			DEBUG_LOG format["deathHandler.sqf : serverSpawnLocation = %1",serverSpawnLocation];
			_baseToSpawnAt = serverSpawnLocation;
			};
		if( not (alive player) ) then
			{
			waitUntil { alive player };
			DEBUG_LOG format["deathHandler.sqf : player died when at spawn menu. Emergency authorised spawn at Xray"];
			
			int _myTeam1=TEAM_RED;
			if( WEST_PLAYER ) then { _myTeam1 = TEAM_BLUE; };
			
			int _xrayBase = -1;
			
			{ if( (_x select SPAWNTYPE) == SPAWN_XRAY and (_x select TEAM) == _myTeam1 ) then { _xrayBase = _x select ID; }; } forEach saas_baselist;
			_baseToSpawnAt = _xrayBase;
			_spawned=true;
			};
			
		sleep 0.2;
		};		
	spawnDialogReady = false;
	
	diag_log "CLI deathHandler.sqf : leaving spawn loop";
		
	enableRadio true;
	string _spawnString = "Error.";
	
	if( _reallyDead ) then
		{
		deleteVehicle _deadUnit;
		if (localDebugMode) then {hint "Deleted old body";};
		_reallyDead=false;
		};
		
	if( _baseToSpawnAt == BASEID_REVIVE ) then
		{
		_spawnString = "You have been revived.";
		
		removeAllWeapons player;
		{ player removeWeapon _x } forEach weapons player;

		{ player addMagazine _x } forEach _magazinesAtDeath;
		{ player addWeapon _x } forEach _weaponsAtDeath;
		player selectWeapon primaryWeapon player;
		sleep 3;
		if (_isPlayerInTheAir) then
		{
			player setPos PositionOfDeath;
		}
		else
		{
			player setPosATL _positionAboveGround;
		};	
		}
	else
		{
		//NAILER[C5] - REMOVED PRINTINGPRESS...
		//string _spawnString = [[format["You have respawned at %1",base_names select _baseToSpawnAt],"<t align = 'Center' shadow = '1' size = '0.7'>%1</t><br/>"]] spawn PrintingPress;
		string _spawnString = format["You have respawned at %1",base_names select _baseToSpawnAt];
		float _spawnRandX=0;
		float _spawnRandY=0;
		hintSilent format ["Last life duration %1 secs.",round (lastDeathTime - lastRespawnTime)];
		if( spawncampProtection == 1 and (lastDeathTime - lastRespawnTime ) < SPAWNCAMP_MIN_LIFESPAN and !deliberateSpawn ) then
			{
			hintSilent format [ "Died in last %1 secs: randomising spawn location." , round (lastDeathTime - lastRespawnTime) ];
			_spawnRandX = (0 - SPAWNCAMP_RANDOMISE_BOUND) + random (SPAWNCAMP_RANDOMISE_BOUND*2);
			_spawnRandY = (0 - SPAWNCAMP_RANDOMISE_BOUND) + random (SPAWNCAMP_RANDOMISE_BOUND*2);
			};
		AAS_EH_HD_ID = player addEventHandler ["HandleDamage",{false}];
		AAS_EH_Fired_ID = player addEventHandler ["Fired",
			{
				AAS_SpawnArmourActive = false;
				hintSilent "";
				player removeEventHandler ["HandleDamage",AAS_EH_HD_ID];
				player removeEventHandler ["Fired",AAS_EH_Fired_ID];
			spawnArmourTime = (time-(SPAWN_ARMOUR_DURATION+1)); // reset the spawn armour timer so as not to confuse peeps
			} ];
		pos _spawnPos = getMarkerPos BASENAME(_baseToSpawnAt);	
		player setPos [ (_spawnPos select 0) + _spawnRandX , (_spawnPos select 1) + _spawnRandY , (_spawnPos select 2) + SPAWN_ELEVATION];		
		spawnArmourTime=time;		
			AAS_SpawnArmourActive = true;
		};
	publicVariable "death_cam";	
	death_cam CameraEffect ["Terminate","Back"];
	CamDestroy death_cam;
	titlecut [" ","BLACK IN",4];
	player switchCamera "INTERNAL";
	titleCut [" ","BLACK OUT",2];
	//titleText [ _spawnString, "PLAIN", 0.5];
	closeDialog 0;
	closeDialog 1;
	closeDialog 2;
	closeDialog 3;
	lastRespawnTime=time;		// last time we respawned is now
	{ player reveal _x; } forEach ((getPos player) nearObjects ["AllVehicles",100]);
	{ player reveal _x; } forEach ((getPos player) nearObjects ["B_supplyCrate_F",50]);
	player addRating 100000;
	if ((daytime < 4) || (daytime > 23)) then
	{
		player action ["nvGoggles",player];
	};
	cutRsc ["HudDisplay","PLAIN",0];				
	};
true