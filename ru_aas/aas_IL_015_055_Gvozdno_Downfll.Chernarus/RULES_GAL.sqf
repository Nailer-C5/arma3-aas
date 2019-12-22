#include "globalDefines.hpp"
#include "mapname.hpp"
RULES_ruleSetName = "ArmA2ru community Rules";
RULES_debugPasswordHash = "vkontakte";   //  password to gain access to debugging commands (teleport, debug etc)
RULES_adminPasswordHash = "vkontakte2";   //  password to gain access to admin commands (weather, time etc)
RULES_WepsQtyDefault =[0, 0, 80, 0];
RULES_AmmoQtyDefault = [ 80, 20, 0, 0, 80, 20, 20 ];
RULES_allowDamageToAmmoCrates = false;
RULES_canCustomiseLoadout = true;    
RULES_customClassCanRevive = false;
RULES_everyoneCanRevive = false;
RULES_armouryUseRange = 10;
RULES_classChangeDelay = 60;
RULES_banScopedWithHeavy = true;
RULES_defaultTagDisplayRange = 600;   // range at which green player tags disppear (too far away to show)
RULES_maxTagDisplayRange     = 3000;  // range at which tag distance selector loops round back to zero
RULES_hudMaxLevel = 2;                // the best available hud display level (0 = minimal, 1 = no minimap, 2 = full)
RULES_captureRadius = 5;      //the radius of the flag that you need to get within to capture fully decamped base
RULES_captureSpeedFactor = 1.5;  //the capture speed factor multiplier (1=normal speed, 2=double speed, 0.5=half speed etc...)
RULES_enableProportionalCaptureSpeed = true;    // enable changing of capture speed depending on player numbers
RULES_captureSpeedMinCapacity = 2.62;               // maximum rate of capture (when there is one player in server)
RULES_captureSpeedMaxCapacity = 0.25;            // minimum rate of capture (when server is full)
RULES_baseQueueInterval = 10;		// how long you have to wait between each player spawning (strongly recommend not to change this)
RULES_minSpawnDelay = 10;			// minimum time you must wait, regardless of there being a queue
RULES_spawnArmourDuration = 10;         // how long does spawn armour last
RULES_spawncampRadius         = 70	; 	// defines the allowed range to walk within enemy base without punishment
RULES_spawncampMinLifespan    = 20 	;  // minimum lifespan under which assumed spawncamper has killed you
RULES_spawnElevation = 0; //Null elevation
RULES_spawncampRandomiseBound = 30	;  // X or Y dist from flag to be relocated (maximum) if randomised spawning used
RULES_spawncampProtectDefault = 1	;	// by default anti-spawncamp protection is on
RULES_overrideVehicleSpawnTimes = true;  // determines whether or not we should use rule settings for vehicle respawn
RULES_abandonedVehicleTimeLimit = 120;   // determines how long a vehicle must be left before considered abandoned
RULES_vehicleRespawnDelay       = AAS_VehicleDelay;    // how long should a vehicle take to respawn once destroyed or abandoned
RULES_tankRespawnDelay          = AAS_TankDelay;    // how long should a tank take to respawn
RULES_chopperRespawnDelay       = AAS_ChopperDelay;    // how long should a chopper take to respawn
RULES_planeRespawnDelay         = AAS_PlaneDelay;   // how long should a plane take to respawn
RULES_Noob_CarRespawnDelay      = AAS_AGSDelay;   // AGS and 30mm 
RULES_points                 = 1  ;       // points won per time period in an attacking zone
RULES_pointsDefzonePerPeriod = 1  ;       // points won per time period in a defending zone
RULES_secondsDefzoneToScore  = 60 ;       // time period for defending zone
RULES_secondsAttzoneToScore  = 30 ;       // time period for attacking zone
RULES_reviveScore            = 2  ;       // points you get for reviving divided by 3 (so if reviveScore=1 you get 3 points probably)
RULES_medicHealAmount     = 0 ;    // the amount of damage (on a scale of 0--1) that the medic heals you by randomly when in proximity
RULES_medicHealRange      = 5   ;    // range within which medic automatically heals injured players
RULES_nearbyMedicDistance = 500  ;    // range within which nearby medics are visible on respawn screen
RULES_canHealAtArmoury = true;        // sets whether you can heal yourself to 100% at the armoury or not
RULES_guiBaseDisplayed = true; //Turn GUI BASE display (ie.1 v 2) ON/OFF
RULES_AISupportMode = 1; //0 = AI support disabled, 1 = AI support enabled
RULES_wepsList = [

//Автоматы: Наименование / обозначение / патроны

[ "G36KV CCO",
"rhs_weap_g36kv",
[["rhssaf_30rnd_556x45_EPR_G36", 6]]],

[ "G36C",
"rhs_weap_g36c",
[["rhssaf_30rnd_556x45_EPR_G36", 6]]],

[ "M16A4",
"rhs_weap_m16a4_carryhandle_grip",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6]]],

[ "M16A4 ACOG",
"rhs_weap_m16a4_carryhandle_bipod",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6]]],

[ "M4A1 CCO",
"rhs_weap_m4a1_carryhandle_grip",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6]]],

[ "M4A1",
"rhs_weap_m4a1_carryhandle_mstock",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6]]],

[ "M4A1 WD ACOG",
"rhs_weap_m4a1_blockII_wd",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6]]],

[ "M4A1 RX01",
"rhs_weap_m4a1_blockII",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6]]],

[ "MK18 G33 XPS3",
"rhs_weap_mk18_grip_bk",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6]]],

[ "HK416 SU-230A",  
"rhs_weap_hk416d145_wd",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6]]],

[ "HK416 D10 CCO",  
"rhs_weap_hk416d10",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6]]],

[ "SA vz 58P T1",
"rhs_weap_savz58p_rail_black",
[["rhs_30Rnd_762x39mm_Savz58", 6]]],

[ "MP44",
"rhs_weap_MP44",
[["rhsgref_30Rnd_792x33_SmE_StG", 6]]],

[ "M3A1",
"rhs_weap_m3a1",
[["rhsgref_30rnd_1143x23_M1911B_SMG", 6]]],

////

[ localize "STR_AAS_AKS74U",
"rhs_weap_aks74u",
[["rhs_30Rnd_545x39_7N6_AK", 6]]],

[ localize "STR_AAS_AKS74NPSO",
"rhs_weap_aks74n",
[["rhs_30Rnd_545x39_7N6_AK", 6]]],
 
[ localize "STR_AAS_AK103DTK",
"rhs_weap_ak103_dtk",
[["rhs_30Rnd_762x39mm", 6]]],
 
[ localize "STR_AAS_AK1051P63",
 "rhs_weap_ak105",
 [["rhs_30Rnd_545x39_7N6_AK", 6]]],
 
[ localize "STR_AAS_AK104PKAS",
 "rhs_weap_ak104",
 [["rhs_30Rnd_762x39mm", 6]]],
 
[localize "STR_AAS_AK74M_Cobra",
"rhs_weap_ak74m_camo",
[["rhs_30Rnd_545x39_7N22_camo_AK", 6]]],

[localize "STR_AAS_AK74M_Cobra_Camo",
"rhs_weap_ak74m_camo_dtk",
[["rhs_30Rnd_545x39_7N10_camo_AK", 6]]],

[localize "STR_AAS_M21",
"rhs_weap_m21s",
[["rhsgref_30rnd_556x45_m21", 6]]],

[ localize "STR_AAS_AK103",
"rhs_weap_ak103",
[["rhs_30Rnd_762x39mm", 6]]],

[ localize "STR_AAS_AKS74",
"rhs_weap_ak74",
[["rhs_30Rnd_545x39_7N6_AK", 6]]],

[ localize "STR_AAS_AK74M_SL",
"rhs_weap_ak74m_camo_folded",
[["rhs_30Rnd_545x39_7N10_camo_AK", 6]]],

[ localize "STR_AAS_AK105_ZEN",
"rhs_weap_ak105_zenitco01",
[["rhs_30Rnd_545x39_7N6_AK", 6]]],

[ localize "STR_AAS_AK74M_NPZ",
"rhs_weap_ak74m_plummag_npz",
[["rhs_30Rnd_545x39_7N6_AK", 6]]],

