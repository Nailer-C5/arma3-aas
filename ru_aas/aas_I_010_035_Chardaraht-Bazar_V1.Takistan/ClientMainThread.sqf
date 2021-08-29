//rev 7.

#include "globalDefines.hpp"
#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

//////////////////////
[] execvm "magic.sqf";
//////////////////////vvv
"AAS_PublicSound" addPublicVariableEventHandler
{
_soundSource = (_this select 1) select 0;
_sound = (_this select 1) select 1;
_soundSource say _sound;
};

"AAS_PublicTeamkillPunishmentInfoMessage" addPublicVariableEventHandler
{
_nameKiller = (_this select 1) select 0;
_nameKilled = (_this select 1) select 1;
[playerSide,"HQ"] commandChat (format [ Localize "STR_AAS_punished_for_teamkill",_nameKiller,_nameKilled]);
};

"AAS_P_FX" addPublicVariableEventHandler
{
_player = (_this select 1) select 0;
_FX = (_this select 1) select 1;
if (player==_player) then
{
switch (_FX) do 
{
case 0: { _nul = ["P_E"] execVM "fast_actions.sqf"; };
};//sw
};//if

};

//травка  колышется от выстрела
fn_firedEffect = {
	_ammo = param [4,""];
	if (_ammo isEqualTo "") exitWith {};
	_caliber = (getNumber(configFile >> "cfgAmmo" >> _ammo >> "caliber") >= 10);
	if !(_caliber) exitWith {};
	_veh = createVehicle ["B_Heli_Light_01_F", [0,0,10], [], 0, "FLY"];
	_veh addEventHandler ["HandleDamage",{0}];
	_veh hideObject true;
	_veh setPosATL [((getPosATL (vehicle player)) select 0),((getPosATL (vehicle player)) select 1),((getPosATL (vehicle player)) select 2) + 3];
	_posveh = (getPosATL _veh);
	_posvehZ = _posveh select 2;
	for "_i" from _posvehZ to (_posvehZ + 25) step 0.2 do {
		_veh setPosATL [(_posveh select 0),(_posveh select 1),_i];
		UiSleep 0.005;
	};
	deleteVehicle _veh;
};

(vehicle player) addEventHandler ["Fired",{
	_this spawn fn_firedEffect;
}];


//////////////////////

//бируши
call{0 spawn {
	waitUntil {!isNull(findDisplay 46)};

	(findDisplay 46) displayAddEventHandler ["KeyDown", {
		if(_this select 1 == 0x46) then {
			_earplugsctrl = (_this select 0) displayCtrl 9001;
			if(isNull(_earplugsctrl)) then {
				_earplugsctrl = (_this select 0) ctrlCreate ["RscText", 9001];
				_earplugsctrl ctrlSetPosition [SafeZoneXAbs, SafeZoneY + (SafeZoneH - 0.05) / 2, 0.2, 0.03];
				_earplugsctrl ctrlSetFontHeight 0.03;
				_earplugsctrl ctrlSetText Localize "STR_AAS_Earplugs";
				_earplugsctrl ctrlShow false;
				_earplugsctrl ctrlCommit 0;
			};
			_shown = ctrlShown _earplugsctrl;
			0.1 fadeSound (if(_shown)then{1}else{0.1});
			_earplugsctrl ctrlShow !_shown;
		};
	}];
};};
[] execvm "magic.sqf";
string consoleExecuteCommand="";		// command to execute on console
bool consoleCommandMode=false;		// mode switch for if console is engaged
string keyPressCurrCmd="";				// working string to build up console command
int localSpawnID=0;					// base ID at which player (client) has selected to spawn
string tleft="???"; 					// time left string
string playerClass = 0;
string lastPlayerNonCustomClass = playerClass;

