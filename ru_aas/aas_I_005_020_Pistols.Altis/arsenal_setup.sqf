//rev -11.
#include "globalDefines.hpp"
#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

//Зачистка ящика 
//Не менять >>>
[VIRTUAL_BOX, VIRTUAL_BOX call BIS_fnc_getVirtualWeaponCargo] spawn BIS_fnc_removeVirtualWeaponCargo;
[VIRTUAL_BOX, VIRTUAL_BOX call BIS_fnc_getVirtualMagazineCargo] spawn BIS_fnc_removeVirtualMagazineCargo;
[VIRTUAL_BOX, VIRTUAL_BOX call BIS_fnc_getVirtualItemCargo] spawn BIS_fnc_removeVirtualItemCargo;
[VIRTUAL_BOX, VIRTUAL_BOX call BIS_fnc_getVirtualBackpackCargo] spawn BIS_fnc_removeVirtualBackpackCargo;
sleep 1;
_wpns=[]; _items=[]; _mags=[]; _bkp= []; 
//Не менять <<<

_mags=[
				"rhsgref_5Rnd_762x54_m38","rhsgref_5Rnd_792x57_kar98k",
				"rhsusf_8Rnd_Slug", "rhsusf_8Rnd_FRAG",
				"rhsusf_mag_17Rnd_9x19_JHP", "rhsusf_mag_15Rnd_9x19_JHP", "rhs_mag_9x19_17", "rhs_mag_9x18_8_57N181S",				
				"rhs_mag_m7a3_cs", "rhs_mag_nspd", "rhs_mag_nspn_yellow", "rhs_mag_nspn_red", "rhs_mag_nspn_green",  
				"rhs_mag_rdg2_white", "rhs_mag_rdg2_black", "rhs_mag_an_m8hc", "rhs_mag_m18_green", "rhs_mag_m18_yellow", "rhs_mag_m18_red", "rhs_mag_m18_purple",
				"Chemlight_blue", "Chemlight_red", "Chemlight_green", "Chemlight_yellow"
		];
		
_items=["NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP"];

if( playerClass != LOADOUT_CUSTOM ) then
{
if( WEST_PLAYER ) then 
	{ 
		myRifles = RULES_classList select playerClass select CL_WESTRIFLES; 
		{ _wpns= _wpns+[_x]; } forEach (RULES_classList select playerClass select CL_WESTWEPS);
		{ _items= _items+ [_x]; } forEach (RULES_classList select playerClass select CL_WESTUNIFORMS);
		{ _items= _items+ [_x]; } forEach (RULES_classList select playerClass select CL_WESTVESTS);
		{ _items= _items+ [_x];	} forEach (RULES_classList select playerClass select CL_WESTHEADGEARS);
		{ _items= _items+ [_x]; } forEach (RULES_classList select playerClass select CL_WESTITEMS);
		{ _items= _items+ [_x]; } forEach (RULES_classList select playerClass select CL_WESTBINOS);
		{ _items= _items+ [_x]; } forEach (RULES_classList select playerClass select CL_WESTGOGGLES);
		{ _mags= _mags+ [_x select 0]; } forEach (RULES_classList select playerClass select CL_WESTMAGS);
		{ _bkp= _bkp+ [_x]; } forEach (RULES_classList select playerClass select CL_WESTBACKBACKS);
	};
	
if( EAST_PLAYER ) then 
	{ 
		myRifles = RULES_classList select playerClass select CL_EASTRIFLES; 
		{ _wpns= _wpns+[_x]; } forEach (RULES_classList select playerClass select CL_EASTWEPS);
		{ _items= _items+ [_x]; } forEach (RULES_classList select playerClass select CL_EASTUNIFORMS);
		{ _items= _items+ [_x]; } forEach (RULES_classList select playerClass select CL_EASTVESTS);
		{ _items= _items+ [_x];	} forEach (RULES_classList select playerClass select CL_EASTHEADGEARS);
		{ _items= _items+ [_x]; } forEach (RULES_classList select playerClass select CL_EASTITEMS);
		{ _items= _items+ [_x]; } forEach (RULES_classList select playerClass select CL_EASTBINOS);
		{ _items= _items+ [_x]; } forEach (RULES_classList select playerClass select CL_EASTGOGGLES);
		{ _mags= _mags+ [_x select 0]; } forEach (RULES_classList select playerClass select CL_EASTMAGS);
		{ _bkp= _bkp+ [_x];	} forEach (RULES_classList select playerClass select CL_EASTBACKBACKS);	
	};

{
	_wpns= _wpns+[_x select 0];	
	
	_items_count= count (_x) -1;
	if (_items_count>0) then
	{		
	for "_i" from 1 to _items_count do 
	{ 
	_items= _items+ [_x select _i];	
	};
	};
	
} forEach myRifles;

};

[VIRTUAL_BOX, _wpns, false, false] call BIS_fnc_addVirtualWeaponCargo;
[VIRTUAL_BOX, _items, false, false] call BIS_fnc_addVirtualItemCargo;
[VIRTUAL_BOX, _bkp, false, false] call BIS_fnc_addVirtualBackpackCargo;
[VIRTUAL_BOX, _mags, false, false] call BIS_fnc_addVirtualMagazineCargo;

sleep 1;
["Open",[nil, VIRTUAL_BOX, player]] spawn bis_fnc_arsenal;