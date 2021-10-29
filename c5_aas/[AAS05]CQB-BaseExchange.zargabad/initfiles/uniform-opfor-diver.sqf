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
this forceAddUniform "U_O_Wetsuit";
for "_i" from 1 to 3 do {this addItemToUniform "20Rnd_556x45_UW_mag";};
for "_i" from 1 to 3 do {this addItemToUniform "16Rnd_9x21_Mag";};
this addVest "V_RebreatherIR";
this addGoggles "G_O_Diving";

comment "Add weapons";
this addWeapon "arifle_SDAR_F";
this addWeapon "hgun_Rook40_F";
this addHandgunItem "muzzle_snds_L";

comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "Binocular";
