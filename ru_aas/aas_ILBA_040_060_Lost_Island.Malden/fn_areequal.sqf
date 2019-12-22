scriptName "Functions\variables\fn_areEqual.sqf";
private ["_i","_r","_d1","_d2","_d1t","_d2t"];
_r = true;
for[{_i=1},{_i < (count _this) && _r},{_i=_i+1}] do
{
	_d1 = _this select (_i-1);
	_d2 = _this select _i;
	if(isnil "_d1") then {_d1t = "UNDEF"} else {_d1t = typename _d1};
	if(isnil "_d2") then {_d2t = "UNDEF"} else {_d2t = typename _d2};
	if(_d1t != _d2t) then
	{
		_r=false;
	}
	else
	{
		switch _d1t do
		{
			case "ARRAY":
			{
				private ["_c","_j"];
				_c = count _d1;
				if(_c!=count _d2)then
				{
					_r=false;
				}
				else
				{
					_j=0;
					while{_j<_c && _r}do
					{
						_r = [_d1 select _j, _d2 select _j] call BIS_fnc_areEqual;
						_j = _j + 1;
					};
				};
			};
			case "BOOL":  {_r = (str _d1) == (str _d2)};
			case (typename {}):  {_r = (str _d1) == (str _d2)};
			case "SCRIPT":{if(scriptdone _d1) then {_r = false} else {_r = (str _d1) == (str _d2)}};
			case "UNDEF": {_r = true};
			case "OBJECT":  {if(isnull _d1) then {_r = isnull _d2} else {_r = _d1 == _d2}};
			case "GROUP":   {if(isnull _d1) then {_r = isnull _d2} else {_r = _d1 == _d2}};
			case "CONTROL": {if(isnull _d1) then {_r = isnull _d2} else {_r = _d1 == _d2}};
			case "DISPLAY": {if(isnull _d1) then {_r = isnull _d2} else {_r = _d1 == _d2}};
			case default {_r = _d1 == _d2};
		};
	};
};
_r
