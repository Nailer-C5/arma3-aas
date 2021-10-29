#include "globalDefines.hpp"
string consoleExecuteCommand="";		// command to execute on console
bool consoleCommandMode=false;		// mode switch for if console is engaged
string keyPressCurrCmd="";				// working string to build up console command
int localSpawnID=0;					// base ID at which player (client) has selected to spawn
string tleft="???"; 					// time left string
string playerClass = 0;
int myFireTeam = 100;
bool enableConsole=true;
onPlayerConnected {};
onPlayerDisconnected {};
int consoleEnableCounter=0;
float myOvercast = -1;
float myRain = -1;
float myFog = -1;
float myGusts = -1;
float myLightnings = -1;
float myRainbow = -1;
int hudDisplayLevel = HUD_MAX_LEVEL;
bool resetHUD = false;		// marker to attempt HUD reset (bug recovery)
int lastRespawnTime=0;	// records time at which we last respawned
int lastDeathTime=0;		// records time at which we last died
bool AAS_SpawnArmourActive = false;
string spawnPrecursorMessage = "Choose your initial spawn point";
bool activateSpawnMenu=false;
float mapZoomLevel = 0.19;
int _minleft=0;	   // minutes left before game end
int _secleft=0;    // seconds left 
int _sounded=0;
float _lastHintTime=time;
int _curHintInterval=HINT_INTERVAL;
float _attZoneEntryTime=time;
float _defZoneEntryTime=time;
float _prevPlayerDamage=0;		// last seen damage level of player
float _serverTimeOffset=0;      // difference between server clock and our clock
code _updateHUD               = compileFinal preprocessFile "updateHUD.sqf";
code _updateZonePlayerLists   = compileFinal preprocessFile "updateZonePlayerLists.sqf";
code _showHint                = compileFinal preprocessFile "showHint.sqf";
code _processPlayerEffects    = compileFinal preprocessFile "processPlayerEffects.sqf";
code processServerCommand    = compileFinal preprocessFile "processServerCommand.sqf";
code AAS_fnc_cPunishTeamKill = compileFinal preprocessFileLineNumbers "cPunishTeamKill.sqf";//TODO
code AAS_fnc_cGetName = compileFinal preprocessFileLineNumbers "cGetName.sqf";
code AAS_fnc_cReducePlayerName = compileFinal preprocessFileLineNumbers "cReducePlayerName.sqf";
code AAS_fnc_cDragActions = compileFinal preprocessFileLineNumbers "cDragActions.sqf";
"AAS_PublicTeamkillPunishmentInfoMessage" addPublicVariableEventHandler
{
 _nameKiller = (_this select 1) select 0;
 _nameKilled = (_this select 1) select 1;
 [playerSide,"HQ"] commandChat (format ["%1 has been punished for teamkilling %2",_nameKiller,_nameKilled]);
};
"AAS_PublicAddActionsAndEH" addPublicVariableEventHandler
{
	_vehicle = _this select 1;
	_vehicle disableTIEquipment true;
	if ((_vehicle isKindOf "Helicopter") || ((typeOf _vehicle) == "B_MH9_F")) then {_vehicle addEventHandler ["GetIn","_this spawn AAS_fnc_Lift;"];};
};
{
	_x disableTIEquipment true;
	if ((_x isKindOf "Helicopter") || ((typeOf _x) == "B_MH9_F")) then {_x addEventHandler ["GetIn","_this spawn AAS_fnc_Lift;"];};
} forEach vehicles;
"AAS_PublicSetDirObject" addPublicVariableEventHandler
{
 _object = (_this select 1) select 0;
 _direction = (_this select 1) select 1;
 _object setDir _direction;
};
"AAS_PublicSwitchMoveObject" addPublicVariableEventHandler
{
 _object = (_this select 1) select 0;
 _animationId = (_this select 1) select 1;
 _animationName = switch (_animationId) do
 {
  case AAS_AINJPPNEMSTPSNONWRFLDB_STILL: {"ainjppnemstpsnonwrfldb_still"};
  case AAS_DEADSTATE:   {"DeadState"};
 };
 _object switchMove _animationName;
};
sleep 1;
player setVariable ["AAS_Side",playerSide,true];
player setVariable ["AAS_UnitName",name player,true];

