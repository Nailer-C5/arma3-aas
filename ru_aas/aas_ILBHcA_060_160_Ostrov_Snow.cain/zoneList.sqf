#include "tb_defines.hpp"

zoneList[] =
{
//ID and PROFILE = not used
//LINK = zones capturable after this one
//DEPEND = auto-capture/enable upon these zones being held
//DEPQTY = quantity of zones required for DEPEND i.e. can have only 2 of the 3 zones in DEPEND required
//SYNC = required zones for progression

//ID TEAM          	SPAWNTYPE       LINK         SYNC   PROFILE   DEPEND     DEPQTY  ZONE_DESC
{ 0, 0           , 0          ,    	{}         	, {}    , 1      , {}        , 0      },
	
{ 1, TEAM_RED, 		SPAWN_XRAY,     {2}      	, {}    , 1      , {12}      , 1    , "%Main base" },
{ 2, TEAM_RED, 		SPAWN_NEVER,    {1,3}		, {}    , 1      , {}      	 , 0    , "%Oshta" },

{ 3, TEAM_RED, 		SPAWN_NEVER,    {2,4}      	, {}   	, 1      , {}        , 0    , "%Ladva-Vetka" },
{ 4, TEAM_RED, 		SPAWN_NEVER,    {3,5}  		, {}    , 1      , {}        , 0    , "%Garages" },
{ 5, TEAM_NEUTRAL, 	SPAWN_NEVER,    {4,6}      	, {}  	, 1      , {}        , 0    , "%Jump" },
{ 6, TEAM_NEUTRAL, 	SPAWN_NEVER,    {5,7}      	, {}   	, 1      , {}        , 0    , "%Border" },
{ 7, TEAM_BLUE, 	SPAWN_NEVER,    {6,8,9}		, {}    , 1      , {}        , 0    , "%Barracks" },
{ 8, TEAM_BLUE, 	SPAWN_NEVER,    {7,10}      , {9}    , 1     , {}		 , 0    , "%Block station" },
{ 9, TEAM_BLUE, 	SPAWN_NEVER,  	{7,10}		, {8}    , 1     , {}    	 , 0    , "%Radar" },

{ 10,TEAM_BLUE, 	SPAWN_NEVER,  	{9,8}		, {}    , 1	     , {}     	 , 0    , "%Fuel base" },
{ 11,TEAM_BLUE, 	SPAWN_XRAY,  	{10}		, {}    , 1      , {}     	 , 0    , "%Maine base" },
{ 12,TEAM_RED, 	 	SPAWN_LARGEFB,  {}			, {}    , 1      , {}     	 , 0    , "%Bereg" },
	
};