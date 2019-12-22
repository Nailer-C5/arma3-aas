#include "globalDefines.hpp"
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
RULES_maxTagDisplayRange     = 1500;  // range at which tag distance selector loops round back to zero
RULES_hudMaxLevel = 2;                // the best available hud display level (0 = minimal, 1 = no minimap, 2 = full)
RULES_captureRadius = 5;      //the radius of the flag that you need to get within to capture fully decamped base
RULES_captureSpeedFactor = 1;  //the capture speed factor multiplier (1=normal speed, 2=double speed, 0.5=half speed etc...)
RULES_enableProportionalCaptureSpeed = true;    // enable changing of capture speed depending on player numbers
RULES_captureSpeedMinCapacity = 2;               // maximum rate of capture (when there is one player in server)
RULES_captureSpeedMaxCapacity = 0.25;            // minimum rate of capture (when server is full)
RULES_baseQueueInterval = 10;		// how long you have to wait between each player spawning (strongly recommend not to change this)
RULES_minSpawnDelay = 10;			// minimum time you must wait, regardless of there being a queue
RULES_spawnArmourDuration = 10;         // how long does spawn armour last
RULES_spawncampRadius         = 150	; 	// defines the allowed range to walk within enemy base without punishment
RULES_spawncampMinLifespan    = 20 	;  // minimum lifespan under which assumed spawncamper has killed you
RULES_spawnElevation = 0; //Null elevation
RULES_spawncampRandomiseBound = 30	;  // X or Y dist from flag to be relocated (maximum) if randomised spawning used
RULES_spawncampProtectDefault = 1	;	// by default anti-spawncamp protection is on
RULES_overrideVehicleSpawnTimes = true;  // determines whether or not we should use rule settings for vehicle respawn
RULES_abandonedVehicleTimeLimit = 120;   // determines how long a vehicle must be left before considered abandoned
RULES_vehicleRespawnDelay       = 60;    // how long should a vehicle take to respawn once destroyed or abandoned
RULES_tankRespawnDelay          = 120;    // how long should a tank take to respawn
RULES_chopperRespawnDelay       = 150;    // how long should a chopper take to respawn
RULES_planeRespawnDelay         = 240;   // how long should a plane take to respawn
RULES_points                 = 1  ;       // points won per time period in an attacking zone
RULES_pointsDefzonePerPeriod = 1  ;       // points won per time period in a defending zone
RULES_secondsDefzoneToScore  = 60 ;       // time period for defending zone
RULES_secondsAttzoneToScore  = 30 ;       // time period for attacking zone
RULES_reviveScore            = 5  ;       // points you get for reviving divided by 3 (so if reviveScore=1 you get 3 points probably)
RULES_medicHealAmount     = 0 ;    // the amount of damage (on a scale of 0--1) that the medic heals you by randomly when in proximity
RULES_medicHealRange      = 5   ;    // range within which medic automatically heals injured players
RULES_nearbyMedicDistance = 500  ;    // range within which nearby medics are visible on respawn screen
RULES_canHealAtArmoury = true;        // sets whether you can heal yourself to 100% at the armoury or not
RULES_guiBaseDisplayed = true; //Turn GUI BASE display (ie.1 v 2) ON/OFF
RULES_AISupportMode = 1; //0 = AI support disabled, 1 = AI support enabled
RULES_wepsList = [

//Автоматы: Наименование / обозначение / патроны

[ "G36KV EOTECH",
"rhs_weap_g36kv",
[["rhssaf_30rnd_556x45_SOST_G36", 6]]],

[ "G36C",
"rhs_weap_g36c",
[["rhssaf_30rnd_556x45_SOST_G36", 6]]],

[ "M16A4",
"rhs_weap_m16a4_carryhandle_grip",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 6]]],

[ "M16A4 ACOG",
"rhs_weap_m16a4_carryhandle_bipod",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 6]]],

[ "M4A1",
"rhs_weap_m4a1_d",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 6]]],

[ "M4A1 ACOG",
"rhs_weap_m4a1_blockII_KAC_d",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 6]]],

[ "MK18",
"rhs_weap_mk18_KAC_d",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 6]]],

[ "HK416",  
"rhs_weap_hk416d10",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 6]]],

////

[ localize "STR_AAS_AKS74U",
"rhs_weap_aks74u",
[["rhs_30Rnd_545x39_7N22_AK", 6]]],
 
[ localize "STR_AAS_AK74M",
"rhs_weap_ak74m_desert_dtk",
[["rhs_30Rnd_545x39_7N22_AK", 6]]],
 
[ "FN FAL",
"CUP_arifle_FNFAL_railed",
[["CUP_20Rnd_762x51_FNFAL_M", 8]]],
 
