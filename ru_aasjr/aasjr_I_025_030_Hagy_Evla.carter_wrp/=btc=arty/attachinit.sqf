act = 0;
attached = 0;
while {true} do {
  _truck = vehicle player;
  _tpos = _truck modeltoworld [0,-4,0];
  _tposx = _tpos select 0;
  _tposy = _tpos select 1;
  _arty = nearestObject [_truck, "StaticCannon"];
  _pos = _arty modeltoworld [0,-1,0];
  _posx = _pos select 0;
  _posy = _pos select 1;
  if ((attached == 0) && (act == 0) && _truck isKindOf "Truck_F" && driver _truck == player && ((_tposy <= (_posy)) && (_tposy >= (_posy - 2)))) then 
  {
  attachActionId = _truck addAction ["Attach arty","=BTC=Arty\attachArty.sqf"];
  act = 1;
  }
  else
  {
  if (_truck isKindOf "Truck_F") then {
  if ((act == 1) && (!(driver _truck == player) or (_truck distance _arty > 12))) then
    {
	_truck removeAction attachActionId;
	act = 0;
	};
	};
  };
  sleep 0.1;
};

if(true) exitWith {}; 