int myFireTeam = 100;
bool enableConsole=true;
onPlayerConnected {};
onPlayerDisconnected {};
int consoleEnableCounter=0;
float myOvercast = -1;
float myRain = -1;
float myFog = -1;
int hudDisplayLevel = HUD_MAX_LEVEL;
bool resetHUD = false;		// marker to attempt HUD reset (bug recovery)
int lastRespawnTime=0;	// records time at which we last respawned
int lastDeathTime=0;		// records time at which we last died
bool AAS_SpawnArmourActive = false;
string spawnPrecursorMessage = localize "STR_AAS_spawn_point";
bool activateSpawnMenu=false;
float mapZoomLevel = mzl;
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

player addEventHandler ["SeatSwitchedMan",{ resetHUD = true;}];
VIRTUAL_BOX= "rhs_weapon_crate" createVehicleLocal  [0,0,0];

[ missionNamespace, "arsenalOpened", 
{
	disableSerialization;
    _display = _this select 0;
	_display displayAddEventHandler ["KeyDown", "if (_this select 3) then {true}"];
	
	( _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE ) ctrlRemoveAllEventHandlers "buttonclick";	
	( _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE ) ctrlSetTextColor [ 1, 1, 0, 1 ];
	( _display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE ) ctrlAddEventHandler ["buttonclick", { [0,0,0,[true,LOADOUT_SAVE]] execVM 'doQuickLoadout.sqf'; }];
  
	(_display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONCLOSE) ctrlEnable  true;
	
	_c= _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONIMPORT;
	_c ctrlEnable  true;
	_c ctrlRemoveAllEventHandlers "buttonclick";	
	_c ctrlSetBackgroundColor [1, 0, 0, 0.5 ];
	_c ctrlAddEventHandler ["buttonclick", { {player removeMagazines _x} forEach (magazines player); player removePrimaryWeaponItem currentMagazine player;}];
	_c ctrlSetText Localize 'STR_AAS_Clear_1'; 
	
	
	(_display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONRANDOM) ctrlEnable  false;
	(_display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD) ctrlEnable  false;
	//hint 'arsenalOpened';
} 
] call BIS_fnc_addScriptedEventHandler;


[ missionNamespace, "arsenalClosed", 
{
resetHUD = true;
call AAS_Check_WM;
//hint 'arsenalClosed';
} 
] call BIS_fnc_addScriptedEventHandler;
////////////

code AAS_fnc_cPunishTeamKill = compile preprocessFileLineNumbers "cPunishTeamKill.sqf";

code AAS_fnc_cGetName = compileFinal preprocessFileLineNumbers "cGetName.sqf";
code AAS_fnc_cReducePlayerName = compileFinal preprocessFileLineNumbers "cReducePlayerName.sqf";
code AAS_fnc_cDragActions = compileFinal preprocessFileLineNumbers "cDragActions.sqf";

call Set_Sett;	
player addMPEventhandler ["MPRespawn", { call Set_Sett; } ]; 



///////////////////////////////////////////////////////////////////

player addEventHandler ["InventoryOpened", 
{ 		
	if bpb then { removeBackpack (_this select 0); hint localize "STR_AAS_not_backpack";  }; 
}];

player addEventHandler ["InventoryClosed", { call AAS_Check_WM; }];


//Test
AAS_Player_Mines=[];
AAS_MinesLimit= {
params['_unit','_weapon', '_muzzle', '_mode', '_ammo', '_magazine', '_projectile', '_vehicle'];
if (_weapon!='Put') exitWith {};
AAS_Player_Mines pushBack _projectile;
{if (isNull _x) then { AAS_Player_Mines deleteAt _forEachIndex; }; } forEach AAS_Player_Mines;
if (count AAS_Player_Mines >10) then { deletevehicle (AAS_Player_Mines select 0);  AAS_Player_Mines deleteAt 0; };
};
player addEventHandler ["Fired", { _this spawn AAS_MinesLimit; }];


///////////////////////////////////////////////////////////////////

