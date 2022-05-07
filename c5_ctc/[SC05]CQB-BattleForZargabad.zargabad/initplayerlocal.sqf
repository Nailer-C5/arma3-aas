player enableFatigue true;
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

player addEventHandler ["getInMan",{
  params ["_plyr","","_veh"];
  [_plyr,_veh] spawn {
    params ["_plyr","_veh"];
    waitUntil {uiSleep 180; !alive _plyr && count crew _veh <= 1 || (_veh != objectParent _plyr && _veh distance2D _plyr > 120 &&  ((crew _veh) isequalto []))};
    deleteVehicle _veh
  }
}];




Call
{
		while {(true)} do
		{ 

			if (cameraview == "EXTERNAL") then
				{
				if((driver (vehicle player) != player) || ((vehicle player) == player)) then {player switchCamera "Internal"};  
				sleep 0.1;
				};
		};


};



