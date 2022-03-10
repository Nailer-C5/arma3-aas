player enableFatigue false;

player setCustomAimCoef 0.5;
player setUnitRecoilCoefficient 0.65;

[player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;


[missionnamespace,"arsenalClosed", {
	[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
	titletext ["Arsenal loadout saved.", "PLAIN DOWN"];
	playSound "click";
}] call bis_fnc_addScriptedEventhandler;