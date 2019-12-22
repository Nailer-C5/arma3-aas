private ["_arty", "_azimuth", "_elevation", "_x", "_y", "_z"];

_arty = _this select 0;
_x = _arty select 0;
_y = _arty select 1;
_z = _arty select 2;

_azimuth = _x atan2 _y;
if (_azimuth < 0) then {_azimuth = _azimuth + 360;};
_elevation = _z atan2 sqrt(_x^2 + _y^2);

[_azimuth, _elevation]