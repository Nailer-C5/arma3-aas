/*/
File: fn_selectLocation 
Description:
Domain: Client
/*/

disableSerialization;
openMap true;
hint "Click on the map to select a custom area. Press CTRL+M to start the mission on selected location.";
waituntil {!isNull (findDisplay 46)};
    
#define M_KEY_CODE 50
BLWK_customAreaDisplayEH = (findDisplay 46) displayAddEventHandler ["KeyDown",{
	// if the pressed keys are ctrl+M
	private _keysPressed = ((_this select 1) isEqualTo M_KEY_CODE) AND {_this select 3};
	if (_keysPressed AND {call bulc_fnc_checkLocation}) then {
		openMap false;
		
		// display 46 is not always active and therefore need to wait for it to be in a scheduled environment
		null = [] spawn {
			waituntil {!isNull (findDisplay 46)};
			(findDisplay 46) displayRemoveEventHandler ["KeyDown",BLWK_customAreaDisplayEH];
			missionNamespace setVariable ["BLWK_customAreaDisplayEH",nil];
		};
		removeMissionEventHandler ["MapSingleClick",BLWK_customPlayAreaMapEH];
		
		// transmit position to server
		missionNamespace setVariable ["bulwarkLocation",BLWK_missionAreaInfo_temp select 0,2];

		// clear globals
		missionNamespace setVariable ["BLWK_customPlayAreaMapEH",nil];
		missionNamespace setVariable ["BLWK_missionAreaInfo_temp",nil];
		// delete markers
		deleteMarker BLWK_centerMarker_temp;
		missionNamespace setVariable ["BLWK_centerMarker_temp",nil];
		deleteMarker BLWK_areaMarker_temp;
		missionNamespace setVariable ["BLWK_areaMarker_temp",nil];
		deleteMarker BLWK_numBuildingsInfoMarker_temp;
		missionNamespace setVariable ["BLWK_numBuildingsInfoMarker_temp",nil];
		deleteMarker BLWK_numBuildingPositionsInfoMarker_temp;
		missionNamespace setVariable ["BLWK_numBuildingPositionsInfoMarker_temp",nil];
	};
}];

BLWK_customPlayAreaMapEH = addMissionEventHandler ["MapSingleClick", {
	params ["_units", "_pos", "_alt", "_shift"];

	// create center marker or move it
	if (isNil "BLWK_centerMarker_temp") then {
		BLWK_centerMarker_temp = createMarker ["centerMarker_temp",_pos];
		
		BLWK_centerMarker_temp setMarkerText "Bulwark";
		BLWK_centerMarker_temp setMarkerType "hd_dot";
		BLWK_centerMarker_temp setMarkerColor "ColorRed";
		//BLWK_centerMarker_temp setMarkerSize 0.5;
	} else {
		BLWK_centerMarker_temp setMarkerPos _pos;
	};
	
	// create radius marker or move it
	if (isNil "BLWK_areaMarker_temp") then {
		BLWK_areaMarker_temp = createMarker ["areaMarker_temp",_pos];

		BLWK_areaMarker_temp setMarkerShape "ELLIPSE";
		BLWK_areaMarker_temp setMarkerSize [BULWARK_RADIUS, BULWARK_RADIUS];
		BLWK_areaMarker_temp setMarkerColor "ColorWhite";
		BLWK_areaMarker_temp setMarkerAlpha 0.5;
	} else {
		BLWK_areaMarker_temp setMarkerPos _pos;
	};

	// create marker for number of buildings in location
	private _markerPosition_1 = _pos getPos [BULWARK_RADIUS + 25,80];// put the marker to the side
	if (isNil "BLWK_numBuildingsInfoMarker_temp") then {	
		BLWK_numBuildingsInfoMarker_temp = createMarker ["numBuildingsInfoMarker_temp",_markerPosition_1];

		BLWK_numBuildingsInfoMarker_temp setMarkerType "hd_dot";
		BLWK_numBuildingsInfoMarker_temp setMarkerSize [0.5,0.5];
		BLWK_numBuildingsInfoMarker_temp setMarkerColor "ColorBLUFOR";
		BLWK_numBuildingsInfoMarker_temp setMarkerAlpha 1;
	} else {
		BLWK_numBuildingsInfoMarker_temp setMarkerPos _markerPosition_1;
	};

	// create marker for number of loot spawn locations
	private _markerPosition_2 = _pos getPos [BULWARK_RADIUS + 25,100];// put the marker to the side
	if (isNil "BLWK_numBuildingPositionsInfoMarker_temp") then {
		BLWK_numBuildingPositionsInfoMarker_temp = createMarker ["numBuildingPositionsInfoMarker_temp",_markerPosition_2];

		BLWK_numBuildingPositionsInfoMarker_temp setMarkerType "hd_dot";
		BLWK_numBuildingPositionsInfoMarker_temp setMarkerSize [0.5,0.5];
		BLWK_numBuildingPositionsInfoMarker_temp setMarkerColor "ColorBLUFOR";
		BLWK_numBuildingPositionsInfoMarker_temp setMarkerAlpha 1;
	} else {
		BLWK_numBuildingPositionsInfoMarker_temp setMarkerPos _markerPosition_2;
	};

	// print out marker texts 
	private _buildingsInfo = [_pos] call bulc_fnc_checkBuildings;
	private _numberOfBuildings = _buildingsInfo select 0;
	BLWK_numBuildingsInfoMarker_temp setMarkerText (format ["There are %1 buildings in the area",_numberOfBuildings]);
	private _numberOfLootPositions = _buildingsInfo select 1;
	BLWK_numBuildingPositionsInfoMarker_temp setMarkerText (format ["There are %1 possible loot spawn locations",_numberOfLootPositions]);
	
	// inform the player of poor positions
	if (_numberOfLootPositions < 10 OR {_numberOfBuildings < 10}) then {
		hint "There is a very limited amount of buildings and/or loot spawns here. Maybe pick another location...";
	}; 
	
	// save for checking in bulc_fnc_checkLocation
	BLWK_missionAreaInfo_temp = [_pos,_numberOfBuildings,_numberOfLootPositions];
}];