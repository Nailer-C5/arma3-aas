/* #define S3_VehSpawn 30
#define S3_TankSpawn 15
#define S3_HeliSpawn 60
#define S3_PlaneSpawn 60
#define S3_BastardSpawn 60 */

//if (true) ExitWith {};
#include "..\..\..\Rules\S3_INITJRMission.h"

#define MAX_DAMAGE 0.9
scriptName ('OLD RESPAWN ('+ gettext(configFile >> 'CfgVehicles' >> typeof (_this select 0)  >> 'displayName')+')');


private [ "_respawnDelay", "_theVehicle", "_startDirection", "_startPos", "_typ", "_lastUsedTime", "_abandoned", "_threadUID",
	"_Vdata", "_uhealth","_upylons","_uWeapons",'_uTextures',"_pylonPaths",'_saveName'];
if( isServer ) then
{
	_theVehicle   = _this select 0;
	diag_log str _theVehicle;
	if(typeOf _theVehicle in ["rhs_tigr_sts_3camo_vv", "rhs_tigr_sts_vv"]) then 
	{_theVehicle removeWeaponTurret ["RHS_weap_Ags30_tigr", [1]]; };
	if(typeOf _theVehicle in ["rhsusf_M1117_O"]) then 
	{_theVehicle removeWeaponGlobal "RHS_MK19"; };
	clearWeaponCargoGlobal _theVehicle; 
	clearMagazineCargoGlobal _theVehicle;
	clearBackpackCargoGlobal _theVehicle;
	clearItemCargoGlobal _theVehicle;
	_theVehicle disableTIEquipment true;
	_theVehicle addItemCargoGlobal ["FirstAidKit", 4];
	_theVehicle addItemCargoGlobal ["ToolKit", 1];
	if( _theVehicle isKindOf "Helicopter" ) then 
				{ 
					{
					_theVehicle addBackpackCargoGlobal ["rhs_d6_Parachute_backpack",50]; 
					}; 
				if(typeOf _theVehicle in ["RHS_AH64_base"]) then 
					{
					_theVehicle addItemCargoGlobal ["rhsusf_ihadss",2]; 
					};
				if(typeOf _theVehicle in ["RHS_AH1Z_base"]) then 
					{
					_theVehicle addItemCargoGlobal ["rhsusf_hgu56p_usa",2]; 
					};
				};
	_startDirection = getDir _theVehicle;
	_startPos= getPos _theVehicle;	
	_typ           = typeOf _theVehicle;
	_theVehicle setVehicleReportRemoteTargets true;
	_theVehicle  setVehicleReportOwnPosition true;
	if(getNumber(configFile >> "CfgVehicles" >> typeof _thevehicle >> "isUav")==1) then {createVehicleCrew _thevehicle;}; 	
	
	_saveName=  'Veh_'+ (_theVehicle call BIS_fnc_netId);
	[_theVehicle, [missionNamespace, _saveName] ] call BIS_fnc_saveVehicle; 
	
    _uTextures= [];
	_uTextures= getObjectTextures _theVehicle;
	
	_uhealth= damage _theVehicle;
    _upylons= getPylonMagazines _theVehicle;
	_uWeapons= _theVehicle call S3_fnc_saveVehicleWeapons;
	
	
	_abandoned = false;
	_lastUsedTime = time;
	_threadUID = round (random 10000);

	_respawnDelay = S3_VehSpawn;		
	
	if( _theVehicle isKindOf "Tank") then { _respawnDelay = S3_TankSpawn; };
	if( _theVehicle isKindOf "Helicopter") then { _respawnDelay = S3_HeliSpawn; };
	if( _theVehicle isKindOf "Plane") then { _respawnDelay = S3_PlaneSpawn;  };
	
	//bastard vehicle (AGS)
		if(typeOf _theVehicle in ["rhs_tigr_sts_3camo_msv", "rhs_tigr_sts_3camo_vdv", "rhs_tigr_sts_3camo_vmf", "rhs_tigr_sts_msv", "rhs_tigr_sts_vdv",  
						   "rhs_tigr_sts_vmf", "rhsusf_m1025_w_mk19", "rhsusf_m1025_d_Mk19", "rhsusf_m1025_d_s_Mk19", "rhsusf_m1025_w_s_Mk19", "rhsusf_M1117_base", "rhsusf_M1117_D", 
						   "rhsusf_M1117_W", "rhsusf_m113_usarmy_MK19", "rhsusf_m113d_usarmy_MK19", "rhsusf_M1232_MK19_usarmy_d", "rhsusf_M1232_MK19_usarmy_wd", 
						   "rhsusf_M1237_MK19_usarmy_d", "rhsusf_M1237_MK19_usarmy_wd", "rhs_weap_2a72", "rhs_weap_2a72_base", "rhsusf_M1220_MK19_usarmy_d", "rhsusf_M1220_MK19_usarmy_wd", 
						   "rhsusf_M1230_MK19_usarmy_wd", "rhsusf_M1230_MK19_usarmy_d", "RHS_UAZ_AGS30_Base","Boat_Armed_01_minigun_base_F", "B_Boat_Armed_01_minigun_F", "Boat_Armed_01_base_F", 
						   "O_Boat_Armed_01_hmg_F", "rhsusf_mkvsoc", "B_APC_Wheeled_01_cannon_F", "B_APC_Wheeled_01_base_F", "MRAP_01_gmg_base_F", "MRAP_02_gmg_base_F", "rhs_gaz66o_vv", 
						   "rhsusf_M1078A1P2_WD_flatbed_fmtv_usarmy",  "RHS_M119_D", "RHS_M119_WD", "rhs_D30_at_ins", "rhs_D30_at_msv", "rhs_D30_at_vdv", "rhs_D30_at_vmf", 
						   "rhs_D30_ins", "rhs_D30_msv", "rhs_D30_vdv", "rhs_D30_vmf"]) then 
		{
			_respawnDelay = S3_BastardSpawn;
		};  
	
	while { true } do
	{
		sleep 5 + (random 10);
		if( (_theVehicle distance _startPos) < 20 ) then { _lastUsedTime = time; };	
		if ( ({alive _x} count (crew _theVehicle)) > 0) then { _lastUsedTime = time }; 
		if( (_theVehicle distance _startPos) < 10 and !(canMove _theVehicle) ) then
			{
			_abandoned = true;
			};
		if( (time-_lastUsedTime) > 60 ) then	//60 abandon time
			{
			_abandoned = true;
			};
		if( ((damage _theVehicle) > MAX_DAMAGE) or _abandoned ) then
			{
  			if ({alive _x} count (crew _theVehicle) > 0) exitWith {};
			sleep (_respawnDelay / 2);
			if ({alive _x} count (crew _theVehicle) > 0) exitWith {};
					
	
			deleteVehicle _theVehicle;
			_theVehicle = objNull;
			sleep (_respawnDelay / 2);		
		
			if(getNumber(configFile >> "CfgVehicles" >> _typ >> "isUav")==1) then
			{
				_theVehicle = createVehicle [_typ, _startPos, [], 0, "FLY"];	
				createVehicleCrew _thevehicle;
			} 
			else
			{
				_theVehicle = _typ createVehicle _startPos;
			};
			
			
			_theVehicle setDamage _uhealth;
			{ _theVehicle setObjectTextureGlobal [_forEachIndex, _x];  } forEach _uTextures;
			
			[_theVehicle, [missionnamespace, _saveName]] call BIS_fnc_loadVehicle;
			
			_theVehicle disableTIEquipment true;
				
			if !(_theVehicle isKindOf "Air") then
			{
				[_theVehicle, _theVehicle call S3_fnc_saveVehicleWeapons] call S3_fnc_ClearVehicleWeapons;
				[_theVehicle, _uWeapons] call S3_fnc_ADDVehicleWeapons;
			} else
			{
			
			_veh = _thevehicle; 
 
			private _allPylons = "true" configClasses ( configFile>>"CfgVehicles" >> (typeOf _veh) >> "Components">>"TransportPylonsComponent">>"pylons"  
			) apply {configName _x}; 
    
 
			_pylonsToRemove = getPylonMagazines _veh;
			_vehTurrets = [[-1]] + allTurrets _veh; 
 
			{ 
			_weaponToRemove = getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon");
			{
			_veh removeWeaponTurret [_weaponToRemove, _x];
			} forEach _vehTurrets; 
			} forEach _pylonsToRemove;
			//hint str _pylonsToRemove;
			{ 
			_veh setPylonLoadOut [_x, ""];
			} forEach _allPylons;
			
			
			
			{ _theVehicle removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach (getPylonMagazines _theVehicle);
			_pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _theVehicle >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
			{ _theVehicle setPylonLoadOut [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex]; } forEach _upylons;
			};
	      
			clearWeaponCargoGlobal _theVehicle; 
			clearMagazineCargoGlobal _theVehicle;
			clearBackpackCargoGlobal _theVehicle;
			clearItemCargoGlobal _theVehicle;
			_theVehicle addItemCargoGlobal ["FirstAidKit",4];
	        _theVehicle addItemCargoGlobal ["ToolKit", 1];
			if( _theVehicle isKindOf "Helicopter" ) then 
				{ 
					{
					_theVehicle addBackpackCargoGlobal ["rhs_d6_Parachute_backpack",50]; 
					}; 
				if(typeOf _theVehicle in ["RHS_AH64_base"]) then 
					{
					_theVehicle addItemCargoGlobal ["rhsusf_ihadss",2]; 
					};
				if(typeOf _theVehicle in ["RHS_AH1Z_base"]) then 
					{
					_theVehicle addItemCargoGlobal ["rhsusf_hgu56p_usa",2]; 
					};
				};
			_theVehicle setPos _startPos;                                   
			_theVehicle setDir _startDirection;
			_theVehicle setVehicleReportRemoteTargets true;
	        _theVehicle  setVehicleReportOwnPosition true;
			
			if(getNumber(configFile >> "CfgVehicles" >> typeof _thevehicle >> "isUav")==1) then{createVehicleCrew _thevehicle;};
			
			AAS_PublicAddActionsAndEH = _theVehicle;
			publicVariable "AAS_PublicAddActionsAndEH";
			
			_abandoned = false;
			_lastUsedTime = time;
			};
				
	};	
};