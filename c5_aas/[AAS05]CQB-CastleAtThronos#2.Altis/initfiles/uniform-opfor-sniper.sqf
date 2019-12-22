comment "Exported from Arsenal by Spc.LittleJP-C5-A";

comment "Remove existing items";
removeAllItems this;
removeAllWeapons this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

comment "Add containers";
this forceAddUniform "U_O_GhillieSuit";
this addVest "V_TacVest_brn";
this addBackpack "B_Kitbag_Ocamo";
this addHeadgear "H_HelmetO_ocamo";

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