[ localize "STR_AAS_AK74MR_MRCO",
"rhs_weap_ak74mr",
[["rhs_30Rnd_545x39_7N6_AK", 6]]],

[ "AKM",
"rhs_weap_akm",
[["rhs_30Rnd_762x39mm", 6]]],

[ localize "STR_AAS_AKMS",
"rhs_weap_akms",
[["rhs_30Rnd_762x39mm", 9]]],

[ localize "STR_AAS_AKM_zen_EKP8",
"rhs_weap_akm_zenitco01_b33",
[["rhs_30Rnd_762x39mm", 6]]],

[ localize "STR_AAS_M38",
"rhs_weap_m38",
[["rhsgref_5Rnd_762x54_m38", 12]]],

[ "SA vz 58P EKP8",
"rhs_weap_savz58p_rail",
[["rhs_30Rnd_762x39mm_Savz58", 6]]],

//стрелковое оружие с ГП: Наименование / обозначение / патроны / гранаты

[ "M16A4 GL ACOG",
"rhs_weap_m16a4_carryhandle_M203",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6],
["rhs_mag_M441_HE", 8]]],

[ "M4A1 GL CCO",
"rhs_weap_m4a1_carryhandle_m203",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6],
["rhs_mag_M441_HE", 8]]],

[ "Mk18 GL CCO",
"rhs_weap_mk18_m320",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6],
["rhs_mag_M441_HE", 8]]],

[ "G36KV GL CCO",
"rhs_weap_g36kv_ag36",
[["rhssaf_30rnd_556x45_EPR_G36", 6],
["rhs_mag_M441_HE", 8]]],

[ "HK416D145 GL RMR",
"rhs_weap_hk416d145_m320",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag", 6],
["rhs_mag_M441_HE", 8]]],

[ "HK416 GL XPS3 SMOKE",
"rhs_weap_hk416d10_m320",
[["rhs_mag_30Rnd_556x45_M855A1_Stanag",6],
["rhs_mag_m714_White", 8]]],

////

[localize "STR_AAS_AK103GL",
"rhs_weap_ak103_gp25_npz",
[["rhs_30Rnd_762x39mm", 6],
["rhs_VOG25", 8]]],

[localize "STR_AAS_AK74MGL",
"rhs_weap_ak74m_gp25",
[["rhs_30Rnd_545x39_7N6_AK", 6],
["rhs_VOG25", 8]]],

[localize "STR_AAS_AKS74-GL",
"rhs_weap_aks74_gp25",
[["rhs_30Rnd_545x39_7N6_AK", 6],
["rhs_VOG25", 8]]],

[localize "STR_AAS_AKS74NGL_Cobra",			
"rhs_weap_aks74n_gp25",
[["rhs_30Rnd_545x39_7N6_AK", 6],
["rhs_VOG25", 8]]],

[localize "STR_AAS_AK74MRGL_MRCO",			
"rhs_weap_ak74mr_gp25",
[["rhs_30Rnd_545x39_7N6_AK", 6],
["rhs_VOG25", 8]]],

[localize "STR_AAS_AKMNGL",			
"rhs_weap_akmn_gp25",
[["rhs_30Rnd_762x39mm", 6],
["rhs_VOG25", 8]]],

[localize "STR_AAS_AK47-MGL",
"rhs_weap_akms_gp25",
[["rhs_30Rnd_762x39mm", 6],
["rhs_VG40MD_White", 8]]],

//Пулеметы: Наименование / обозначение / патроны

[ "M249 EOTECH",
"rhs_weap_m249_pip_S_para",
[["rhsusf_100Rnd_556x45_M855_soft_pouch", 3]]],

[ "M249 MDO",
"rhs_weap_m249_pip_L_para",
[["rhsusf_100Rnd_556x45_M855_soft_pouch", 3]]],

[ "M249 G33 T1",
"rhs_weap_m249_pip",
[["rhsusf_100Rnd_556x45_M855_soft_pouch", 3]]],

[ "M240B elcan",
"rhs_weap_m240b_elcan",
[["rhsusf_100Rnd_762x51_m80a1epr", 4]]],

[ "M240B MDO",
"rhs_weap_m240B",
[["rhsusf_100Rnd_762x51_m80a1epr", 4]]],

[ "M240B XPS3",
"rhs_weap_m240B_CAP",
[["rhsusf_100Rnd_762x51_m80a1epr", 4]]],

[ "M27 IAR RMR",
"rhs_weap_m27iar_grip",
[["rhs_mag_100Rnd_556x45_M855A1_cmag", 4]]],

[ "M27 IAR XPS3",
"rhs_weap_m27iar",
[["rhs_mag_100Rnd_556x45_M855A1_cmag", 4]]],

[ "FN Minimi Para CCO",
"rhs_weap_minimi_para_railed",
[["rhsusf_200Rnd_556x45_box", 2]]],
/*
[ "MG42",
"rhs_weap_mg42",
[["rhsgref_296Rnd_792x57_SmE_belt", 3]]],
*/
////

[localize "STR_AAS_pkp",
"rhs_weap_pkp",
[["rhs_100Rnd_762x54mmR", 4]]],

[localize "STR_AAS_PKM",
"rhs_weap_pkm",
[["rhs_100Rnd_762x54mmR", 4]]],

[localize "STR_AAS_PM63",
"rhs_weap_pm63",
[["rhs_75Rnd_762x39mm", 6]]],

["M84",
"rhs_weap_m84",
[["rhssaf_250Rnd_762x54R", 1]]],

[localize "STR_AAS_AK74M_ZEN",
"rhs_weap_ak74m_zenitco01",
[["rhs_45Rnd_545X39_7N6_AK", 12]]],

//Спецоружие: Наименование / обозначение / патроны

[ "Mk18 KAC",
"rhs_weap_mk18_KAC_wd",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 9]]],

[ "MP7A2 XPS3",
"rhsusf_weap_MP7A2",
[["rhsusf_mag_40Rnd_46x30_JHP", 8]]],

[ "CAS SR25 SD",
"rhs_weap_sr25_ec_wd",
[["rhsusf_20Rnd_762x51_SR25_m993_Mag", 9]]], 

[ "G36C SD XPS3",
"rhs_weap_g36c_grip3",
[["rhssaf_30rnd_556x45_SOST_G36", 9]]],

[ "M4A1WD SD RSO",
"rhs_weap_m4a1_blockII_KAC_wd",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 9]]],

[ "MP7A2 SD",
"rhsusf_weap_MP7A2_aor1",
[["rhsusf_mag_40Rnd_46x30_AP", 8]]],

[ "SDAR",
"arifle_SDAR_F",
[["30Rnd_556x45_Stanag_green", 8]]],

[ "M3A1 SD",
"rhs_weap_m3a1_specops",
[["rhsgref_30rnd_1143x23_M1911B_2mag_SMG", 8]]],

///

[localize "STR_AAS_asval",
"rhs_weap_asval_grip",
[["rhs_20rnd_9x39mm_SP6", 9]]],

[localize "STR_AAS_pp2000",
"rhs_weap_pp2000",
[["rhs_mag_9x19mm_7n31_44", 6]]],

[localize "STR_AAS_VSS",
"rhs_weap_vss_grip",
[["rhs_20rnd_9x39mm_SP6", 9]]],

["Scorpion",
"rhs_weap_savz61",
[["rhsgref_20rnd_765x17_vz61", 9]]],             

[localize "STR_AAS_AK103SD",
"rhs_weap_ak103_zenitco01",
[["rhs_30Rnd_762x39mm_89", 9]]],               

[localize "STR_AAS_AK105_ZENITKA",
"rhs_weap_ak105_zenitco01_b33",
[["rhs_30Rnd_545x39_7N22_AK", 9]]],               

//Снайперское оружие: Наименование / обозначение / патроны

[ "M14 EBR-RI",
"rhs_weap_m14ebrri_leu",
[["rhsusf_20Rnd_762x51_m118_special_Mag", 6]]],

[ "CAS SR25",
"rhs_weap_sr25_wd",
[["rhsusf_20Rnd_762x51_SR25_m118_special_Mag", 6]]],

