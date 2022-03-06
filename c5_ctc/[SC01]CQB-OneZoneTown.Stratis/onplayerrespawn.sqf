player enableFatigue false;

// removeAllWeapons player;
// removeGoggles player;
// removeHeadgear player;
// removeVest player;
// removeUniform player;
// removeAllAssignedItems player;
// clearAllItemsFromBackpack player;
// removeBackpack player;
[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;


[missionnamespace,"arsenalClosed", {
	[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
	titletext ["Arsenal loadout saved.", "PLAIN DOWN"];
	playSound "click";
}] call bis_fnc_addScriptedEventhandler;