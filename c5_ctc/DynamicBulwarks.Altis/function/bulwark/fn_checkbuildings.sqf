params ["_positionToCheck"];

private _buildingsThatMeetCriteria = (_positionToCheck nearObjects ["House", BULWARK_RADIUS]) select {
	// check that the building has cfg building positions to spawn stuff
	!((_x buildingPos -1) isEqualTo []) AND 
	// And check that it doesn't have water directly beneath it (avoid being too far out on a dock)
	{!(	surfaceIsWater (((lineIntersectsSurfaces [AGLToASL(_x buildingPos 0),AGLToASL(_x buildingPos 0) vectorDiff [0,0,20]]) select 0) select 0))}
};	
private _numberOfBuildings = count _buildingsThatMeetCriteria;

// if no buildings are found
if (_numberOfBuildings isEqualTo 0) then {
	[0,0] // return no buildings and no positions to spawn loot in area
} else {
	private _numBuildingPositions = 0;
	_buildingsThatMeetCriteria apply {
		_numBuildingPositions = _numBuildingPositions + (count (_x buildingPos -1));
	};
	// return the number of buildings an loot spawn locations
	[_numberOfBuildings,_numBuildingPositions]
};