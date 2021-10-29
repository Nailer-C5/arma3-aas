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
this forceAddUniform "U_B_GhillieSuit";
for "_i" from 1 to 3 do {this addItemToUniform "16Rnd_9x21_Mag";};
this addVest "V_TacVest_camo";
this addBackpack "B_Kitbag_mcamo";
this addHeadgear "H_HelmetB_camo";

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
this linkItem "Rangefinder";