if (AAS_Params_PunishTeamkills == 1) then
{
 player addEventHandler ["killed","_this spawn AAS_fnc_cPunishTeamKill;"];
};
disableSerialization;
//NAILER[C5] - DISABLE INTRO - ADD WELCOME MESSAGE...
//_0 = [player, SHORT_VERSION,5,nil,120,1] call establishingShot;
string _versionMessage = SHORT_VERSION;
string _welcomeMessage = "\nWelcome to Cerberus 5 Server  \n* Want to join our Community? Visit C5GAMING.COM \n* Join us on TS3 at TS3.C5GAMING.COM";
string _specMsg = format ["\nPercentage of players using scoped weps : %5%6",specialisationPercentRed,"%",specialisationPercentBlue,"%",scopedPercent,"%"];
titleText [format["AAS - Advance and Secure\n%1\n\n%2\n%3",_versionMessage,_specMsg,_welcomeMessage], "BLACK FADED", 0];	// black out screen for initial start
sleep 8; //used to have AAS splash screen here
//END NAILER[C5]
int showChooserTime = 0;	    // amount of time remaining to show the team chooser menu
float _lastChooserTime = time;  // last second in which chooser was shown
pos lastChooserPos = getPos player;  // position the player was in when the menu was brought up
int myRifleIndex = 0;		// index of rifle from standard rifles list used
array myRifles = [];        // list of available rifles to current class
myRifles = (RULES_classList select playerClass) select CL_WESTRIFLES;
if( EAST_PLAYER ) then { myRifles = (RULES_classList select playerClass) select CL_EASTRIFLES; };
bool classChangeLocked=false;     // lock the user out of class change for X seconds
float lastClassChangeTime=time-(RULES_classChangeDelay*2);   // time at which class was last changed
code KeyHandler = compileFinal( preprocessFileLineNumbers "keypress.sqf" );
code KeyHandlerRespawnDialog = compileFinal(preprocessFileLineNumbers "keypressRespawnDialog.sqf");
int desiredTeamID=0; // used in the keypress.sqf for shortcut to switch player teams
(findDisplay 46) displaySetEventHandler ["KeyDown","_this call KeyHandler"];
[0,0,0,[false,playerClass]] spawn cmdDoQuickLoadout;
player addRating 100000;
code addBriefing = 
    {
    player createDiaryRecord ["Diary", ["Rules",RULES_ruleSetName]];
    player createDiaryRecord ["Diary", ["Version",versionString]];
    player createDiaryRecord ["Diary", ["Scoring","You can earn points during each game:<br/> 1 point per kill<br/> 10 points for capturing an objective<br/> 1 point per 30 seconds attacking<br/> 1 point per 60 seconds defending<br/> 1 point per medic revive<br/> <br/>"] ];
    player createDiaryRecord ["Diary", ["Advance and Secure","This is <B>Advance And Secure</B>. Fight for control of the string of bases, Alpha through Foxtrot, which must be taken sequential order. The display on the top right of your screen shows the two contested bases. You must defend your own, and simultaneously attack the enemy's. Each team starts in control of three bases.<br/><br/>In order to seize the enemy base you must enter the outer perimeter, and outnumber the enemy until the base capture bar reaches zero. You must then get at least one soldier within 10m of the central flag to complete the capture.<br/><br/> When you die, you can wait to be revived by a team-mate, or you can respawn at any base fully camped by your team. The more people spawning at a base, the longer you will have to queue. Your X-Ray base has the most vehicles, but is the furthest away. Visit the armoury near each base flag, to select between the <B>quick loadouts</B> of Rifleman, Medic, Gunner, Engineer, Sniper. Alternatively, use the gear menu to choose your own loadout.<br/><br/> Advance And Secure is tactical: luck is not a factor!<br/>"] ];
    };
