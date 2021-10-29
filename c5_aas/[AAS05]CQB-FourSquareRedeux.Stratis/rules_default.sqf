#include "globalDefines.hpp"
RULES_ruleSetName = "Public";
RULES_debugPasswordHash = "FD1878C23FAC954A966D3DF2F8DC18716D304E7FFDD833734980707A51C9BC9F";   //  password to gain access to debugging commands (teleport, debug etc)
RULES_adminPasswordHash = "FB8193DD10FD704D72F3280EF521B36F54287FADF95D1038ECE532BBD6A6F030";   //  password to gain access to admin commands (weather, time etc)
RULES_WepsQtyDefault =[10, 0, 40, 0];
RULES_AmmoQtyDefault = [ 40, 0, 0, 10, 40, 20, 40 ];
RULES_allowDamageToAmmoCrates = false;
RULES_canCustomiseLoadout = false;    
RULES_customClassCanRevive = false;
RULES_everyoneCanRevive = false;
RULES_armouryUseRange = 10;
RULES_classChangeDelay = 40;
RULES_banScopedWithHeavy = false;
RULES_defaultTagDisplayRange = 1000;   // range at which green player tags disppear (too far away to show)
RULES_maxTagDisplayRange     = 1000;  // range at which tag distance selector loops round back to zero
RULES_hudMaxLevel = 2;                // the best available hud display level (0 = minimal, 1 = no minimap, 2 = full)
RULES_captureRadius = 15;      //the radius of the flag that you need to get within to capture fully decamped base
RULES_captureSpeedFactor = 5;  //the capture speed factor multiplier (1=normal speed, 2=double speed, 0.5=half speed etc...)
RULES_enableProportionalCaptureSpeed = true;    // enable changing of capture speed depending on player numbers
RULES_captureSpeedMinCapacity = 2;               // maximum rate of capture (when there is one player in server)
RULES_captureSpeedMaxCapacity = 0.25;            // minimum rate of capture (when server is full)
RULES_baseQueueInterval = 10;		// how long you have to wait between each player spawning (strongly recommend not to change this)
RULES_minSpawnDelay = 20;			// minimum time you must wait, regardless of there being a queue
RULES_spawnArmourDuration = 20;     // how long does spawn armour last (if you go below 5secs armour will disable or when you pull your gun trigger)
RULES_spawncampRadius         = 150	; 	// defines the allowed range to walk within enemy base without punishment
RULES_spawncampMinLifespan    = 20 	;  // minimum lifespan under which assumed spawncamper has killed you
RULES_spawnElevation = 0; //Null elevation
RULES_spawncampRandomiseBound = 50	;  // X or Y dist from flag to be relocated (maximum) if randomised spawning used
RULES_spawncampProtectDefault = 1	;	// by default anti-spawncamp protection is on
RULES_overrideVehicleSpawnTimes = true;  // determines whether or not we should use rule settings for vehicle respawn
RULES_abandonedVehicleTimeLimit = 120;   // determines how long a vehicle must be left before considered abandoned
RULES_vehicleRespawnDelay       = 120;    // how long should a vehicle take to respawn once destroyed or abandoned
RULES_tankRespawnDelay          = 300;    // how long should a tank take to respawn
RULES_chopperRespawnDelay       = 240;    // how long should a chopper take to respawn
RULES_planeRespawnDelay         = 300;   // how long should a plane take to respawn
RULES_points                 = 1  ;       // points won per time period in an attacking zone
RULES_pointsDefzonePerPeriod = 1  ;       // points won per time period in a defending zone
RULES_secondsDefzoneToScore  = 60 ;       // time period for defending zone
RULES_secondsAttzoneToScore  = 30 ;       // time period for attacking zone
RULES_reviveScore            = 1  ;       // points you get for reviving divided by 3 (so if reviveScore=1 you get 3 points probably)
RULES_medicHealAmount     = 0.1 ;    // the amount of damage (on a scale of 0--1) that the medic heals you by randomly when in proximity
RULES_medicHealRange      = 10   ;    // range within which medic automatically heals injured players
RULES_nearbyMedicDistance = 350  ;    // range within which nearby medics are visible on respawn screen
RULES_canHealAtArmoury = false;        // sets whether you can heal yourself to 100% at the armoury or not
RULES_guiBaseDisplayed = true; //Turn GUI BASE display (ie.1 v 2) ON/OFF
RULES_SquadLeaderToFlagDist = 100;
RULES_wepsList = [
[ "MXM 7.62 SOS"     , "arifle_MXM_SOS_pointer_F"           , [ ["30Rnd_65x39_caseless_mag"    , 6]                      ] ],
[ "MXM 7.62 RCO"      , "arifle_MXM_Hamr_pointer_F"          , [ ["30Rnd_65x39_caseless_mag"        , 6]                      ] ],
[ "MX 3GL ACO"     , "arifle_MX_GL_ACO_F"             , [ ["30Rnd_65x39_caseless_mag"    , 5] , ["3Rnd_HE_Grenade_shell",2] ] ],
[ "MX 6.5 mm"          , "arifle_MX_F"               , [ ["30Rnd_65x39_caseless_mag"    , 5]                      ] ],
[ "MX ACO"       , "arifle_MX_ACO_F"            , [ ["30Rnd_65x39_caseless_mag"       , 5]                     ] ],
[ "MX ACOg"            , "arifle_MX_ACOg_point_grip_F"        , [ ["30Rnd_65x39_caseless_mag"     ,  5]                     ] ],
[ "MX 3GL"            , "arifle_MX_GL_F"            , [ ["30Rnd_65x39_caseless_mag"       , 5] , ["3Rnd_HE_Grenade_shell",2] ] ],
[ "MXC ACO"         , "arifle_MXC_ACO_pointer_F"        , [ ["30Rnd_65x39_caseless_mag"        , 5]                     ] ],
[ "MXC Holo SD"          , "arifle_MXC_Holo_pointer_snds_F"               , [ ["30Rnd_65x39_caseless_mag"       , 5]                      ] ],
[ "MX Holo"          , "arifle_MX_Holo_pointer_F"               , [ ["30Rnd_65x39_caseless_mag"    , 5]                      ] ],
[ "MXC Holo"          , "arifle_MXC_Holo_pointer_F"               , [ ["30Rnd_65x39_caseless_mag"    , 5]                      ] ],
[ "MXSW RCO"        , "arifle_MX_SW_Hamr_point_F"            , [ ["100Rnd_65x39_caseless_mag_Tracer"        , 5]                      ] ],
[ "MXSW"        , "arifle_MX_SW_pointer_F"            , [ ["100Rnd_65x39_caseless_mag_Tracer"        , 5]                      ] ],
[ "Katiba C ACO"      , "arifle_Katiba_C_ACO_pointer_F"     , [ ["30Rnd_65x39_caseless_green"        , 5]                     ] ],
[ "Katiba ACO"      , "arifle_Katiba_ACO_pointer_F"     , [ ["30Rnd_65x39_caseless_green"        , 5]                     ] ],
[ "Katiba 6.5 mm"          , "arifle_Katiba_F"               , [ ["30Rnd_65x39_caseless_green"        , 5]                      ] ],
[ "Katiba GL ACO"     , "arifle_Katiba_GL_ACO_pointer_F"             , [ ["30Rnd_65x39_caseless_green"    , 5] , ["1Rnd_HE_Grenade_shell",6] ] ],
[ "Katiba GL SD"           , "arifle_Khaybar_GL_ACO_point_mzls_F"                , [ ["30Rnd_65x39_caseless_mag"    , 5] , ["1Rnd_HE_Grenade_shell",6] ] ],
[ "Katiba SD"          , "arifle_Khaybar_Holo_mzls_F"               , [ ["30Rnd_65x39_caseless_green"         , 5]                      ] ],
[ "Katiba C ACO SD"     , "arifle_Khaybar_C_ACO_flash_snds_F"               , [ ["30Rnd_65x39_caseless_green"     , 5]                      ] ],
[ "Katiba GL"            , "arifle_Katiba_GL_F"                  , [ ["30Rnd_65x39_caseless_green"       , 5] , ["1Rnd_HE_Grenade_shell",6] ] ],
[ "Katiba GL ACOg"          , "arifle_Khaybar_GL_ACOg_point_F"              , [ ["30Rnd_65x39_caseless_green"       , 5] , ["1Rnd_HE_Grenade_shell",6] ] ],
[ "Katiba ACOg SD"       , "arifle_Khaybar_C_ACOg_flash_snds_F"      , [ ["30Rnd_65x39_caseless_green"    , 5]                      ] ],
[ "Katiba C ACOg"            , "arifle_Khaybar_C_ACOg_point_F"                 , [ ["30Rnd_65x39_caseless_green"       ,  5]                     ] ],
[ "Mk200 MRCO"      , "LMG_Mk200_MRCO_F"          , [ ["200Rnd_65x39_cased_Box_Tracer"        , 4]                      ] ],
[ "LMG Zafir"      , "LMG_Zafir_pointer_F"          , [ ["150Rnd_762x51_Box_Tracer"        , 4]                      ] ],
[ "SDAR"     , "arifle_SDAR_F"             , [ ["20Rnd_556x45_UW_mag"    , 4] , ["30Rnd_556x45_Stanag",3] ] ],
[ "Vermin"     , "SMG_01_Holo_pointer_snds_F"             , [ ["30Rnd_45ACP_Mag_SMG_01"    , 8] ] ],
[ "Scorpion"     , "SMG_02_ACO_F"             , [ ["30Rnd_9x21_Mag"    , 8] ] ],
[ "GM6 Lynx"           , "srifle_GM6_SOS_F"                , [ ["5Rnd_127x108_Mag"      , 8]                     ] ],
[ "M320 LRR"           , "srifle_LRR_SOS_F"                , [ ["7Rnd_408_Mag"      , 7]                     ] ],
[ "SAS SD Rifle"      , "srifle_EBR_F"    , [ ["20Rnd_762x51_Mag"  , 6]                      ] ],
[ "Mk18 ABR SOS"      , "srifle_EBR_SOS_F"    , [ ["20Rnd_762x51_Mag"  , 6]                      ] ],
[ "Mk18 ABR ARCO"   , "srifle_EBR_ARCO_pointer_F"        , [ ["20Rnd_762x51_Mag"        , 5]                      ] ],
[ "Mk18 ABR ACO"          , "srifle_EBR_ACO_point_F"               , [ ["20Rnd_762x51_Mag"       , 6]                      ] ],
[ "Mk18 ABR ACOg"        , "srifle_EBR_ACOG_F"     , [ ["20Rnd_762x51_Mag"     , 6]                      ] ],
[ "Mk20 5.56 MRCO"      , "arifle_Mk20_MRCO_pointer_F"     , [ ["30Rnd_556x45_Stanag"        , 5]                     ] ],
[ "Mk20 5.56 Holo"      , "arifle_Mk20_Holo_F"     , [ ["30Rnd_556x45_Stanag"        , 5]                     ] ],
[ "Mk20C 5.56 ACO"      , "arifle_Mk20C_ACO_pointer_F"     , [ ["30Rnd_556x45_Stanag"        , 5]                     ] ],
[ "Mk20 GL MRCO"      , "arifle_Mk20_GL_MRCO_pointer_F"     , [ ["30Rnd_556x45_Stanag"        , 5], ["1Rnd_HE_Grenade_shell",6] ]],
[ "TRG20 ACOg SD"           , "arifle_TRG20_ACOg_flash_snds_F"                , [ ["30Rnd_556x45_Stanag_Tracer_Yellow"     , 5]                      ] ],
[ "TRG20 ACOg"          , "arifle_TRG20_ACOg_F"               , [ ["30Rnd_556x45_Stanag_Tracer_Yellow"    , 5]                      ] ],
[ "TRG20 Holo"          , "arifle_TRG20_Holo_F"               , [ ["30Rnd_556x45_Stanag_Tracer_Yellow"        , 5]                     ] ],
[ "TRG21 ACO"          , "arifle_TRG21_ACO_pointer_F"               , [ ["30Rnd_556x45_Stanag_Tracer_Yellow"        , 5]                     ] ],
[ "TRG21 GL ACO"       , "arifle_TRG21_GL_ACO_pointer_F"     , [ ["30Rnd_556x45_Stanag_Tracer_Yellow"      , 5] , ["1Rnd_HE_Grenade_shell",6] ] ],
[ "TRG21 ACOg"           , "arifle_TRG21_ACOg_point_F"                , [ ["30Rnd_556x45_Stanag_Tracer_Yellow"      , 5]                     ] ]
];
RULES_classList =
[
[
"Rifleman", 
[ "arifle_MX_F", "arifle_TRG20_Holo_F","arifle_TRG21_ACO_pointer_F","arifle_MXC_Holo_pointer_F","arifle_MXC_ACO_pointer_F", "arifle_MX_Holo_pointer_F", "arifle_MX_ACO_F", "arifle_TRG20_Holo_F" ],
[ "arifle_Katiba_F", "arifle_Mk20_Holo_F", "arifle_Katiba_C_ACO_pointer_F", "arifle_Mk20_MRCO_pointer_F", "arifle_Katiba_ACO_pointer_F", "arifle_Mk20C_ACO_pointer_F" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10] ],
[ "hgun_P07_snds_F" , "NVGoggles" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10] ],
[ "hgun_Rook40_snds_F", "NVGoggles" ],
false,
false,
["U_B_CombatUniform_mcam"],//uniform west
["U_O_CombatUniform_ocamo"],//uniform east
["V_PlateCarrier1_rgr"],//vest west
["V_HarnessO_brn"],//vest east
["B_FieldPack_cbr"],//backback west
["B_FieldPack_ocamo"],//backback east
["Binocular"],//binocular type items
["G_Combat"],//Goggles/eyewear
["H_HelmetB"],//West HeadGear
["H_HelmetO_ocamo"],//East HeadGear
[],//West Inventory Items
[],// East Inventory Items
["acc_flashlight"]//PrimaryWeapon Items
],
[
"Grenadier", 
[ "arifle_MX_GL_ACO_F", "arifle_MX_GL_F", "arifle_TRG21_GL_ACO_pointer_F" ],
[ "arifle_Mk20_GL_MRCO_pointer_F", "arifle_Katiba_GL_ACO_pointer_F", "arifle_Katiba_GL_F" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10] ],
[ "hgun_P07_snds_F" , "NVGoggles" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10] ],
[ "hgun_Rook40_snds_F", "NVGoggles" ],
false,
false,
["U_B_CombatUniform_mcam"],
["U_O_CombatUniform_ocamo"],
["V_PlateCarrierGL_rgr"],
["V_HarnessOGL_brn"],
["B_AssaultPack_cbr"],
["B_AssaultPack_mcamo"],
["Binocular"],
["G_Sport_Blackred"],
["H_HelmetSpecB_paint2"],
["H_HelmetSpecO_ocamo"],
[],
[],
["acc_flashlight"]
],
[
"Diver", 
[ "arifle_SDAR_F", "arifle_MX_F" ],
[ "arifle_SDAR_F", "arifle_Katiba_F" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10] ],
[ "hgun_P07_snds_F" , "NVGoggles" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10] ],
[ "hgun_Rook40_snds_F", "NVGoggles" ],
false,
false,
[ "U_B_Wetsuit" ],
[ "U_O_Wetsuit" ],
["V_RebreatherB"],
["V_RebreatherIR"],
[ "B_TacticalPack_blk"],
["B_Bergen_blk"],
["Binocular"],
["G_Diving"],
[],
[],
[],
[],
["acc_flashlight","optic_Aco","muzzle_snds_H"]
],
[
"Gunner", 
[ "arifle_MX_SW_pointer_F", "LMG_Mk200_MRCO_F" ],
[ "LMG_Zafir_pointer_F", "LMG_Mk200_MRCO_F" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10] ],
[ "hgun_P07_snds_F" , "NVGoggles" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10] ],
[ "hgun_Rook40_snds_F","NVGoggles" ],
false,
false,
["U_B_CombatUniform_mcam"],
["U_O_CombatUniform_ocamo"],
["V_PlateCarrier2_rgr"],
["V_HarnessO_brn"],
["B_AssaultPack_mcamo_AAR"],
["B_FieldPack_ocamo_AAR"],
["Binocular"],
["G_Combat"],
["H_HelmetSpecB_blk"],
["H_HelmetSpecO_blk"],
[],
[],
["acc_flashlight","optic_MRCO"]
],
[
"Medic", 
[ "arifle_MX_F", "arifle_TRG20_Holo_F","arifle_TRG21_ACO_pointer_F","arifle_MXC_Holo_pointer_F","arifle_MXC_ACO_pointer_F", "arifle_MX_Holo_pointer_F", "arifle_MX_ACO_F", "arifle_TRG20_Holo_F" ],
[ "arifle_Katiba_F", "arifle_Mk20_Holo_F", "arifle_Katiba_C_ACO_pointer_F", "arifle_Mk20_MRCO_pointer_F", "arifle_Katiba_ACO_pointer_F", "arifle_Mk20C_ACO_pointer_F" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10] ],
[ "hgun_P07_snds_F" , "NVGoggles" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10] ],
[ "hgun_Rook40_snds_F", "NVGoggles" ],
true,
false,
["U_B_CombatUniform_mcam_tshirt"],
["U_O_OfficerUniform_ocamo"],
["V_PlateCarrier2_rgr"],
["V_TacVest_brn"],
["B_AssaultPack_rgr_Medic"],
["B_FieldPack_ocamo_Medic"],
["Binocular"],
["G_Sport_Checkered"],
["H_Cap_blu"],
["H_Cap_red"],
[],
[],
["acc_flashlight"]
],
[
"Anti-Tank", 
[ "arifle_MX_F", "arifle_TRG20_Holo_F","arifle_TRG21_ACO_pointer_F","arifle_MXC_Holo_pointer_F","arifle_MXC_ACO_pointer_F", "arifle_MX_Holo_pointer_F", "arifle_MX_ACO_F", "arifle_TRG20_Holo_F" ],
[ "arifle_Katiba_F", "arifle_Mk20_Holo_F", "arifle_Katiba_C_ACO_pointer_F", "arifle_Mk20_MRCO_pointer_F", "arifle_Katiba_ACO_pointer_F", "arifle_Mk20C_ACO_pointer_F" ],
[ ["NLAW_F",2], ["SmokeShell",3] ],
[ "launch_NLAW_F", "NVGoggles" ],
[ ["RPG32_F",2], ["SmokeShell",3] ],
[ "launch_RPG32_F", "NVGoggles" ],
false,
false,
["U_B_CombatUniform_mcam"],
["U_O_CombatUniform_ocamo"],
["V_PlateCarrierSpec_rgr"],
["V_TacVest_brn"],
["B_AssaultPack_rgr_ReconLAT"],
["B_FieldPack_cbr_LAT"],
["Binocular"],
["G_Shades_Black"],
["H_HelmetB"],
["H_HelmetO_ocamo"],
[],
[],
["acc_flashlight"]
],
[
"Anti-Air", 
[ "arifle_MX_F", "arifle_TRG20_Holo_F","arifle_TRG21_ACO_pointer_F","arifle_MXC_Holo_pointer_F","arifle_MXC_ACO_pointer_F", "arifle_MX_Holo_pointer_F", "arifle_MX_ACO_F", "arifle_TRG20_Holo_F" ],
[ "arifle_Katiba_F", "arifle_Mk20_Holo_F", "arifle_Katiba_C_ACO_pointer_F", "arifle_Mk20_MRCO_pointer_F", "arifle_Katiba_ACO_pointer_F", "arifle_Mk20C_ACO_pointer_F" ],
[ ["Titan_AA",2], ["Titan_AP",1], ["SmokeShell",3] ],
[ "launch_B_Titan_F", "NVGoggles" ],
[ ["Titan_AA",2], ["Titan_AP",1], ["SmokeShell",3] ],
[ "launch_O_Titan_F", "NVGoggles" ],
false,
false,
["U_B_CombatUniform_mcam"],
["U_O_CombatUniform_ocamo"],
["V_PlateCarrierSpec_rgr"],
["V_TacVest_brn"],
["B_Carryall_mcamo"],
["B_Carryall_ocamo"],
["Binocular"],
["G_Shades_Black"],
["H_HelmetB_plain_mcamo"],
["H_HelmetO_oucamo"],
[],
[],
["acc_flashlight"]
],
[
"Sniper", 
[ "arifle_MXM_SOS_pointer_F", "arifle_MXM_Hamr_pointer_F", "srifle_LRR_SOS_F","srifle_GM6_SOS_F" ],
[ "srifle_EBR_ARCO_pointer_F", "srifle_EBR_SOS_F", "srifle_GM6_SOS_F","srifle_LRR_SOS_F"],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10], ["APERSTripMine_Wire_Mag", 2] ],
[ "hgun_P07_snds_F" , "NVGoggles" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10], ["APERSTripMine_Wire_Mag", 2] ],
[ "hgun_Rook40_snds_F", "NVGoggles" ],
false,
false,
["U_B_GhillieSuit"],
["U_O_GhillieSuit"],
["V_PlateCarrier2_rgr"],
["V_TacVest_brn"],
["B_AssaultPack_cbr"],
["B_AssaultPack_mcamo"],
["Rangefinder"],
["G_Shades_Blue"],
[],
[],
[],
[],
["acc_flashlight"]
],
[
"Saboteur", 
[ "arifle_MXC_Holo_pointer_snds_F", "arifle_TRG21_ACO_pointer_F" ],
[ "arifle_Mk20_Holo_F", "arifle_Mk20_MRCO_pointer_F" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10], ["APERSBoundingMine_Range_Mag",1], ["ClaymoreDirectionalMine_Remote_Mag",1], ["APERSTripMine_Wire_Mag",1] ],
[ "hgun_P07_snds_F" , "NVGoggles" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10], ["APERSBoundingMine_Range_Mag",1], ["ClaymoreDirectionalMine_Remote_Mag",1], ["APERSTripMine_Wire_Mag",1] ],
[ "hgun_Rook40_snds_F", "NVGoggles" ],
false,
false,
["U_B_CombatUniform_mcam"],
["U_O_CombatUniform_ocamo"],
["V_Chestrig_khk"],
["V_TacVest_brn"],
["B_Kitbag_rgr_Exp"],
["B_Carryall_ocamo_Exp"],
["Binocular"],
["G_Sport_BlackWhite"],
["H_Cap_khaki_specops_UK"],
["H_Cap_brn_SPECOPS"],
[],
[],
["acc_flashlight"]
],
[
"SAS", 
[ "SMG_01_Holo_pointer_snds_F", "SMG_02_ACO_F", "srifle_EBR_F" ],
[ "SMG_01_Holo_pointer_snds_F", "SMG_02_ACO_F", "srifle_EBR_F" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10], ["Laserbatteries",2], ["APERSBoundingMine_Range_Mag",1], ["ClaymoreDirectionalMine_Remote_Mag",1], ["APERSTripMine_Wire_Mag",1] ],
[ "hgun_P07_snds_F" , "NVGoggles" ],
[ ["HandGrenade",3], ["SmokeShell",2], ["30Rnd_9x21_Mag",10], ["Laserbatteries",2], ["APERSBoundingMine_Range_Mag",1], ["ClaymoreDirectionalMine_Remote_Mag",1], ["APERSTripMine_Wire_Mag",1] ],
[ "hgun_Rook40_snds_F", "NVGoggles" ],
false,
false,
["U_B_SpecopsUniform_sgg"],
["U_O_SpecopsUniform_blk"],
["V_Chestrig_khk"],
["V_TacVest_brn"],
["B_Carryall_mcamo"],
["B_Carryall_ocamo"],
["Laserdesignator"],
["G_Tactical_Black"],
["H_Booniehat_tan"],
["H_Beret_blk"],
["optic_aco_smg", "optic_Holosight_smg", "optic_SOS", "optic_MRCO"],
["optic_aco_smg", "optic_Holosight_smg", "optic_SOS", "optic_MRCO"],
["muzzle_snds_L","acc_pointer_IR","muzzle_snds_B"]
]
];