[ "XM2010",
"rhs_weap_XM2010_wd",
[["rhsusf_5Rnd_300winmag_xm2010", 16]]],

[ "M107",
"rhs_weap_M107_w",
[["rhsusf_mag_10Rnd_STD_50BMG_M33", 4]]],
  
[ "M24",
"rhs_weap_m24sws",
[["rhsusf_5Rnd_762x51_m118_special_Mag", 16]]], 
               
[ "M40A5",
"rhs_weap_m40a5_wd",
[["rhsusf_10Rnd_762x51_m118_special_Mag", 12]]],  //   rhs_weap_m40a5_d

////

[ localize "STR_AAS_SVD",
"rhs_weap_svdp",
[["rhs_10Rnd_762x54mmR_7N1", 12]]],

[ localize "STR_AAS_SVD_camo",
"rhs_weap_svdp_wd",
[["rhs_10Rnd_762x54mmR_7N14", 12]]],

[ "Т-5000",
"rhs_weap_t5000",
[["rhs_5Rnd_338lapua_t5000", 16]]],

[ "M82A1",
"rhs_weap_m82a1",
[["rhsusf_mag_10Rnd_STD_50BMG_M33", 4]]],

[ "M76",
"rhs_weap_m76",
[["rhsgref_10Rnd_792x57_m76",12]]],

[ localize "STR_AAS_SVD_NPZ",
"rhs_weap_svdp_wd_npz",
[["rhs_10Rnd_762x54mmR_7N1", 12]]],

[ localize "STR_AAS_Mosin_sbr",
"rhs_weap_mosin_sbr",
[["rhsgref_5Rnd_762x54_m38", 20]]],  

[ localize "STR_AAS_Izh18",
"rhs_weap_Izh18",
[["rhsgref_1Rnd_Slug", 120]]],
			
//винтовки: Наименование / обозначение / патроны
                
[ localize "STR_AAS_M38_SCOPE",
"rhs_weap_m38_rail",
[["rhsgref_5Rnd_762x54_m38", 12]]],
               
[ "Karabiner 98 Kurz",
"rhs_weap_kar98k",
[["rhsgref_5Rnd_792x57_kar98k", 12]]],
           
[ "M1 Garand",
"rhs_weap_m1garand_sa43",
[["rhsgref_8Rnd_762x63_M2B_M1rifle", 12]]],
                       
[ "M590 S",
"rhs_weap_M590_8RD",
[["rhsusf_8Rnd_Slug", 12]]]
];


