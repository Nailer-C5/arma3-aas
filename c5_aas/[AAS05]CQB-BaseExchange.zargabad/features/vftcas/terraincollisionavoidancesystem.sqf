private ["_vehicle","_lowLimit","_tfrscan","_tfrlevel","_direction","_speed","_height","_speedLimit"];
_vehicle = _this;
_lowLimit = 35;
_speedLimit = 30;
while {((!(isNull (driver _vehicle))) && (!(isPlayer (driver _vehicle))) && (alive (driver _vehicle)))} do
{
	while {(abs(speed _vehicle) <= _speedLimit) && (canMove _vehicle) && (!(isPlayer (driver _vehicle) || (isNull (driver _vehicle)) || (!(alive (driver _vehicle)))))} do
	{
		sleep 1;
	};
	_tfrscan = "Can_small" createVehicle (getPos _vehicle);
	while {(abs(speed _vehicle) > _speedLimit)} do
	{
		_pilot = driver _vehicle;
		if ((!(canMove _vehicle)) || (isPlayer _pilot) || (isNull _pilot) || (!(alive _pilot))) exitWith {};
		sleep 0.1;
		_height = (getPosATL _vehicle) select 2;
		_direction = getDir _vehicle;
		_speed = speed _vehicle;
		_tfrscan setPos [(getPos _vehicle select 0) + (sin _direction * _speed),(getPos _vehicle select 1) + (cos _direction * _speed),_height];
		_tfrlevel = (getPosATL _tfrscan) select 2;
		if (_tfrlevel < _lowLimit) then
		{
			_vehicle setVelocity
			[
				(velocity _vehicle select 0) * 1.01,
				(velocity _vehicle select 1) * 1.01,
				(velocity _vehicle select 2) + (_lowLimit - _tfrlevel)
			];
		};
	};
	deleteVehicle _tfrscan;
};