_time = ["ParamsGameTime",1800] call BIS_fnc_getParamValue;

//Engage the Virtual Arsonal 

arsenalItems = compileFinal preprocessFileLineNumbers "VirtualArsenalItems.sqf";

//Recruit AI

[] execVM "bon_recruit_units\init.sqf";

//Set Fog
[] execVM "Fog.sqf";

//Third person is set to drivers of vehicles only
		
[] execVM "ThirdPerson.sqf";