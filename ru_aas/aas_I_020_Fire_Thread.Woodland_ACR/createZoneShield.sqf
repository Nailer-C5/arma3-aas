_position = _this select 0;
_zone= "ProtectionZone_Invisible_F";//ProtectionZone_F or ProtectionZone_Invisible_F
_zone createVehicleLocal (_position); 

_zone createVehicleLocal ([(_position select 0)+30,(_position select 1),_position select 2]);
_zone createVehicleLocal ([(_position select 0)-30,(_position select 1),_position select 2]);

_zone createVehicleLocal ([(_position select 0),(_position select 1)+30,_position select 2]);
_zone createVehicleLocal ([(_position select 0),(_position select 1)-30,_position select 2]);

_zone createVehicleLocal ([(_position select 0)+30,(_position select 1)+30,_position select 2]);
_zone createVehicleLocal ([(_position select 0)-30,(_position select 1)-30,_position select 2]);

_zone createVehicleLocal ([(_position select 0)-30,(_position select 1)+30,_position select 2]);
_zone createVehicleLocal ([(_position select 0)+30,(_position select 1)-30,_position select 2]);