"AAS_PublicAddActionsAndEH" addPublicVariableEventHandler
{
	_vehicle = _this select 1;
	_vehicle disableTIEquipment true;
	if ((_vehicle isKindOf "RHS_Mi8_base") || (_vehicle isKindOf "RHS_UH60_Base"  )) then {_vehicle addEventHandler ["GetIn","_this spawn AAS_fnc_Lift;"];};
};
{
	_x disableTIEquipment true;
	if ((_x isKindOf "RHS_Mi8_base") || (_x isKindOf "RHS_UH60_Base")) then {_x addEventHandler ["GetIn","_this spawn AAS_fnc_Lift;"];};
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
player addEventHandler ["GetInMan",
"
_obj= (_this select 2); 
if ( _obj iskindof 'StaticMortar') then  
{
_obj setVectorUp [0,0,1]; 
};
_obj disableTIEquipment true; 
if ( ((_this select 1)in ['driver','gunner']) and (_obj iskindof 'rhs_bmp_base' or _obj iskindof 'rhs_bmd_base') ) then { player groupchat Localize 'STR_AAS_Press_ctrl_J'; resetHUD = true; }; 
if ( ((_this select 1)in ['driver','gunner']) and (typeOf _obj in ['rhs_tigr_sts_vv' , 'rhs_tigr_sts_3camo_vv', 'rhsusf_M1117_O']) ) then { player groupchat Localize 'STR_AAS_Without_AGS'; };
if ( ((_this select 1)== 'driver') and (typeOf _obj in ['rhsusf_M977A4_REPAIR_usarmy_wd', 'rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd', 'rhsusf_M977A4_REPAIR_BKIT_M2_usarmy_wd','RHS_Ural_Repair_MSV_01', 'rhs_gaz66_repair_base', 'O_Truck_02_box_F']) ) then { player groupchat Localize 'STR_AAS_FULLREP'; };
"];
/*
//Беруши автомат earplugs auto
player addEventHandler ["GetInMan", " 3 fadeSound 0.3; "]; 
player addEventHandler ["GetOutMan", " 3 fadeSound 1; "];*/
disableSerialization;
string _versionMessage = SHORT_VERSION;
string _welcomeMessage = localize "STR_AAS_What_New";
string _specMsg = format [localize "STR_AAS_players_using_powerful",specialisationPercentRed,"%",specialisationPercentBlue,"%",scopedPercent,"%"];
titleText [format[localize "STR_AAS_Welcome",_versionMessage,_specMsg,_welcomeMessage], "BLACK FADED", 0];
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
waituntil {!isnull (finddisplay 46)}; 
(findDisplay 46) displayAddEventHandler ["KeyDown","_this call KeyHandler"];
[0,0,0,[false,playerClass]] spawn cmdDoQuickLoadout;
player addRating 100000;
code addBriefing = 
	{
	player createDiaryRecord ["Diary", [localize "STR_AAS_Rules",RULES_ruleSetName]];
	player createDiaryRecord ["Diary", [localize "STR_AAS_Version",versionString]];
	player createDiaryRecord ["Diary", [localize "STR_AAS_HotKey",localize "STR_AAS_HotKey2"]];
	player createDiaryRecord ["Diary", [localize "STR_AAS_Scoring",localize "STR_AAS_Scoring_2"] ];
	player createDiaryRecord ["Diary", [localize "STR_AAS_Advance_and_Secure",localize "STR_AAS_Advance_and_Secure_2"] ];
	player createDiaryRecord ["Diary", [localize "STR_AAS_Mortar",localize "STR_AAS_Mortar2"] ];
	player createDiaryRecord ["Diary", [localize "STR_AAS_Podnos","CHARGE      RANGE        ELEVATION            SCATTER           TIME <br /><br />
CHARGE 1   100m            84.6/82.1                28/28              15/15<br />
                       200m            79.3/71.7                28/28              14/14<br />
                       300m            73.5/----                   27/----             14/----<br />
CH 1/2          400m            66.8/84.3                26/53              13/28<br />
CH 1/2          500m            57.8/82.9                24/53              12/28<br />
CHARGE 2   600m            82.0/81.5                56/53              29/28<br />
                       700m            80.6/80.0                57/52              30/27<br />
                       800m            79.3/78.6                56/52              29/27<br />
                       900m            77.9/77.1                56/52              29/27<br />
                      1000m          76.5/75.5                55/52              29/27<br />
                      1100m          75.0/73.9                55/51              29/27<br />
                      1200m          73.5/72.2                54/51              28/26<br />
                      1300m          71.9/70.5                54/50              28/26<br />
                      1400m          70.3/68.6                53/49              28/26<br />
                      1500m          68.6/66.6                53/49              28/25<br />
                      1600m          66.8/64.4                52/48              27/25<br />
                      1700m          64.9/62.0                51/46              27/24<br />
                      1800m          62.8/59.1                50/45              26/23<br />
                      1900m          60.5/55.1                49/42              26/22<br />
CH 2/3         2000m          57.8/76.8                48/79              25/41<br />
CH 2/3         2100m          54.4/75.6                46/76              24/40<br />
CH 2/3         2200m          49.1/74.9                43/76              22/40<br />
CHARGE 3  2300m          74.6/74.1                78/76              41/40<br />
                      2400m          73.9/73.3                78/76              41/40<br />
                      2500m          73.1/72.5                78/75              41/39<br />
                      2600m          72.4/71.7                77/75              41/39<br />
                      2700m          71.6/70.9                77/74              40/39<br />
                      2800m          70.8/70.1                77/74              40/39<br />
                      2900m          70.0/69.2                76/74              40/39<br />
                      3000m          69.1/68.3                76/73              40/38<br />
                      3100m          68.3/67.4                76/73              40/38<br />
                      3200m          67.4/66.4                75/72              39/38<br />
                      3300m          66.5/65.5                75/72              39/37<br />
                      3400m          65.6/64.4                74/71              39/37<br />
                      3500m          64.6/63.4                73/70              38/37<br />
                      3600m          63.6/62.2                73/69              38/36<br />
                      3700m          62.5/61.0                72/69              38/36<br />
                      3800m          61.4/59.7                71/68              37/35<br />
                      3900m          60.2/58.2                71/66              37/35<br />
                      4000m          58.9/56.6                70/65              36/34<br />
                      4100m          57.5/54.6                69/64              36/33<br />
                      4200m          56.0/52.1                67/61              35/32<br />
                      4300m          54.2                           64                     32 <br />
                      4400m          52.0                           64                     33 <br />
                      4500m          48.6                           61                     32<br />"] ];
	player createDiaryRecord ["Diary", [localize "STR_AAS_M252","CHARGE      RANGE   ELEVATION  SCATTER    TIME <br /><br />
CHARGE 0   30m              84.7                15              8<br />
                       60m              79.2                15              8<br />
                       90m              73.3                14              7<br />
                       120m            66.4                14              7<br />
                       150m            56.8                13              6<br />
CHARGE 1   200m            81.0                30              16<br />
                       300m            76.3                30              15<br />
                       400m            71.1                29              15<br />
                       500m            65.0                28              14<br />
                       600m            56.6                25              13<br />
CHARGE 2  700m            75.7                45              23<br />
                       800m            73.5                44              23<br />
                       900m            71.1                44              23<br />
                      1000m          68.5                43              22<br />
                      1100m          65.7                42              22<br />
                      1200m          62.6                41              21<br />
                      1300m          58.9                39              20<br />
                      1400m          53.8                37              19<br />
CHARGE 3  1500m         72.5                 59              31<br />
                      1600m          71.1                58              30<br />
                      1700m          69.7                58              30<br />
                      1800m          68.2                57              30<br />
                      1900m          66.6                56              29<br />
                      2000m          65.0                56              29<br />
                      2100m          63.2                55              29<br />
                      2200m          61.3                54              28<br />
                      2300m          59.1                53              28<br />
                      2400m          56.6                51              27<br />
                      2500m          53.4                49              26<br />
                      2600m          47.6                45              24<br />
CHARGE 4  2700m         69.3                 72              38<br />
                      2800m          68.3                72              37<br />
                      2900m          67.3                71              37<br />
                      3000m          66.3                70              37<br />
                      3100m          65.3                70              37<br />
                      3200m          64.1                69              36<br />
                      3300m          63.0                69              36<br />
                      3400m          61.8                68              35<br />
                      3500m          60.4                67              35<br />
                      3600m          59.0                66              34<br />
                      3700m          57.4                65              34<br />
                      3800m          55.6                64              33<br />
                      3900m          53.5                62              32<br />
                      4000m          50.6                59              31<br />
                      4080m          45.6                55              29<br />"] ];
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
	_m setMarkerSizeLocal[0.25, 0.22];	// make it small
	
	playerMarkers set [count playerMarkers,_m];
	_m setMarkerColorLocal _mColor;	
};

spawnArmourTime=time;
teamMateMarker=-1;	// index number of teammate to mark to follow (special colour)
bool updateTagsThreadRun = false;
sleep 0.1;

//save
player setVariable ["custom_inventory", getUnitLoadout player, false];

triggerWestWin=false;	// west/blues win
triggerEastWin=false;	// east/reds win
triggerStalemate=false;	// stalemate
CLIENT_initialised=true;
int _smsgtime=time;		// time last spawn armour message was displayed (to ensure it only displays once per second)
int _slowCounter=0;				
while { true } do
	{
//systemchat format["Current wpn.: %1", currentweapon vehicle player];	
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
	_currentCutDisplay = uiNamespace getVariable "curdispHUD";
	if( !isNull _currentCutDisplay ) then
		{	
		call _updateHUD;
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
		
		if ( _scoped and _heavy ) then
			{
			hint localize "STR_AAS_CarryBothScoped";
			//removeAllWeapons player;
			player removeWeapon (secondaryWeapon player); 
			};
		
		};
	if( serverHint != "" ) then
	{
		hintSilent  format [localize "STR_AAS_minutes_left", serverHint];
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
		hintSilent format [ localize "STR_AAS_Spawn_Armour",round (SPAWN_ARMOUR_DURATION - (time-spawnArmourTime)) ];
		};	
	if ((time - spawnArmourTime) > (SPAWN_ARMOUR_DURATION) && AAS_SpawnArmourActive) then
		{
		AAS_SpawnArmourActive = false;
		hintSilent "";
		player removeEventHandler ["HandleDamage",AAS_EH_HD_ID];
		player removeEventHandler ["Fired",AAS_EH_Fired_ID];
		};
	_protectBaseSelect = [ "dummy" , "respawn_west" , "respawn_east" , "dummy" ];
	int _tMyTeam=TEAM_RED;
	if( WEST_PLAYER ) then { _tMyTeam = TEAM_BLUE; };
    if( (player distance (getMarkerPos (_protectBaseSelect select _tMyTeam))) < BOOTHILLCAMP_RADIUS ) then
		{
		[format[localize "STR_AAS_DANGER", SPAWNCAMP_RADIUS, round _theDist],-1,-1,4,0,0,789] spawn BIS_fnc_dynamicText;
		player setDamage (damage player + 0.007);		
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
					[format[localize "STR_AAS_DANGER", SPAWNCAMP_RADIUS, round _theDist],-1,-1,4,0,0,789] spawn BIS_fnc_dynamicText;
					player setDamage (damage player + 0.007);
					};
				};
			};
		};		
		
	if( resetHUD or _firstHudLaunch) then
		{
		resetHUD=false;
        
        if( _firstHudLaunch ) then
            {
			cutRsc ["HudDisplay","PLAIN",0];
			activateSpawnMenu = true; // calls respawn menu
            }
        else
            {
            cutRsc ["HudDisplay","PLAIN",0];				
            };
        _firstHudLaunch=false;		
		};
	call cmdProcessPlayerAttribs;		
	call _processPlayerEffects;
	};