[ localize "STR_AAS_AK103DTK",
"rhs_weap_ak103_dtk",
[["rhs_30Rnd_762x39mm_89", 6]]],
 
[ localize "STR_AAS_AK105PSO",
 "rhs_weap_ak105",
 [["rhs_30Rnd_545x39_7N22_AK", 6]]],
 
[ localize "STR_AAS_AK104COBRA",
 "rhs_weap_ak104",
 [["rhs_30Rnd_762x39mm_89", 6]]],
 
[localize "STR_AAS_AK74M_1P63",
"rhs_weap_ak74m_desert",
[["rhs_30Rnd_545x39_7N22_AK", 6]]],

[localize "STR_AAS_M21",
"rhs_weap_m21s",
[["rhsgref_30rnd_556x45_m21", 6]]],

[ localize "STR_AAS_AK74M",
"rhs_weap_ak74m_desert_npz",
[["rhs_30Rnd_545x39_7N22_AK", 6]]],

[ localize "STR_AAS_AK103",
"rhs_weap_ak103",
[["rhs_30Rnd_762x39mm_89", 6]]],

[ localize "STR_AAS_AKS74",
"rhs_weap_aks74",
[["rhs_30Rnd_545x39_7N22_AK", 6]]],

[ localize "STR_AAS_AK74M_SL",
"rhs_weap_ak74m_camo_folded",
[["rhs_30Rnd_545x39_7N22_AK", 6]]],

[ localize "STR_AAS_AK105_ZEN",
"rhs_weap_ak105_zenitco01",
[["rhs_30Rnd_545x39_7N22_AK", 6]]],


//стрелковое оружие с ГП: Наименование / обозначение / патроны / гранаты

[ "M16A4 GL ACOG",
"rhs_weap_m16a4_carryhandle_M203",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 6],
["rhs_mag_M433_HEDP", 8]]],

[ "M4A1 GL",
"rhs_weap_m4a1_carryhandle_m203",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 6],
["rhs_mag_M397_HET", 8]]],

[ "Mk18 GL",
"rhs_weap_mk18_m320",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 6],
["rhs_mag_M441_HE", 8]]],

[ "G36KV GL",
"rhs_weap_g36kv_ag36",
[["rhssaf_30rnd_556x45_SOST_G36", 6],
["rhs_mag_M433_HEDP", 8]]],

[ "HK416D145 GL",
"rhs_weap_hk416d145_m320",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 6],
["rhs_mag_M441_HE", 8]]],

[ "M4A1 GL SMOKE",
"rhs_weap_m4a1_blockII_M203_d",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag",6],
["rhs_mag_m714_White", 8]]],

////

[localize "STR_AAS_AK103GL",
"rhs_weap_ak103_gp25",
[["rhs_30Rnd_762x39mm_89", 6],
["rhs_VOG25", 8]]],

[localize "STR_AAS_AK74MGL",
"rhs_weap_ak74m_gp25",
[["rhs_30Rnd_545x39_7N22_AK", 6],
["rhs_vg40tb", 8]]],

[localize "STR_AAS_AKS74-GL",
"rhs_weap_aks74_gp25",
[["rhs_30Rnd_545x39_7N22_AK", 6],
["rhs_VOG25", 8]]],

[localize "STR_AAS_AKS74NGL_Cobra",			
"rhs_weap_aks74n_gp25",
[["rhs_30Rnd_545x39_7N22_AK", 6],
["rhs_VOG25", 8]]],

[localize "STR_AAS_AK74MRGL_MRCO",			
"rhs_weap_ak74mr_gp25",
[["rhs_30Rnd_545x39_7N22_AK", 6],
["rhs_VOG25", 8]]],

[localize "STR_AAS_AK47-MGL",
"rhs_weap_akms_gp25",
[["rhs_30Rnd_762x39mm_89", 6],
["rhs_VG40MD_White", 8]]],

//Пулеметы: Наименование / обозначение / патроны

[ "M249 EOTECH",
"rhs_weap_m249_pip_S_para",
[["rhsusf_100Rnd_556x45_soft_pouch", 4]]],

[ "M240B elcan",
"rhs_weap_m240b_elcan",
[["rhsusf_100Rnd_762x51_m993", 4]]],

[ "M240B ACOG",
"rhs_weap_m240B",
[["rhsusf_100Rnd_762x51_m993", 4]]],

[ "M240B EOTECH",
"rhs_weap_m240B_CAP",
[["rhsusf_100Rnd_762x51_m993", 4]]],

[ "M249 ACOG",
"rhs_weap_m249_pip_L_para",
[["rhsusf_100Rnd_556x45_soft_pouch", 4]]],

////

