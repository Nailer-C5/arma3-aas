#include "globalDefines.hpp"
#define MAX_DAMAGE 0.9
RULES_initialised = netObjNull;
waitUntil { RULES_initialised };
// this function is called by every vehicle to record its initial coords then respawn it if it is destroyed
private [ "_respawnDelay", "_theVehicle", "_startDirection", "_startPos", "_typ", "_lastUsedTime", "_abandoned", "_threadUID" ];

if( isServer ) then
	{
	int _respawnDelay = _this select 1;
	obj _theVehicle   = _this select 0;
	_startDirection = getDir _theVehicle;
	pos _startPos   = getPos _theVehicle;
	_typ            = typeOf _theVehicle;
	bool _abandoned = false;
	float _lastUsedTime = time;
	int _threadUID = round (random 10000);
	DEBUG_LOG format["SRV vehicleRespawn.sqf (UID %1) : init",_threadUID];
	// wait respawn delay then create new vehicle
	if( RULES_overrideVehicleSpawnTimes ) then
		{
		_respawnDelay = RULES_vehicleRespawnDelay;
		if( _theVehicle isKindOf "Tank"       ) then { _respawnDelay = RULES_tankRespawnDelay;    };
		if( _theVehicle isKindOf "Helicopter" ) then { _respawnDelay = RULES_chopperRespawnDelay; };
		if( _theVehicle isKindOf "Plane"      ) then { _respawnDelay = RULES_planeRespawnDelay;   };
		};
	// main loop	
	while { true } do
		{
        // dont check too often, and dont make all the scripts run at the same time
		sleep 5 + (random 10);
        // if we are at start position, update lastmoved
		if( (_theVehicle distance _startPos) < 20 ) then { _lastUsedTime = time; };	
		// if there are still people in it, then reset the last used time
		if ( ({alive _x} count (crew _theVehicle)) > 0) then { _lastUsedTime = time }; 
		// if the vehicles wheels have been shot out and its hardly moved from start point, then respawn it
		if( (_theVehicle distance _startPos) < 10 and !(canMove _theVehicle) ) then
			{
			_abandoned = true;
			};
		// if the vehicle hasn't been used for ages (either moved or occupied)
		if( (time-_lastUsedTime) > RULES_abandonedVehicleTimeLimit ) then
			{
			DEBUG_LOG format["SRV vehicleRespawn.sqf (UID %1) : Vehicle %2, _lastUsedTime = %3, time =%4, abandoned",_threadUID, _theVehicle,round _lastUsedTime,round time];
			_abandoned = true;
			};
		if( ((damage _theVehicle) > MAX_DAMAGE) or _abandoned ) then
			{
			DEBUG_LOG format["SRV vehicleRespawn.sqf (UID %1) : Vehicle %2, damage = %3, canMove = %4, _abandoned = %5, deleting vehicle",_threadUID, _theVehicle, damage _theVehicle,canMove _theVehicle,_abandoned];
			// if vehicle not empty, skip
  			if ({alive _x} count (crew _theVehicle) > 0) exitWith {};
			// sleep required amount
			sleep (_respawnDelay / 2);
			if ({alive _x} count (crew _theVehicle) > 0) exitWith {};
			// get rid of the husk
			deleteVehicle _theVehicle;
			_theVehicle = objNull;
			// sleep required amount
			sleep (_respawnDelay / 2);					
			_theVehicle = _typ createVehicle _startPos;
			_theVehicle setPos _startPos;                                   
			_theVehicle setDir _startDirection;
			AAS_PublicAddActionsAndEH = _theVehicle;
			publicVariable "AAS_PublicAddActionsAndEH";
			if (!(isDedicated)) then
			{
				_theVehicle disableTIEquipment true;
			};
			if ((_theVehicle isKindOf "Helicopter") || ((typeOf _theVehicle) == "MV22")) then {_theVehicle addEventHandler ["GetIn","_this spawn AAS_fnc_Lift;"];};
			DEBUG_LOG format["SRV vehicleRespawn.sqf (UID %1) : Created new vehicle %2",_threadUID, _theVehicle];
			// reset counters
			_abandoned = false;
			_lastUsedTime = time;
			};
				
		};
		
	};
	