RULES_classList =
[
[
//////////////////////////  
localize "STR_AAS_Rifleman", //     0- БОЕЦ  
[
["rhs_weap_m4a1_carryhandle_grip", "hgun_P07_khk_F", "rhsusf_acc_SFMB556"], 
["rhs_weap_mk18_grip_bk", "rhsusf_acc_g33_xps3", "rhsusf_acc_SF3P556"], 
["rhs_weap_g36c", "rhsusf_acc_compm4", "rhsusf_acc_SF3P556"],
["rhs_weap_hk416d145", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],    
["rhs_weap_hk416d145_wd", "rhsusf_acc_su230a_mrds", "rhsusf_acc_SF3P556"],    
["rhs_weap_m4a1_blockII_wd", "rhsusf_acc_ACOG_wd", "rhsusf_acc_grip2", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_bipod", "rhsusf_acc_ACOG2", "rhsusf_acc_SF3P556"],
["rhs_weap_savz58p_rail_black", "rhsusf_acc_T1_high", "rhsgref_acc_zendl"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74", "rhs_acc_dtk1983"], 
["rhs_weap_m21s"],
["rhs_weap_ak105", "rhs_acc_dtk","rhs_acc_1p63"],  
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp1"],
["rhs_weap_ak74mr", "optic_MRCO", "rhs_acc_dtk"],
["rhs_weap_ak74m_plummag_npz","rhs_acc_rakursPM", "rhs_acc_dtk"],
["rhs_weap_ak104","rhs_acc_pkas", "rhs_acc_dtk2"],
["rhs_weap_aks74n", "rhs_acc_pso1m2_ak", "rhs_acc_dtk1983"],
["rhs_weap_akm_zenitco01_b33", "rhs_acc_ekp8_18", "rhs_acc_dtk1983"],
["rhs_weap_savz58p_rail", "rhs_acc_ekp8_18", "rhsgref_acc_zendl"],
["rhs_weap_m38"],    
["rhs_weap_M590_8RD"] 	
],
[ ["rhs_mag_m67",4], ["rhs_mag_an_m8hc",2]],
["rhsusf_weap_m9", "rhsusf_mag_15Rnd_9x19_JHP"],
[ ["rhs_mag_rgn",4], ["rhs_mag_rdg2_white",2]], 
["rhs_weap_pya", "rhs_mag_9x19_17"],
false,	//revive
true,	//specialised
1,//limit of such class in game
["rhs_uniform_FROG01_wd", "rhs_acc_rakursPM", "rhsusf_acc_M2A1", "rhsusf_acc_anpvs27", "rhsusf_acc_g33_T1", "rhsusf_acc_g33_xps3", "rhsusf_acc_T1_high", "rhsusf_acc_T1_low","rhs_acc_1p87", "rhs_acc_ekp8_18", "rhsusf_acc_T1_low_fwd_ak",
"rhsusf_acc_EOTECH", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_compm4", "rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD", "rhsusf_acc_SpecterDR_D", 
"rhsusf_acc_SpecterDR_A", "rhsusf_acc_su230a_mrds", "rhsusf_acc_ACOG_wd", "rhsusf_acc_ACOG2","rhsusf_acc_eotech_xps3", "rhsusf_acc_g33_xps3"],//uniform west
["rhsgref_uniform_reed", "rhs_acc_1p63", "rhs_acc_pso1m2", "rhs_acc_pkas", "rhs_acc_nita", "rhs_acc_ekp1", "rhs_acc_rakursPM", "rhs_acc_1p87", "rhs_acc_ekp8_18", "rhsusf_acc_T1_low_fwd_ak","rhsusf_acc_M2A1", "rhsusf_acc_anpvs27", 
"rhsusf_acc_EOTECH", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_compm4", "rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD", "rhsusf_acc_SpecterDR_D", 
"rhsusf_acc_SpecterDR_A", "rhsusf_acc_su230a_mrds", "rhsusf_acc_ACOG_wd", "rhsusf_acc_ACOG2","rhsusf_acc_g33_T1", "rhsusf_acc_g33_xps3", "rhsusf_acc_T1_high", "rhsusf_acc_T1_low","rhsusf_acc_eotech_xps3", "rhsusf_acc_g33_xps3"],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"	],//vest east   
[								],//backback west  
[								],//backback east  
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit",  "rhsusf_mag_15Rnd_9x19_JHP", "rhsusf_mag_15Rnd_9x19_JHP", "rhsusf_mag_15Rnd_9x19_JHP"],//West Inventory Items
["FirstAidKit", "rhs_mag_9x19_17", "rhs_mag_9x19_17", "rhs_mag_9x19_17"],// East Inventory Items  
["acc_flashlight"				]//PrimaryWeapon 
]

];
////////////////////////  1- ГП
if boecgp then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_Grenadier",
[ 
["rhs_weap_m16a4_carryhandle_M203", "rhsusf_acc_ACOG2", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d145_m320", "rhsusf_acc_ACOG_RMR", "rhsusf_acc_SF3P556"], 
["rhs_weap_g36kv_ag36", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],  
["rhs_weap_mk18_m320", "rhsusf_acc_compm4", "rhsusf_acc_SF3P556"],    
["rhs_weap_m4a1_carryhandle_m203", "rhsusf_acc_SF3P556"],
["rhs_weap_hk416d10_m320", "rhsusf_acc_eotech_xps3", "rhsusf_acc_SF3P556"] 
], //
[  
["rhs_weap_ak74m_gp25", "rhs_acc_pso1m2", "rhs_acc_dtk"],
["rhs_weap_ak74mr_gp25", "optic_MRCO", "rhs_acc_uuk"],
["rhs_weap_ak103_gp25_npz", "rhs_acc_rakursPM", "rhs_acc_dtk"],  
["rhs_weap_aks74n_gp25", "rhs_acc_ekp8_02", "rhs_acc_dtk1983"], 
["rhs_weap_aks74_gp25", "rhs_acc_dtk1983"], 
["rhs_weap_akmn_gp25", "rhs_acc_dtk1983"],
["rhs_weap_akms_gp25"] 
],   //
[ ["rhs_mag_m67",5], ["rhs_mag_an_m8hc",2]],
["rhsusf_weap_m9", "rhsusf_mag_15Rnd_9x19_JHP"],
[ ["rhs_mag_rgn",5], ["rhs_mag_rdg2_white",2]],  
["rhs_weap_pya", "rhs_mag_9x19_17"],
false,	//revive
false,	//specialised 
0.1,//limit of such class in game
["rhs_uniform_FROG01_wd", "rhs_acc_rakursPM", "rhsusf_acc_M2A1", "rhsusf_acc_ACOG", "rhsusf_acc_ACOG2", "rhsusf_acc_anpvs27", "rhs_acc_1p87", "rhs_acc_ekp8_18", "rhsusf_acc_T1_low_fwd_ak","rhsusf_acc_g33_T1", "rhsusf_acc_g33_xps3", "rhsusf_acc_T1_high", "rhsusf_acc_T1_low",
"rhsusf_acc_EOTECH", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_compm4", "rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD", "rhsusf_acc_SpecterDR_D", 
"rhsusf_acc_SpecterDR_A", "rhsusf_acc_su230a_mrds", "rhsusf_acc_eotech_xps3" , "rhsusf_acc_ACOG_wd", "rhsusf_acc_g33_xps3"		],//uniform west
["rhsgref_uniform_reed", "rhs_acc_1p63", "rhs_acc_ekp1", "rhs_acc_pkas", "rhs_acc_nita", "rhs_acc_rakursPM", "rhs_acc_1p87", "rhs_acc_ekp8_18", "rhsusf_acc_T1_low_fwd_ak","rhsusf_acc_M2A1", "rhsusf_acc_ACOG", "rhsusf_acc_ACOG2", "rhsusf_acc_anpvs27", 
"rhsusf_acc_EOTECH", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_compm4", "rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD", "rhsusf_acc_SpecterDR_D", "rhsusf_acc_g33_T1", "rhsusf_acc_g33_xps3", "rhsusf_acc_T1_high", "rhsusf_acc_T1_low",
"rhsusf_acc_SpecterDR_A", "rhsusf_acc_su230a_mrds", "rhsusf_acc_eotech_xps3", "rhsusf_acc_ACOG_wd", "rhsusf_acc_g33_xps3"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west 
["V_PlateCarrier1_blk"				],//vest east 
[								],//backback west  
[								],//backback east 		
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit", "rhsusf_mag_15Rnd_9x19_JHP" , "rhsusf_mag_15Rnd_9x19_JHP", "rhsusf_mag_15Rnd_9x19_JHP"],//West Inventory Items
["FirstAidKit", "rhs_mag_9x19_17", "rhs_mag_9x19_17", "rhs_mag_9x19_17"],// East Inventory Items
["acc_flashlight"				]//PrimaryWeapon Items
]
];

};
////////////////////////  2- ПУЛЕМЕТ ПСО
if macpso then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_Gunner_scope",  // 
[ 
["rhs_weap_m240B", "rhsusf_acc_ACOG_MDO","rhs_bipod"],
["rhs_weap_m240b_elcan", "rhsusf_acc_ELCAN","rhs_bipod"],
["rhs_weap_m249_pip_L_para","rhsusf_acc_ACOG_MDO", "rhsusf_acc_SF3P556","rhs_bipod"],
["rhs_weap_m249_pip","rhsusf_acc_g33_T1", "rhsusf_acc_SF3P556","rhs_bipod"],
["rhs_weap_m27iar_grip", "rhsusf_acc_ACOG_RMR","rhsusf_acc_harris_bipod", "rhsusf_acc_SF3P556"]
],
[ 
["rhs_weap_pkp", "rhs_acc_1p78"], 
["rhs_weap_ak74m_zenitco01","rhs_acc_1p78","rhs_bipod"]  //rhs_acc_pso1m2_pkp
],
[ ["rhs_mag_m67",1], ["rhs_mag_an_m8hc",1]],
[ "rhsusf_weap_m9", "rhsusf_mag_15Rnd_9x19_JHP"  													],
[ ["rhs_mag_rgn",1], ["rhs_mag_rdg2_white",1]], 
[  "rhs_weap_pya", "rhs_mag_9x19_17"														],
false,	//revive
false,	//specialised 
0.2,//limit of such class in game
["rhs_uniform_FROG01_wd","rhsusf_acc_ACOG2_USMC", "rhsusf_acc_g33_xps3", "rhsusf_acc_ACOG_USMC", "rhsusf_acc_ELCAN_ard", 
		 "rhsusf_acc_ACOG", "rhsusf_acc_ACOG2", "rhs_acc_1pn93_2", "rhs_acc_pso1m2", "rhs_acc_pso1m21", "rhsusf_acc_ELCAN",
		"rhsusf_acc_ACOG_MDO", "rhsusf_acc_ACOG_RMR", "rhsusf_acc_ACOG_d", "rhsusf_acc_ACOG_wd"		],//uniform west
["rhsgref_uniform_reed","rhs_acc_1p29", "rhs_acc_1p78", "rhs_acc_1pn93_1", "rhs_acc_1pn93_2", "rhs_acc_nita"],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["rhsusf_assault_eagleaiii_ocp"	],//backback west  
["B_Carryall_oucamo"			],//backback east 			
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit", "rhsusf_mag_15Rnd_9x19_JHP" , "rhsusf_mag_15Rnd_9x19_JHP", "rhsusf_mag_15Rnd_9x19_JHP"],//West Inventory Items
["FirstAidKit", "rhs_mag_9x19_17", "rhs_mag_9x19_17", "rhs_mag_9x19_17"],// East Inventory Items 
[ 								]//PrimaryWeapon Items
]
];

};
////////////////////////////  3- ПУЛЕМЕТ
if machgn then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_Gunner",  // 
[ 
["rhs_weap_m240B_CAP", "rhsusf_acc_eotech_xps3"],
["rhs_weap_m249_pip_S_para","rhsusf_acc_eotech_552"],
["rhs_weap_minimi_para_railed","rhsusf_acc_SF3P556","rhsusf_acc_eotech_552"],
["rhs_weap_m27iar", "rhsusf_acc_eotech_xps3","rhsusf_acc_harris_bipod"],
["rhs_weap_mg42", "rhsgref_mg42_acc_AAsight"]
],
[  
["rhs_weap_pkp","rhs_acc_pkas"],
["rhs_weap_pkm"],
["rhs_weap_pm63", "rhs_acc_dtkakm"],
["rhs_weap_m84"], 
["rhs_weap_ak74m_zenitco01","rhs_acc_pkas"]
],
[ ["rhs_mag_m67",1], ["rhs_mag_an_m8hc",1]	],
[  "rhsusf_weap_m9", "rhsusf_mag_15Rnd_9x19_JHP" 													],
[ ["rhs_mag_rgn",1], ["rhs_mag_rdg2_white",1] 						], 
[  "rhs_weap_pya", "rhs_mag_9x19_17"														],
false,	//revive
true,	//specialised 
1,//limit of such class in game
["rhs_uniform_FROG01_wd", "rhs_acc_1p63", "rhs_acc_ekp1", "rhs_acc_pkas", "rhsusf_acc_M2A1", "rhs_acc_rakursPM", "rhsusf_acc_EOTECH", "rhsusf_acc_eotech_552", "rhsusf_acc_T1_high", "rhsusf_acc_T1_low", 
"rhsusf_acc_eotech_552_d", "rhsusf_acc_compm4", "rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD", "rhsusf_acc_SpecterDR_D", "rhsusf_acc_SpecterDR_A", "rhsusf_acc_eotech_xps3"	],//uniform west
["rhsgref_uniform_reed" ,"rhs_acc_1p63", "rhs_acc_ekp1", "rhs_acc_1p87", "rhs_acc_ekp8_18", "rhsusf_acc_T1_low_fwd_ak","rhs_acc_pkas"],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["rhsusf_assault_eagleaiii_ocp"	],//backback west  
["B_Carryall_oucamo"			],//backback east 			
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit", "rhsusf_mag_15Rnd_9x19_JHP" , "rhsusf_mag_15Rnd_9x19_JHP", "rhsusf_mag_15Rnd_9x19_JHP"],//West Inventory Items
["FirstAidKit", "rhs_mag_9x19_17", "rhs_mag_9x19_17", "rhs_mag_9x19_17"],// East Inventory Items
[ 								]//PrimaryWeapon Items
]
];

};
/////////////////////////////// 4 - МЕДИК
if sanit then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_Medic",
[ 
["rhs_weap_m4a1_carryhandle_grip", "rhsusf_acc_compm4", "rhsusf_acc_SF3P556"], 
["rhs_weap_g36kv", "rhsusf_acc_SF3P556", "rhsusf_acc_compm4"], 
["rhs_weap_m4a1_blockII", "rhsusf_acc_RX01_NoFilter", "rhsusf_acc_SF3P556"],
["rhsusf_weap_MP7A2", "rhsusf_acc_eotech_xps3"],
["rhs_weap_MP44"], 
["rhs_weap_m3a1"] 
],
[ 
["rhs_weap_pp2000", "rhs_acc_1p87"], 
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp8_02"],
["rhs_weap_ak105_zenitco01_b33", "rhs_acc_rakursPM", "rhs_acc_dtk"],
["rhs_weap_savz61"] 
],
[ ["rhs_mag_m67",3], ["rhs_mag_an_m8hc",6] , ["rhsusf_mag_15Rnd_9x19_JHP",3]],
[   "rhsusf_weap_m9" , "rhsusf_mag_15Rnd_9x19_JHP"],
[ ["rhs_mag_rgn",3], ["rhs_mag_rdg2_white",6] , ["rhs_18rnd_9x21mm_7N28",3]],  
[  "rhs_weap_6p53" 	, "rhs_18rnd_9x21mm_7N28"	],
true,	//revive
true,	//specialised 
1,//limit of such class in game
["rhs_uniform_FROG01_wd",  "rhs_acc_1p63", "rhs_acc_ekp1", "rhs_acc_pkas", "rhsusf_acc_M2A1", "rhs_acc_rakursPM", "rhsusf_acc_EOTECH", "rhsusf_acc_eotech_552", "rhs_acc_1p87", "rhs_acc_ekp8_18", "rhsusf_acc_T1_low_fwd_ak",
 "rhsusf_acc_eotech_552_d", "rhsusf_acc_compm4", "rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD", "rhsusf_acc_SpecterDR_D", "rhsusf_acc_T1_high", "rhsusf_acc_T1_low", 
"rhsusf_acc_SpecterDR_A", "rhsusf_acc_eotech_xps3"		],//uniform west
["rhsgref_uniform_reed",  "rhs_acc_1p63", "rhs_acc_ekp1", "rhs_acc_pkas", "rhs_acc_rakursPM", "rhs_acc_1p87", "rhs_acc_ekp8_18", "rhsusf_acc_T1_high", "rhsusf_acc_T1_low", "rhsusf_acc_T1_low_fwd_ak","rhsusf_acc_M2A1", "rhs_acc_rakursPM", "rhsusf_acc_EOTECH", "rhsusf_acc_eotech_552", 
"rhsusf_acc_eotech_552_d", "rhsusf_acc_compm4", "rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD", "rhsusf_acc_SpecterDR_D", 
"rhsusf_acc_SpecterDR_A", "rhsusf_acc_eotech_xps3"			],//uniform east
["rhsusf_iotv_ocp_Medic"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["rhsusf_falconii_mc"			],//backback west
["B_Carryall_oucamo"				],//backback east  
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
[ "Medikit", "FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit"],//West Inventory Items
[ "Medikit", "FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit"],// East Inventory Items
[ 								]//PrimaryWeapon Items
]
];

};
/////////////////////////////////////   5 - Ремонтник
if remont then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_repairman", 
[   
["rhs_weap_m4a1_carryhandle_mstock", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d10", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[
["rhs_weap_ak74", "rhs_acc_dtk1983"], 
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp8_02"], 
["rhs_weap_akm"],
["rhs_weap_ak103", "rhs_acc_dtk"], 
["rhs_weap_M590_8RD"]
],
[ ["rhs_mag_m67",2], ["rhs_mag_an_m8hc",2]],
["rhsusf_weap_m9", "rhsusf_mag_15Rnd_9x19_JHP"],
[ ["rhs_mag_rgn",2], ["rhs_mag_rdg2_white",2]], 
["rhs_weap_pya", "rhs_mag_9x19_17"],
false,	//revive
true,	//specialised 
1,//limit of such class in game
["rhs_uniform_FROG01_wd"		],//uniform west
["rhsgref_uniform_reed"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["rhsusf_falconii_mc"			],//backback west  	
["B_Carryall_oucamo"			],//backback east  	
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit", "rhsusf_mag_15Rnd_9x19_JHP" , "rhsusf_mag_15Rnd_9x19_JHP", "rhsusf_mag_15Rnd_9x19_JHP"],//West Inventory Items
["FirstAidKit", "rhs_mag_9x19_17", "rhs_mag_9x19_17", "rhs_mag_9x19_17"],// East Inventory Items
[								]//PrimaryWeapon Items
]
];

};
//////////////////////////////   6 - РШГ
if rshg then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_Light AT", 
[  
["rhs_weap_m4a1_carryhandle_mstock", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d10", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74", "rhs_acc_dtk1983"],
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp8_02"], 
["rhs_weap_akm"],
["rhs_weap_ak103", "rhs_acc_dtk"], 
["rhs_weap_M590_8RD"]
],
[ ["rhs_m136_mag",1], ["rhs_mag_m67",6], ["rhs_mag_an_m8hc",6]], //rhs_m72a7_mag
[ "rhs_weap_M136"], //rhs_weap_m72a7
[ ["rhs_rpg_empty",1],["rhs_mag_rgn",6], ["rhs_mag_rdg2_white",6]], //rhs_rshg2_mag
[ "rhs_weap_rpg26"], //rhs_weap_rshg2
false,	//revive
true,	//specialised 
1,//limit of such class in game
["rhs_uniform_FROG01_wd"		],//uniform west
["rhsgref_uniform_reed"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["rhs_6b23_digi_6sh92"			],//vest east
["rhsusf_falconii_mc"			],//backback west  	
["B_Carryall_oucamo"			],//backback east  	
["lerca_1200_black"						],//east binocular type items
["rhs_pdu4"						],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit"/*, "rhs_weap_panzerfaust60", "rhs_weap_m72a7", "rhs_weap_M136_hp"*/				],//West Inventory Items
["FirstAidKit"/*, "rhs_weap_rpg75", "rhs_weap_panzerfaust60", "rhs_weap_m80"	*/				],// East Inventory Items 
[ 								]//PrimaryWeapon Items
]
];

};
//////////////////////////////   7 - РПГ-7
if rpg7 then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_Mid AT",          
[   
["rhs_weap_m4a1_carryhandle_mstock", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d10", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74", "rhs_acc_dtk1983"],
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp8_02"], 
["rhs_weap_akm"],
["rhs_weap_ak103", "rhs_acc_dtk"], 
["rhs_weap_M590_8RD"]
],
[ /*["rhs_mag_maaws_HEDP",1], */["rhs_mag_maaws_HEAT",2], ["rhs_mag_maaws_HE",2],["rhs_mag_m67",1], ["rhs_mag_an_m8hc",1]], //rhs_mag_smaw_HEAA   
[ "rhs_weap_maaws" , "rhs_optic_maaws" ],  //"rhs_weap_smaw_optic"
[ ["rhs_rpg7_PG7VR_mag",1],["rhs_rpg7_PG7VL_mag",2],["rhs_rpg7_OG7V_mag",2], ["rhs_mag_rgn",1], ["rhs_mag_rdg2_white",1]],   
[ "rhs_weap_rpg7_pgo"], 
false,	//revive
true,	//specialised 
0.35,//limit of such class in game
["rhs_uniform_FROG01_wd"		],//uniform west
["rhsgref_uniform_reed"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["B_Carryall_cbr"				],//backback west
["rhs_rpg_empty"				],//backback east
["lerca_1200_black"						],//east binocular type items
["rhs_pdu4"						],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit"					],//West Inventory Items
["FirstAidKit"					],// East Inventory Items
[ ]//PrimaryWeapon Items
]
];

};
//////////////////////////////   8 - ПТРК-1
if ptrk1 then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_AT", 
[   
["rhs_weap_m4a1_carryhandle_mstock", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d10", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74", "rhs_acc_dtk1983"],
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp8_02"], 
["rhs_weap_akm"],
["rhs_weap_ak103", "rhs_acc_dtk"], 
["rhs_weap_M590_8RD"]
],
[  ["rhs_mag_m67",1], ["rhs_mag_an_m8hc",1]],//
[ ], 
[ ["rhs_mag_rgn",1], ["rhs_mag_rdg2_white",1]],
[ ],
false,	//revive
false,	//specialised 
0.1,//limit of such class in game
["rhs_uniform_FROG01_wd"		],//uniform west
["rhsgref_uniform_reed"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["rhs_Tow_Gun_Bag", "rhs_TOW_Tripod_Bag"],//backback west  
["RHS_Metis_Gun_Bag", "RHS_Metis_Tripod_Bag", "RHS_Kornet_Gun_Bag", "RHS_Kornet_Tripod_Bag"],//backback east
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit"					],//West Inventory Items
["FirstAidKit"					],// East Inventory Items
[ ]//PrimaryWeapon Items
]
];

};
//////////////////////////////   9 - станковое
if tpod then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_Tripod",
[  
["rhs_weap_m4a1_carryhandle_mstock", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d10", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74", "rhs_acc_dtk1983"],
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp8_02"], 
["rhs_weap_akm"],
["rhs_weap_ak103", "rhs_acc_dtk"], 
["rhs_weap_M590_8RD"]
],
[  ["rhs_mag_m67",1], ["rhs_mag_an_m8hc",1]],//
[ ], //
[ ["rhs_mag_rgn",1], ["rhs_mag_rdg2_white",1]],
[ ],
false,	//revive
false,	//specialised 
0.1,//limit of such class in game
["rhs_uniform_FROG01_wd"		],//uniform west
["rhsgref_uniform_reed"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["RHS_M2_Gun_Bag",	"RHS_M2_Tripod_Bag", "RHS_M2_MiniTripod_Bag"],//backback west   
["RHS_DShkM_Gun_Bag", "RHS_DShkM_TripodHigh_Bag", "RHS_DShkM_TripodLow_Bag", "RHS_Kord_Tripod_Bag", "RHS_Kord_Gun_Bag",	"RHS_NSV_Tripod_Bag","RHS_NSV_Gun_Bag",	
"RHS_SPG9_Gun_Bag", "RHS_SPG9_Tripod_Bag"	],//backback east
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit"					],//West Inventory Items
["FirstAidKit"					],// East Inventory Items
[ ]//PrimaryWeapon Items
]
];

};
//////////////////////////////   10 - АГС+Миномет
if agsm then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_AGS_Mortar",
[  
["rhs_weap_m4a1_carryhandle_mstock", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d10", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74", "rhs_acc_dtk1983"],
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp8_02"], 
["rhs_weap_akm"],
["rhs_weap_ak103", "rhs_acc_dtk"], 
["rhs_weap_M590_8RD"]
],
[  ["rhs_mag_m67",1], ["rhs_mag_an_m8hc",1]],//
[ ], //
[ ["rhs_mag_rgn",1], ["rhs_mag_rdg2_white",1]],
[ ],
false,	//revive
false,	//specialised 
0.1,//limit of such class in game
["rhs_uniform_FROG01_wd"		],//uniform west
["rhsgref_uniform_reed"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["rhs_M252_Gun_Bag", "rhs_M252_Bipod_Bag", "RHS_Mk19_Gun_Bag", "RHS_Mk19_Tripod_Bag" ],//backback west   
["RHS_Podnos_Bipod_Bag", "RHS_Podnos_Gun_Bag", "RHS_AGS30_Tripod_Bag", "RHS_AGS30_Gun_Bag"],//backback east
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit"					],//West Inventory Items
["FirstAidKit"					],// East Inventory Items
[ ]//PrimaryWeapon Items
]
];

};
//////////////////////////////   11 - Javelin
if Jav then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_Javelin", 
[  
["rhs_weap_m4a1_carryhandle_mstock", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d10", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74", "rhs_acc_dtk1983"],
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp8_02"], 
["rhs_weap_akm"],
["rhs_weap_ak103", "rhs_acc_dtk"], 
["rhs_weap_M590_8RD"]
],
[ ["rhs_fgm148_magazine_AT",1], ["rhs_mag_m67",1], ["rhs_mag_an_m8hc",1]], 
[ "rhs_weap_fgm148"],
[ ["Vorona_HEAT",2],["rhs_mag_rgn",2], ["rhs_mag_rdg2_white",1]], 
[ "launch_O_Vorona_green_F"], 
false,	//revive
false,	//specialised 
0.1,//limit of such class in game
["rhs_uniform_FROG01_wd"		],//uniform west
["rhsgref_uniform_reed"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["B_Carryall_cbr"				],//backback west
["B_Carryall_oucamo"			],//backback east
["lerca_1200_black"						],//east binocular type items
["rhs_pdu4"						],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit"					],//West Inventory Items
["FirstAidKit"					],// East Inventory Items
[ ]//PrimaryWeapon Items
]
];

};
//////////////////////////////   12 - ПЗРК
if pzrk1 then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_Anti_Air", 
[  
["rhs_weap_m4a1_carryhandle_mstock", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d10", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74", "rhs_acc_dtk1983"],
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp8_02"], 
["rhs_weap_akm"],
["rhs_weap_ak103", "rhs_acc_dtk"], 
["rhs_weap_M590_8RD"]
],
[ ["rhs_fim92_mag",1], ["rhs_mag_m67",1], ["rhs_mag_an_m8hc",1]], 
[ "rhs_weap_fim92"],
[ ["rhs_mag_9k38_rocket",1],["rhs_mag_rgn",1], ["rhs_mag_rdg2_white",1]], 
[ "rhs_weap_igla"], 
false,	//revive
true,	//specialised 
1,//limit of such class in game
["rhs_uniform_FROG01_wd"		],//uniform west
["rhsgref_uniform_reed"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["rhsusf_assault_eagleaiii_ocp"	],//backback west
["B_Carryall_oucamo"			],//backback east
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["FirstAidKit"					],//West Inventory Items
["FirstAidKit"					],// East Inventory Items
[ ]//PrimaryWeapon Items
]
];

};
//////////////////////////////   13 - СНАЙПЕР
if snip then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_Sniper", //       
[  
["rhs_weap_m24sws","rhsusf_acc_premier_low","rhs_bipod"],
["rhs_weap_m24sws_wd","rhsusf_acc_M8541_low_wd","rhs_bipod"],
["rhs_weap_m14ebrri_leu","rhs_bipod"], 
["rhs_weap_m40a5_wd","optic_LRPS","rhs_bipod"],  // "rhsusf_acc_M8541_low_wd"
["rhs_weap_sr25_wd","rhsusf_acc_premier","rhs_bipod"], 
["rhs_weap_XM2010_wd","rhsusf_acc_LEUPOLDMK4_2","rhs_bipod"], 
["rhs_weap_M107_w","rhsusf_acc_premier","rhs_bipod"],
["rhs_weap_kar98k"]  
], 
[ 
["rhs_weap_svdp","rhs_acc_pso1m2"], 
["rhs_weap_svdp_wd","rhs_acc_pso1m2"], 
["rhs_weap_t5000","rhs_acc_harris_swivel","rhs_acc_dh520x56"],
["rhs_weap_m76","rhs_acc_pso1m2"], 
["rhs_weap_m82a1","rhs_acc_dh520x56"],
["rhs_weap_svdp_wd_npz", "optic_DMS"], //"rhs_acc_dh520x56"  
["rhs_weap_Izh18", "rhs_acc_dh520x56"],
["rhs_weap_m38_rail","optic_SOS"] 
],
[ ["rhs_mag_m67",1], ["APERSTripMine_Wire_Mag",1] ],
[   "rhsusf_weap_glock17g4" , "rhsusf_mag_17Rnd_9x19_JHP"], 
[ ["rhs_mag_rgn",1], ["APERSTripMine_Wire_Mag",1] ],    
[  "rhs_weap_pya" 	, "rhs_mag_9x19_17"	],  
false,	//revive
false,	//specialised 
0.1,//limit of such class in game
[ "rhs_uniform_FROG01_wd", "U_B_FullGhillie_ard","U_B_FullGhillie_lsh", "U_B_T_FullGhillie_tna_F", "U_B_FullGhillie_sard","rhs_acc_pso1m2", "rhs_acc_1pn93_1", "rhs_acc_dh520x56", 
			"rhsusf_acc_M8541_low", "rhsusf_acc_M8541_low_d", "rhsusf_acc_M8541_low_wd", "rhsusf_acc_premier_low", "rhsusf_acc_premier", 
			"rhsusf_acc_premier_anpvs27",	"rhsusf_acc_LEUPOLDMK4", "rhsusf_acc_LEUPOLDMK4_2", "rhsusf_acc_LEUPOLDMK4_2_d", "optic_DMS"	],//uniform west  "U_B_GhillieSuit",