call addBriefing;
diag_log format["CLI ClientMainThread.sqf : %1",versionString];
int clickedSpawnButton  = -1;		// the control ID of the button clicked
int playerSelectedSpawn = -1;		// the based ID of the base player would like to spawn at
bool serverAuthorisedSpawn=false;
int serverSpawnLocation=-1;
bool playerCanRevive = (RULES_classList select playerClass) select CL_CANREVIVE;
string myClassName = (RULES_classList select playerClass) select CL_NAME; 
tagDisplayRange=DEFAULT_TAG_DISPLAY_RANGE;
string myName = format["%1",player];
int myPlayerQID = player call getPlayerQID;
DEBUG_LOG format["CLI ClientMainThread.sqf : myPlayerQID = %1",myPlayerQID];
DEBUG_LOG format["CLI ClientMainThread.sqf : myName = %1",myName];
call cmdUpdatePlayerLists;
_firstHudLaunch=true;
array playerMarkers = [];
string _mColor="ColorBlue";
if( EAST_PLAYER ) then
	{
		 _mColor="ColorRed";
	};
int _ctr=0;
for "_ctr" from 0 to (MAX_PLAYERS_PER_SIDE - 1) do
{
	obj _m = createMarkerLocal[ format["marker%1", _ctr ] , [10000,10000]];
	_m setMarkerTextLocal "";			// let's not use name tags
	_m setMarkerTypeLocal "mil_arrow"; 		// these look good
	_m setMarkerSizeLocal[0.3, 0.3];	// make it small
	
	playerMarkers set [count playerMarkers,_m];
	_m setMarkerColorLocal _mColor;	
};

