private _missionAreaInfo = missionNamespace getVariable ["BLWK_missionAreaInfo_temp",[]];
// if no selection has been made
if (_missionAreaInfo isEqualTo []) exitWith {
	hint "You neeed to click on the map to select a mission area";
	false
};

_missionAreaInfo params ["","_numBuildings","_numLootPositions"];
if (_numBuildings isEqualTo 0) exitWith {
	hint parseText "<t color='#ff0000'>You need an area with buildings to spawn stuff</t>"; 
	false
};
// some of the mandatory items like the weapon box, loot revealer and satellite dish require unique positions
if (_numLootPositions < 6) exitWith {
	hint parseText "<t color='#ff0000'>You need at least SIX positions to spawn loot</t>"; 
	false
};
 
true