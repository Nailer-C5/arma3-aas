#include "globalDefines.hpp"
#define LOOPDELAY_SEC 0.5			// amount of time to wait per loop iteration
#define SLOWDELAY_SEC 5				// duration of slow update loop
#define SERVER_REPORT_PERIOD 30     // frequency at which server reports stats to logging
#define DEBUG_SVR       publicVariable	
#define DEBUG_ZONES		_ignore=

float lastTime=0;		// used to create one second intervals for spawn queue processing
int _lmctr=0; 
int xmitseq=0;	// transmission sequence no (used for spawn queues and base update messages)
bool debugDoReviveAll=false;    // when set to true, this launches a revive message for everyone in the server
int _debugReviveCounter=0;      // debug revive countdown
onPlayerConnected {};
onPlayerDisconnected {};
code _updateZonePlayerLists   = compileFinal preprocessFile "updateZonePlayerLists.sqf";
code _updateZoneCalculations  = compileFinal preprocessFile "updateZoneCalculations.sqf";
code _updateSpawnQueues       = compileFinal preprocessFile "updateSpawnQueues.sqf";
code _compileGameStatistics   = compileFinal preprocessFile "compileGameStatistics.sqf";
int _slowrep=0;		        	// loop timer for infrequent actions
int _slowRepMax=0;				// max value of infrequent action loop timer (note this is set properly just below)
int _srvPrevBase = 0;			// server local record of previous base
int _gameEndHints = [ 115, 110, 105, 100, 95, 90, 85, 80, 75, 70, 65, 60, 55, 50, 45, 40, 35, 30, 25, 20, 17, 15, 13, 10, 7, 5, 3, 1, -100];
int _curEndHint = 0;

while { (_gameEndHints select _curEndHint)*60 > timemax } do
{
	_curEndHint = _curEndHint + 1;
};
float _lastReportTime = 0;     // time at which last report of class loadout etc was compiled
_slowRepMax=floor (SLOWDELAY_SEC / LOOPDELAY_SEC);

[] execVM "ServerAIThread.sqf";

//NAILER[C5] - LET'S TRY RUNNING UPSMON JUST ONE TIME... //[] execVM "features\UPSMON\Init_UPSMON.sqf";
if (AAS_Params_AISupportMode != SUPPORT_OFF) then
{
	[] execVM "features\UPSMON\Init_UPSMON.sqf";
};

//NAILER - FIX TIME SETTINGS - ONLY APPLY TIME WHEN IT IS EXPLICITLY SET...
if (AAS_Params_HourOfDay != 0 || AAS_Params_MinuteOfDay != 0) then
{
	waitUntil {time > 0};
	_hour = date select 3;
	_minute = date select 4;
	if (AAS_Params_HourOfDay > 0) then { _hour = AAS_Params_HourOfDay; };
	if (AAS_Params_HourOfDay < 0) then { _hour = floor(random 24); };
	if (AAS_Params_MinuteOfDay > 0) then { _minute = AAS_Params_MinuteOfDay; };
	if (AAS_Params_MinuteOfDay < 0) then { _minute = floor(random 60); };
	if (isNil '_hour') then { _hour = "12"; };
	if (isNil '_minute') then { _minute = "0"; };
	setDate [(date select 0),(date select 1),(date select 2),_hour,_minute];
};
//END OF TIME SETTINGS FIX

//NAILER - FIX FOG AND RAIN FOR ARMA3 - NOW GLOBAL BY DEFAULT
//SEE ALSO: processServerCommand.sqf for client side wx settings (overcast, gusts, lightning)
switch (AAS_Params_Weather) do
{
	case -1:
	{
		globalOvercast = random floor (101);
		skipTime -24; 
		86400 setOvercast globalOvercast; 
		skipTime 24; 
		forceWeatherChange;
	};
	case 1:
	{
		globalOvercast = 0;
		skipTime -24; 
		86400 setOvercast globalOvercast; 
		skipTime 24; 
		forceWeatherChange;
	};
	case 2:
	{
		globalOvercast = 0.5;
		skipTime -24; 
		86400 setOvercast globalOvercast; 
		skipTime 24; 
		forceWeatherChange;
	};
	case 3:
	{
		globalOvercast = 0.75;
		skipTime -24; 
		86400 setOvercast globalOvercast; 
		skipTime 24; 
		
		globalRain = 0.15;
		0 setRain globalRain;
		
		setWind [0, -5, false];
		globalGusts = 0.25;
		0 setGusts globalGusts;
		
		globalRainbow = 1;
		0 setRainbow globalRainbow;
		
		forceWeatherChange;
	};
	case 4:
	{
		globalOvercast = 1; 
		skipTime -24; 
		86400 setOvercast globalOvercast; 
		skipTime 24; 
		
		globalRain = 1;
		0 setRain globalRain;
		
		setWind [0, -15, true];
		globalGusts = 1;
		0 setGusts globalGusts;
		
		globalLightnings = 1;
		0 setLightnings globalLightnings;
		
		//forceWeatherChange;
	};
};
switch (AAS_Params_Fog) do
{
	case -1:
	{
		globalFog = random floor (101);
		0 setFog globalFog;
	};
	case 1:
	{
		globalFog = 0;
		0 setFog globalFog;
	};
	case 2:
	{
		globalFog = 0.05;
		0 setFog globalFog;
	};
	case 3:
	{
		globalFog = 0.075;
		0 setFog globalFog;
	};
	case 4:
	{
		globalFog = 0.015;
		0 setFog globalFog;
	};
	case 5:
	{
		globalFog = 2;
		0 setFog globalFog;
	};
};
//END NAILER WEATHER FIXES

