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
// saas_baselist
// saas_basecache
// srv_saas_basecache

#include "globalDefines.hpp"

saas_baselist =
[
//ID TEAM          SPAWNTYPE    LINK       SYNC   PROFILE   DEPEND   DEPQTY
[ 0, 0           , 0          , []       , []    , 1      , []       , 0    ],
[ 1, TEAM_BLUE   , SPAWN_XRAY , [2]      , []    , 1      , []       , 0    ],
[ 2, TEAM_BLUE   , SPAWN_QUEUE, [1,3]    , []    , 1      , []       , 0    ],
[ 3, TEAM_BLUE   , SPAWN_QUEUE, [2,4]    , []    , 1      , []       , 0    ],
[ 4, TEAM_BLUE   , SPAWN_QUEUE, [3,5]    , []    , 1      , []       , 0    ],
[ 5, TEAM_BLUE   , SPAWN_QUEUE, [4,6]    , []    , 1      , []       , 0    ],
[ 6, TEAM_NEUTRAL, SPAWN_QUEUE, [5,7]    , []    , 1      , []       , 0    ],
[ 7, TEAM_RED    , SPAWN_QUEUE, [6,8]    , []    , 1      , []       , 0    ],
[ 8, TEAM_RED    , SPAWN_QUEUE, [7,9]    , []    , 1      , []       , 0    ],
[ 9, TEAM_RED    , SPAWN_QUEUE, [8,10]   , []    , 1      , []       , 0    ],
[ 10,TEAM_RED    , SPAWN_QUEUE, [9,11]   , []    , 1      , []       , 0    ],
[ 11,TEAM_RED    , SPAWN_XRAY , [10]     , []    , 1      , []       , 0    ]
];
saas_basecache =
[
// ID  CAPLEVEL   NUMBLUE   NUMRED  PREVCAPLEVEL   SQUEUE  STIMER  PLAYERPRESENT
[  0 , 0        , 0       , 0      , 100         , []    , 0     , false    ],
[  1 , 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  2 , 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  3 , 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  4 , 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  5 , 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  6 , 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  7 , 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  8 , 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  9 , 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  10, 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  11, 100      , 0       , 0      , 100         , []    , 0     , false    ]
];
srv_saas_basecache =
[
// ID  CAPLEVEL   NUMBLUE   NUMRED  PREVCAPLEVEL   SQUEUE  STIMER  PLAYERPRESENT
[  0 , 0        , 0       , 0      , 100         , []    , 0     , false   ],
[  1 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  2 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  3 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  4 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  5 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  6 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  7 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  8 , 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  9 , 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  10, 100      , 0       , 0      , 100         , []    , 0     , false    ],
[  11, 100      , 0       , 0      , 100         , []    , 0     , false    ]
];
