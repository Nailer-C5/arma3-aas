comment "Exported from Arsenal by Spc.LittleJP-C5-A";

comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_CombatUniform_mcam";
this addVest "V_TacVest_khk";
this addBackpack "B_AssaultPack_mcamo";
this addHeadgear "H_HelmetB_camo";
this addGoggles "G_Bandanna_khk";



comment "Add weapons";
this addWeapon "arifle_TRG20_F";
this addPrimaryWeaponItem "acc_flashlight";
this addPrimaryWeaponItem "optic_Hamr";
this addWeapon "hgun_P07_F";


comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "Binocular";
this linkItem "NVGoggles";
