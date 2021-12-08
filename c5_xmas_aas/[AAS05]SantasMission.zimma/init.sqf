enableSaving[false,false];
#include "globalDefines.hpp"
bool RULES_initialised=false;    // this flag tells other scripts to pause until the rules have been set up
bool CLIENT_initialised=false;   // this flag tells setupcontrolcrates script to pause until client is ready
float AAS_cst=0;			// this counter should hold central server time and is used to check win
bool triggerWestWin=false;	// west/blues win (actual triggers)
bool triggerEastWin=false;	// east/reds win
bool triggerStalemate=false;	// stalemate
public bool goWestWin=false;	// west/blues win (public transmitted variables)
public bool goEastWin=false;	// east/reds win
public bool goStalemate=false;	// stalemate
if (isNil "BIS_fnc_areEqual") then {BIS_fnc_areEqual = compileFinal preprocessFileLineNumbers "fn_areEqual.sqf";};			
code cmdRefreshRespawnButtons = compileFinal preprocessFile "refreshRespawnButtons.sqf";
code cmdHashString = compileFinal preprocessFile "hashString.sqf";
code cmdPRNG = compileFinal preprocessFile "prng.sqf";
code cmdInitSAAS = compileFinal preprocessFile "initSAAS.sqf";
code cmdUnpackStateSAAS = compileFinal preprocessFile "unpackStateSAAS.sqf";
code cmdPackStateSAAS = compileFinal preprocessFile "packStateSAAS.sqf";
code cmdCaptureBase = compileFinal preprocessFile "captureBase.sqf";
code cmdRecalcBattleFronts = compileFinal preprocessFile "recalcBattleFronts.sqf";
code cmdRecalcDependentBases = compileFinal preprocessFile "recalcDependentBases.sqf";
code cmdPlayerTransmitCmd = compileFinal preprocessFile "playerTransmitCmd.sqf";
code cmdUpdatePlayerLists = compileFinal preprocessFile "updatePlayerLists.sqf";
code updateGUI = compileFinal preprocessFile "updateGUI.sqf";
code updateGUIremove = compileFinal preprocessFile "updateGUIremove.sqf";
code cmdProcessPlayerAttribs = compileFinal preprocessFile "processPlayerAttribs.sqf";
code cmdDoQuickLoadout = compileFinal preprocessFileLineNumbers "doQuickLoadout.sqf";
//code AAS_fnc_Lift = compile preprocessFileLineNumbers "features\heli_lift\lift.sqf";
code cmdSetRulesDefault    = compileFinal preprocessFile "RULES_default.sqf";
code cmdSetRulesAUSARMA    = compileFinal preprocessFile "RULES_AUSARMA.sqf";
code cmdSetRulesGBB    = compileFinal preprocessFile "RULES_GBB.sqf";
//NAILER[C5] - ADD C5 RULES...
code cmdSetRulesC5    = compileFinal preprocessFile "RULES_C5.sqf";
saveLoadout = compileFinal preprocessFileLineNumbers "fnc_saveLoadout.sqf";
loadGear = compileFinal preprocessFileLineNumbers "fnc_loadGear.sqf";
arsenalItems = compileFinal preprocessFileLineNumbers "VirtualArsenalItems.sqf";
//NAILER[C5] - NO INTRO NEEDED AND SOUNDS REMOVED...
//establishingShot = compileFinal preprocessFileLineNumbers "fn_establishingShot.sqf";		  
code getName =
	{
	string _resultname="Unknown";
	if( alive _this ) then
		{
		_resultname = name _this;
		}
	else
		{
		//_resultname = format["%1",_this];
		_resultname = "DEAD";
		};
	_resultname
	};
code getPlayerQID =
	{
	array _parr = toArray format["%1",_this];
	int _qid=1;
	if( _parr select 6 == 69 ) then { _qid = _qid + 0   };
	if( _parr select 6 == 87 ) then { _qid = _qid + 100 };
	if( count _parr == 12 ) then
		{
		_qid = _qid + (((_parr select 10)-48) * 10) + ((_parr select 11)-48);
		}
	else
		{
		_qid = _qid + ((_parr select 10)-48);
		};
	_qid
	};
code getUnitFromQID =
	{
	unit _unit = nil;
	string _unitName= "player";
	int _qidRemainder=0;
	if( _this < 100 ) then
		{
		_unitName = _unitName + "East";
		_qidRemainder = _this - 1;
		}
	else
		{
		_unitName = _unitName + "West";
		_qidRemainder = _this - 100 - 1;
		};
	_unitName = _unitName + format["%1", _qidRemainder];
	call compile format["_unit = %1;",_unitName];
	DEBUG_LOG format["getUnitFromQID : QID = %1 , unit = %2",_this,_unit];
	_unit
	};
