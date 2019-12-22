enableSaving[false,false];
#include "globalDefines.hpp"
#include "mapname.hpp"

/////////////////////////////////////////////////////////////////////////
AAS_PublicSound = "";
/////////////////////////////////////////////////////////////////////////

_arty = execVM "=BTC=Arty\ArtyInit.sqf";
_hook = execVM "=BTC=Arty\AttachInit.sqf";

///////////////////////////////
AAS_fnc_ClearVehicleWeapons=
{
	params['_vehicle'];
	{
		_magazineName= _x select 0;
		_turretPath= _x select 1;
		
		//First clear mags
		_vehicle removeMagazinesTurret [_magazineName, _turretPath]; 
		//Next remowe weapons
		_weapons= _vehicle weaponsTurret _turretPath;
		{ _vehicle removeWeaponTurret [_x, _turretPath] } forEach _weapons;
		
	} forEach (magazinesAllTurrets _vehicle);
};

AAS_fnc_ADDVehicleWeapons=
{
	//ADD
	params['_vehicle','_uWeapons'];
 	{
	diag_log format ['AAS_fnc_ADDVehicleWeapons>>> V: %1', typeof _vehicle];
	//if (_foreachindex>=1) Exitwith {systemchat 'Trunc';};
		_turret= _x select 1;
		_weapons= _x select 0;
		{diag_log format ['AddWeaponTurret %1 %2 ', _x, _turret]; _vehicle AddWeaponTurret [ _x, _turret];  _vehicle AddWeaponTurret [ _x, _turret];} forEach _weapons;
		
	} forEach (_uWeapons select 0);
	{diag_log format ['AddMagazineTurret %1 %2 %3 ', _x select 0, _x select 1, _x select 2]; _cnt= _x select 2; if (_cnt==0) then { _cnt=100500; };  _vehicle AddMagazineTurret [_x select 0, _x select 1, _cnt] } forEach (_uWeapons select 1);
	diag_log str _uWeapons;
};

	
AAS_fnc_saveVehicleWeapons= {
	params['_vehicle'];
	_weaponsData= [[],[]];
	_allwpns=[];
	{
		_mags= _x select 0;
		_turretPath= _x select 1;
		_ammoCount= _x select 2;
		_weapon= _vehicle weaponsTurret _turretPath;
		(_weaponsData select 1) pushBack [_mags, _turretPath, _ammoCount];
		_allwpns pushBackUnique [_weapon, _turretPath];
		
	} forEach (magazinesAllTurrets _vehicle);
	_weaponsData set [0, _allwpns];
	
	_weaponsData;
};
///////////

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
code cmdSetRulesZEL = compileFinal preprocessFile "RULES_ZEL.sqf"; 
code cmdSetRulesPES = compileFinal preprocessFile "RULES_PES.sqf"; 
code cmdSetRulesGUNS = compileFinal preprocessFile "RULES_GUNS.sqf"; 
code cmdSetRulesGAL = compileFinal preprocessFile "RULES_GAL.sqf";  

//Ремонтник
[] execVM "zlt_fieldrepair.sqf";

if (!(isDedicated)) then 
{ 
waitUntil {!isNull player}; 
waitUntil {player == player}; 
[] execVM "Peredacha\LowGear\LowGear_Init.sqf"; 
};