[ "rhsgref_uniform_tigerstripe","U_O_FullGhillie_ard","U_I_FullGhillie_lsh", "U_O_T_FullGhillie_tna_F", "U_I_FullGhillie_sard","rhs_acc_pso1m2", "rhs_acc_1pn93_1", "rhs_acc_dh520x56", 
					"rhsusf_acc_M8541_low", "rhsusf_acc_M8541_low_d", "rhsusf_acc_M8541_low_wd", "rhsusf_acc_premier_low", "rhsusf_acc_premier", 
					"rhsusf_acc_premier_anpvs27",	"rhsusf_acc_LEUPOLDMK4", "rhsusf_acc_LEUPOLDMK4_2", "rhsusf_acc_LEUPOLDMK4_2_d", "optic_DMS"			],//uniform east  "U_O_GhillieSuit",
["V_Chestrig_khk"	],//vest west
["V_Chestrig_oli"	],//vest east
[					],//backback west  
[					],//backback east 		
["lerca_1200_black"						],//east binocular type items
["rhs_pdu4"						],//east binocular type items
[								],//west Goggles/eyewear
["rhs_balaclava"								],//east Goggles/eyewear
["rhs_8point_marpatwd"],//West HeadGear
["G_Bandanna_blk"],//East HeadGear
["FirstAidKit", "rhs_mag_an_m8hc", "rhsusf_mag_17Rnd_9x19_JHP", "rhsusf_mag_17Rnd_9x19_JHP", "rhsusf_mag_17Rnd_9x19_JHP"],//West Inventory Items
["FirstAidKit", "rhs_mag_rdg2_white", "rhs_mag_9x19_17", "rhs_mag_9x19_17", "rhs_mag_9x19_17"],// East Inventory Items 
[ 	]//PrimaryWeapon Items
]
];

};
//////////////////////////////   14 - РАЗВЕДКА
if spez then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_Recon", //  
[ 
["rhs_weap_m4a1_blockII_KAC_wd", "rhsusf_acc_rotex5_grey", "rhsusf_acc_ACOG_RMR", "rhsusf_acc_anpeq15A"], 
["rhs_weap_g36c_grip3", "rhsusf_acc_eotech_xps3", "rhsusf_acc_grip3", "rhsusf_acc_nt4_black", "rhsusf_acc_anpeq15A"], 
["rhs_weap_sr25_ec_wd", "rhsusf_acc_M8541", "rhsusf_acc_SR25S", "rhsusf_acc_anpeq15A"], 
["rhsusf_weap_MP7A2_aor1", "rhsusf_acc_rotex_mp7_aor1", "rhsusf_acc_EOTECH"], 
["arifle_SDAR_F"], 
["rhs_weap_m3a1_specops", "rhsgref_acc_RX01_camo"]
],
[ 
["rhs_weap_ak103_zenitco01", "rhs_acc_pbs1", "rhs_acc_pkas"],
["rhs_weap_ak74m_camo", "rhs_acc_ekp8_02", "rhs_acc_dtk4short"], 
["rhs_weap_asval_grip", "rhs_acc_ekp8_02", "rhs_acc_perst1ik_ris"],
["rhs_weap_vss_grip", "rhs_acc_pso1m21", "rhs_acc_perst1ik_ris"],
["rhs_weap_akms", "rhs_acc_pbs1"],
["rhs_weap_ak105_zenitco01_b33", "rhs_acc_dtk4short", "optic_MRCO", "rhs_acc_perst3_2dp_light_h"],
["rhs_weap_svdp_wd","rhs_acc_pso1m2","rhs_acc_tgpv2"], 
["rhs_weap_mosin_sbr", "rhsgref_sdn6_suppressor", "optic_DMS"], 
["arifle_SDAR_F"]
], 
[ ["rhs_mag_m67",1], ["rhs_mag_mk84",2], ["Laserbatteries",1], ["rhs_mag_an_m8hc",2], ["rhsusf_m112_mag",4], ["rhsusf_m112x4_mag",2], ["rhsusf_mag_17Rnd_9x19_JHP",3], ["APERSTripMine_Wire_Mag",1], ["rhssaf_mine_tma4_mag",1], ["rhs_mine_sm320_white_mag",1], ["rhs_mine_sm320_green_mag",1], ["rhs_mine_sm320_red_mag",1] 	],
[  "rhsusf_weap_glock17g4","rhsusf_acc_omega9k","rhsusf_mag_17Rnd_9x19_JHP"],
[ ["rhs_mag_rgn",1], ["rhs_mag_fakel",2], ["Laserbatteries",1], ["rhs_mag_rdg2_white",2], ["rhssaf_tm200_mag",4], ["rhssaf_tm500_mag",2], ["rhs_mag_9x18_8_57N181S",8], ["APERSTripMine_Wire_Mag",1], ["rhs_mag_mine_ptm1",1], ["rhs_mine_msk40p_white_mag",1], ["rhs_mine_msk40p_green_mag",1], ["rhs_mine_msk40p_blue_mag",1] 	], 
[  "rhs_weap_pb_6p9" 	, "rhs_acc_6p9_suppressor", "rhs_mag_9x18_8_57N181S" ],
false,	//revive
false,	//specialised 
0.1,//limit of such class in game
["rhs_uniform_g3_m81", "rhs_acc_1p63", "rhs_acc_ekp1", "rhs_acc_pkas", "rhs_acc_rakursPM", "rhsusf_acc_M2A1", "rhsusf_acc_ACOG_RMR", "rhs_acc_rakursPM", "rhsusf_acc_anpvs27", "rhsusf_acc_g33_T1", "rhsusf_acc_g33_xps3", "rhsusf_acc_T1_high", "rhsusf_acc_T1_low",
"rhsusf_acc_EOTECH", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_compm4", "rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD", "rhsusf_acc_SpecterDR_D", "rhs_acc_1p87", "rhs_acc_ekp8_18", "rhsusf_acc_T1_low_fwd_ak",
"rhsusf_acc_SpecterDR_A", "rhsusf_acc_su230a_mrds", "rhsusf_acc_eotech_xps3""rhs_acc_pso1m2", "rhs_acc_1pn93_1", "rhs_acc_dh520x56", "rhsusf_acc_M8541_low", "rhsusf_acc_M8541_low_d", "rhsusf_acc_M8541_low_wd", "rhsusf_acc_premier_low", "rhsusf_acc_premier", 
		  "rhsusf_acc_premier_anpvs27",	"rhsusf_acc_LEUPOLDMK4", "rhsusf_acc_LEUPOLDMK4_2","rhsusf_acc_ACOG_wd", "rhsusf_acc_ACOG2", "rhsusf_acc_LEUPOLDMK4_2_d", "U_B_Wetsuit", "rhsusf_acc_g33_xps3"	],//uniform west
