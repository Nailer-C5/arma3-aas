// TAKE NOTE: most comments have been stripped from this file to reduce the overall
// map download size. Do not attempt to understand these raw files.
#include "globalDefines.hpp"
saas_baselist =
[
//ID TEAM          SPAWNTYPE    LINK       SYNC   PROFILE   DEPEND   DEPQTY
[ 0, 0           , 0          , []       , []    , 1      , []       , 0    ],
[ 1, TEAM_BLUE   , SPAWN_XRAY , [2,3]    , []    , 1      , []       , 0    ],
[ 2, TEAM_BLUE   , SPAWN_QUEUE, [1,4]    , [3]   , 1      , []       , 0    ],
[ 3, TEAM_BLUE   , SPAWN_QUEUE, [1,4]    , [2]   , 1      , []       , 0    ],
[ 4, TEAM_NEUTRAL   , SPAWN_QUEUE, [2,3,5,6]  , []    , 1    , []       , 0    ],
[ 5, TEAM_RED    , SPAWN_QUEUE, [4,7]  , [6]    , 1     , []       , 0    ],
[ 6, TEAM_RED    , SPAWN_QUEUE, [4,7]    , [5]   , 1      , []       , 0    ],
[ 7, TEAM_RED    , SPAWN_XRAY , [5,6]    , []    , 1      , []       , 0    ]
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
[  7 , 100      , 0       , 0      , 100         , []    , 0     , false    ]
];
srv_saas_basecache =
[
[  0 , 0        , 0       , 0      , 100         , []    , 0     , false   ],
[  1 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  2 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  3 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  4 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  5 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  6 , 100      , 0       , 0      , 100         , []    , 0     , false   ],
[  7 , 100      , 0       , 0      , 100         , []    , 0     , false   ]
];
