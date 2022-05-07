// This file holds the menu items to add vehicles to the game kiosk, which at the time of writing this is Guba, to use, copy the line you want into populateammocrate.sqf at the bottom.


_vec addAction["Spawn a Buggy HMG (LIMIT 3)", "mopit_vehicles\SpawnBuggyHMG.sqf", nil, 6, true, true, "", "true", 2];              

_vec addAction["Spawn an APC (LIMIT 1)", "mopit_vehicles\SpawnAPC.sqf", nil, 6, true, true, "", "true", 2];					

_vec addAction["Spawn a Transport Helicopter (LIMIT 2)", "mopit_vehicles\SpawnTHelicopter.sqf", nil, 6, true, true, "", "true", 2];

_vec addAction["Spawn an Attack Helicopter (LIMIT 1)", "mopit_vehicles\SpawnAHelipcopter.sqf", nil, 6, true, true, "", "true", 2];

_vec addAction["Spawn a UAV (LIMIT1)", "mopit_vehicles\SpawnUAV.sqf", nil, 6, true, true, "", "true", 2];
