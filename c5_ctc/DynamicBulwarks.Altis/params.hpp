class Params
{

	class BODY_CLEANUP
	{
		title = "Dead bodies remain for how many waves (dead bodies impact perfomance)";
		values[] = {0, 1, 2};
		texts[] = {"0 (until next round begins)", "1", "2"};
		default = 0;
	};

	class DOWN_TIME
	{
		title = "Time between rounds";
		values[] = {0, 15, 30, 60, 90, 120, 180, 240, 300};
		texts[] = {"0", "15 Seconds", "30 Seconds", "1 Minute", "1 Minute 30 Seconds", "2 Minutes", "3 Minutes", "4 Minutes", "5 Minutes"};
		default = 60;
	};

	class MAX_WAVES
	{
		title = "How Many Waves";
		values[] = {"infinite", 20, 30, 40};
		texts[] = {"Infinite", "20", "30", "40"};
		default = "infinite";
	};

	class BULWARK_MEDIKIT
	{
		title = "Medikits in Bulwark";
		values[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
		texts[] = {"None", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight"};
		default = 8;
	};

	class SPECIAL_WAVES
	{
		title = "Special Waves - suicide bombers, etc";
		values[] = {0, 1};
		texts[] = {"No", "Yes"};
		default = 1;
	};

	class ARMOUR_START_WAVE
	{
		title = "Vehicles can spawn after wave";
		values[] = {5, 10, 15, 20, 25, 9999};
		texts[] = {"5", "10", "15", "20", "25", "Never"};
		default = 5;
	};

	class RANDOM_WEAPONS
	{
		title = "Randomize Hostile Weapons";
		values[] = {"true", "false"};
		texts[] = {"Yes", "No"};
		default = "No";
	};

	class HUD_POINT_HITMARKERS
	{
		title = "Point Hitmarkers on HUD";
		values[] = {1, 0};
		texts[] = {"Yes", "No"};
		default = "1";
	};

	class BULWARK_LABEL_SPACE
	{
		title = " ";
		values[] = {0};
		texts[] = {""};
		default = 0;
	};

	class BULWARK_LABEL
	{
		title = "===== Bulwark Settings ======";
		values[] = {0};
		texts[] = {""};
		default = 0;
	};
	
	class BULWARK_LOCATION
	{
		title = "Bulwark Location";
		values[] = {1, 0};
		texts[] = {"Random", "Custom - Map Select"};
		default = "1";
	};

	class BULWARK_MINSIZE
	{
		title = "Minimum spawn room size";
		values[] = {10, 13, 15, 18, 20};
		texts[] = {"10m²", "13m²", "15m²", "18m²", "20m²"};
		default = 15;
	};

	class BULWARK_LANDRATIO
	{
		title = "Minimum land area (To avoid spawning on a dock)";
		values[] = {60, 70, 80, 90, 100};
		texts[] = {"60%","70%","80%","90%","100%"};
		default = 80;
	};

	class LOOT_HOUSE_DENSITY
	{
		title = "Minimum number of buildings in Bulwark radius";
		values[] = {5, 10, 15, 20, 30};
		texts[] = {"5","10","15","20","30"};
		default = 10;
	};

	class LOOT_SUPPLYDROP
	{
		title = "Supply drop distance from centre";
		values[] = {0, 25, 50, 75};
		texts[] = {"Dead centre", "25%", "50%", "75%"};
		default = 25;
	};

	class DAY_TIME_FROM
	{
		title = "Earliest time of day";
		values[] = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};
		texts[] = {"2am","4am","6am","8am","10am","Midday", "2pm", "4pm", "6pm", "8pm", "10pm"};
		default = 8;
	};

	class DAY_TIME_TO
	{
		title = "Latest time of day";
		values[] = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};
		texts[] = {"2am","4am","6am","8am","10am","Midday", "2pm", "4pm", "6pm", "8pm", "10pm"};
		default = 16;
	};

	class POWERUP_LABEL_SPACE
	{
		title = " ";
		values[] = {0};
		texts[] = {""};
		default = 0;
	};

	class POWERUP_LABEL
	{
		title = "====== Powerup Settings =====";
		values[] = {0};
		texts[] = {""};
		default = 0;
	};

	class START_KILLPOINTS
	{
		title = "Kill points players start with";
		values[] = {0, 250, 500, 1000, 2500, 5000, 10000};
		texts[] = {"0", "250", "500", "1000", "2500", "5000", "10000"};
		default = 500;
	};

	class SUPPORT_MENU
	{
		title = "Find Satellite Dish to Unlock Supports";
		values[] = {0, 1};
		texts[] = {"No, Supports are available from the begining of the mission", "Yes, find the Satellite Dish to unlock the Support Menu"};
		default = 0;
	};

	class REVIVE_LABEL_SPACE
	{
		title = "";
		values[] = {0};
		texts[] = {""};
		default = 0;
	};

	class REVIVE_LABEL
	{
		title = "===== Revive Settings ======";
		values[] = {0};
		texts[] = {""};
		default = 0;
	};

	class ReviveRequiredItems
	{
		title = "Required items";
		isGlobal = 0;

		values[] = {
			0,
			1,
			2
		};
		texts[] = {
			"None",
			"Medikit",
			"First Aid Kit / Medikit"
		};
		default = 2;
		function = "bis_fnc_paramReviveRequiredItems";
	};

};
