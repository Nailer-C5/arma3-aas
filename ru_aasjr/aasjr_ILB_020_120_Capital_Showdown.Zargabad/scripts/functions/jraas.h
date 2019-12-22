
class S3 //Tag
{
	class Cheat_Zilla
	{
		file = "Scripts\Functions\CZilla";
		PreInit = 1;
		class ScriptsView {};
		class AdminEye {};
		class PBSTRD {};
		class MadChat {};
		class getAdmin {};
		
	};
		
	class jrAASRespawn
	{
		postInit = 1;
		file = "Scripts\Functions\Respawn";
		class jrRespawnInit {};
		class ClearVehicleWeapons {};
		class ADDVehicleWeapons {};
		class saveVehicleWeapons {};
	};
	

	
	class jrAAS
	{
		/*
		preInit = 1; //(formerly known as "forced") 1 to call the function upon mission start, before objects are initialized. Passed arguments are ["preInit"]
		postInit = 1; //1 to call the function upon mission start, after objects are initialized. Passed arguments are ["postInit", didJIP]
		preStart = 1; //1 to call the function upon game start, before title screen, but after all addons are loaded (config.cpp only)
		ext = ".fsm"; //Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM). Default is ".sqf".
		headerType = -1; //Set function header type: -1 - no header; 0 - default header; 1 - system header.
		recompile = 1; //1 to recompile the function upon mission start (config.cpp only; functions in description.ext are compiled upon mission start already)
		*/
		
		preStart = 1;
		file = "Scripts\Functions\jrAAS";
		class jrFnc {};
		class Arsenal {};
		class Melee {};
		class JumpLFR {};
		class drawNametag {};
		class syncParams {};
		class UpdateClassMenu {};
		class Help {};
		class BastardWP {};
		
		class SRV_Update {};
		//class SpawnUnit {};
		
		//class ammoCrate {};
	};	

    
};

//S3_fnc_ammoCrate		//ammobox init:	[this] spawn S3_fnc_ammoCrate;

//S3_fnc_BastardWP
//S3_fnc_SpawnUnit


//S3_fnc_ScriptsView
//S3_fnc_AdminEye
//S3_fnc_PBSTRD
//S3_fnc_MadChat
//S3_fnc_getAdmin


//S3_fnc_jrFnc
//S3_fnc_Arsenal
//S3_fnc_Melee
//S3_fnc_JumpLFR
//S3_fnc_drawNametag
//S3_fnc_syncParams
//S3_fnc_Help

//S3_fnc_jrRespawn
//S3_fnc_jrRespawnInit
//S3_fnc_jrRespawnAddEHs

//S3_fnc_vehicleRespawn