spawnArmourTime=time;
teamMateMarker=-1;	// index number of teammate to mark to follow (special colour)
bool updateTagsThreadRun = false;
sleep 0.1;
customWeapons = weapons player;
customMagazines = magazines player;
customUniforms = uniform player;
customVests = vest player;
customBackpacks = backpack player;
customGoggles = goggles player;
customHeadgears  = headgear player;
customItems = items player;
customPrimaryWeaponItems  = primaryWeaponItems player;
triggerWestWin=false;	// west/blues win
triggerEastWin=false;	// east/reds win
triggerStalemate=false;	// stalemate
CLIENT_initialised=true;
int _smsgtime=time;		// time last spawn armour message was displayed (to ensure it only displays once per second)
int _slowCounter=0;				
while { true } do
	{	
	if( AAS_cst < 60 ) then
		{
		triggerWestWin=false;	// west/blues win
		triggerEastWin=false;	// east/reds win
		triggerStalemate=false;	// stalemate
		};
	call cmdUnpackStateSAAS;			
	if( centralServerTime != -1 ) then
		{
		_serverTimeOffset = (centralServerTime - time);
		AAS_cst = centralServerTime;	// countermeasure to try to stop JIP-quit-to-result-screen bug
		centralServerTime = -1;
		};
	_curtime = time + _serverTimeOffset;
	_minleft=floor ((timemax-_curtime) / 60);
	_secleft=floor (timemax-_curtime)-(_minleft*60);
	if( _minleft < 0 ) then { _minleft = 0; _secleft = 0; };	// prevent timer from going negative
	
	if( _secleft >= 10 ) then
	{
		tleft=format["%1:%2",_minleft,_secleft];
	}
	else
	{
		tleft=format["%1:0%2",_minleft,_secleft];
	};
	_slowCounter=_slowCounter + 1;
	if( _slowCounter >= 600 ) then { _slowCounter=0; };
	call _updateZonePlayerLists;	// done by both client and server
	_currentCutDisplay = uiNamespace getVariable "curdisp";
	if (!(isNil "_currentCutDisplay")) then {
	if( !isNull _currentCutDisplay ) then
		{	
		call _updateHUD;
		};
       };		
	if( (_slowCounter mod 60) == 0  ) then
		{
		call cmdUpdatePlayerLists;
		array _weps = weapons player;			
		bool _scoped = false;
		bool _heavy = false;
		
			{
			if( _x in scopedWeapons ) then { _scoped = true; };
			if( _x in heavyWeapons  ) then { _heavy = true;  };
			} forEach _weps;
		
		if( _scoped and _heavy ) then
			{
			hint "You may not carry both scoped and heavy weapons. Removing all weapons.";
			removeAllWeapons player;
			};
		};
	if( serverHint != "" ) then
	{
		hintSilent serverHint;
		serverHint="";
	};
		{
		if( BASECACHEA(_x,CAPLEVEL) == 0 and BASECACHEA(_x,PREVCAPLEVEL) > 0 ) then
			{
			if( _sounded == 0 ) then { playSound "BaseCaptureSnd"; _sounded=40;	};
			};
		
		if( BASECACHEA(_x,CAPLEVEL) == 100 and BASECACHEA(_x,PREVCAPLEVEL) < 100 ) then
			{
			if( _sounded == 0 ) then { playSound "BaseCaptureSnd"; _sounded=40;	};
			};

		SETBASECACHEA(_x,PREVCAPLEVEL, BASECACHEA(_x,CAPLEVEL) );
		} forEach( curBaseList );
			
	if( _sounded > 0 ) then { _sounded=_sounded-1; };
				
	if (!AAS_processServerCommand_Busy) then {AAS_processServerCommand_Busy = false;[] spawn processServerCommand;};
    array _myAttList = redAttackList;
    array _myDefList = redDefendList;
       
	if( WEST_PLAYER ) then
		{
        _myAttList = blueAttackList;
        _myDefList = blueDefendList;
        };
    if( ({ BASECACHEA(_x,PLAYERPRESENT) } count _myAttList) > 0 ) then
    	{
    	if( (time-_attZoneEntryTime) > SECONDS_ATTZONE_TOSCORE ) then
    		{
    		[ CMD_ADDSCORE , POINTS_ATTZONE_PERPERIOD ] call cmdPlayerTransmitCmd;
    		_attZoneEntryTime=time;
    		};
        }
    else
        {
        _attZoneEntryTime=time; 
        };
    if( ({ BASECACHEA(_x,PLAYERPRESENT) } count _myDefList) > 0 ) then
    	{
    	if( (time-_defZoneEntryTime) > SECONDS_DEFZONE_TOSCORE ) then
    		{
    		[ CMD_ADDSCORE , POINTS_ATTZONE_PERPERIOD ] call cmdPlayerTransmitCmd;
    		_defZoneEntryTime=time;
    		};
        }
    else
        {
        _defZoneEntryTime=time; 
        };
      if (AAS_Params_ShowHint == 1) then{  
	if( (time-_lastHintTime) > _curHintInterval ) then
		{
		call _showHint;
		_lastHintTime=time;
		_curHintInterval=HINT_INTERVAL;
		};
       };	
	if( showChooserTime > 0 ) then
		{
		if( (round time) != _lastChooserTime ) then
			{
			showChooserTime = showChooserTime - 1;
			_lastChooserTime = (round time);
			};
			
		if( ((getPos player) distance lastChooserPos) > 0.1 ) then
			{
			showChooserTime = 0;
			};
		};
	if( ((round (time-lastClassChangeTime)) == CLASS_CHANGE_SETTLE_TIME) and (time > 30) ) then
		{
		classChangeLocked=true;
		};
		
	if( (time-lastClassChangeTime) > RULES_classChangeDelay ) then
		{
		classChangeLocked=false;
		};
	if( goWestWin   and (AAS_cst > 60)) then { triggerWestWin   = true; };
	if( goEastWin   and (AAS_cst > 60)) then { triggerEastWin   = true; };
	if( goStalemate and (AAS_cst > 60)) then { triggerStalemate = true; };
	if (((time - spawnArmourTime) < SPAWN_ARMOUR_DURATION) && (time > 5) && ((round time) != _smsgtime) && AAS_SpawnArmourActive) then
		{
		_smsgtime = round time;
		hintSilent format [ "Spawn Armour Active ... %1",round (SPAWN_ARMOUR_DURATION - (time-spawnArmourTime)) ];
		};	
	if ((time - spawnArmourTime) > (SPAWN_ARMOUR_DURATION) && AAS_SpawnArmourActive) then
		{
		AAS_SpawnArmourActive = false;
		hintSilent "";
		player removeEventHandler ["HandleDamage",AAS_EH_HD_ID];
		player removeEventHandler ["Fired",AAS_EH_Fired_ID];
		if (localDebugMode) then { DEBUG_LOG "CLI ClientMainThread.sqf : spawn armour expired. removing HandleDamage event handler"; };
		};
	_protectBaseSelect = [ "dummy" , "respawn_west" , "respawn_east" , "dummy" ];
	int _tMyTeam=TEAM_RED;
	if( WEST_PLAYER ) then { _tMyTeam = TEAM_BLUE; };
    if( (player distance (getMarkerPos (_protectBaseSelect select _tMyTeam))) < BOOTHILLCAMP_RADIUS ) then
		{
		hintSilent format ["DANGER: You are not allowed within %1m of boot hill (%2m)",BOOTHILLCAMP_RADIUS,round (player distance (getMarkerPos (_protectBaseSelect select _tMyTeam)))];
		player setDamage (damage player + 0.01);		
		};
	if( spawncampProtection == 1 ) then
		{			
		int _pblCtr=0;
		for "_pblctr" from 0 to ((count saas_baselist) - 1) do
			{			
			if( BASEA(_pblCtr,SPAWNTYPE) == SPAWN_XRAY and BASEA(_pblCtr,TEAM) != _tMyTeam ) then
				{
				float _theDist =  player distance (getMarkerPos BASENAME(_pblCtr));
				if(  _theDist < SPAWNCAMP_RADIUS ) then					
					{
					hintSilent format ["WARNING: You are not allowed within %1m of enemy spawn (%2m)",SPAWNCAMP_RADIUS,round _theDist ];
					player setDamage (damage player + 0.01);
					};
				};
			};
		};
		//TODO make a work around for Revive addaction
		{		
		if( !(alive _x) ) then
			{
			diag_log format["dead is %1",_x];
			bool _added = false;
			_added = _x getVariable "addedRevive";
			
			if( !_added ) then
				{
				int _reviveQID = _x getVariable "qid";
				_x addAction ["Revive player","actionMenuHandler.sqf",["REVIVE",_reviveQID],10,true,true,"","(playerCanRevive || RULES_everyoneCanRevive)"];
				_x setVariable ["addedRevive",true,false];
				if (localDebugMode) then {DEBUG_LOG format["Your teammate QID %1 (%2) is down.",_reviveQID,_x];};
				};				
			}
		else
			{
			_x setVariable ["addedRevive",false,false];
			};
			
		} forEach player_units_myteam;
	if( resetHUD or _firstHudLaunch) then
		{
		resetHUD=false;
        
        if( _firstHudLaunch ) then
            {
			cutRsc ["HudDisplay","PLAIN",0];
			(findDisplay 46) displaySetEventHandler ["KeyDown","_this call KeyHandler"];
			activateSpawnMenu = true; // calls respawn menu
            }
        else
            {
            cutRsc ["HudDisplay","PLAIN",0];				
			(findDisplay 46) displaySetEventHandler ["KeyDown","_this call KeyHandler"];
            };
        _firstHudLaunch=false;		
		};
	call cmdProcessPlayerAttribs;		
	call _processPlayerEffects;
	};