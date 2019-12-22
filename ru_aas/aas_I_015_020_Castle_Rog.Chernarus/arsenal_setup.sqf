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
_wpns=["rhs_weap_tr8"];
_mags=[
				"rhs_VOG25", "rhs_VOG25P", "rhs_vg40sz", "rhs_VG40TB", "rhs_VG40MD_White", "rhs_GDM40", "rhs_VG40OP_green",
				"rhs_mag_M441_HE", "rhs_mag_M433_HEDP", "rhs_mag_M397_HET", "rhs_mag_m714_White", "rhs_mag_m4009", "rhs_mag_m576", "rhs_mag_m662_red", "rhs_30Rnd_762x39mm_Savz58", "rhs_30Rnd_762x39mm_Savz58_tracer",
				"rhs_30Rnd_545x39_7N10_plum_AK", "rhs_30Rnd_545x39_7N10_desert_AK", "rhs_30Rnd_545x39_7N10_camo_AK", "rhs_30Rnd_545x39_7N6_green_AK", "rhs_30Rnd_545x39_7N6M_AK", "rhs_30Rnd_545x39_7N6M_green_AK",
				"rhs_30Rnd_545x39_7N6M_plum_AK", "rhs_30Rnd_545x39_7N22_desert_AK", "rhs_30Rnd_545x39_7N22_plum_AK", "rhs_30Rnd_545x39_7N22_camo_AK", "rhs_30Rnd_545x39_7N10_2mag_AK", "rhs_30Rnd_545x39_7N10_2mag_plum_AK",
				"rhs_30Rnd_545x39_7N10_2mag_desert_AK", "rhs_30Rnd_545x39_7N10_2mag_camo_AK", "rhs_30Rnd_545x39_AK_plum_green", "rhs_30Rnd_545x39_7U1_AK", "rhs_45Rnd_545X39_7U1_AK", 
				"rhs_30Rnd_545x39_AK", "rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_7N10_AK", "rhs_30Rnd_545x39_7N22_AK",
				"rhs_30Rnd_762x39mm_tracer", "rhs_30Rnd_762x39mm", "rhs_30Rnd_762x39mm_89", "rhs_30Rnd_762x39mm_U",  "rhsgref_30rnd_556x45_m21_t",
				"rhs_mag_30Rnd_556x45_M855_Stanag", "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red", "rhs_mag_30Rnd_556x45_M855A1_PMAG", "rhs_mag_30Rnd_556x45_M855A1_PMAG_Tracer_Red", "rhs_mag_30Rnd_556x45_M855_PMAG",
				"rhs_mag_30Rnd_556x45_M855_PMAG_Tracer_Red", "rhs_mag_30Rnd_556x45_Mk318_PMAG", "rhs_mag_30Rnd_556x45_Mk262_PMAG", "rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan", "rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan_Tracer_Red",
				"rhs_mag_30Rnd_556x45_M855_PMAG_Tan", "rhs_mag_30Rnd_556x45_M855_PMAG_Tan_Tracer_Red", "rhs_mag_30Rnd_556x45_Mk318_PMAG_Tan",
				"rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",  "rhs_mag_30Rnd_556x45_Mk318_Stanag", "rhs_mag_30Rnd_556x45_Mk262_Stanag", 
				"rhs_100Rnd_762x54mmR_7BZ3", "rhs_100Rnd_762x54mmR_green","rhs_100Rnd_762x54mmR_7N26","rhssaf_250Rnd_762x54R", "rhs_45Rnd_545X39_7N6_AK", "rhs_45Rnd_545X39_7N10_AK","rhs_75Rnd_762x39mm", "rhs_75Rnd_762x39mm_tracer", "rhs_75Rnd_762x39mm_89",
				"rhs_45Rnd_545X39_7N22_AK", "rhs_45Rnd_545X39_AK_Green",  
				"rhsgref_50Rnd_792x57_SmE_notracers_drum", "rhsgref_50Rnd_792x57_SmK_drum", "rhsgref_50Rnd_792x57_SmK_alltracers_drum", /*"rhsgref_296Rnd_792x57_SmE_belt", "rhsgref_296Rnd_792x57_SmE_notracers_belt", "rhsgref_296Rnd_792x57_SmK_belt", "rhsgref_296Rnd_792x57_SmK_alltracers_belt", */   
				"rhsusf_100Rnd_762x51_m993", "rhsusf_100Rnd_762x51_m62_tracer", "rhsusf_100Rnd_762x51_m61_ap", "rhsusf_100Rnd_762x51_m80a1epr", "rhsusf_200Rnd_556x45_soft_pouch", "rhsusf_200Rnd_556x45_mixed_soft_pouch", 
				"rhsusf_200Rnd_556x45_M855_soft_pouch", "rhsusf_200Rnd_556x45_M855_mixed_soft_pouch", "rhsusf_100Rnd_556x45_soft_pouch", "rhsusf_100Rnd_556x45_mixed_soft_pouch", "rhsusf_50Rnd_762x51", "rhsusf_50Rnd_762x51_m61_ap",
				"rhsusf_50Rnd_762x51_m62_tracer", "rhsusf_50Rnd_762x51_m80a1epr", 
				"rhsusf_100Rnd_556x45_M855_soft_pouch", "rhsusf_200Rnd_556x45_box", "rhsusf_200rnd_556x45_mixed_box", "rhsusf_200rnd_556x45_M855_box", "rhsusf_100Rnd_556x45_M855_soft_pouch", "rhsusf_100Rnd_556x45_M855_mixed_soft_pouch", /*"rhs_mag_100Rnd_556x45_M855A1_cmag_mixed", "rhs_mag_100Rnd_556x45_M855A1_cmag",*/
				"rhs_20rnd_9x39mm_SP6", "rhsgref_1Rnd_Slug", "rhsgref_1Rnd_00Buck",
				"rhssaf_30rnd_556x45_Tracers_G36", "rhssaf_30rnd_556x45_SOST_G36", "rhssaf_30rnd_556x45_SPR_G36", "rhssaf_30rnd_556x45_TDIM_G36", "rhssaf_30rnd_556x45_MDIM_G36", "rhssaf_30rnd_556x45_EPR_G36", 
				//"rhssaf_100rnd_556x45_EPR_G36", "150Rnd_556x45_Drum_Mag_F", "150Rnd_556x45_Drum_Mag_Tracer_F",
				"rhs_10Rnd_762x54mmR_7N1", "rhs_10Rnd_762x54mmR_7N14", "rhs_5Rnd_338lapua_t5000", "rhsusf_mag_10Rnd_STD_50BMG_M33", /*"rhsusf_mag_10Rnd_STD_50BMG_mk211", */"rhsgref_10Rnd_792x57_m76", "rhssaf_10Rnd_792x57_m76_tracer", "rhsgref_5Rnd_762x54_m38",
				"rhsusf_20Rnd_762x51_SR25_m118_special_Mag", "rhsusf_20Rnd_762x51_SR25_m62_Mag", "rhsusf_20Rnd_762x51_SR25_m993_Mag", "rhsusf_5Rnd_300winmag_xm2010",  
				"rhsusf_5Rnd_762x51_m118_special_Mag", "rhsusf_5Rnd_762x51_m993_Mag", "rhsusf_5Rnd_762x51_m62_Mag","rhsgref_5Rnd_792x57_kar98k",
				"rhsusf_20Rnd_762x51_m118_special_Mag", "rhsusf_20Rnd_762x51_m993_Mag", "rhsusf_20Rnd_762x51_m62_Mag", 
				"rhs_mag_9x19mm_7n21_44", "rhs_mag_9x19mm_7n31_44", "rhs_18rnd_9x21mm_7N28", "rhs_18rnd_9x21mm_7N29", "rhs_18rnd_9x21mm_7BT3", //"rhs_mag_9x19mm_7n31_20", 
				"rhsusf_mag_40Rnd_46x30_JHP", "rhsusf_mag_40Rnd_46x30_FMJ", "rhsusf_mag_40Rnd_46x30_AP", "rhsusf_mag_15Rnd_9x19_JHP", "rhsusf_mag_17Rnd_9x19_JHP",
				"rhsusf_8Rnd_Slug", "rhsusf_8Rnd_FRAG",
				"rhsgref_20rnd_765x17_vz61", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x19_17", "rhsgref_8Rnd_762x63_M2B_M1rifle",
				"rhsgref_30rnd_1143x23_M1911B_SMG", "rhsgref_30rnd_1143x23_M1T_SMG", "rhsgref_30rnd_1143x23_M1T_2mag_SMG", "rhsgref_30rnd_1143x23_M1911B_2mag_SMG",
				"rhsusf_mag_7x45acp_MHP","30Rnd_556x45_Stanag_green", "20Rnd_556x45_UW_mag",
				"rhs_rpg7_PG7V_mag", "rhs_rpg7_PG7VL_mag", "rhs_rpg7_PG7VR_mag", "rhs_rpg7_TBG7V_mag", "rhs_rpg7_type69_airburst_mag", "rhs_rpg7_OG7V_mag", "RPG32_F", "rhs_mag_9k38_rocket",   
				"rhs_mag_smaw_HEAA" ,"rhs_mag_smaw_HEDP" , "rhs_mag_maaws_HEAT", "rhs_mag_maaws_HEDP", "rhs_mag_maaws_HE", "rhs_fim92_mag", "rhs_fgm148_magazine_AT",   
				"rhs_mag_rgn", "rhs_mag_rgd5", "rhs_mag_rgo", "rhs_mag_m67", "rhs_mag_f1",
				"rhs_mag_an_m14_th3", "rhs_mag_m7a3_cs", "rhs_mag_mk3a2", "rhs_mag_nspd", "rhs_mag_nspn_yellow", "rhs_mag_nspn_red", "rhs_mag_nspn_green", "rhs_mag_mk84", "rhs_mag_fakel" , 
				"rhs_mag_fakels", "rhsgref_mag_rkg3em", "rhs_mag_plamyam", "rhs_mag_zarya2",
				"rhs_mine_tm62m_mag", "rhs_mine_M19_mag",
				"rhs_mag_rdg2_white", "rhs_mag_rdg2_black", "rhs_mag_an_m8hc", "rhs_mag_m18_green", "rhs_mag_m18_yellow", "rhs_mag_m18_red", "rhs_mag_m18_purple",
				"Chemlight_blue", "Chemlight_red", "Chemlight_green", "Chemlight_yellow",
                "rhs_mag_m714_White", "rhs_mag_m713_Red",  "rhsusf_mag_6Rnd_M714_white", "rhs_GRD40_White", "rhs_vg40op_white"
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