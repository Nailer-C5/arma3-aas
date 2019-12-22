  clearWeaponCargoGlobal _obj ;
  clearMagazineCargoGlobal _obj ;
  clearItemCargoGlobal _obj ;
  clearBackpackCargoGlobal _obj ;

if( playerSide == west ) then
	{
	_obj addWeaponCargoGlobal ["rhs_weap_M136",10];
	_obj addWeaponCargoGlobal ["rhs_weap_M136_hedp",10];
	_obj addWeaponCargoGlobal ["rhs_weap_m72a7",10];
	_obj addWeaponCargoGlobal ["rhs_weap_panzerfaust60",10];
	//_obj addWeaponCargoGlobal ["rhs_weap_optic_smaw",5];
	//_obj addWeaponCargoGlobal ["rhs_weap_fgm148",5];
	//_obj addWeaponCargoGlobal ["rhs_weap_fim92",10];		
	};
	
if( playerSide == east ) then
	{
	_obj addWeaponCargoGlobal ["rhs_weap_rpg26",10];
	_obj addWeaponCargoGlobal ["rhs_weap_rshg2",10];
	_obj addWeaponCargoGlobal ["rhs_weap_m80",10];
	_obj addWeaponCargoGlobal ["rhs_weap_rpg75",10];
    //_obj addWeaponCargoGlobal ["rhs_weap_rpg7_pgo",5];
    //_obj addWeaponCargoGlobal ["launch_O_Vorona_green_F",5];
	//_obj addWeaponCargoGlobal ["rhs_weap_igla",10];	
	};

    _obj addMagazineCargoGlobal ["rhs_mag_rgn",40],
	_obj addMagazineCargoGlobal ["rhs_mag_rgd5",40],
	_obj addMagazineCargoGlobal ["rhs_mag_rgo",40];
	_obj addMagazineCargoGlobal ["rhs_mag_m67",40],
	_obj addMagazineCargoGlobal ["rhs_mag_f1",40];		

_rockets = [ 	"rhs_rpg7_PG7V_mag", "rhs_rpg7_PG7VL_mag", "rhs_rpg7_PG7VR_mag", "rhs_rpg7_TBG7V_mag", "rhs_rpg7_type69_airburst_mag","rhs_rpg7_OG7V_mag", "rhs_mag_9k38_rocket",  "Vorona_HEAT",   
				"rhs_mag_smaw_HEAA" ,"rhs_mag_smaw_HEDP" , "rhs_mag_maaws_HEAT", "rhs_mag_maaws_HEDP", "rhs_mag_maaws_HE", "rhs_fim92_mag","rhs_fgm148_magazine_AT"];
