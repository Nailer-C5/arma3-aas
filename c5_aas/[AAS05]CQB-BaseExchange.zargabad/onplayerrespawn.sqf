
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
 