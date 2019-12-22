#include "globalDefines.hpp"
obj _vec = _this select 0;
int _rank = _this select 1;
clearWeaponCargoGlobal _vec;
clearMagazineCargoGlobal _vec;
clearItemCargoGlobal _vec;
clearBackpackCargoGlobal _vec;
RULES_initialised = netObjNull;
waitUntil {RULES_initialised};
_vec allowDamage RULES_allowDamageToAmmoCrates;
int _qlctr=0;
for "_qlctr" from 0 to ((count RULES_classList) - 1) do
{
	array _thisClass = RULES_classList select _qlctr;
	_vec addAction [_thisClass select CL_NAME,"doQuickLoadout.sqf",[true, _qlctr],20-_qlctr,false,true,"","true",10,false,"",""];
};
if (RULES_canCustomiseLoadout) then
{
 _vec addAction [localize "STR_AAS_Save_Loadout", "doQuickLoadout.sqf",[true,LOADOUT_SAVE], 3,false,true,"","true",10,false,"",""];
 _vec addAction [localize "STR_AAS_Load_Gear", "doQuickLoadout.sqf",[true,LOADOUT_CUSTOM], 2,false,true,"","true",10,false,"",""];
 _vec addAction [localize "STR_AAS_ARSENAL", "arsenal_setup.sqf",[], 4,false,true,"","true",10,false,"",""];
 };
 
AAS_RemoveAllMagazines={
{player removeMagazine _x} forEach (magazines player);

{
	_p= _x;
	{ _p removePrimaryWeaponItem _x} forEach (primaryWeaponMagazine _p);
	{ _p removeSecondaryWeaponItem _x} forEach (secondaryWeaponMagazine _p);
	{ _p removeHandgunItem _x } forEach (handgunMagazine _p);
	
} forEach [player];

player groupchat Localize 'STR_AAS_Clear_3';
};
 
if (RULES_canHealAtArmoury) then{
_vec addAction [localize "STR_AAS_Heal_Thyself", "actionMenuHandler.sqf",["SELF_HEAL"],100,false,true,"","true",10,false,"",""];};
_vec addAction [localize "STR_AAS_Select_Team", "actionMenuHandler.sqf",["SELECT_TEAM"],1,false,true,"","true",10,false,"",""];
_vec addAction [localize "STR_AAS_Clear_2", { 0 spawn AAS_RemoveAllMagazines },[], 4,false,true,"","true",10,false,"",""];
	
bool _doWest=true;
bool _doEast=true;

_rockets = [ 	]; //
				
_mags =    [ 	
				"rhsgref_5Rnd_762x54_m38","rhsgref_5Rnd_792x57_kar98k",
				"rhsusf_8Rnd_Slug", "rhsusf_8Rnd_FRAG",
				"rhsusf_mag_17Rnd_9x19_JHP", "rhsusf_mag_15Rnd_9x19_JHP", "rhs_mag_9x19_17", "rhs_mag_9x18_8_57N181S"
				]; 

_supportammo = [ "rhs_mag_m7a3_cs", "rhs_mag_mk3a2", "rhs_mag_nspd", "rhs_mag_nspn_yellow", "rhs_mag_nspn_red", "rhs_mag_nspn_green",  
				"rhs_mag_rdg2_white", "rhs_mag_an_m8hc", "rhs_mag_m18_green", "rhs_mag_m18_yellow", "rhs_mag_m18_red", "rhs_mag_m18_purple",
				"Chemlight_blue", "Chemlight_red", "Chemlight_green", "Chemlight_yellow"];				
	
	{ _vec AddMagazineCargoGlobal [ _x , AMMO_QTY_DEFAULT_ROCKETS ]; } forEach _rockets;
	//{ _vec AddMagazineCargoGlobal [ _x , AMMO_QTY_DEFAULT_ANTIAIR ]; } forEach _antiair;
	{ _vec AddMagazineCargoGlobal [ _x , AMMO_QTY_DEFAULT_MAGS    ]; } forEach _mags;
	{ _vec AddMagazineCargoGlobal [ _x , AMMO_QTY_DEFAULT_SUPPORT ]; } forEach _supportammo;

_vec addMagazineCargoGlobal [ 		 		AMMO_QTY_DEFAULT_MINES		];
_vec addMagazineCargoGlobal [ 		 		AMMO_QTY_DEFAULT_MINES		];
_vec addMagazineCargoGlobal [	"Laserbatteries",	AMMO_QTY_DEFAULT_SUPPORT	];
array _smokes = [  ]; //, "rhs_mag_M585_white"
			
{ _vec addMagazineCargoGlobal [ _x, AMMO_QTY_DEFAULT_SUPPORT ]; } forEach _smokes;

_supportweps = [ "Binocular", "rhsusf_ANPVS_15" ];  
{ _vec AddWeaponCargoGlobal [ _x , WEPS_QTY_DEFAULT_SUPPORT ]; } forEach _supportweps;


