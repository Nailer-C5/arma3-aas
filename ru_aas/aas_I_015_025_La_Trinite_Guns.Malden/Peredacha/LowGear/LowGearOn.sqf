// by WINSE
_direction=
{
	private["_vel","_veh","_vdir","_dir"];
	
	_vel=_this select 0;
	_veh=_this select 1;
	
	_vdir=(_vel select 0) atan2 (_vel select 1);
	if (_vdir < 0) then {_vdir=_vdir+360};
	_dir=getDir _veh;
	if (_dir < 0) then {_dir=_dir+360};
	
	_vdir=_vdir-_dir;
	
	if (abs(_vdir) < 15) then {true} else {false};
};

_min=20;
_max=30;

RIPLOWGEARON = true;
_veh = vehicle player;
_veh removeAction RIP_LOWGEARACTON;
RIP_LOWGEARACTON = nil;
RIP_LOWGEARACTOFF = _veh addAction [localize "STR_RIP_LOWGEAROFF", "Peredacha\LowGear\LowGearOff.sqf", "", 0, true, true, "", "driver  _target == _this"];


while {(player != _veh) && (player==(driver _veh)) && (RIPLOWGEARON) && (canMove _veh)} do
{
	_speed=speed _veh;
	_vel=velocity _veh;	
	if (_speed < _min) then
	{
		if ((inputAction "MoveForward") == 1) then
		{
			if (_speed > 0) then
			{			
				if ([_vel,_veh] call _direction) then
				{
					_vel=[(_vel select 0)*1.3,(_vel select 1)*1.3,(_vel select 2)*1.3];
					_veh setVelocity _vel;
				};
			};		
		};		
	}
	else
	{	
		if (_speed > _max) then
		{		
			if ([_vel,_veh] call _direction) then
			{
				_vel=[(_vel select 0)*0.7,(_vel select 1)*0.7,(_vel select 2)*0.7];
				_veh setVelocity _vel;
			};
		};
	};
	sleep 0.1;
};

RIPLOWGEARON = false;
_veh removeAction RIP_LOWGEARACTOFF;
RIP_LOWGEARACTOFF = nil;