call cmdUpdatePlayerLists;
while { true } do
{	
	_slowrep=_slowrep + 1;
	
	if (_slowrep > _slowRepMax) then
	{
			publicVariable "timemax";
			centralServerTime=time;
			publicVariable "centralServerTime";
			publicVariable "globalOvercast";
			publicVariable "globalRain";			
			publicVariable "globalFog";
			publicVariable "globalGusts";
			publicVariable "globalLightnings";
			publicVariable "globalRainbow";
			int _lmctr=0;
		for "_lmctr" from 1 to (count saas_baselist) do
				{
				string _lname=BASENAME(_lmctr);
				_lname setMarkerColor (teamColors select BASEA(_lmctr,TEAM));	
				
				if( !(_lmctr in curBaseList) ) then
					{
					SETSRVBASECACHEA(_lmctr,CAPLEVEL,100);
					};
				};
			KRON_UPS_WEST = 0;
			KRON_UPS_EAST = 0;
			int _numRedBases  = { (_x select TEAM) == TEAM_RED  } count saas_baselist;
			int _numBlueBases = { (_x select TEAM) == TEAM_BLUE } count saas_baselist;
			if( time >= timemax and _numBlueBases >  _numRedBases  ) then { goWestWin   = true; publicVariable "goWestWin";   sleep 3; triggerWestWin=true;   };
			if( time >= timemax and _numRedBases  >  _numBlueBases ) then { goEastWin   = true; publicVariable "goEastwin";   sleep 3; triggerEastWin=true;   };
			if( time >= timemax and _numBlueBases == _numRedBases  ) then { goStalemate = true; publicVariable "goStalemate"; sleep 3; triggerStalemate=true; };
			if( (timemax - time) < (_gameEndHints select _curEndHint)*60 ) then
				{
				serverHint=format["%1 minutes left",_gameEndHints select _curEndHint];
				publicVariable "serverHint";					
				_curEndHint = _curEndHint + 1;
				sleep 1;
			      //_PAPABEAR=[West,"HQ"];
				_start = diag_tickTime;
			    //_PAPABEAR sidechat "STARTING CleanUP";
                      { deleteVehicle _x; } forEach allDeadMen;
                      sleep 1;
                      //NAILER[C5] temp disable for testing...
                      //{ deleteVehicle _x; } forEach nearestObjects [[10000,10000],["WeaponHolder","GroundWeaponHolder","WeaponHolderSimulated"],10000];
	                              
                       diag_log format ["SERVER_CLEANUP REPORT: Server cleanup took %1 seconds",diag_tickTime - _start];

                       //_PAPABEAR sidechat format ["Server cleanup took %1 seconds",diag_tickTime - _start];
				};
			if( (time-_lastReportTime) > SERVER_REPORT_PERIOD ) then
				{
				_lastReportTime=time;
				call _compileGameStatistics;
				};
			publicVariable "bonus_trucks_east";
			publicVariable "bonus_trucks_west";
			_slowrep=0;
	};
	if( createEastTruck ) then
		{		
		createEastTruck=false;
		unit _theVehicle = "O_Ifrit_F" createVehicle (getMarkerPos BASENAME(redXrayBaseID));			
		bonus_trucks_east = bonus_trucks_east + [ _theVehicle ];
		};
	if( createWestTruck ) then
		{		
		createWestTruck=false;
		unit _theVehicle = "B_Hunter_F" createVehicle (getMarkerPos BASENAME(blueXrayBaseID));			
		bonus_trucks_west = bonus_trucks_west + [ _theVehicle ];
		};
	if( debugTestRevive ) then
		{
		debugTestRevive=false;
		_debugReviveCounter=61;
		serverHint="Revive all in 30 secs.";
		publicVariable "serverHint";				
		};
	if( _debugReviveCounter > 0 ) then
		{
		_debugReviveCounter = _debugReviveCounter - 1;
		
		if( _debugReviveCounter == 50 ) then
			{
			serverHint="Revive all in 25 secs.";
			publicVariable "serverHint";		
			};
			
		if( _debugReviveCounter == 0 ) then
			{
			debugDoReviveAll=true;
			};
		};
	call cmdUpdatePlayerLists;
	call cmdProcessPlayerAttribs;		
	call _updateZonePlayerLists;	// done by both client and server
	call _updateZoneCalculations;	// percentage calcs done only by server (as stateful)
	call cmdPackStateSAAS;
	publicVariable "v1";	
	call _updateSpawnQueues;
	sleep LOOPDELAY_SEC;
};