["rhsgref_uniform_specter", "optic_DMS","rhs_acc_1p63","rhs_acc_nita", "rhs_acc_ekp1", "rhs_acc_pkas", "rhs_acc_rakursPM", "rhs_acc_1p87", "rhs_acc_ekp8_18", "rhsusf_acc_T1_low_fwd_ak","rhsusf_acc_M2A1", "rhsusf_acc_anpvs27", "rhsusf_acc_g33_T1", "rhsusf_acc_g33_xps3", "rhsusf_acc_T1_high", "rhsusf_acc_T1_low",
"rhsusf_acc_EOTECH", "rhsusf_acc_eotech_552", "rhsusf_acc_eotech_552_d", "rhsusf_acc_compm4", "rhsusf_acc_SpecterDR","rhsusf_acc_SpecterDR_OD", "rhsusf_acc_SpecterDR_D", 
"rhsusf_acc_SpecterDR_A", "rhsusf_acc_su230a_mrds", "rhsusf_acc_eotech_xps3""rhs_acc_pso1m2", "rhs_acc_1pn93_1", "rhs_acc_dh520x56", "rhsusf_acc_M8541_low", "rhsusf_acc_M8541_low_d", "rhsusf_acc_M8541_low_wd", "rhsusf_acc_premier_low", "rhsusf_acc_premier", 
		  "rhsusf_acc_premier_anpvs27",	"rhsusf_acc_LEUPOLDMK4", "rhsusf_acc_LEUPOLDMK4_2","rhsusf_acc_ACOG_wd", "rhsusf_acc_ACOG2", "rhsusf_acc_LEUPOLDMK4_2_d", "U_O_Wetsuit", "rhs_acc_tgpv", "rhsusf_acc_g33_xps3"],//uniform east