code getRifleName =
	{
	_name = "Unknown";
	{ if( _x select WL_NAME == _this ) then { _name = _x select WL_PRINTEDNAME; }; } forEach RULES_wepsList;
	_name
	};
code getDefaultMags = 
	{
	_mags = [];
	{ if( _x select WL_NAME == _this ) then { _mags = _x select WL_MAGLIST; }; } forEach RULES_wepsList;
	_mags
	};
call Compile preprocessFileLineNumbers "features\DOM_squad\x_netinit.sqf";
if (!isDedicated) then {
	call Compile preprocessFileLineNumbers "features\DOM_squad\x_uifuncs.sqf";
	};
bool EditorModeSP = false;
int timemax=60 * 60;
if (isNil "paramsArray") then
{
 	AAS_Params_Rules = SETUP_PUBLIC;
 	AAS_Params_GameDuration = 60;
	AAS_Params_TimeOfDay = 0;
	AAS_Params_HourOfDay = 0;
	AAS_Params_MinuteOfDay = 0;
	AAS_Params_Weather = 0;
	AAS_Params_Fog = 0;
	AAS_Params_ViewDistance = 1500;
	AAS_Params_Grass = 0;
	AAS_Params_RecruitAIStatusDialog = 0;
	AAS_Params_GoToSquadLeader = 1;
	AAS_Params_SASHALO = 1;
	AAS_Params_ShowHint = 1;
	AAS_Params_DisableProfileSaveLoad = 0;	
	AAS_Params_AISupportMode = SUPPORT_OFF;
	AAS_Params_AIVehiclesUse = 0;
	AAS_Params_NumberOfAIgroups = 5;
    AAS_Params_NumberOfAIunitsPerGroup = 2;
	AAS_Params_AIVehiclesUsePercentage = 0;
	AAS_Params_AggressiveAIBehavior = 0;
	AAS_Params_AIDebugMode = 0;
	AAS_Params_CameraView = 0;
 	EditorModeSP = true;
}
else
{
              for "_i" from 0 to (count paramsArray - 1) do {
    missionNamespace setVariable [configName ((missionConfigFile >> "Params") select _i), paramsArray select _i];
 	};
};
switch (AAS_Params_GameDuration) do
{
 	case 20: { timemax = 20 * 60; };
 	case 30: { timemax = 30 * 60; };
 	case 45: { timemax = 45 * 60; };
 	case 60: { timemax = 60 * 60; };
	case 90: { timemax = 90 * 60; };
	case 120: { timemax = 120 * 60; };
};
call cmdSetRulesDefault;
if( AAS_Params_Rules == SETUP_PUBLIC     ) then { call cmdSetRulesDefault };
if( AAS_Params_Rules == SETUP_AUSARMA         ) then { call cmdSetRulesAUSARMA };
if( AAS_Params_Rules == SETUP_GBB    ) then { call cmdSetRulesGBB };
//NAILER[C5] - ADD C5 RULES
if( AAS_Params_Rules == SETUP_C5    ) then { call cmdSetRulesC5 };
setViewDistance AAS_Params_ViewDistance;
if (AAS_Params_Grass == 0) then {setTerrainGrid 50};
RULES_initialised=true;
call cmdInitSAAS;
AAS_NumberOfZones = (count saas_baselist) - 1;
AAS_FirstZone = 2;
AAS_LastZone = AAS_NumberOfZones - 1;
AAS_ZoneMarkers = [];
for "_basenumber" from (0) to (AAS_NumberOfZones) do
{
	AAS_ZoneMarkers set [count AAS_ZoneMarkers,format["zone%1",_baseNumber]];
};
AAS_ZoneMarkersRadius = [];
{
	AAS_ZoneMarkersRadius set [count AAS_ZoneMarkersRadius,(getMarkerSize _x) select 0];
} forEach AAS_ZoneMarkers;
call cmdRecalcDependentBases;
call cmdRecalcBattleFronts;
string versionString = "ARMA 3" + SHORT_VERSION;
public bool DEBUG_create_death=false;
bool spawnDialogReady=false;
public int spawncampProtection=SPAWNCAMP_PROTECT_DEFAULT;
bool srvAISpawnWest = false;	// should the western AI spawn (yes/no)
bool srvAISpawnEast = false;	// should the eastern AI spawn (yes/no)
switch (AAS_Params_AISupportMode) do
{
	case (SUPPORT_WEST):	{srvAISpawnWest = true;};
	case (SUPPORT_EAST):	{srvAISpawnEast = true;};
	case (SUPPORT_ON):	{srvAISpawnWest = true; srvAISpawnEast = true;};
};
switch ( AAS_Params_DisableProfileSaveLoad ) do
{
// NAILER[C5] - WE USE ASORGS AND MAY NOT NEED THIS SWITCH BLOCK OR PARAM OPTION AT ALL...
//     case (0): { vas_disableLoadSave = true;};
//     case (1): { vas_disableLoadSave = false;};
};
array name_stock = [ "Alpha" , "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel", "India", "Juliet", "Kilo", "Lima", "Mike", 
                    "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whisky", "Yankee", "Zulu" ]; 
