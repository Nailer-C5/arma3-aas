if( isServer ) then
{
	[] execVM "ServerMainThread.sqf";
	
};
  waitUntil { player == player };
if( local player ) then
{
	[] execVM "ClientMainThread.sqf";
	player execVM "deathHandler.sqf";
	[] execVM "ClientAIDebugThread.sqf";
	[] execVM "limitThirdPersonView.sqf";
	[] execVM "fnc_PlayerMarkers.sqf";
	player execVM "ClientUpdateTagsThread.sqf"; 
};