bad_weapons= [];
bad_mags= ["rhs_mag_M433_HEDP", "rhs_mag_M441_HE", "rhs_mag_M397_HET", "rhs_VOG25", "rhs_VG40TB"]; // +7
bad_mags2= [  "rhs_mag_maaws_HE", "rhs_rpg7_type69_airburst_mag", "rhs_rpg7_OG7V_mag", "rhs_rpg7_TBG7V_mag", "RPG32_HE_F"]; //+2
bad_mags3= ["rhssaf_mine_tma4_mag","rhs_mag_mine_ptm1","rhssaf_mine_mrud_d_mag"];
bad_mags4= ["APERSTripMine_Wire_Mag","Vorona_HEAT" /*,"rhssaf_mine_mrud_b_mag","rhs_mine_pmn2_mag", "rhsusf_mine_m14_mag"*/]; //+1
bad_mags5= ["rhs_fgm148_magazine_AT","rhs_fim92_mag","rhs_mag_9k38_rocket"]; // всего 1
/*bad_mags6= ["rhs_mag_an_m14_th3", "rhs_mag_rgo", "rhs_mag_rgd5", "rhs_mag_f1",	"rhs_mag_rgn", "rhs_mag_m67"];*/
bad_WItemCustom0= ["rhsgref_sdn6_suppressor", "rhsusf_acc_rotex5_grey", "rhsusf_acc_nt4_black", "rhsusf_acc_SR25S", "rhsusf_acc_rotex_mp7_aor1"  ];//black list
bad_WItemCustom1= ["rhs_acc_pbs1", "rhs_acc_dtk4short", "rhs_acc_tgpv2"  ];//black list
bad_W0= ["rhs_weap_m16a4_carryhandle_M203", "rhs_weap_m4a1_carryhandle_m203", "rhs_weap_mk18_m320", "rhs_weap_g36kv_ag36", "rhs_weap_hk416d145_m320", "rhs_weap_hk416d10_m320", "rhs_weap_m4a1_blockII_M203_d",
		 "rhs_weap_m249_pip_S_para", "rhs_weap_m249_pip_L_para", "rhs_weap_m249_pip", "rhs_weap_m240b_elcan", "rhs_weap_m240B", "rhs_weap_m240B_CAP", "rhs_weap_minimi_para_railed" ];//black list
bad_W1= ["rhs_weap_ak74m_gp25", "rhs_weap_aks74_gp25", "rhs_weap_aks74n_gp25", "rhs_weap_ak74mr_gp25", "rhs_weap_akmn_gp25", "rhs_weap_akms_gp25", "rhs_weap_ak103_gp25_npz"  ];//black list
		   