_mags =    [ 	"rhs_VOG25", "rhs_VOG25P", "rhs_vg40sz",	"rhs_VG40TB", "rhs_VG40MD_White", "rhs_GDM40", "rhs_VG40OP_green",
				"rhs_mag_M441_HE", "rhs_mag_M433_HEDP", "rhs_mag_M397_HET", "rhs_mag_m714_White", "rhs_mag_m4009", "rhs_mag_m576", "rhs_mag_m662_red",
				"rhs_30Rnd_545x39_AK", "rhs_30Rnd_545x39_AK_green", "rhs_30Rnd_545x39_7N6_AK", "rhs_30Rnd_545x39_7N10_AK", "rhs_30Rnd_545x39_7N22_AK",
				"rhs_30Rnd_762x39mm_tracer", "rhs_30Rnd_762x39mm", "rhs_30Rnd_762x39mm_89", "rhs_30Rnd_762x39mm_U", "rhsgref_30rnd_556x45_m21_t",
				"rhs_mag_30Rnd_556x45_M855A1_Stanag", "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",  "rhs_mag_30Rnd_556x45_Mk318_Stanag", "rhs_mag_30Rnd_556x45_Mk262_Stanag", "rhs_30Rnd_762x39mm_Savz58", "rhs_30Rnd_762x39mm_Savz58_tracer",  
				"rhs_100Rnd_762x54mmR_7BZ3", "rhs_100Rnd_762x54mmR_green","rhs_100Rnd_762x54mmR_7N26", "rhssaf_250Rnd_762x54R", "rhs_45Rnd_545X39_7N6_AK", "rhs_45Rnd_545X39_7N10_AK",
				"rhs_45Rnd_545X39_7N22_AK", "rhs_45Rnd_545X39_AK_Green",   
				"rhsusf_100Rnd_762x51_m993", "rhsusf_100Rnd_762x51_m62_tracer", "rhsusf_100Rnd_762x51_m61_ap", "rhsusf_100Rnd_762x51_m80a1epr", "rhsusf_100Rnd_762x51_m82_blank",
				"rhsusf_100Rnd_556x45_soft_pouch", "rhs_200rnd_556x45_M_SAW", "rhs_200rnd_556x45_B_SAW", "rhs_200rnd_556x45_T_SAW", 
				"rhs_20rnd_9x39mm_SP6", "rhsgref_1Rnd_Slug", "rhsgref_1Rnd_00Buck",
				"rhssaf_30rnd_556x45_Tracers_G36", "rhssaf_30rnd_556x45_SOST_G36", "rhssaf_30rnd_556x45_SPR_G36", "rhssaf_30rnd_556x45_TDIM_G36", "rhssaf_30rnd_556x45_MDIM_G36", "rhssaf_30rnd_556x45_EPR_G36", 
				//"rhssaf_100rnd_556x45_EPR_G36", "150Rnd_556x45_Drum_Mag_F", "150Rnd_556x45_Drum_Mag_Tracer_F",
				"rhs_10Rnd_762x54mmR_7N1", "rhs_5Rnd_338lapua_t5000", "rhsusf_mag_10Rnd_STD_50BMG_M33", "rhsusf_mag_10Rnd_STD_50BMG_mk211", "rhsgref_10Rnd_792x57_m76", "rhssaf_10Rnd_792x57_m76_tracer", "rhsgref_5Rnd_762x54_m38",
				"rhsusf_20Rnd_762x51_m993_Mag", "rhsusf_20Rnd_762x51_m993_Mag", "rhsusf_5Rnd_300winmag_xm2010",  
				"rhsusf_5Rnd_762x51_m118_special_Mag", "rhsusf_5Rnd_762x51_m993_Mag", "rhsusf_5Rnd_762x51_m62_Mag","rhsgref_5Rnd_792x57_kar98k",
				"rhsusf_20Rnd_762x51_m118_special_Mag", "rhsusf_20Rnd_762x51_m993_Mag", "rhsusf_10Rnd_762x51_m118_special_Mag", "rhsusf_10Rnd_762x51_m993_Mag", "rhsusf_10Rnd_762x51_m62_Mag", 
				"rhs_mag_9x19mm_7n31_20",
				"rhsusf_mag_40Rnd_46x30_JHP", "rhsusf_mag_40Rnd_46x30_FMJ", "rhsusf_mag_40Rnd_46x30_AP", "rhsusf_mag_15Rnd_9x19_JHP", "rhsusf_mag_17Rnd_9x19_JHP",
				"rhsusf_8Rnd_Slug", "rhsusf_8Rnd_FRAG",
				"rhsgref_20rnd_765x17_vz61", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x19_17",
				"rhsusf_mag_7x45acp_MHP"
				]; 
_supportammo = [ "rhs_mag_an_m14_th3", "rhs_mag_m7a3_cs", "rhs_mag_mk3a2", "rhs_mag_nspd", "rhs_mag_nspn_yellow", "rhs_mag_nspn_red", "rhs_mag_nspn_green", "rhs_mag_mk84", "rhs_mag_fakel" , 
				"rhs_mag_rdg2_white", "rhs_mag_an_m8hc", "rhs_mag_m18_green", "rhs_mag_m18_yellow", "rhs_mag_m18_red", "rhs_mag_m18_purple",
				"Chemlight_blue", "Chemlight_red", "Chemlight_green", "Chemlight_yellow",
				"rhs_mag_fakels", "rhsgref_mag_rkg3em", "rhs_mag_plamyam", "rhs_mag_zarya2"];	
_smokes = [ "rhs_mag_rdg2_white", "rhs_mag_rdg2_black", "rhs_mag_an_m8hc",
                  "rhs_mag_m714_White", "rhs_mag_m713_Red",  "rhsusf_mag_6Rnd_M714_white",
        	      "rhs_GRD40_White", "rhs_vg40op_white"  ]; //, "rhs_mag_M585_white"			
_supportweps = [ "Binocular" ];  				
    { _obj AddMagazineCargoGlobal [ _x , 20 ]; } forEach _rockets;
	//{ _obj AddMagazineCargoGlobal [ _x , 20 ]; } forEach _antiair;
	{ _obj AddMagazineCargoGlobal [ _x , 50    ]; } forEach _mags;
	{ _obj AddMagazineCargoGlobal [ _x , 50 ]; } forEach _supportammo;
    { _obj addMagazineCargoGlobal [ _x,50 ]; } forEach _smokes;
    { _obj AddWeaponCargoGlobal [ _x , 50 ]; } forEach _supportweps;				
    _obj addMagazineCargoGlobal [ "rhs_mine_tm62m_mag",15];
    _obj addMagazineCargoGlobal [ "rhs_mine_M19_mag",15];	

			



		
	