
player enableFatigue true;
player setFatigue 0.4;
player setCustomAimCoef 0.5;
player setUnitRecoilCoefficient 0.65;


[] spawn { 
  while {true} do {
    if (getFatigue player > 0.4) then { player setFatigue 0.4; };
    sleep 0.1;
  };
};


[] spawn {
  while {true} do {
    if (side player == west) then { diwako_dui_special_track = missionNamespace getVariable "west_diwako_dui_special_track"; };
	if (side player == east) then { diwako_dui_special_track = missionNamespace getVariable "east_diwako_dui_special_track"; };
    sleep 1;
  };
};