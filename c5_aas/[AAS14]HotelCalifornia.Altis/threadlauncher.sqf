if( isServer ) then
{
	[] execVM "ServerMainThread.sqf";
	//NAILER[C5] - SKIP THIS SCRIPT
	//[] execVM "antihack.sqf";
};
//NAILER[C5] - TRIM PBO FILE SIZE - REMOVE MUSIC
//0 fadeMusic 1;
//playMusic "TheUnitCut";

waitUntil { player == player };
if( local player ) then
{
	[] execVM "ClientMainThread.sqf";
	player execVM "deathHandler.sqf";
	[] execVM "ClientAIDebugThread.sqf";
	[] execVM "limitThirdPersonView.sqf";
	//NAILER[C5] - HANDLE CLEAR VEHICLE CARGO ELSEWHERE...
	//[] execVM "ClearVehicleCargo.sqf";
	[] execVM "fnc_PlayerMarkers.sqf";
	player execVM "ClientUpdateTagsThread.sqf"; 
};
