/*/
File: fn_scoreTransfer
Author: Deathman : modified by rory-dev
Description:
Domain: Client
/*/
private["_display","_units"];
if (!alive player || dialog) exitWith {};
createDialog "transferPoints";
disableSerialization;

_display = findDisplay 5480;
_units = _display displayCtrl 5481;

lbClear _units;

{
        _units lbAdd format ["%1", name _x];
        _units lbSetData [(lbSize _units)-1,str(_x)];
} forEach playableUnits;

lbSetCurSel [5481,0];
