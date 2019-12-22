// File Description
// Name           : updateTags.sqf
// Called by      : ThreadLauncher.sqf
// Referenced by  : ThreadLauncher.sqf
// Client/Server  : client side
// Function area  : game UI
//
// Description
// the update HUD thread is pretty self-explanatory ... it takes the variables
// of the game state and various other info, and updates the graphical and text
// elements of the hud correspondingly
//
// The following HUD elements are updated by this script:
//   * name tags (above each player's head)

// ============================================================================/
// ----------------------------------------------------------------------------
//                            DEFINES
// ----------------------------------------------------------------------------
// ============================================================================/

#include "globalDefines.hpp"

// ============================================================================/
// ----------------------------------------------------------------------------
//                            VARIABLES
// ----------------------------------------------------------------------------
// ============================================================================/
	
// ============================================================================/
// ----------------------------------------------------------------------------
//                            MAIN ROUTINE
// ----------------------------------------------------------------------------
// ============================================================================/
 updateTagsThreadRun = netObjNull;
disableSerialization;         // ARMA2 command to make the _currentCutDisplay not cause a problem
while { true } do
	{
	
	waitUntil{ updateTagsThreadRun };
	
	// ----------------- wait a bit -------------------------
	//sleep 0.005; 

	//--------------------- player location --------------------

	// ARMA2, cant use global currentCutDisplay because it is not serialisable in mission namespace 
	 _currentCutDisplay = uiNamespace getVariable "curdispHUD";
			
	string _mColor="ColorBlue";
	if( EAST_PLAYER ) then
		{
			 _mColor="ColorRed";
		};
	
	// loop through all markers
	int	_ctr=0;
	for "_ctr" from 0 to (MAX_PLAYERS_PER_SIDE - 1) do
		{
		if( _ctr < count player_units_myteam ) then
			{
			obj _ttarget = player_units_myteam select _ctr;
			
			//--------------  update the minimap markers location and direction ------------------
					
			bool _inRange = false;
			
			// normal live in range check	
			if( player distance _ttarget > 1 and player distance _ttarget < tagDisplayRange ) then { _inRange = true; };
			
			// dead body in range check
			if( animationState _ttarget == "AmovPpneMstpSnonWnonDnon_healed" ) then
				{
				_markerName = format["%1 is down", _ttarget];
				array _posBody = getMarkerPos _markerName;
				
				if( player distance _posBody > 1 and player distance _posBody < tagDisplayRange ) then { _inRange = true; };		
				};
			
			// only display the name tag if player isnt running or in a vehicle
			// (ideally also check for if player is not zoomed in and if player
			// is not 3rd person, but can't think how to do this yet.
			
			//if( _inRange and speed player < 18 and ((vehicle player) == player) ) then
			if( _inRange ) then
				{
				// do name tags
					
				control _control = _currentCutDisplay displayCtrl (IDCPLAYER + _ctr);
				
				//pos _position = ctrlPosition _control;
				pos _targetPos = (getPosATL _ttarget);		
				_targetPos set [ 2 , (_targetPos select 2) + 1.9 ];	// make marker float 1.6m above
				
				array _position = worldToScreen _targetPos;
				
				if( (count _position) != 0 ) then		// this checks player is not out of view
					{
					ctrlShow [ _control , true ];
					_control ctrlSetPosition _position;			
					string _playerNameForTag = (_ttarget call getName);
								
					if( _playerNameForTag == "DEAD" ) then
						{		
						_control ctrlSetTextColor [0.7,0.2,0.2,1];  // red-ish colour
						}
					else
						{
						if( (damage _ttarget > 0.1) ) then
							{
							// player is damaged
							_control ctrlSetTextColor [1.0,0.5,0,1];  // orange
							_playerNameForTag = _playerNameForTag + format[" (%1%2)",100-round ((damage _ttarget)*100),"%"];
							}
						else
							{
							if( (_ttarget getVariable "fireteam") == myFireTeam and (myFireTeam != FIRETEAM_NONE) ) then
								{
								// marked player
								_control ctrlSetTextColor [0.7,0.7,0,1];  // yellow
								}
							else
								{
								_control ctrlSetTextColor [0,0.7,0,1];  // green
								};
							};
						};						
					_control ctrlSetText _playerNameForTag;					
					}
				else
					{
					_control ctrlSetText "";
					};	
			
				_control ctrlCommit 0;
				waitUntil { ctrlCommitted _control };	
				}
			else
				{
				control _control = _currentCutDisplay displayCtrl (IDCPLAYER + _ctr);
				_control ctrlSetText "";
				_control ctrlCommit 0;		
				waitUntil { ctrlCommitted _control };	
				};
			}
		else
			{
			control _control = _currentCutDisplay displayCtrl (IDCPLAYER + _ctr);
			_control ctrlSetText "";
			_control ctrlCommit 0;
			waitUntil { ctrlCommitted _control };	
			};
		};
	};