array flags = [ flag1 ];	// dummy flag in position 0
array AAS_FlagObjectPositions = [[0,0,0]];
array base_names = [ "dummy" ];
array teamColors = [ "ColorWhite", "ColorRed", "ColorBlue", "ColorGreen" ];
int redXrayBaseID = 0;
int blueXrayBaseID = 0;
int _flagCounter = 1;
for "_flagcounter" from 1 to ((count saas_baselist) - 1) do
{
	_flag = missionNamespace getVariable (format["flag%1",_flagCounter]);
	flags set [count flags,_flag];
	AAS_FlagObjectPositions set [count AAS_FlagObjectPositions,getPos _flag];
	string _zoneMarker = BASENAME(_flagCounter);
	_zoneMarker setMarkerPosLocal (getPos (flags select _flagCounter));
	_zoneMarker setMarkerColorLocal (teamColors select BASEA(_flagCounter,TEAM));
};
array _synchList = [];  // list of bases which current base is synched with
int _cname=0;
int _lmctr=0;   
int _lctr=0;
for "_lctr" from 1 to ((count saas_baselist) - 1) do
	{
	if( BASEA(_lctr,SPAWNTYPE) == SPAWN_XRAY ) then
		{
		base_names set [count base_names,"X-Ray"];
		if( BASEA(_lctr,TEAM) == TEAM_RED  ) then { redXrayBaseID  = _lctr; };
		if( BASEA(_lctr,TEAM) == TEAM_BLUE ) then { blueXrayBaseID = _lctr; };		
		}
	else
		{
		base_names set [count base_names,(name_stock select _cname)];
		_cname = _cname + 1;		
		};
	_mname = format["zoneName%1",_lctr];
	createMarkerLocal [ _mname , getPos (flags select _lctr) ];
	_mname setMarkerTypeLocal "mil_dot";
	_mname setMarkerTextLocal (base_names select _lctr);
		{
		if( _x > _lctr ) then
			{
			_tempName = format["marker%1", floor (random 10000)];
			_fromPos = getMarkerPos BASENAME(_lctr);
			_toPos = getMarkerPos BASENAME(_x);
			_fromPos set [ 2 , 0 ];
			_toPos set [ 2 , 0 ];
			_dist = _fromPos distance _toPos;
			_angle = ((_toPos select 0) - (_fromPos select 0)) atan2 ((_toPos select 1) - (_fromPos select 1));	
			_centre = [(_fromPos select 0) + ((sin _angle) * _dist / 2),	(_fromPos select 1) + ((cos _angle) * _dist / 2)];
			createMarkerLocal [_tempName,_centre];
			_tempName setMarkerShapeLocal "RECTANGLE";
			_tempName setMarkerSizeLocal [ 5 , _dist / 2];
			_tempName setMarkerColorLocal "ColorBlack";
			_tempName setMarkerDirLocal _angle;		
			};
		} forEach BASEA(_lctr,LINK);
		{
		if( _x > _lctr ) then
			{
			_tempName = format["marker%1", floor (random 10000)];
			_fromPos = getMarkerPos BASENAME(_lctr);
			_toPos = getMarkerPos BASENAME(_x);
			_fromPos set [ 2 , 0 ];
			_toPos set [ 2 , 0 ];
			_dist = _fromPos distance _toPos;
			_angle = ((_toPos select 0) - (_fromPos select 0)) atan2 ((_toPos select 1) - (_fromPos select 1));	
			_centre = [(_fromPos select 0) + ((sin _angle) * _dist / 2),	(_fromPos select 1) + ((cos _angle) * _dist / 2)];
			createMarkerLocal [_tempName, _centre];
			_tempName setMarkerShapeLocal "RECTANGLE";
			_tempName setMarkerSizeLocal [ 5 , _dist / 2];
			_tempName setMarkerColorLocal "ColorOrange";
			_tempName setMarkerDirLocal _angle;		
			};
		} forEach BASEA(_lctr,SYNC);
	};
bool AAS_processServerCommand_Busy = false;