AAS_Check_WM=
{
	if( count ((getPos player) nearObjects ["rhs_weapon_crate", 10]) > 0 ) then 
	{
	_detected= false;
	_detected2= false;
	_detected3= false;
	_detected4= false;
	//_detected6= false;
	_fba1="";
	_fba2="";
	_fba3="";
	_fba4="";
	//_fba6="";
	
	{
		if (_x in bad_weapons) then 
		{ 
			player removeWeapon _x; 
			player commandchat format["%1 %2",localize "STR_AAS_bad_weapons", _x];
		}; 
	} forEach (weapons player);
	
	{ 
		if (_x in bad_mags) then 
		{
			_detected= true;
			_fba1= _x;
			player removeMagazines _x;
			//player commandchat format[ Localize "STR_AAS_You_can_not_take_it", _x];
		};
	} forEach (magazines player);
	

	if (_detected) then
	{
		if (_fba1 != "") then {	player addMagazines [_fba1, 7 ];};		
	};	
	
	{
		if (_x in bad_mags2) then 
		{ 
			_detected2= true;
			_fba2= _x;
			player removeMagazine _x; 
			//player commandchat format[ Localize "STR_AAS_You_can_not_take_it", _x];
		}; 
	} forEach (magazines player);
	
	if (_detected2) then
	{
		if (_fba2 != "") then {	player addMagazines [_fba2, 2 ];};		
	};
	
	{
		if (_x in bad_mags3) then 
		{  
			_detected3= true;
			_fba3= _x;
			player removeMagazine _x; 
			//player commandchat format[ Localize "STR_AAS_You_can_not_take_it", _x];
		}; 
	} forEach (magazines player);
	
	if (_detected3) then
	{
		if (_fba3 != "") then {	player addMagazines [_fba3, 2 ];};		
	};
	 
	{
		if (_x in bad_mags4) then 
		{  
			_detected4= true;
			_fba4= _x;
			player removeMagazine _x; 
			//player commandchat format[ Localize "STR_AAS_You_can_not_take_it", _x];
		}; 
	} forEach (magazines player);
	
	if (_detected4) then
	{
		if (_fba4 != "") then {	player addMagazines [_fba4, 1 ];};		
	};
	 
	{
		if (_x in bad_mags5) then 
		{  
			player removeMagazine _x; 
			//player commandchat format[ Localize "STR_AAS_You_can_not_take_it", _x];
		}; 
	} forEach (magazines player);
	/*
	{ if (_x in bad_mags6) then 
		{  
		_detected6= true;
		_fba6= _x;
		player removeMagazine _x; 
		//player commandchat format[ Localize "STR_AAS_You_can_not_take_it", _x];
		}; 
	} forEach (magazines player);
	
	if (_detected6) then
		{
			if (_fba6 != "") then {	player addMagazines [_fba6, 6 ];};		
		};
			*/
	//123
	};
	
	
	
	_prim_w_i_s= (primaryWeaponItems player) select 0;//Silencer
	_prim_w= primaryWeapon player;

	if (playerclass == 100) then //Custom detected
	{
		
		//кастом с крысиным оружием - не получишь глушак 
		if( WEST_PLAYER ) then 
		{
			if (_prim_w in bad_W0) then
			{
			
				if ( _prim_w_i_s in bad_WItemCustom0) then
				{
					_s= 'OLD'+ str (getUnitLoadout player);
				
					player removePrimaryWeaponItem _prim_w_i_s; 
					_s= _s+ ' >>>NEW'+ str (getUnitLoadout player);
					diag_log str _s;
				
				};	
			};
		}
		else 
		{
			if (_prim_w in bad_W1) then
			{
			
				if ( _prim_w_i_s in bad_WItemCustom1) then
				{
					_s= 'OLD'+ str (getUnitLoadout player);
				
					player removePrimaryWeaponItem _prim_w_i_s; 
					_s= _s+ ' >>>NEW'+ str (getUnitLoadout player);
					diag_log str _s;
				
				};	
			};
		};
	};
};
	
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
 	AAS_Params_GameDuration = 60;
	AAS_Params_TimeOfDay = 0;
	AAS_Params_HourOfDay = 12;
	AAS_Params_MinuteOfDay = 0;
	AAS_Params_Weather = 1;
	AAS_Params_Fog = 1;
	AAS_EnableFatigue= 0;
	AAS_Params_ViewDistance = 1500;
	AAS_Params_Grass = 1;
	AAS_Params_RecruitAIStatusDialog = 0;
	AAS_Params_ShowHint = 1;	
	AAS_Params_AISupportMode = SUPPORT_LTE6;
	AAS_Params_AIVehiclesUse = 1;
	AAS_Params_NumberOfAIgroups = 5;
    AAS_Params_NumberOfAIunitsPerGroup = 4;
	AAS_Params_AIVehiclesUsePercentage = 30;
	AAS_Params_AggressiveAIBehavior = 1;
	AAS_Params_AIDebugMode = 0;
	AAS_Params_CameraView = 0;
 	EditorModeSP = true;
}
else
{
    for "_i" from 0 to ((count paramsArray) - 1) do
	{
    missionNamespace setVariable [configName ((missionConfigFile >> "Params") select _i), paramsArray select _i];
	//call compile format ["%1 = %2",(configName ((missionConfigFile >> "Params") select _i)),(paramsArray select _i)]; //Arma2 version
 	};
};
/////////////////////////////////////////////////////////////////////////////
//Settings Volkovision o_O Do not edit!
	
	Run_Anims_List=
	[
	"amovpercmevasraswrfldf", 
	"amovpercmevasraswrfldf_amovpknlmstpsraswrfldnon", 
	"amovpercmevasraswrfldfr_amovpknlmstpsraswrfldnon", 
	"amovpercmevasraswrfldfl_amovpknlmstpsraswrfldnon",
	"amovpercmevasraswrfldf_amovpercmevasraswrfldfl", 
	"amovpercmevasraswrfldf_amovpercmevasraswrfldfr", 
	"amovpercmevasraswrfldf_amovpercmstpsraswrfldnon"
	]; 
		
//Settings Default

