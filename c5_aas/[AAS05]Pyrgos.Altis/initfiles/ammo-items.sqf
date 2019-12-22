// _nul = this execVM "initfiles\filename.sqf";

#include "..\globalDefines.hpp"


clearWeaponCargo _this;
clearMagazineCargo _this;
clearBackpackCargo _this;
clearItemCargo _this;
clearWeaponcargoglobal _this;
clearMagazinecargoglobal _this;
clearBackpackcargoglobal _this;
clearItemcargoglobal _this;


RULES_initialised = netObjNull;
waitUntil {RULES_initialised};
_this allowDamage RULES_allowDamageToAmmoCrates;
int _qlctr=0;
for "_qlctr" from 0 to ((count RULES_classList) - 1) do
{
	array _thisClass = RULES_classList select _qlctr;
	_this addAction [_thisClass select CL_NAME,"doQuickLoadout.sqf",[true, _qlctr],20-_qlctr,false,true,""];
};
//NAILER[C5] - REMOVE TEAM SELECT OPTION 
//_this addAction ["<t color='#ffcc66'>Team Select</t>", "actionMenuHandler.sqf",["SELECT_TEAM"],1000,false,true,""];
if (RULES_canCustomiseLoadout) then
{
 _this addAction ["<t color='#ff1111'>Save loadout</t>", "doQuickLoadout.sqf",[true,LOADOUT_SAVE]    ,3,false,true,""];
 _this addAction ["<t color='#0099ee'>Load Gear</t>", "fnc_loadGear.sqf",[true,LOADOUT_CUSTOM]  ,4,false,true,""];
//NAILER[C5] - WE DO NOT USE VAS - WE USE ASORGS
//_this addAction["<t color='#00cc00'>Virtual Ammobox</t>", "features\VAS\open.sqf"];};
 _this addAction["<t color='#111111'>Gear Select</t>", "execvm 'ASORGS\open.sqf'"]; 
};
if (RULES_canHealAtArmoury) then{
_this addAction ["<t color='#ff8822'>Heal Thyself</t>", "actionMenuHandler.sqf",["SELF_HEAL"],2,false,true,""];};
if (AAS_Params_GoToSquadLeader == 1) then{
	_this addAction ["<t color='#ffff22'>Teleport to Squad Leader</t>", "SquadLeaderTeleport.sqf"];};
  if (AAS_Params_GoToSquadLeader == 2) then{
 _this addAction ["<t color='#ffff22'>Parachute on Squad Leader</t>", "SquadLeaderParachute.sqf"];};
  if (AAS_Params_SASHALO == 1) then{
 _this addAction ["<t color='#ffcc66'>HALO</t>", "actionMenuHandler.sqf",["HALO"],900,false,true,""];};
//--------------------------------- Add the detailed crate contents -------------------
