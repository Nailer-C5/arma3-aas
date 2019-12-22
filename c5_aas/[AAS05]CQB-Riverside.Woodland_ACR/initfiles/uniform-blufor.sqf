comment "Exported from Arsenal by Spc.LittleJP-C5-A";

comment "Remove existing items";
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeAllWeapons this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_B_CombatUniform_mcam";
for "_i" from 1 to 3 do {this addItemToUniform "16Rnd_9x21_Mag";};
this addVest "V_TacVest_khk";
this addBackpack "B_AssaultPack_mcamo";
this addHeadgear "H_MilCap_mcamo";
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
this linkItem "NVGoggles";
this linkItem "Binocular";