//AnimStateChanged or AnimChanged
	player addEventHandler 
	["AnimChanged", 
	{ 
	//(_this select 0) commandchat str (_this select 1); //Потом удалить
	if ((_this select 1) in Run_Anims_List) then { (_this select 0) setAnimSpeedCoef (AAS_SpeedCoef/100) } else { (_this select 0) setAnimSpeedCoef 1; };
	}
	];

	
Set_Sett= 
{
  player enableStamina true; 
  player forceWalk false;
  player setCustomAimCoef (AAS_CustomAimCoef/100);
  player setUnitRecoilCoefficient (AAS_UnitRecoilCoefficient/100); 
};
   
////////////////////////////////////////////////////////////////////////	
	

switch (AAS_Params_GameDuration) do
{
 	case 20: { timemax = 20 * 60; };
 	case 30: { timemax = 30 * 60; };
 	case 45: { timemax = 45 * 60; };
 	case 60: { timemax = 60 * 60; };
	case 90: { timemax = 90 * 60; };
	case 120: { timemax = 120 * 60; };
};
if ( Rulchoice == SETUP_ZEL     ) then { call cmdSetRulesZEL };
if ( Rulchoice == SETUP_PES     ) then { call cmdSetRulesPES };
if ( Rulchoice == SETUP_GUNS    ) then { call cmdSetRulesGUNS};
if ( Rulchoice == SETUP_GAL     ) then { call cmdSetRulesGAL };
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
			_tempName setMarkerSizeLocal [ 2.5 , _dist / 2];
			_tempName setMarkerColorLocal "ColorOrange";
			_tempName setMarkerDirLocal _angle;		
			};
		} forEach BASEA(_lctr,SYNC);
	};
bool AAS_processServerCommand_Busy = false;
if (isNil "centralServerTime") then
{
public float centralServerTime=0;
};
if (isNil "globalOvercast") then
{
	public float globalOvercast = -1;
};
if (isNil "globalRain") then
{
	public float globalRain = -1;
};
if (isNil "globalFog") then
{
	public float globalFog = -1;	
};
bool localDebugMode=false;
bool enableDebugCommands=false;      // special console commands like teleport etc
bool enableAdminCommands=false;      // normal console commands like weather, 
public bool godMode=false;		// debugging mode makes player invulnerable
bool debugTestRevive=false;     // this launches a "revive all message" 30 seconds after use
if (isNil "srvCommand") then
{
public string srvCommand = "";
};
if (isNil "chatCommand") then
{
public chatCommand = ["0", "1"];
};
if (isNil "serverHint") then
{
public string serverHint=""; // messages about server state
};
if (isNil "AAS_PublicReviveSideMessage") then
{
	public string AAS_PublicReviveSideMessage = "";	// sideChat messages X reviving Y
};
if (isNil "v1") then
{
public string v1 = "";	   // v1 carries base colours and capture levels
};
if (isNil "v2") then
{
public string v2 = "";     // the encoded array carrying spawn instructions
};
if (isNil "v3") then
{
public string v3 = "";     // the encoded array carrying spawn queues and timers
};
if (isNil "triggerWestWin") then
{
public bool triggerWestWin=false;	// west/blues win
};
if (isNil "triggerEastWin") then
{
public bool triggerEastWin=false;	// east/reds win
};
if (isNil "triggerStalemate") then
{
public bool triggerStalemate=false;	// stalemate
};
if (isNil "captureSpeedFactor") then
{
public int captureSpeedFactor = RULES_captureSpeedFactor;		// multiplier to change base capture speed
};
public array nameClassMap = [ 0 , "" ];	// comms variable for player class changes [ QID , class id (0... count RULES_classList) ]
array playerClasses = [];			// a list of all the player classes of the players on our current team
array playerTeams = [];             // a list of what different teams each player is in
int _initCtr1=0;
for "_initctr1" from 0 to 204 do
    {
	playerClasses set [count playerClasses,0];
    playerTeams set [count playerTeams,FIRETEAM_NONE];	//playerTeams set [count playerTeams,0];
    //format ["%1%2", playerTeams , toString [ FIRETEAM_NONE ] ];
	};
