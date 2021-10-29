// _nul = this execVM "initfiles\filename.sqf";
if (! isServer) exitWith {};
_this allowDamage false;

while {alive _this} do
{

// Remove the stock items from the crate
clearWeaponcargoglobal _this;
clearMagazinecargoglobal _this;
clearBackpackcargoglobal _this;
clearItemcargoglobal _this;

//Uniforms

_this addWeaponcargoglobal ["U_B_CombatUniform_mcam", 100];
_this addWeaponcargoglobal ["U_B_CombatUniform_mcam_tshirt", 100];
_this addWeaponcargoglobal ["U_B_CombatUniform_mcam_vest", 100];
_this addWeaponcargoglobal ["U_B_GhillieSuit", 100];
_this addWeaponcargoglobal ["U_B_HeliPilotCoveralls", 100];
_this addWeaponcargoglobal ["U_B_Wetsuit", 100];
_this addWeaponcargoglobal ["U_B_SpecopsUniform_sgg", 100];
_this addWeaponcargoglobal ["U_B_PilotCoveralls", 100];
_this addWeaponcargoglobal ["U_B_FullGhillie_lsh", 100];
_this addWeaponcargoglobal ["U_B_FullGhillie_sard", 100];
_this addWeaponcargoglobal ["U_B_FullGhillie_ard", 100];

//Helmets

_this addWeaponcargoglobal ["H_HelmetB", 100];
_this addWeaponcargoglobal ["H_HelmetB_camo", 100];
_this addWeaponcargoglobal ["H_HelmetB__plain_camo", 100];
_this addWeaponcargoglobal ["H_HelmetSpecB", 100];
_this addWeaponcargoglobal ["H_HelmetSpecB_paint1", 100];
_this addWeaponcargoglobal ["H_HelmetSpecB_paint2", 100];
_this addWeaponcargoglobal ["H_HelmetSpecB_blk", 100];
_this addWeaponcargoglobal ["H_HelmetCrew_B", 100];
_this addWeaponcargoglobal ["H_PilotHelmetFighter_B", 100];
_this addWeaponcargoglobal ["H_PilotHelmet_heli_B", 100];
_this addWeaponcargoglobal ["H_HelmetB_paint", 100];
_this addWeaponcargoglobal ["H_HelmetB_light", 100];
_this addWeaponcargoglobal ["H_Booniehat_mcamo", 100];

