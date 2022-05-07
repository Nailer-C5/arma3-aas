/*/
File: fn_level
Author : Deathman
Description: 
Domain: Client
/*/
//@TODO review function
_levels = [0, 3, 6, 9, 11, 14, 17, 20, 23, 26, 29, 32, 35, 38, 31, 34, 37, 40, 43, 46, 49, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 114, 117, 120];
_kills = player getVariable ["AI_kills",0];

_levelOld = player getVariable ["Level",0];
_level = _levelOld;

{
  if (_kills >= _x) then {
    _level = _forEachIndex;
  };
} forEach _levels;

if (_levelOld != _level) then {
    player setVariable ["Level", _level];
	RealLevel = _level;
    hint parseText format["<br/><t size='1.25' font='PuristaSemiBold' color='#ffa000'>You have Levelled Up! </t><t size='1.25' font='PuristaSemiBold' color='#8e24aa'>Level %1.</t>",_level];
    //@TODO change levelup sound
	//playsound "LevelUP";
};
