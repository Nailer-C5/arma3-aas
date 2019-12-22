// File Description
// Name           : initSAAS.sqf
// Called by      : init thread
// Referenced by  : init.sqf
// Client/Server  : both
// Function area  : game mechanics
//
// Description
// This function initialises the super-Advance and Secure (SAAS) system,
// setting up initial variable values etc
//

#include "globalDefines.hpp"

// SPLIT X2 AAS BASELIST
saas_baselist =
[
//	ID	TEAM		SPAWNTYPE	LINK		SYNC	PROFILE
	[0,	0,		0,		[],		[],	1],
	[1,	TEAM_BLUE,	SPAWN_XRAY,	[2],		[],	1],
	[2,	TEAM_BLUE,	SPAWN_QUEUE,	[1,3],		[],	1],
	[3,	TEAM_BLUE,	SPAWN_QUEUE,	[2,4],		[],	1],
	[4,	TEAM_NEUTRAL,	SPAWN_QUEUE,	[3,5],		[],	1],
	[5,	TEAM_RED,	SPAWN_QUEUE,	[4,6],		[],	1],
	[6,	TEAM_RED,	SPAWN_QUEUE,	[5,7],		[],	1],
	[7,	TEAM_RED,	SPAWN_XRAY,	[6],		[],	1]
];
saas_basecache =
[
//	ID	CAPLEVEL	NUMBLUE	NUMRED	PREVCAPLEVEL	SQUEUE	STIMER	PLAYERPRESENT
	[0,	0,		0,	0,	100,		[],	0,	false],
	[1,	100,		0,	0,	100,		[],	0,	false],
	[2,	100,		0,	0,	100,		[],	0,	false],
	[3,	100,		0,	0,	100,		[],	0,	false],
	[4,	100,		0,	0,	100,		[],	0,	false],
	[5,	100,		0,	0,	100,		[],	0,	false],
	[6,	100,		0,	0,	100,		[],	0,	false],
	[7,	100,		0,	0,	100,		[],	0,	false]
];
srv_saas_basecache =
[
//	ID	CAPLEVEL	NUMBLUE	NUMRED	PREVCAPLEVEL	SQUEUE	STIMER	PLAYERPRESENT
	[0,	0,		0,	0,	100,		[],	0,	false],
	[1,	100,		0,	0,	100,		[],	0,	false],
	[2,	100,		0,	0,	100,		[],	0,	false],
	[3,	100,		0,	0,	100,		[],	0,	false],
	[4,	100,		0,	0,	100,		[],	0,	false],
	[5,	100,		0,	0,	100,		[],	0,	false],
	[6,	100,		0,	0,	100,		[],	0,	false],
	[7,	100,		0,	0,	100,		[],	0,	false]
];