[localize "STR_AAS_pkp",
"rhs_weap_pkp",
[["rhs_100Rnd_762x54mmR_7N26", 4]]],

[localize "STR_AAS_PKM",
"rhs_weap_pkm",
[["rhs_100Rnd_762x54mmR_7N26", 4]]],

["M84",
"rhs_weap_m84",
[["rhssaf_250Rnd_762x54R", 1]]],

[localize "STR_AAS_RPK74",
"CUP_arifle_RPK74M",
[["CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M", 5]]],

//Спецоружие: Наименование / обозначение / патроны

[ "Mk18 KAC",
"rhs_weap_mk18_d",
[["rhs_mag_30Rnd_556x45_Mk318_Stanag", 9]]],

[ "MP5 SD6",
"CUP_smg_MP5SD6",
[["CUP_30Rnd_9x19_MP5", 9]]],

[ "MP5A5",
"CUP_MP5A5",
[["CUP_30Rnd_9x19_MP5", 6]]],

[ "MP7A1",
"rhsusf_weap_MP7A1_desert",
[["rhsusf_mag_40Rnd_46x30_JHP", 8]]],

[ "CAS SR25",
"rhs_weap_sr25_ec_d",
[["rhsusf_20Rnd_762x51_m993_Mag", 9]]],

[ "G36C SD EXPS3",
"rhs_weap_g36c",
[["rhssaf_30rnd_556x45_SOST_G36", 9]]],

[ "Mk17 SD",
"CUP_arifle_Mk17_CQC_FG",
[["CUP_20Rnd_762x51_B_SCAR", 8]]],


///

[localize "STR_AAS_asval",
"rhs_weap_asval_grip",
[["rhs_20rnd_9x39mm_SP6", 9]]],

[localize "STR_AAS_pp2000",
"rhs_weap_pp2000",
[["rhs_mag_9x19mm_7n31_20", 6]]],

[localize "STR_AAS_VSS",
"rhs_weap_vss_grip",
[["rhs_20rnd_9x39mm_SP6", 9]]],

[localize "STR_AAS_Bizon_SD",
"CUP_bizon_silenced",
[["CUP_64Rnd_9x19_Bizon_M", 9]]],               

[localize "STR_AAS_Bizon",
"CUP_bizon",
[["CUP_64Rnd_9x19_Bizon_M", 6]]],               

[localize "STR_AAS_AKS74UN",
"rhs_weap_aks74un",
[["rhs_30Rnd_545x39_7U1_AK", 9]]],               

[localize "STR_AAS_AK105_ZENITKA",
"rhs_weap_ak105_zenitco01_b33",
[["rhs_30Rnd_545x39_7N22_AK", 9]]],               

//Снайперское оружие: Наименование / обозначение / патроны

[ "M14 EBR-RI",
"rhs_weap_m14ebrri_leu",
[["rhsusf_20Rnd_762x51_m993_Mag", 6]]],

[ "CAS SR25",
"rhs_weap_sr25_ec_d",
[["rhsusf_20Rnd_762x51_m993_Mag", 6]]],

[ "XM2010",
"rhs_weap_XM2010_d_leu",
[["rhsusf_5Rnd_300winmag_xm2010", 16]]],

[ "M107",
"rhs_weap_M107_d_leu",
[["rhsusf_mag_10Rnd_STD_50BMG_M33", 3]]],
  
[ "M24",
"rhs_weap_m24sws_ghillie",
[["rhsusf_5Rnd_762x51_m993_Mag", 16]]], 
               
[ "M40A5",
"rhs_weap_m40a5_d",
[["rhsusf_10Rnd_762x51_m993_Mag", 12]]],  

////

[ localize "STR_AAS_SVD",
"rhs_weap_svd_pso1",
[["rhs_10Rnd_762x54mmR_7N1", 12]]],

[ "Т-5000",
"rhs_weap_t5000",
[["rhs_5Rnd_338lapua_t5000", 16]]],

[ localize "STR_AAS_KSVK",
"CUP_srifle_ksvk_PSO3",
[["CUP_5Rnd_127x108_KSVK_M", 6]]],

[ "M76",
"rhs_weap_m76",
[["rhsgref_10Rnd_792x57_m76",12]]],

[ "CZ 750",
"CUP_srifle_CZ750_SOS_bipod",
[["CUP_10Rnd_762x51_CZ750", 12]]],
			
//винтовки: Наименование / обозначение / патроны
                
[ localize "STR_AAS_M38",
"rhs_weap_m38_rail",
[["rhsgref_5Rnd_762x54_m38", 12]]],
               
[ "Karabiner 98 Kurz",
"rhs_weap_kar98k",
[["rhsgref_5Rnd_792x57_kar98k", 12]]],
                
