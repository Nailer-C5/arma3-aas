attached = 0;
_truck = vehicle player;
_arty = nearestObject [_truck, "StaticCannon"];
_truck removeAction detachActionId;
detach _arty;
vehicle player vehicleChat "Arty detached";
if(true) exitWith {}; 