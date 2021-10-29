#include "globalDefines.hpp"
array _loc_player_units_east = [];		// a list of all the player objects on east team
array _loc_player_units_west = [];		// a list of all the player objects on the west team
array _loc_player_units_all = playableUnits;
array _loc_player_units_myteam = [];
if( count _loc_player_units_all == 0 ) then
	{
				{
		if( WESTSIDE(_x) and (alive _x) ) then { _loc_player_units_west = _loc_player_units_west + [ _x ]; };
		if( EASTSIDE(_x) and (alive _x) ) then { _loc_player_units_east = _loc_player_units_east + [ _x ]; };
		} forEach _loc_player_units_all;				
	};
if( local player ) then
	{
	if( WEST_PLAYER ) then
		{
		_loc_player_units_myteam = _loc_player_units_west;
		}
	else
		{
		_loc_player_units_myteam = _loc_player_units_east;
		};
	};
player_units_east   = _loc_player_units_east;
player_units_west   = _loc_player_units_west;
player_units_all    = _loc_player_units_all;
player_units_myteam = _loc_player_units_myteam;
if( local player ) then
	{
	//array _arrPlayerTeams = toArray playerTeams;
	array _arrPlayerTeams = playerTeams;
		{
		int _plyQID = _x call getPlayerQID;
		_x setVariable [ "qid"         , _plyQID                        , false ];
		_x setVariable [ "fireteam"    , _arrPlayerTeams select _plyQID , false ];
		_x setVariable [ "playerclass" , playerClasses   select _plyQID , false ];
		} forEach player_units_myteam;
	myFireTeam = player getVariable "fireteam";
	};

	
    