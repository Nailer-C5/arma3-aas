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
		keyPressCurrCmd="";	
	}
	else
	{
		hint "CONSOLE ACTIVE";
		consoleCommandMode=true;
		keyPressCurrCmd="";
	};
};

string _str = _charmap select _keypressed;
   /* if ( _str =="y" and _control_state ) then
   {
if (call BIS_fnc_admin isEqualTo 2 ) then {createdialog "RscDisplayAttributesModuleWeather";};
   }; */
if (inputAction "action" > 0) then { if ( lifestate player=='INCAPACITATED') then { player setdamage 1 } };

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
	
	if( _str == "y" and _control_state ) then
	{
		if (call BIS_fnc_admin isEqualTo 2) then 
		{ 
			createdialog "RscDisplayAttributesModuleWeather";
			
			_c= (findDisplay -1) displayCtrl 1;
			_pos= ctrlPosition _c;
			_pos set[2, (_pos select 2)*2];
			_pos set[0, 0.5-(_pos select 2)/2];
			
			_s= (findDisplay -1) ctrlCreate ["RscXSliderH", 10001];
			_s sliderSetRange [0, 1439];
			_s ctrlSetPosition _pos;
			_s sliderSetPosition ((date select 3)*60+ (date select 4));
			_s ctrlCommit 0;
			_s ctrlSetEventHandler ["SliderPosChanged", "_this spawn f_time"];
			
		f_time= {
			disableSerialization;
			params['_c','_pos'];
			_h= floor (_pos/60); 
			_m= floor(_pos mod 60);  
			//_c ctrlSetTooltip format ['Time %1:%2', _h, _m]; 
			_date= date; 
			_date set [3, _h]; 
			_date set [4, _m]; 
			[_date] remoteExec ['setDate', 0, true]; 
			_txt= uiNamespace getVariable "AAS_timeXCtrl";
			if (_m< 10) then { _m= "0"+str _m };
			_txt ctrlSetStructuredText parseText format['<t align="Center">Time %1:%2</t>', _h, _m]; 
			_txt ctrlCommit 0;
		};
		
		_txt= (findDisplay -1) ctrlCreate ["RscStructuredText", 10002];
		
		_m= date select 4;
		if (_m< 10) then { _m= "0"+str _m };
		
		_txt ctrlSetStructuredText parseText format['<t align="Center">Time %1:%2</t>', date select 3, _m];
		_pos set [1, (_pos select 1)+(_pos select 3)];
		_txt ctrlSetPosition _pos;
		_txt ctrlCommit 0;
		uiNamespace setVariable ["AAS_timeXCtrl", _txt];
		};
	};
	
	if( _str == "4" ) then
	{
	_nul = ["P"] execVM "fast_actions.sqf";
	_return=true;
	};
	
	 if( _str == "f1" ) then
	{
	[] spawn AAS_fnc_cDragActions;
	_return=true;
	};
	if( _str == "z" and _control_state ) then
	{
		if( mapZoomLevel > 0.03 ) then {	mapZoomLevel = mapZoomLevel - 0.03; };
		_return=true;
		hintSilent localize "STR_AAS_zoomed_in";
	};
	if( _str == "x" and _control_state ) then
	{	
		if( mapZoomLevel < 1.0 ) then {	mapZoomLevel = mapZoomLevel + 0.03; };
		_return=true;
		hintSilent localize "STR_AAS_zoomed_out";
	};
	if( _str == "h" and _control_state ) then
	{
		hudDisplayLevel = hudDisplayLevel + 1;
		if( hudDisplayLevel > HUD_MAX_LEVEL ) then { hudDisplayLevel = 0; };
		_return=true;
		if( hudDisplayLevel == HUD_LEVEL_MINIMAL ) then { hint localize "STR_AAS_HUD_minimal"; }; 
		if( hudDisplayLevel == HUD_LEVEL_NOMAP ) then { hint localize "STR_AAS_HUD_reduced"; }; 
		if( hudDisplayLevel == HUD_LEVEL_FULL ) then { hint localize "STR_AAS_HUD_normal"; }; 
	};
	if( _str == "t" and _control_state ) then
	{
		tagDisplayRange = tagDisplayRange + 20;
        if( tagDisplayRange > 200  ) then { tagDisplayRange = tagDisplayRange + 80; };
        if( tagDisplayRange > 1500  ) then { tagDisplayRange = tagDisplayRange + 400; };
        if( tagDisplayRange > MAX_TAG_DISPLAY_RANGE ) then { tagDisplayRange = 0; };
		_return = true;
		hint format[localize "STR_AAS_Tag_display",tagDisplayRange];
	};
	if( _str == "j" and _control_state ) then
	{
		resetHUD = true;
		_return = true;
		hint localize "STR_AAS_reset_HUD";
	};
	if( _str == "c" and _control_state and showChooserTime > 0 ) then
	{
		if( count ((getPos player) nearObjects ["rhs_weapon_crate",RULES_armouryUseRange]) > 0 ) then
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
			hint format[localize "STR_AAS_change_class",RULES_armouryUseRange];
			};
		_return = true;
	};
	if( _str == "d" and _control_state and showChooserTime > 0 ) then
	{
		if( count ((getPos player) nearObjects ["rhs_weapon_crate",RULES_armouryUseRange]) > 0 ) then
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
	 if(!classChangeLocked && count ((getPos player) nearObjects ["rhs_weapon_crate",RULES_armouryUseRange]) > 0 ) then
	 {
		 showChooserTime=CHOOSER_DURATION;	
	squad_mgmt_action = [objNull, objNull, 0, []] execVM "features\DOM_squad\open_dialog.sqf";	      
[0,0,0,[true,playerClass]] execVM "doQuickLoadout.sqf";
	            }
		else
			{
			hint format[localize "STR_AAS_Please_Wait",RULES_armouryUseRange];
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