[ localize "STR_AAS_Saiga12K",
"CUP_sgun_Saiga12K",
[["CUP_8Rnd_B_Saiga12_74Slug_M", 12]]],
                      
[ "M590 S",
"rhs_weap_M590_8RD",
[["rhsusf_8Rnd_Slug", 12]]]
];


RULES_classList =
[
[
//////////////////////////  
localize "STR_AAS_Rifleman", //     0- БОЕЦ  deathHandler.sqf строка 184
[  
["rhs_weap_hk416d10", "rhsusf_acc_SF3P556"],
["rhs_weap_m4a1_d", "rhsusf_acc_compm4", "rhsusf_acc_grip2_tan", "rhsusf_acc_SFMB556"],
["rhs_weap_mk18_KAC_d", "rhsusf_acc_eotech_552_d", "rhsusf_acc_SFMB556"],
["rhs_weap_g36kv", "rhsusf_acc_eotech_552", "hgun_P07_khk_F"],
["rhs_weap_m4a1_blockII_KAC_d", "rhsusf_acc_ACOG_d", "rhsusf_acc_grip1", "rhsusf_acc_SF3P556", "rhsusf_acc_anpeq15_wmx_light"],
["rhs_weap_m16a4_carryhandle_bipod", "rhsusf_acc_ACOG_RMR", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74m_desert_dtk"],
["rhs_weap_ak103_dtk"],  
["CUP_arifle_FNFAL_railed"], 
["rhs_weap_m21s"], // "rhsusf_acc_eotech_xps3"  
["rhs_weap_ak74m_desert", "rhs_acc_dtk", "rhs_acc_1p63"],
["rhs_weap_ak104","rhs_acc_pkas", "rhs_acc_dtk"],
["rhs_weap_ak105", "rhs_acc_pso1m2_ak", "rhs_acc_dtk"],
["CUP_sgun_Saiga12K"] 	
],
[ ["rhs_mag_m67",4], ["rhs_mag_an_m8hc",2]],
["rhsusf_weap_m1911a1", "rhsusf_mag_7x45acp_MHP"],
[ ["rhs_mag_rgn",4], ["rhs_mag_rdg2_white",2]], 
["rhs_weap_makarov_pm", "rhs_mag_9x18_8_57N181S"],
false,	//revive
false,	//specialised
1,//limit of such class in game
["rhs_uniform_cu_ucp"		],//uniform west
["rhs_uniform_m88_patchless"],//uniform east
["rhsusf_iotv_ucp_Repair"	],//vest west
["rhs_6b23_ML_6sh92_vog"	],//vest east   rhs_6b13_6sh92	rhs_6b13   rhs_6b23_digi
[							],//backback west  
[							],//backback east  
["Binocular"				],//binocular type items
[							],//Goggles/eyewear
["rhsusf_ach_helmet_ucp"	],//West HeadGear
["rhs_6b27m_ml"				],//East HeadGear
["FirstAidKit",  "rhsusf_mag_7x45acp_MHP", "rhsusf_mag_7x45acp_MHP", "rhsusf_mag_7x45acp_MHP"],//West Inventory Items
["FirstAidKit", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x18_8_57N181S"],// East Inventory Items  
[ ]//PrimaryWeapon Items
],
////////////////////////  1- ГП
[
localize "STR_AAS_Grenadier",
[ 
["rhs_weap_m16a4_carryhandle_M203", "rhsusf_acc_ACOG2", "rhsusf_acc_SF3P556"], 
["rhs_weap_hk416d145_m320", "rhsusf_acc_ACOG_RMR", "rhsusf_acc_SF3P556"], 
["rhs_weap_g36kv_ag36", "rhsusf_acc_eotech_552", "rhsusf_acc_SF3P556"],  
["rhs_weap_mk18_m320", "rhsusf_acc_compm4", "rhsusf_acc_SF3P556"],    
["rhs_weap_m4a1_carryhandle_m203", "rhsusf_acc_SF3P556"],
["rhs_weap_m4a1_blockII_M203_d", "rhsusf_acc_eotech_xps3", "rhsusf_acc_SF3P556"] 
], //
[  
["rhs_weap_ak74m_gp25", "rhs_acc_pso1m2", "rhs_acc_dtk"],
["rhs_weap_ak74mr_gp25", "optic_MRCO", "rhs_acc_uuk"],
["rhs_weap_ak103_gp25", "rhs_acc_pkas", "rhs_acc_dtk"],  
["rhs_weap_aks74n_gp25", "rhs_acc_ekp1", "rhs_acc_dtk1983"], 
["rhs_weap_aks74_gp25", "rhs_acc_dtk1983"],
["rhs_weap_akms_gp25"] 
],   //
[ ["rhs_mag_m67",5], ["rhs_mag_an_m8hc",2]],
["rhsusf_weap_m1911a1", "rhsusf_mag_7x45acp_MHP"],
[ ["rhs_mag_rgn",5], ["rhs_mag_rdg2_white",2]],  
["rhs_weap_makarov_pm", "rhs_mag_9x18_8_57N181S"],
false,	//revive
false,	//specialised 
0.2,//limit of such class in game
["rhs_uniform_cu_ucp"		],//uniform west
["rhs_uniform_m88_patchless"],//uniform east
["rhsusf_iotv_ucp_Repair"	],//vest west  rhsusf_iotv_ocp_Grenadier
["rhs_6b23_ML_6sh92_vog"	],//vest east  rhs_6b23_ML_6sh92_vog_vog
[							],//backback west  
[							],//backback east 		
["Binocular"				],//binocular type items
[							],//Goggles/eyewear
["rhsusf_ach_helmet_ucp"	],//West HeadGear
["rhs_6b27m_ml"				],//East HeadGear
["FirstAidKit", "rhsusf_mag_7x45acp_MHP" , "rhsusf_mag_7x45acp_MHP", "rhsusf_mag_7x45acp_MHP"],//West Inventory Items
["FirstAidKit", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x18_8_57N181S"],// East Inventory Items
["acc_flashlight"]//PrimaryWeapon Items
],
////////////////////////  2- ПУЛЕМЕТ ПСО
[
localize "STR_AAS_Gunner_scope",  // 
[ 
["rhs_weap_m240B", "rhsusf_acc_ACOG_MDO","rhs_bipod"],
["rhs_weap_m249_pip_L_para","rhsusf_acc_ACOG_MDO","rhs_bipod"]
],
[ 
["rhs_weap_pkp","rhs_bipod","rhs_acc_1p78"]  //rhs_acc_pso1m2_pkp
],
[ ["rhs_mag_m67",1], ["rhs_mag_an_m8hc",1]],
[ "rhsusf_weap_m1911a1", "rhsusf_mag_7x45acp_MHP"  													],
[ ["rhs_mag_rgn",1], ["rhs_mag_rdg2_white",1]], 
[  "rhs_weap_makarov_pm", "rhs_mag_9x18_8_57N181S"														],
false,	//revive
true,	//specialised 
0.2,//limit of such class in game
["rhs_uniform_cu_ucp"			],//uniform west
["rhs_uniform_m88_patchless"	],//uniform east
["rhsusf_iotv_ucp_Repair"		],//vest west
["rhs_6b23_ML_6sh92_vog"		],//vest east
["rhsusf_assault_eagleaiii_ucp"	],//backback west  "B_Carryall_mcamo"	
["B_Kitbag_cbr"					],//backback east  "rhs_rpg_empty" 			
["Binocular"					],//binocular type items
[								],//Goggles/eyewear
["rhsusf_ach_helmet_ucp"		],//West HeadGear
["rhs_6b27m_ml"					],//East HeadGear
["FirstAidKit", "rhsusf_mag_7x45acp_MHP" , "rhsusf_mag_7x45acp_MHP", "rhsusf_mag_7x45acp_MHP"],//West Inventory Items
["FirstAidKit", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x18_8_57N181S"],// East Inventory Items 
[ ]//PrimaryWeapon Items
],
////////////////////////////  3- ПУЛЕМЕТ
[
localize "STR_AAS_Gunner",  // 
[ 
["rhs_weap_m240B_CAP", "rhsusf_acc_EOTECH","rhs_bipod"],
["rhs_weap_m249_pip_S_para","rhs_bipod","rhsusf_acc_EOTECH"]
],
[ 
["CUP_arifle_RPK74M","rhs_acc_pkas","rhs_bipod"], 
["rhs_weap_pkp","rhs_acc_pkas" ,"rhs_bipod"],
["rhs_weap_pkm"],
["rhs_weap_m84"]
],
[ ["rhs_mag_m67",1], ["rhs_mag_an_m8hc",1]	],
[  "rhsusf_weap_m1911a1", "rhsusf_mag_7x45acp_MHP" 													],
[ ["rhs_mag_rgn",1], ["rhs_mag_rdg2_white",1] 						], 
[  "rhs_weap_makarov_pm", "rhs_mag_9x18_8_57N181S"														],
false,	//revive
true,	//specialised 
1,//limit of such class in game
["rhs_uniform_cu_ucp"			],//uniform west
["rhs_uniform_m88_patchless"	],//uniform east
["rhsusf_iotv_ucp_Repair"		],//vest west
["rhs_6b23_ML_6sh92_vog"		],//vest east
["rhsusf_assault_eagleaiii_ucp"	],//backback west  "B_Carryall_mcamo"	
["B_Kitbag_cbr"					],//backback east  "rhs_rpg_empty" 			
["Binocular"					],//binocular type items
[								],//Goggles/eyewear
["rhsusf_ach_helmet_ucp"		],//West HeadGear
["rhs_6b27m_ml"					],//East HeadGear
["FirstAidKit", "rhsusf_mag_7x45acp_MHP" , "rhsusf_mag_7x45acp_MHP", "rhsusf_mag_7x45acp_MHP"],//West Inventory Items
["FirstAidKit", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x18_8_57N181S"],// East Inventory Items
[ ]//PrimaryWeapon Items
],
/////////////////////////////// 4 - МЕДИК
[
localize "STR_AAS_Medic",
[ 
["CUP_MP5A5", "rhsusf_acc_compm4"], 
["rhs_weap_m4a1_d", "rhsusf_acc_compm4", "rhsusf_acc_SF3P556"],
["rhsusf_weap_MP7A1_desert", "rhsusf_acc_eotech_xps3"] 
],
[ 
["rhs_weap_pp2000", "rhs_acc_rakursPM"], 
["rhs_weap_ak74m_desert_npz", "rhsusf_acc_compm4", "rhs_acc_dtk"],
["CUP_bizon", "rhs_acc_pkas"] 
],
[ ["rhs_mag_m67",3], ["rhs_mag_an_m8hc",6] , ["rhsusf_mag_17Rnd_9x19_JHP",3]],
[   "rhsusf_weap_glock17g4" , "rhsusf_mag_17Rnd_9x19_JHP"],
[ ["rhs_mag_rgn",3], ["rhs_mag_rdg2_white",6] , ["rhs_mag_9x19_17",3]],  
[  "rhs_weap_pya" 	, "rhs_mag_9x19_17"	],
true,	//revive
false,	//specialised 
1,//limit of such class in game
["rhs_uniform_cu_ucp"		],//uniform west
["rhs_uniform_m88_patchless"],//uniform east
["rhsusf_iotv_ucp_Medic"	],//vest west
["rhs_6b23_ML_6sh92_vog"		],//vest east
["rhsusf_falconii_mc"		],//backback west
["rhs_medic_bag"		],//backback east  
["Binocular"				],//binocular type items
[							],//Goggles/eyewear
["rhsusf_ach_helmet_ucp"	],//West HeadGear
["rhs_6b27m_ml"				],//East HeadGear
[ "FirstAidKit", "FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit"],//West Inventory Items
[ "FirstAidKit", "FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit"],// East Inventory Items
[ ]//PrimaryWeapon Items
],
//////////////////////////////   5 - РШГ
[
localize "STR_AAS_RSHG", 
[  
["rhs_weap_hk416d10", "rhsusf_acc_SF3P556"], 
["rhs_weap_m4a1_d", "rhsusf_acc_eotech_552_d", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74m_desert_dtk"],
["CUP_arifle_FNFAL_railed"],
["rhs_weap_ak103", "rhs_acc_dtk"],
["CUP_sgun_Saiga12K"]
],
[ ["CUP_MAAWS_HEDP_M",1], ["rhs_mag_m67",6], ["rhs_mag_an_m8hc",6]], 
[ "CUP_launch_MAAWS"], 
[ ["rhs_rshg2_mag",1],["rhs_mag_rgn",6], ["rhs_mag_rdg2_white",6]],
[ "rhs_weap_rshg2"], 
false,	//revive
false,	//specialised 
0.1,//limit of such class in game
["rhs_uniform_cu_ucp"			],//uniform west
["rhs_uniform_m88_patchless"	],//uniform east
["rhsusf_iotv_ucp_Repair"		],//vest west
["rhs_6b23_ML_6sh92_vog"		],//vest east
["rhsusf_falconii_mc"	],//backback west  "B_AssaultPack_sgg"	
["B_AssaultPack_ocamo"		],//backback east  			
["Binocular"					],//binocular type items
[								],//Goggles/eyewear
["rhsusf_ach_helmet_ucp"		],//West HeadGear
["rhs_6b27m_ml"					],//East HeadGear
["FirstAidKit"					],//West Inventory Items
["FirstAidKit"					],// East Inventory Items
[ 								]//PrimaryWeapon Items
],
//////////////////////////////   6 - РПГ-7
[
localize "STR_AAS_Mid AT",          
[  
["rhs_weap_hk416d10", "rhsusf_acc_SF3P556"], 
["rhs_weap_m4a1_d", "rhsusf_acc_eotech_552_d", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74m_desert_dtk"],
["CUP_arifle_FNFAL_railed"],
["rhs_weap_ak103", "rhs_acc_dtk"],
["CUP_sgun_Saiga12K"]
],
[ ["rhs_mag_smaw_HEAA",2], ["rhs_mag_m67",1], ["rhs_mag_an_m8hc",1]],
[ "rhs_weap_smaw_optic" ],
[ ["rhs_rpg7_PG7VL_mag",3],["rhs_mag_rgn",1], ["rhs_mag_rdg2_white",1]],
[ "rhs_weap_rpg7_pgo"], 
false,	//revive
true,	//specialised 
1,//limit of such class in game
["rhs_uniform_cu_ucp"		],//uniform west
["rhs_uniform_m88_patchless"],//uniform east
["rhsusf_iotv_ucp_Repair"	],//vest west
["rhs_6b23_ML_6sh92_vog"	],//vest east
["B_Carryall_mcamo"			],//backback west
["rhs_rpg_empty"			],//backback east
["Binocular"				],//binocular type items
[							],//Goggles/eyewear
["rhsusf_ach_helmet_ucp"	],//West HeadGear
["rhs_6b27m_ml"				],//East HeadGear
["FirstAidKit"				],//West Inventory Items
["FirstAidKit"				],// East Inventory Items
[ ]//PrimaryWeapon Items
],
//////////////////////////////   7 - СНАЙПЕР
[
localize "STR_AAS_Sniper", //       
[  
["rhs_weap_m24sws_ghillie","rhsusf_acc_premier_low","rhs_bipod"],
["rhs_weap_m14ebrri_leu","rhs_bipod"], 
["rhs_weap_m40a5_d","rhsusf_acc_M8541_low_d","rhs_bipod"],   
["rhs_weap_sr25_ec_d","rhsusf_acc_premier","rhs_bipod"], 
["rhs_weap_XM2010_d_leu","rhsusf_acc_LEUPOLDMK4_2","rhs_bipod"], 
["rhs_weap_M107_d_leu","rhsusf_acc_premier","rhs_bipod"],
["rhs_weap_kar98k"]  
], 
[ 
["rhs_weap_svd_pso1","rhs_bipod"],  
["rhs_weap_t5000","rhs_acc_harris_swivel","rhs_acc_dh520x56"],
["rhs_weap_m76","rhs_acc_pso1m2","rhs_bipod"], 
["CUP_srifle_CZ750_SOS_bipod"],
["CUP_srifle_ksvk_PSO3","rhs_bipod"],
["rhs_weap_m38_rail","optic_SOS"] 
],
[ ["rhs_mag_m67",1], ["APERSTripMine_Wire_Mag",1] ],
[   "rhsusf_weap_glock17g4" , "rhsusf_mag_17Rnd_9x19_JHP"], 
[ ["rhs_mag_rgn",1], ["APERSTripMine_Wire_Mag",1] ],    
[  "rhs_weap_pya" 	, "rhs_mag_9x19_17"	],  
false,	//revive
true,	//specialised 
0.15,//limit of such class in game
["CUP_U_B_USArmy_Ghillie"	],//uniform west
["CUP_U_O_RUS_Ghillie"	],//uniform east   
["CUP_V_C_Police_Holster"	],//vest west
["CUP_V_C_Police_Holster"	],//vest east
[							],//backback west  
[							],//backback east 		
["CUP_Vector21Nite"			],//binocular type items rhs_scarf
[							],//Goggles/eyewear
[							],//West HeadGear
[							],//East HeadGear
["FirstAidKit", "rhs_mag_m67", "rhsusf_mag_17Rnd_9x19_JHP", "rhsusf_mag_17Rnd_9x19_JHP", "rhsusf_mag_17Rnd_9x19_JHP"],//West Inventory Items
["FirstAidKit", "rhs_mag_rgn", "rhs_mag_9x19_17", "rhs_mag_9x19_17", "rhs_mag_9x19_17"],// East Inventory Items 
[ ]//PrimaryWeapon Items
],
//////////////////////////////   8 - РАЗВЕДКА
[
localize "STR_AAS_Recon", //  
[ 
["rhs_weap_mk18_d", "rhsusf_acc_ACOG_RMR", "rhsusf_acc_grip2_tan", "rhsusf_acc_anpeq15A"], 
["rhs_weap_g36c", "rhsusf_acc_eotech_xps3", "rhsusf_acc_nt4_tan", "rhsusf_acc_anpeq15A"], 
["rhs_weap_sr25_ec_d", "rhsusf_acc_M8541", "rhsusf_acc_SR25S", "rhsusf_acc_anpeq15A"], 
["CUP_arifle_Mk17_CQC_FG", "CUP_muzzle_snds_SCAR_H", "rhsusf_acc_ACOG_d", "rhsusf_acc_anpeq15A"], 
["CUP_smg_MP5SD6"]
],
[ 
["rhs_weap_aks74un", "rhs_acc_pbs4", "rhs_acc_ekp1"], 
["rhs_weap_asval_grip", "rhs_acc_ekp1", "rhs_acc_perst1ik_ris"],
["rhs_weap_vss_grip", "rhs_acc_pso1m21", "rhs_acc_perst1ik_ris"],
["rhs_weap_ak105_zenitco01_b33", "optic_MRCO", "rhs_acc_dtk", "rhs_acc_grip_ffg2", "rhs_acc_tgpa"],
["CUP_bizon_silenced", "rhs_acc_pkas"] 
], 
[ ["rhs_mag_m67",1], ["Laserbatteries",1], ["rhs_mag_an_m8hc",2], ["rhsusf_m112_mag",2], ["CUP_30Rnd_9x19_UZI",3] 																],
[  "CUP_hgun_MicroUzi","CUP_muzzle_snds_MicroUzi","CUP_30Rnd_9x19_UZI"],
[ ["rhs_mag_rgn",1], ["Laserbatteries",1], ["rhs_mag_rdg2_white",2], ["rhsusf_m112_mag",2], ["CUP_18Rnd_9x19_Phantom",5] 	], 
[  "CUP_hgun_Phantom", "muzzle_snds_L", "CUP_acc_CZ_M3X", "CUP_18Rnd_9x19_Phantom" ],
false,	//revive
true,	//specialised 
0.15,//limit of such class in game
["rhs_uniform_g3_mc"			],//uniform west
["rhs_uniform_m88_patchless"	],//uniform east
["CUP_V_I_RACS_Carrier_Rig_2"	],//vest west
["CUP_V_RUS_Smersh_2"			],//vest east
["rhsusf_assault_eagleaiii_ocp"	],//backback west
["B_AssaultPack_khk"			],//backback east		
["CUP_LRTV"						],//binocular type items
[								],//Goggles/eyewear
["rhs_Booniehat_ocp"			],//West HeadGear
["CUP_H_RUS_Bandana_HS"			],//East HeadGear
["FirstAidKit"					],//West Inventory Items  
["FirstAidKit"					],// East Inventory Items   
[ ]//PrimaryWeapon Items
],				
//////////////////////////////   9 - САПЕР
[
localize "STR_AAS_sapper",
[   
["rhs_weap_hk416d10", "rhsusf_acc_SF3P556"], 
["rhs_weap_m4a1_d", "rhsusf_acc_eotech_552_d", "rhsusf_acc_SF3P556"],
["rhs_weap_m16a4_carryhandle_grip", "rhsusf_acc_SF3P556"],
["rhs_weap_M590_8RD"]
],
[ 
["rhs_weap_ak74m_desert_dtk"],
["CUP_arifle_FNFAL_railed"],
["rhs_weap_ak103", "rhs_acc_dtk"],
["CUP_sgun_Saiga12K"]
],
[ ["rhs_mag_m67",2],["rhs_mag_an_m8hc",2], ["rhs_mine_pmn2_mag",2],["APERSTripMine_Wire_Mag",2],["rhs_mine_M19_mag",1] ],  
[ "rhsusf_weap_m1911a1", "rhsusf_mag_7x45acp_MHP"																														],
[ ["rhs_mag_rgn",2], ["rhs_mag_rdg2_white",2],["rhs_mine_pmn2_mag",2],["APERSTripMine_Wire_Mag",2],["rhs_mine_tm62m_mag",1] 	],
[	"rhs_weap_makarov_pm", "rhs_mag_9x18_8_57N181S"																														],
false,	//revive
true,	//specialised 
0.15,//limit of such class in game
["rhs_uniform_cu_ucp"		],//uniform west
["rhs_uniform_m88_patchless"],//uniform east
["rhsusf_iotv_ucp_Repair"	],//vest west
["rhs_6b23_ML_6sh92_vog"	],//vest east
["B_Carryall_mcamo"			],//backback west
["CUP_B_AlicePack_Khaki"	],//backback east
["Binocular"				],//binocular type items
[							],//Goggles/eyewear
["rhsusf_ach_helmet_ucp"	],//West HeadGear
["rhs_6b27m_ml"				],//East HeadGear
["rhsusf_mag_7x45acp_MHP" , "rhsusf_mag_7x45acp_MHP", "rhsusf_mag_7x45acp_MHP","MineDetector" , "ToolKit","FirstAidKit"],//West Inventory Items
["FirstAidKit", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x18_8_57N181S", "rhs_mag_9x18_8_57N181S","MineDetector" , "ToolKit","FirstAidKit"],// East Inventory Items
[ ]//PrimaryWeapon Items
]
];