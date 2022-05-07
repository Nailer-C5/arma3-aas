/*/
File: fn_giveKillPoints
Description: transfer of points.
Domain: Client
/*/
private _amount = ctrlText 5487;
ctrlShow[5485,false];
if ((lbCurSel 5481) isEqualTo -1) exitWith {hint "You haven't selected a player.";ctrlShow[5485,true];};
private _unit = lbdata [5481,lbCurSel 5481];
_unit = call compile format ["%1",_unit];
diag_log format["%1",_unit];
if (isNil "_unit") exitWith {hint "Error 13.";ctrlShow[5485,true];};
if (_unit == player) exitWith {hint "You can't give yourself money, dumbass.";ctrlShow[5485,true];};
if (isNull _unit) exitWith {hint "Error 15.";ctrlShow[5485,true];};

private _killponits = player getVariable "killPoints";
if (parseNumber(_amount) <= 0) exitWith {hint "You have to enter a value.";ctrlShow[5485,true];};
if (parseNumber(_amount) > _killponits) exitWith {hint "You ain't that rich, try again.";ctrlShow[5485,true];};
if (isNull _unit) exitWith {hint "Error 20.";ctrlShow[5485,true];};
if (isNil "_unit") exitWith {ctrlShow[5485,true]; hint "That player is out of range";};

hint format["You have sent %1 Kill Points to %2 .", (parseNumber(_amount)),name _unit];
player setVariable ["killPoints", _killponits - (parseNumber(_amount)),true];

[_unit,_amount,player] remoteExecCall ["bulc_fnc_receive",_unit];
[] remoteExec ["bulc_fnc_updateHud", player];
