#include "globalDefines.hpp"
private ["_killed","_killer","_sideKilled","_sideKiller"];
_killed = _this select 0;
_killer = _this select 1;
_sideKilled = _killed getVariable "AAS_Side";
_sideKiller = _killer getVariable "AAS_Side";

//Default
if ((!(isNull _killer)) && (isPlayer _killer) && (player != _killer) && (_sideKiller == _sideKilled)) then
{
	private["_nameKiller","_nameKilled"];
	_nameKiller = _killer call AAS_fnc_cGetName;
	_nameKilled = _killed call AAS_fnc_cGetName;
	[playerSide,"HQ"] commandChat (format [ Localize "STR_AAS_punished_for_teamkilling",_nameKiller,_nameKilled]);
	array AAS_PublicTeamkillPunishmentInfoMessage = [_nameKiller,_nameKilled];
	publicVariable "AAS_PublicTeamkillPunishmentInfoMessage";	
	
	publicTK_Score = [_killer];
	publicVariable "publicTK_Score";	
};