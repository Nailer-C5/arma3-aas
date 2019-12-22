//      code type           ArmA script type
#define bool                //boolean
#define code                //code
#define int                 //number
#define array               //array
#define float               //number
#define string              //string

// more advanced types
#define obj
#define pos
#define control 
#define unit
#define grp	//just added this one
#define public              // public denotes variable is to be sent via "publicVariable" command
//NAILER[C5] - SET VERSION FOR C5 MODS
#define SHORT_VERSION "AAS Version 1.00"    // version string displayed at bottom of screen
#define MAX_PLAYERS_PER_SIDE 50		// total number of players per side
#define SPAWN_ELEVATION_DELTA 1
#define HUD_LEVEL_MINIMAL 0	    // HUD is off except for AAS counter levels and capture display
#define HUD_LEVEL_NOMAP   1		// the minimap is removed
#define HUD_LEVEL_FULL    2		// the full HUD is used
#define QUEUE_TIMER_EMPTY 200
#define BOOTHILLCAMP_RADIUS 50        // min distance from boot hill before taking damage
#define HINT_INTERVAL (60 + random 60)  // how often do hints come
#define CLASS_CHANGE_SETTLE_TIME 10   // seconds after which it is assumed that you have settled on your chosen class
#define WEST_PLAYER (playerSide == west)
#define EAST_PLAYER (playerSide == east)
#define WESTSIDE(X) (((toArray format["%1",(X)]) select 6) == 87)
#define EASTSIDE(X) (((toArray format["%1",(X)]) select 6) == 69)
#define FIRETEAM_BASE 100
#define FIRETEAM_NONE 100
#define SUPPORT_OFF   1     // no AI support at all (just player v player)
#define SUPPORT_LTE4  2     // AI support will switch on an auto ramp up to 30 per side whenever <=4 players playing
#define SUPPORT_LTE6  3     // AI support will switch on an auto ramp up to 30 per side whenever <=6 players playing
#define SUPPORT_LTE8  4     // AI support will switch on an auto ramp up to 30 per side whenever <=8 players playing
#define SUPPORT_LTE10 5     // AI support will switch on an auto ramp up to 30 per side whenever <=10 players playing
#define SUPPORT_LTE12 6     // AI support will switch on an auto ramp up to 30 per side whenever <=12 players playing
#define SUPPORT_EAST  7     // AI support for east will be permanently on (i.e. east soldiers spawn)
#define SUPPORT_WEST  8     // AI support for west will be permanently on
#define SUPPORT_ON    9     // AI support always on regardless of number of human players
//NAILER[C5] - ADD C5 RULES
#define SETUP_PUBLIC    1
#define SETUP_C5        2
#define SETUP_AUSARMA   3
#define SETUP_GBB       4
#define CL_NAME        0 // RULES_classList subarray elements
#define CL_WESTRIFLES  1
#define CL_EASTRIFLES  2
#define CL_WESTMAGS    3
#define CL_WESTWEPS    4
#define CL_EASTMAGS    5
#define CL_EASTWEPS    6
#define CL_CANREVIVE   7
#define CL_SPECIALISED 8
#define CL_WESTUNIFORMS  9
#define CL_EASTUNIFORMS  10
#define CL_WESTVESTS  11
#define CL_EASTVESTS  12
#define CL_WESTBACKBACKS  13
#define CL_EASTBACKBACKS  14
#define CL_BINOS  15
#define CL_GOGGLES 16
#define CL_WESTHEADGEARS 17
#define CL_EASTHEADGEARS 18
#define CL_WESTITEMS     19
#define CL_EASTITEMS     20
#define CL_PRIITEMS    21
#define WL_PRINTEDNAME 0
#define WL_NAME        1
#define WL_MAGLIST     2
#define CHOOSER_DURATION 12 // number of seconds for which chooser menu stays visible after a keypress
#define LOADOUT_SAVE   -2
#define LOADOUT_CUSTOM 100
#define TEAM_RED 1
#define TEAM_BLUE 2
#define TEAM_NEUTRAL 3
#define SPAWN_XRAY 1
#define SPAWN_QUEUE 2
#define SPAWN_TIMESLOT 3
#define SPAWN_ALWAYS 4
#define SPAWN_INSTANT 5
#define SPAWN_NEVER 6
#define ID 0
#define TEAM 1
#define SPAWNTYPE 2
#define LINK 3
#define SYNC 4
#define PROFILE 5
#define DEPEND 6
#define DEPQTY 7
#define AAS_CANCEL_RESPAWN_BUTTON 99
#define AAS_CANCEL_RESPAWN_ID 0
#define AAS_CANCEL_RESPAWN_LOCATION 1
#define BASE(X) (saas_baselist select (X))
#define BASEA(X,Y) ((saas_baselist select (X)) select (Y))
#define SETBASEA(X,Y,Z) ((saas_baselist select (X)) set [(Y),(Z)])
#define BASECACHE(X) (saas_basecache select (X))
#define BASECACHEA(X,Y) ((saas_basecache select (X)) select (Y))
#define SETBASECACHEA(X,Y,Z) ((saas_basecache select (X)) set [(Y),(Z)])
#define SRVBASECACHE(X) (srv_saas_basecache select (X))
#define SRVBASECACHEA(X,Y) ((srv_saas_basecache select (X)) select (Y))
#define SETSRVBASECACHEA(X,Y,Z) ((srv_saas_basecache select (X)) set [(Y),(Z)])
#define BASENAME(X) format["zone%1",X]	// get object name of the base marker
#define BASELETTER(X) (toString [(toArray( base_names select (X) ) select 0)])  // get short letter for this base
#define BASEID_REVIVE 201
#define CAPLEVEL      1
#define NUMBLUE       2
#define NUMRED        3
#define PREVCAPLEVEL  4
#define SQUEUE        5
#define STIMER        6
#define PLAYERPRESENT 7
#define CMD_PLAYERSPAWNSELECT 100
#define CMD_ADDSCORE          101
#define CMD_PLAYERTEAMSELECT  102
#define CMD_REVIVEPLAYER      103
#define DEBUG_LOG diag_log
#define QIDBASE 100			// the offset from 0 for player IDs in spawn queues
#define AAS_AINJPPNEMSTPSNONWRFLDB_STILL 0
#define AAS_DEADSTATE    1
#define QUOTEME(x) #x
#define AAS_DEFAULT_TIME_HOUR_MACRO(h) QUOTEME(Mission Default (h:XX))
#define AAS_DEFAULT_TIME_MINUTE_MACRO(m) QUOTEME(Mission Default (XX:m))
#define AAS_DEFAULT_WEATHER_MACRO(weather) QUOTEME(Mission Default (weather))
#define AAS_DEFAULT_FOG_MACRO(fog) QUOTEME(Mission Default (fog))
#include "mapname.hpp"
#include "ruleDefines.hpp"
#include "idcDefines.hpp"
#include "iddDefines.hpp"
