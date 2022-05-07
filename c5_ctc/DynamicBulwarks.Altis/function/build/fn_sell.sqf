_object = _this select 0;
_player = _this select 1;

_shopPrice = _object getVariable ["shopPrice", 0];

//refund to player would go here

deleteVehicle (_object);