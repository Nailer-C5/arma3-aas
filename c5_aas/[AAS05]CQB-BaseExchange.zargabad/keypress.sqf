#include "globalDefines.hpp"
_display = _this select 0;
int _keypressed = _this select 1;
bool _shift_state = _this select 2;
bool _control_state = _this select 3;
bool _alt_state = _this select 4;
bool _return = false;
int _KEYSCANCODE_ENTER = 28;
int _KEYSCANCODE_WINL  = 220;
array _charmap = [
  "" , "" , "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "" , "" , "" , "" ,	// 0
  "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "" , "" , "" , "" , "a", "s",	// 10
  "d", "f", "g", "h", "j", "k", "l", "" , "" , "" , "" , "" , "z", "x", "c", "v",	// 20
  "b", "n", "m", "" , "" , "" , "" , "" , "" , "", "" , "f1" , "" , "" , "" , "" ,	// 30
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,	// 40
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,	// 50
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,	// 60
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,	// 70
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,	// 80
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,	// 90
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,	// A0
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,	// B0
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,	// C0
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,	// D0
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ,	// E0
  "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" ];	// F0
if( _keypressed == _KEYSCANCODE_WINL and _control_state and enableConsole ) then
{
	if( consoleCommandMode ) then
	{
		consoleCommandMode=false;
		hint format["CONSOLE INACTIVE at %1",time];
		DEBUG_LOG format["CONSOLE INACTIVE at %1",time];
		keyPressCurrCmd="";	
	}
	else
	{
        DEBUG_LOG format["CONSOLE ACTIVE at %1",time];
		hint "CONSOLE ACTIVE";
		consoleCommandMode=true;
		keyPressCurrCmd="";
	};
};
if( consoleCommandMode ) then
{
	string _str = _charmap select _keypressed;
	if( _str != "" ) then
	{
		keyPressCurrCmd = keyPressCurrCmd + _str;
		_return = true;
		hintSilent format[">%1",keyPressCurrCmd];
	};
	if( _keypressed == _KEYSCANCODE_ENTER ) then
	{
		consoleExecuteCommand=keyPressCurrCmd;
		keyPressCurrCmd="";
		hintSilent ">";
		_return = true;
	};
}
else
{
	string _str = _charmap select _keypressed;
	 if( _str == "f1" ) then
	{
	[] spawn AAS_fnc_cDragActions;
	_return=true;
	};
	if( _str == "z" and _control_state ) then
	{
		if( mapZoomLevel > 0.03 ) then {	mapZoomLevel = mapZoomLevel - 0.03; };
		_return=true;
		hintSilent "Map zoomed in.";
	};
	if( _str == "x" and _control_state ) then
	{	
		if( mapZoomLevel < 1.0 ) then {	mapZoomLevel = mapZoomLevel + 0.03; };
		_return=true;
		hintSilent "Map zoomed out.";
	};
	if( _str == "h" and _control_state ) then
	{
		hudDisplayLevel = hudDisplayLevel + 1;
		if( hudDisplayLevel > HUD_MAX_LEVEL ) then { hudDisplayLevel = 0; };
		_return=true;
		if( hudDisplayLevel == HUD_LEVEL_MINIMAL ) then { hint "HUD set to minimal."; }; 
		if( hudDisplayLevel == HUD_LEVEL_NOMAP ) then { hint "HUD set to reduced."; }; 
		if( hudDisplayLevel == HUD_LEVEL_FULL ) then { hint "HUD set to normal."; }; 
	};
	if( _str == "t" and _control_state ) then
	{
		tagDisplayRange = tagDisplayRange + 20;
        if( tagDisplayRange > 200  ) then { tagDisplayRange = tagDisplayRange + 80; };
        if( tagDisplayRange > MAX_TAG_DISPLAY_RANGE ) then { tagDisplayRange = 0; };
		_return = true;
		hint format["Tag display range set to %1m",tagDisplayRange];
	};
	if( _str == "j" and _control_state ) then
	{
		resetHUD = true;
		_return = true;
		hint "Attempting to reset HUD";
	};
	if( _str == "c" and _control_state and showChooserTime > 0 ) then
	{
		if( count ((getPos player) nearObjects ["B_supplyCrate_F",RULES_armouryUseRange]) > 0 ) then
			{	
			showChooserTime=CHOOSER_DURATION;
			if( !classChangeLocked ) then
				{
				playerClass = ( playerClass + 1 ) mod (count RULES_classList);
				[0,0,0,[true,playerClass]] execVM "doQuickLoadout.sqf";			
				};
			}
		else
			{
			hint format["You must be within %1m of armoury to change class.",RULES_armouryUseRange];
			};
		_return = true;
	};
	if( _str == "d" and _control_state and showChooserTime > 0 ) then
	{
		if( count ((getPos player) nearObjects ["B_supplyCrate_F",RULES_armouryUseRange]) > 0 ) then
			{	
			showChooserTime=CHOOSER_DURATION;

			if( !classChangeLocked ) then
				{
				myRifleIndex = ( myRifleIndex + 1 ) mod (count myRifles);
				[0,0,0,[true,playerClass]] execVM "doQuickLoadout.sqf";
				};
			}
		else
			{
			hint format["You must be within %1m of armoury to change weapon.",RULES_armouryUseRange];
			};
		_return = true;
	};
	 if( _str == "k" and _control_state and showChooserTime > 0 ) then
	{
	 if(!classChangeLocked && count ((getPos player) nearObjects ["B_supplyCrate_F",RULES_armouryUseRange]) > 0 ) then
	 {
		 showChooserTime=CHOOSER_DURATION;	
	squad_mgmt_action = [objNull, objNull, 0, []] execVM "features\DOM_squad\open_dialog.sqf";	      
[0,0,0,[true,playerClass]] execVM "doQuickLoadout.sqf";
	            }
		else
			{
			hint format["Please Wait Team Select is locked.",RULES_armouryUseRange];
			};
		_return = true;
	};
	if( _str == "p" and _control_state ) then
	{	
		consoleEnableCounter = consoleEnableCounter + 1;
		_return = true;
		if( consoleEnableCounter == 10 ) then
			{
			consoleEnableCounter=0;
			hint "CONSOLE ACTIVE";
			consoleCommandMode=true;
			keyPressCurrCmd="";
			};
	};
	_AAS_ForceCommandingModeKeys = actionKeys "ForceCommandingMode";
	if (_keypressed in _AAS_ForceCommandingModeKeys) then { _return = true; };	
};
_return
