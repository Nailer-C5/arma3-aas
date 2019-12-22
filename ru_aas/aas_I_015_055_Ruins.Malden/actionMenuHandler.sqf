#include "globalDefines.hpp"
string _actionType   = (_this select 3) select 0;		// this is the name of the action triggered
int _selectedTeam = (_this select 3) select 1;   // when "SET_TEAM", this is team id
int _toReviveQID  = (_this select 3) select 1;   // when "REVIVE", this is player QID to revive
if( _actionType == "SELF_HEAL" ) then
	{
	player setDammage 0;
	hint localize "STR_AAS_Healed_to_full_health";
	};
if( _actionType == "SELECT_TEAM" ) then
	{
		 if(!classChangeLocked && count ((getPos player) nearObjects ["rhs_weapon_crate",RULES_armouryUseRange]) > 0 ) then
	    {
		 showChooserTime=CHOOSER_DURATION;	
       if (AAS_Params_RecruitAIStatusDialog == 1 && AAS_Params_AISupportMode == SUPPORT_LTE4 or AAS_Params_AISupportMode == SUPPORT_LTE6 or AAS_Params_AISupportMode == SUPPORT_LTE8 or AAS_Params_AISupportMode == SUPPORT_LTE10 or AAS_Params_AISupportMode == SUPPORT_LTE12 or AAS_Params_AISupportMode == SUPPORT_EAST or AAS_Params_AISupportMode == SUPPORT_WEST or AAS_Params_AISupportMode == SUPPORT_ON) then 
        {
	squad_mgmt_action = [objNull, objNull, 0, []] execVM "features\DOM_squad\open_dialog.sqf";	      
	[0,0,0,[true,playerClass]] execVM "doQuickLoadout.sqf";
	    }
	      else
	    {      
	squad_mgmt_action = [objNull, objNull, 0, []] execVM "features\DOM_squad\open_dialog.sqf";	      
		[0,0,0,[true,playerClass]] execVM "doQuickLoadout.sqf";
	    }; 
	    }
		else
			{
			hint format[localize "STR_AAS_Please_Wait",RULES_armouryUseRange];
	lastChooserPos = getPos player;
	showChooserTime=CHOOSER_DURATION;
		};
		_return = true;
	};		
if( _actionType == "SET_TEAM" ) then
    {
    array _xmitCmd = [ CMD_PLAYERTEAMSELECT , _selectedTeam ];				
	_xmitCmd call cmdPlayerTransmitCmd;		 
    hint format[localize "STR_AAS_Applied_to_join_team",my_fireteams select (_selectedTeam-FIRETEAM_BASE)];
    };
if( _actionType == "RESPAWN" ) then
	{
	spawnPrecursorMessage = localize "STR_AAS_Choose_your_spawn_point";
	activateSpawnMenu=true;
	hint localize "STR_AAS_Respawning";
	};	
if( _actionType == "REVIVE" ) then
	{
	if( playerCanRevive or RULES_everyoneCanRevive ) then
		{
		array _xmitCmd = [ CMD_REVIVEPLAYER , _toReviveQID ];				
		hint localize "STR_AAS_attempting_to_revive";
			player playMove "AinvPknlMstpSlayWrflDnon_medic";
		sleep 1;		
		_xmitCmd call cmdPlayerTransmitCmd;				 
		sleep 2;		
		_xmitCmd call cmdPlayerTransmitCmd;				 
		sleep 2;		
		_xmitCmd call cmdPlayerTransmitCmd;				 
		sleep 2;				
		}
	else
		{
		hint localize "STR_AAS_cannot_revive_class";
		};
	};	