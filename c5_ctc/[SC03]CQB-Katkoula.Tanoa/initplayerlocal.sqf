player enableFatigue false;
player setCustomAimCoef 0.5;
player setUnitRecoilCoefficient 0.65;

[] spawn { 
  while {true} do {
    if (getFatigue player > 0.4) then { player setFatigue 0.4; };
    sleep 0.1; player};
  };




[missionnamespace,"arsenalClosed", {
	[player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;
	titletext ["Arsenal loadout saved.", "PLAIN DOWN"];
	playSound "click";}] call bis_fnc_addScriptedEventhandler;