waitUntil {!isNull(findDisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown","_this call keybind"];

keybind = {
_control = _this select 0;
_code = _this select 1; 
_shift = _this select 2; 
_ctrl = _this select 3; 
_alt = _this select 4; 
_handled = false;

switch (_code) do {
	
	case 19: {//R key
		if (!_shift && _ctrl && !_alt) then {
			[] call bulc_fnc_magRepack;
		};
	};
 
	case 35: {//H key
		if (!_shift && !_ctrl && !_alt) then {
			if (!hasInterface) exitWith {};
			player action ["SWITCHWEAPON",player,player,-1];
			waitUntil {currentWeapon player == "" or {primaryWeapon player == "" && handgunWeapon player == ""}};
		};
	};

	case 199: {//HOME key
		[] call bulc_fnc_openmenu;
	_handled;
	};
	
	case 207: {//END key
		if (soundVolume isEqualTo 1) then {
		1 fadeSound 0.4; hintSilent "Ear Plugs Inserted";
		}else{
		1 fadeSound 1; hintSilent "Ear Plugs Removed";
		};
	_handled;
	};
};
_handled;
};