["V_Chestrig_khk"		],//vest west
["V_Chestrig_oli"		],//vest east
["B_Carryall_cbr"		],//backback west
["B_Carryall_oli"		],//backback east		
["Laserdesignator"					],//west binocular type items
["Laserdesignator"					],//east binocular type items
[								],//west Goggles/eyewear
["rhs_balaclava"								],//east Goggles/eyewear
["rhs_Booniehat_m81"	],//West HeadGear
["G_Bandanna_blk"		],//East HeadGear
["FirstAidKit"			],//West Inventory Items  
["FirstAidKit","rhs_weap_6p53"			],// East Inventory Items   
[						]//PrimaryWeapon Items
]
];

};
//////////////////////////////   15 - САПЕР
if saper then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_sapper",
[ 
["rhs_weap_m4a1_carryhandle_mstock", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d10", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[
["rhs_weap_ak74", "rhs_acc_dtk1983"], 
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp8_02"], 
["rhs_weap_akm"],
["rhs_weap_ak103", "rhs_acc_dtk"], 
["rhs_weap_M590_8RD"]
],
[ ["rhs_mag_m67",2],["rhs_mag_an_m8hc",2],["APERSTripMine_Wire_Mag",3], ["APERSMine_Range_Mag",6], ["rhssaf_mine_tma4_mag",1] ],  
[ "rhsusf_weap_m9", "rhsusf_mag_15Rnd_9x19_JHP"																														],
[ ["rhs_mag_rgn",2], ["rhs_mag_rdg2_white",2],["rhssaf_mine_mrud_a_mag",3],["rhs_mine_pmn2_mag",3], ["rhs_mag_mine_pfm1",3], ["rhs_mag_mine_ptm1",1] 	], 
[	"rhs_weap_pya", "rhs_mag_9x19_17"																														],
false,	//revive
false,	//specialised 
0.1,//limit of such class in game
["rhs_uniform_FROG01_wd"		],//uniform west
["rhsgref_uniform_reed"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["B_Carryall_cbr"				],//backback west
["B_Carryall_oucamo"				],//backback east
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["rhsusf_mag_15Rnd_9x19_JHP" , "rhsusf_mag_15Rnd_9x19_JHP", "rhsusf_mag_15Rnd_9x19_JHP", "FirstAidKit", "ToolKit", "MineDetector"],//West Inventory Items
["FirstAidKit", "rhs_mag_9x19_17", "rhs_mag_9x19_17", "rhs_mag_9x19_17", "ToolKit", "MineDetector"],// East Inventory Items
[ 								]//PrimaryWeapon Items
]
];

};
//////////////////////////////   16 - Десантник
if zavdv then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_paratrooper",
[
["rhs_weap_m4a1_carryhandle_mstock", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],   
["rhs_weap_g36c", "rhsusf_acc_SF3P556"],   
["rhs_weap_m1garand_sa43"]
],
[
["rhs_weap_ak105_zenitco01", "rhs_acc_pgs64"],
["rhs_weap_ak74m_camo_folded", "rhs_acc_dtk"],
["rhs_weap_aks74u", "rhs_acc_pgs64_74u"]
],
[ ["rhs_m136_hedp_mag",1], ["rhs_mag_m67",3], ["rhs_mag_an_m8hc",3]], // 
[ "rhs_weap_M136_hedp"], //
[ ["rhs_rshg2_mag",1],["rhs_mag_rgn",3], ["rhs_mag_rdg2_white",3]],
[ "rhs_weap_rshg2"], //
false,	//revive
true,	//specialised 
1,//limit of such class in game
["rhs_uniform_cu_ocp_82nd", "rhs_uniform_abu"		],//uniform west
["rhsgref_uniform_woodland"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
["rhsusf_eject_Parachute_backpack"	],//backback west
["rhs_d6_Parachute_backpack"	],//backback east
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_oli"				],//east Goggles/eyewear
["rhssaf_beret_para"			],//West HeadGear
["rhs_beret_vdv2"				],//East HeadGear
["FirstAidKit"],//West Inventory Items
["FirstAidKit"],// East Inventory Items
[ 								]//PrimaryWeapon Items
]
];

};
/////////////////////////////////////   17 Оператор БПЛА
if opbpla then
{

RULES_classList =RULES_classList +
[
[
localize "STR_AAS_UAV_operator", 
[   
["rhs_weap_m4a1_carryhandle_mstock", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d10", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[
["rhs_weap_ak74", "rhs_acc_dtk1983"], 
["rhs_weap_ak74m_camo_dtk", "rhs_acc_ekp8_02"], 
["rhs_weap_akm"],
["rhs_weap_ak103", "rhs_acc_dtk"], 
["rhs_weap_M590_8RD"]
],
[ ["rhs_mag_m67",3], ["rhs_mag_an_m8hc",3]], // 
[ "rhsusf_weap_m9", "rhsusf_mag_15Rnd_9x19_JHP"																														],
[ ["rhs_mag_rgn",3], ["rhs_mag_rdg2_white",3]],
[  "rhs_weap_pya" 	, "rhs_mag_9x19_17" ],
false,	//revive
true,	//specialised 
1,//limit of such class in game
["rhs_uniform_FROG01_wd"		],//uniform west
["rhsgref_uniform_reed"			],//uniform east
["rhsusf_iotv_ocp_Repair"		],//vest west
["V_PlateCarrier1_blk"				],//vest east
[								],//backback west
[								],//backback east
["Binocular"					],//west binocular type items
["rhssaf_zrak_rd7j"					],//east binocular type items
[								],//west Goggles/eyewear
["G_Bandanna_blk"				],//east Goggles/eyewear
["rhsusf_lwh_helmet_marpatwd"	],//West HeadGear
["rhs_beanie_green"				],//East HeadGear
["B_UavTerminal", "FirstAidKit", "rhsusf_mag_15Rnd_9x19_JHP" , "rhsusf_mag_15Rnd_9x19_JHP", "rhsusf_mag_15Rnd_9x19_JHP" ],//West Inventory Items
["O_UavTerminal", "FirstAidKit", "rhs_mag_9x19_17", "rhs_mag_9x19_17", "rhs_mag_9x19_17" ],// East Inventory Items
[								]//PrimaryWeapon Items
]
];

};