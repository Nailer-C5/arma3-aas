disableSerialization;
_listFormat = "%1 - %2";

createDialog "dialog_build";
waitUntil {!isNull (findDisplay 9999);};

_ctrl = (findDisplay 9999) displayCtrl 1500;
[_ctrl, BULWARK_BUILDITEMS] call bulc_fnc_populateBuildTree;

_ctrl = (findDisplay 9999) displayCtrl 1501;
SUPPORTMENU = missionNamespace getVariable "SUPPORTMENU";
if (SUPPORTMENU) then {
  {
      _ctrl lbAdd format [_listFormat, _x select 0, _x select 1];
  } forEach BULWARK_SUPPORTITEMS;
}else{
  _ctrl lbAdd " ";
  _ctrl lbAdd "";
  _ctrl lbAdd "         A Satellite Dish must be found";
  _ctrl lbAdd "             to unlock Support Menu";
};

((findDisplay 9999) displayCtrl 1500) ctrlAddEventHandler ['TreeSelChanged', {
  _path = tvCurSel 1500;
  if ((count _path) == 2) then {
    _picture = getText (configFile >> "CfgVehicles" >> (((BULWARK_BUILDITEMS select (_path select 0)) select (_path select 1)) select 1) >> "editorPreview");
    ctrlSetText [1502, _picture];
  }
}]