public int specialisationPercentRed = 0.15; 
public int specialisationPercentBlue = 0.15; 
public int scopedPercent = 0.15;
array scopedWeapons = [ /*"rhsusf_acc_su230a_mrds",  "rhsusf_acc_ACOG_wd",  "rhsusf_acc_ACOG2", "rhsusf_acc_g33_xps3"*/"rhs_weap_sr25","rhs_weap_sr25_ec_wd", "rhs_weap_m24sws", "rhs_weap_m14ebrri_leu","rhs_weap_sr25_wd", "rhs_weap_XM2010_wd", "rhs_weap_M107_w", "rhs_weap_m24sws_ghillie", 
						"rhs_weap_m40a5_wd","rhs_weap_m40a5_d", "rhs_weap_sr25_ec_d", "rhs_weap_XM2010_d_leu", "rhs_weap_M107_d_leu",
						"rhs_weap_m240B_CAP","rhs_weap_m240b_elcan", "rhs_weap_m249_pip_S_para", "rhs_weap_m249_pip_L_para", "rhs_weap_m240B","rhs_weap_minimi_para_railed","rhs_weap_m27iar_grip",
						"rhs_weap_vss_grip", "rhs_weap_asval_grip", "rhs_weap_svdp","rhs_weap_svdp_wd","rhs_weap_svdp_wd_npz", "rhs_weap_m76", "rhs_weap_t5000", "rhs_weap_m82a1",
						"rhs_weap_pkm", "rhs_weap_pkp","rhs_weap_ak74m_zenitco01", "rhs_weap_m84"];
array heavyWeapons = ["launch_RPG32_F", "launch_O_Vorona_green_F", "rhs_weap_M136_hedp","rhs_weap_M136", "rhs_weap_maaws", "rhs_weap_smaw_optic", "rhs_weap_fim92", "rhs_weap_fgm148","rhs_weap_rpg26", "rhs_weap_rshg2", "rhs_weap_rpg7_pgo", "rhs_weap_igla", "rhs_weap_panzerfaust60" ];
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
//playSound "AASIntro"; 
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
		if (side _x == side player && {!alive _x }) then {
            _dist = (player distance _x) / 3000;
            _color = [0,0.7,0,0.7];
			_namedead= name _x;
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
                _namedead,
                2,
                0.03,
                'Bitstream'
            ];
          };
    } forEach playableUnits;
}];
//END NAILER[C5] - ADD NAME TAGS FOR YOUR OWN TEAM...
PrintingPress =  { 
private["_blocks","_block","_blockCount","_blockNr","_blockArray","_blockText","_blockTextF","_blockTextF_","_blockFormat","_formats","_inputData","_processedTextF","_char","_cursorBlinks","_cursorInvis"]; 
_blockCount = count _this; 
_invisCursor = "<t color ='#00000000' shadow = '0'>_</t>"; 
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
  _blockTextF_ = format[_blockFormat, _blockText + "_"]; 
[(_processedTextF + _blockTextF_), 0, 0.6, 5, 0, 0, 90] spawn BIS_fnc_dynamicText; 
playSound "click"; 
sleep 0.05; 
[(_processedTextF + _blockTextF), 0, 0.6, 5, 0, 0, 90] spawn BIS_fnc_dynamicText; 
sleep 0.02; } forEach _blockArray; 
 if (_blockNr + 1 < _blockCount) then { _cursorBlinks = 4; }  else { _cursorBlinks = 8; }; 
for "_i" from 1 to _cursorBlinks do { [_processedTextF + _blockTextF_, 0, 0.6, 5, 0, 0, 90] spawn BIS_fnc_dynamicText; 
            sleep 0.08; 
            [_processedTextF + _blockTextF, 0, 0.6, 5, 0, 0, 90] spawn BIS_fnc_dynamicText; 
            sleep 0.02; }; 
        _processedTextF  = _processedTextF + _blockTextF; } forEach _blocks; 
    ["", 0, 0.6, 5, 0, 1, 90] spawn BIS_fnc_dynamicText; 
};