if (isNil "centralServerTime") then { public float centralServerTime=0; };
if (isNil "globalOvercast") then { public float globalOvercast = -1; };
if (isNil "globalRain") then { public float globalRain = -1; };
if (isNil "globalFog") then { public float globalFog = -1; };
if (isNil "globalGusts") then { public float globalGusts = -1; };
if (isNil "globalLightnings") then { public float globalLightnings = -1; };
if (isNil "globalRainbow") then { public float globalRainbow = -1; };

bool localDebugMode=false;
bool enableDebugCommands=false;      // special console commands like teleport etc
bool enableAdminCommands=false;      // normal console commands like weather, 
public bool godMode=false;		// debugging mode makes player invulnerable
bool debugTestRevive=false;     // this launches a "revive all message" 30 seconds after use

if (isNil "srvCommand") then { public string srvCommand = ""; };
if (isNil "chatCommand") then { public string chatCommand = ""; };
if (isNil "serverHint") then { public string serverHint=""; };  // messages about server state 
if (isNil "AAS_PublicReviveSideMessage") then {	public string AAS_PublicReviveSideMessage = "";	}; // sideChat messages X reviving Y 
if (isNil "v1") then { public string v1 = ""; }; // v1 carries base colours and capture levels
if (isNil "v2") then { public string v2 = ""; };      // the encoded array carrying spawn instructions 
if (isNil "v3") then { public string v3 = ""; };     // the encoded array carrying spawn queues and timers 
if (isNil "triggerWestWin") then { public bool triggerWestWin=false; }; 	// west/blues win 
if (isNil "triggerEastWin") then { public bool triggerEastWin=false; }; 	// east/reds win 
if (isNil "triggerStalemate") then { public bool triggerStalemate=false; }; 	// stalemate 
if (isNil "captureSpeedFactor") then { public int captureSpeedFactor = RULES_captureSpeedFactor; }; // multiplier to change base capture speed

public array nameClassMap = [ 0 , "" ];	// comms variable for player class changes [ QID , class id (0... count RULES_classList) ]
array playerClasses = [];			// a list of all the player classes of the players on our current team
array playerTeams = [];             // a list of what different teams each player is in
int _initCtr1=0;
for "_initctr1" from 0 to 204 do
    {
	playerClasses set [count playerClasses,0];
    playerTeams set [count playerTeams,0];
    //format ["%1%2", playerTeams , toString [ FIRETEAM_NONE ] ];
	};
public int specialisationPercentRed = 0; 
public int specialisationPercentBlue = 0; 
public int scopedPercent = 0;
array scopedWeapons = [];
array heavyWeapons = [];
array player_units_east = [];		// a list of all the player objects on east team
array player_units_west = [];		// a list of all the player objects on the west team
array player_units_myteam = [];     // array which mirrors either the east or west player units arrays
array player_units_all = playableUnits;
public array bonus_trucks_east = [];
public array bonus_trucks_west = [];
public bool createEastTruck=false;
public bool createWestTruck=false;
call cmdUpdatePlayerLists;
[] execVM "ThreadLauncher.sqf";
introText =  { 
private["_blocks","_block","_blockCount","_blockNr","_blockArray","_blockText","_blockTextF","_blockTextF_","_blockFormat","_formats","_inputData","_processedTextF","_char","_cursorBlinks","_cursorInvis"]; 
//NAILER[C5] - TRIM PBO SIZE - REMOVE MUSIC //playSound "AASIntro"; 
_blockCount = count _this; 
_invisCursor = "<t color='#00000000' shadow = '0'>_</t>"; 
_blocks = []; 
_formats = []; 
{  _inputData = _x; 
_block     = [_inputData, 0, "", [""]] call BIS_fnc_param; 
_format = [_inputData, 1, "<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>", [""]] call BIS_fnc_param; 
 _blockArray = toArray _block; 
 {_blockArray set [_forEachIndex, toString [_x]]} forEach _blockArray; 
_blocks  = _blocks + [_blockArray]; 
_formats = _formats + [_format]; } forEach _this; 
_processedTextF  = ""; 
{  _blockArray  = _x; 
   _blockNr      = _forEachIndex; 
   _blockFormat = _formats select _blockNr; 
   _blockText   = ""; 
   _blockTextF  = ""; 
   _blockTextF_ = ""; 
{ _char = _x; 
  _blockText = _blockText + _char; 
  _blockTextF  = format[_blockFormat, _blockText + _invisCursor]; 
  _blockTextF_ = format[_blockFormat, _blockText + "."]; 
[(_processedTextF + _blockTextF_), 0, 0.5, 15, 0, 0, 90] spawn BIS_fnc_dynamicText; 
sleep 0.05; 
[(_processedTextF + _blockTextF), 0, 0.5, 15, 0, 0, 90] spawn BIS_fnc_dynamicText; 
sleep 0.05; } forEach _blockArray; 
 if (_blockNr + 1 < _blockCount) then { _cursorBlinks = 6; }  else { _cursorBlinks = 15; }; 
for "_i" from 1 to _cursorBlinks do { [_processedTextF + _blockTextF_, 0, 0.15, 15, 0, 0, 90] spawn BIS_fnc_dynamicText; 
            sleep 0.1; 
            [_processedTextF + _blockTextF, 0, 0.5, 15, 0, 0, 90] spawn BIS_fnc_dynamicText; 
            sleep 0.2; }; 
        _processedTextF  = _processedTextF + _blockTextF; } forEach _blocks; 
    ["", 0, 0.5, 15, 0, 1, 90] spawn BIS_fnc_dynamicText; 
};

