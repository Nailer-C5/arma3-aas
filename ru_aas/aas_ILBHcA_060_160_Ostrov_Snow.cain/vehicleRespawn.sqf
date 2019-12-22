//0.2
#include "globalDefines.hpp"
#define MAX_DAMAGE 0.9
RULES_initialised = netObjNull;
waitUntil { RULES_initialised };
private [ "_respawnDelay", "_theVehicle", "_startDirection", "_startPos", "_typ", "_lastUsedTime", "_abandoned", "_threadUID","_pylonPaths",
'_uTextures', '_uWeapons', '_uhealth', "_upylons"];

AAS_zlt_repair= 
{
	if (getRepairCargo _this > 0) then 
	{
		_this setRepairCargo 0;
		_this setVariable ["zlt_repair_cargo", 10, true]; 
	};	
};

if( isServer ) then
	{
	int _respawnDelay = _this select 1;
	obj _theVehicle   = _this select 0;
	//АГС убираем
	if(typeOf _theVehicle in ["rhs_tigr_sts_3camo_vv", "rhs_tigr_sts_vv"]) then 
		{_theVehicle removeWeaponTurret ["RHS_weap_Ags30_tigr", [1]]; };
	if(typeOf _theVehicle in ["rhsusf_M1117_O"]) then 
		{_theVehicle removeWeaponGlobal "RHS_MK19"; };
    //			
	_theVehicle setvariable ["bomb",false,true];
	_theVehicle call AAS_zlt_repair;
    clearWeaponCargoGlobal _theVehicle; 
	clearMagazineCargoGlobal _theVehicle;
	clearBackpackCargoGlobal _theVehicle;
	clearItemCargoGlobal _theVehicle;
	//call Replace_weapon;
	_theVehicle addItemCargoGlobal ["FirstAidKit", (random 10)];
	if( _theVehicle isKindOf "Helicopter" ) then 
		 	{
			_theVehicle addBackpackCargoGlobal ["rhs_d6_Parachute_backpack",50]; 
			 			
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
	pos _startPos   = getPos _theVehicle;
	_typ            = typeOf _theVehicle;
	
	//_theVehicle setVariable['upylons', getPylonMagazines _theVehicle];
	
	_theVehicle addEventHandler ["Fired",{ _this spawn fn_firedEffect }];
	_uTextures= getObjectTextures _theVehicle;
	_uWeapons= _theVehicle call AAS_fnc_saveVehicleWeapons;
	_uhealth= damage _theVehicle;
	_upylons= getPylonMagazines _theVehicle;
	////////////////////////
	
	//diag_log str(getObjectTextures _theVehicle);
	
	bool _abandoned = false;
	float _lastUsedTime = time;
	int _threadUID = round (random 10000);
	if( RULES_overrideVehicleSpawnTimes ) then
		{
		_respawnDelay = RULES_vehicleRespawnDelay;
		if( _theVehicle isKindOf "Tank"       ) then { _respawnDelay = RULES_tankRespawnDelay;    };
		if( _theVehicle isKindOf "Helicopter" ) then { _respawnDelay = RULES_chopperRespawnDelay; };
		if( _theVehicle isKindOf "Plane"      ) then { _respawnDelay = RULES_planeRespawnDelay;   };
		if(typeOf _theVehicle in ["rhs_tigr_sts_3camo_msv", "rhs_tigr_sts_3camo_vdv", "rhs_tigr_sts_3camo_vmf", "rhs_tigr_sts_msv", "rhs_tigr_sts_vdv",  
						   "rhs_tigr_sts_vmf", "rhsusf_m1025_w_mk19", "rhsusf_m1025_d_Mk19", "rhsusf_m1025_d_s_Mk19", "rhsusf_m1025_w_s_Mk19", "rhsusf_M1117_base", "rhsusf_M1117_D", 
						   "rhsusf_M1117_W", "rhsusf_m113_usarmy_MK19", "rhsusf_m113d_usarmy_MK19", "rhsusf_M1232_MK19_usarmy_d", "rhsusf_M1232_MK19_usarmy_wd", 
						   "rhsusf_M1237_MK19_usarmy_d", "rhsusf_M1237_MK19_usarmy_wd", "rhs_weap_2a72", "rhs_weap_2a72_base", "rhsusf_M1220_MK19_usarmy_d", "rhsusf_M1220_MK19_usarmy_wd", 
						   "rhsusf_M1230_MK19_usarmy_wd", "rhsusf_M1230_MK19_usarmy_d", "RHS_UAZ_AGS30_Base","Boat_Armed_01_minigun_base_F", "B_Boat_Armed_01_minigun_F", "Boat_Armed_01_base_F", 
						   "O_Boat_Armed_01_hmg_F", "rhsusf_mkvsoc", "B_APC_Wheeled_01_cannon_F", "B_APC_Wheeled_01_base_F", "MRAP_01_gmg_base_F", "MRAP_02_gmg_base_F"]) then 
		{_respawnDelay = RULES_Noob_CarRespawnDelay; }; 
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
		if( (time-_lastUsedTime) > RULES_abandonedVehicleTimeLimit ) then
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
			_theVehicle = _typ createVehicle _startPos;	
			//_theVehicle addEventHandler ["Fired",
			/////////////////////////////////
			/////////////////////////////////
			_theVehicle setDamage _uhealth;	//Set health
			{ _theVehicle setObjectTextureGlobal [_forEachIndex, _x];  } forEach _uTextures;	//Set textures
			[_theVehicle, _theVehicle call AAS_fnc_saveVehicleWeapons] call AAS_fnc_ClearVehicleWeapons;	//Remove default weapons
			[_theVehicle, _uWeapons] call AAS_fnc_ADDVehicleWeapons;	//Add configured weapons
			////////////////////////////////////////////////
			_theVehicle addEventHandler ["Fired",{ _this spawn fn_firedEffect }];
			////////////////////////////////////////////////
			
			
			//АГС убираем
			if(typeOf _theVehicle in ["rhs_tigr_sts_3camo_vv", "rhs_tigr_sts_vv"]) then 
			{_theVehicle removeWeaponTurret ["RHS_weap_Ags30_tigr", [1]]; };			
			 
			if(typeOf _theVehicle in ["rhsusf_M1117_O"]) then 
			{_theVehicle removeWeaponGlobal "RHS_MK19"; };
			//
			/////////////////////////Rev 2

			{ _theVehicle removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach (getPylonMagazines _theVehicle);
			_pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _theVehicle >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
			{ _theVehicle setPylonLoadOut [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex]; } forEach _upylons;

			/////////////////////////
			_theVehicle call AAS_zlt_repair;
			_theVehicle setvariable ["bomb",false,true];
			clearWeaponCargoGlobal _theVehicle; 
			clearMagazineCargoGlobal _theVehicle;
			clearBackpackCargoGlobal _theVehicle;
			clearItemCargoGlobal _theVehicle;
			//call Replace_weapon;
			_theVehicle addItemCargoGlobal ["FirstAidKit", (random 10)];
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
	
			AAS_PublicAddActionsAndEH = _theVehicle;
			publicVariable "AAS_PublicAddActionsAndEH";
			if (!(isDedicated)) then
			{
				_theVehicle disableTIEquipment true;
			};
			_abandoned = false;
			_lastUsedTime = time;
			};
				
		};
		
	};
	