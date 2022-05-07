/*/
File: fn_receivePoints
Description:
Domain: Client
/*/
params [["_unit",objNull,[objNull]],["_val","",[""]],["_from",objNull,[objNull]]];

if (isNull _unit || isNull _from || _val isEqualTo "") exitWith {};
if !(player isEqualTo _unit) exitWith {};
if (_unit == _from) exitWith {};

private _killpointsunit = player getVariable "killPoints";
//@TODO add hint for receiving player
hint format["%1 has given you %2 Kill Points.",name _from,[(parseNumber (_val))] call bulc_fnc_numberText];
player setVariable ["killPoints", _killpointsunit + parseNumber(_val),true];
[] remoteExec ["bulc_fnc_updateHud", player];

ctrlShow[5485,true];