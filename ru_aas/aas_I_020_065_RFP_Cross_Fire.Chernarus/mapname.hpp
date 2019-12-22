#define MAP_DESCRIPTION "aas_I_020_065_RFP_Cross_Fire by"

#define OVERVIEWTEXT $STR_AAS_HISTORY

#define AAS_SMALL_MISSION

#define AAS_DEFAULT_WEATHER 0			//Погода по умолчанию - 0 -чисто. 1 - штормовая (ваврьируется от 0 до 1)
#define AAS_DEFAULT_FOG 0				//Туман по умолчанию 0 чисто, 1 - сильнейший туман
#define AAS_DEFAULT_TIME_HOUR 12		//Время по умолчанию
#define AAS_DEFAULT_TIME_MINUTE 00		//Минуты по умолчанию
#define dst 500 						// Дистанция обзора в метрах
#define mzl 0.2							//Размер карты HUD  для примера - малые карты 0.1, средние - 0.2, большие 0.3 и больше

//Оставляем один из пунктов
//1_боты зеленка
#define awu ["rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman_m590","rhsusf_usmc_marpat_wd_rifleman_law","rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman_m4","rhsusf_usmc_marpat_wd_rifleman_m4","rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_rifleman"]
#define aeu ["rhs_msv_emr_rifleman","rhs_msv_emr_efreitor","rhs_msv_emr_junior_sergeant","rhs_msv_emr_machinegunner","rhs_msv_emr_officer","rhs_msv_emr_arifleman","rhs_msv_emr_marksman","rhs_msv_emr_sergeant","rhs_msv_emr_RShG2","rhs_msv_emr_grenadier"]

/*
//2_боты ганслингер
#define awu ["rhsusf_usmc_recon_marpat_wd_teamleader_fast","rhsusf_usmc_recon_marpat_wd_machinegunner_m249_fast","rhsusf_usmc_recon_marpat_wd_marksman_fast","rhsusf_usmc_recon_marpat_wd_marksman_fast","rhsusf_usmc_recon_marpat_wd_rifleman_fast","rhsusf_usmc_recon_marpat_wd_autorifleman_fast","rhsusf_usmc_recon_marpat_wd_rifleman_at_fast","rhsusf_usmc_recon_marpat_wd_rifleman_at_fast","rhsusf_usmc_recon_marpat_wd_marksman_fast"]
#define aeu ["rhs_mvd_izlom_sergeant","rhs_mvd_izlom_machinegunner","rhs_mvd_izlom_marksman","rhs_mvd_izlom_marksman_vss","rhs_mvd_izlom_rifleman_asval","rhs_mvd_izlom_rifleman","rhs_mvd_izlom_arifleman","rhs_mvd_izlom_rifleman_LAT","rhs_mvd_izlom_efreitor","rhs_mvd_izlom_grenadier_rpg"]
*/
/*
//3_боты пески
#define awu ["rhsusf_usmc_recon_marpat_d_officer","rhsusf_usmc_recon_marpat_d_rifleman_fast","rhsusf_usmc_recon_marpat_d_marksman","rhsusf_usmc_marpat_d_grenadier","rhsusf_usmc_marpat_d_autorifleman","rhsusf_usmc_marpat_d_gunner","rhsusf_usmc_marpat_d_autorifleman_m249","rhsusf_usmc_marpat_d_squadleader","rhsusf_usmc_marpat_d_fso","rhsusf_usmc_marpat_d_riflemanat"]
#define aeu ["rhs_vmf_recon_sergeant","rhs_vmf_recon_efreitor","rhs_vmf_recon_medic","rhs_vmf_recon_arifleman","rhs_vmf_recon_marksman","rhs_vmf_recon_rifleman_akms","rhs_vmf_recon_grenadier","rhs_vmf_recon_marksman_vss","rhs_vmf_rifleman_scout_akm","rhs_vmf_recon_rifleman_lat"]
*/
//Один из четырех наборов
//1_Набор правил "зеленка" (Черноруссия и подобнные) RULES_ZEL.sqf
#define Rulchoice SETUP_ZEL
//2_Набор правил "пески" (Такистан и подобнные) RULES_PES.sqf
//#define Rulchoice SETUP_PES 
//3_Набор правил специально для Gunslingers RULES_GUNS.sqf
//#define Rulchoice SETUP_GUNS
//4_Набор правил специально для карт by [HA]Galactic RULES_GAL.sqf
//#define Rulchoice SETUP_GAL

//Бойцы которых можно отключить пишем false или true
#define boecgp true		// 1 рюкзак не положен (0 - боец)
#define macpso true		// 2
#define machgn true		// 3
#define sanit  true		// 4
#define remont true	    // 5
#define rshg   true		// 6
#define rpg7   false		// 7
#define ptrk1  false		// 8
#define tpod   true		// 9
#define agsm   false		// 10
#define Jav    false		// 11
#define pzrk1  false		// 12
#define snip   true		// 13
#define spez   true		// 14
#define saper  true		// 15
#define zavdv  true		// 16
#define opbpla false	 	// 17
//Кому рюкзак не положен. Если выключаем класс, соответственно надо изменить цифру

#define bpb ((playerClass==0) or (playerClass==1))








