#include "globalDefines.hpp"
#define ASSERT(X) if( !(X) ) then { diag_log "ERR Assertion Failed." }
#define ASSERT(X,Y) if( !(X) ) then { diag_log Y; }
string _in = "helloworld";
string _out = _in call cmdHashString; 
ASSERT( _out == "" , "cmdHashString test vector failed" );
call cmdInitSAAS;
ASSERT( count saas_baselist == count saas_basecache , "Baselist and cache wrong lengths" );
ASSERT( count saas_baselist == count srv_saas_basecache , "Server baselist and cache wrong lengths" );
int _ict=0;
for "_ict" from 1 to ((count saas_baselist) - 1) do
    {
    ASSERT( (saas_baselist select TEAM) in [ TEAM_RED , TEAM_BLUE , TEAM_NEUTRAL ] , "Invalid initial team" );
    ASSERT( (saas_baselist select SPAWNTYPE) in [ SPAWN_XRAY , SPAWN_QUEUE ] , "Invalid spawn type" );
    };
string _oldv1 = v1;
call cmdPackStateSAAS; 
ASSERT( v1 != _oldv1, "v1 not updating correctly" );
ASSERT( count v1 == ((count saas_baselist)*3 + 1) , "Cmd pack state packing incorrectly" );
call cmdPlayerTransmitCmd;
ASSERT( XXXXX == [ xmitseq + 1 , CMD_NOOP , 123 ] , "Player transmit command not working" );
call cmdRefreshRespawnButtons;
call cmdPRNG;
call cmdUnpackStateSAAS; 
call cmdCaptureBase;
call cmdRecalcDependentBases;
call cmdRecalcBattleFronts; 
call cmdUpdatePlayerLists; 