//NAILER[C5] - ADD NAME TAGS FOR YOUR OWN TEAM...
TAGS = addMissionEventHandler ["Draw3D", {
    {
        if (side _x == side player && {alive _x }) then {;
            _dist = (player distance _x) / 3000;
            _color = getArray (configFile/'CfgInGameUI'/'SideColors'/'colorFriendly');
            if (cursorTarget != _x) then {
                _color set [3, 1 - _dist]
            };
            drawIcon3D [
                '',
                _color,
                [
                    visiblePosition _x select 0,
                    visiblePosition _x select 1,
                    (visiblePosition _x select 2) +
                    ((_x modelToWorld (
                        _x selectionPosition 'head'
                    )) select 2) + 0.4 + _dist / 1.5
                ],
                0,
                0,
                0,
                name _x,
                2,
                0.03,
                'PuristaMedium'
            ];
        };
    } count allUnits - [player];
}];
//END NAILER[C5] - ADD NAME TAGS FOR YOUR OWN TEAM...

//NAILER[C5] - WE USE BULLETS TO LEAVE AN IMPRINT...
//PrintingPress =  { 
//private["_blocks","_block","_blockCount","_blockNr","_blockArray","_blockText","_blockTextF","_blockTextF_","_blockFormat","_formats","_inputData","_processedTextF","_char","_cursorBlinks","_cursorInvis"]; 
//_blockCount = count _this; 
//_invisCursor = "<t color ='#00000000' shadow = '0'>_</t>"; 
//_blocks = []; 
//_formats = []; 
//{  _inputData = _x; 
//_block     = [_inputData, 0, "", [""]] call BIS_fnc_param; 
//_format = [_inputData, 1, "<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>", [""]] call BIS_fnc_param; 
// _blockArray = toArray _block; 
// {_blockArray set [_forEachIndex, toString [_x]]} forEach _blockArray; 
//_blocks  = _blocks + [_blockArray]; 
//_formats = _formats + [_format]; } forEach _this; 
//_processedTextF  = ""; 
//{  _blockArray  = _x; 
//   _blockNr      = _forEachIndex; 
//   _blockFormat = _formats select _blockNr; 
//   _blockText   = ""; 
//   _blockTextF  = ""; 
//   _blockTextF_ = ""; 
//{ _char = _x; 
//  _blockText = _blockText + _char; 
//  _blockTextF  = format[_blockFormat, _blockText + _invisCursor]; 
//  _blockTextF_ = format[_blockFormat, _blockText + "_"]; 
//[(_processedTextF + _blockTextF_), 0, 0.6, 5, 0, 0, 90] spawn BIS_fnc_dynamicText; 
//playSound "click"; 
//sleep 0.05; 
//[(_processedTextF + _blockTextF), 0, 0.6, 5, 0, 0, 90] spawn BIS_fnc_dynamicText; 
//sleep 0.02; } forEach _blockArray; 
// if (_blockNr + 1 < _blockCount) then { _cursorBlinks = 4; }  else { _cursorBlinks = 8; }; 
//for "_i" from 1 to _cursorBlinks do { [_processedTextF + _blockTextF_, 0, 0.6, 5, 0, 0, 90] spawn BIS_fnc_dynamicText; 
//            sleep 0.08; 
//            [_processedTextF + _blockTextF, 0, 0.6, 5, 0, 0, 90] spawn BIS_fnc_dynamicText; 
//            sleep 0.02; }; 
//        _processedTextF  = _processedTextF + _blockTextF; } forEach _blocks; 
//    ["", 0, 0.6, 5, 0, 1, 90] spawn BIS_fnc_dynamicText; 
//};
//END MOD BY NAILER[C5]
