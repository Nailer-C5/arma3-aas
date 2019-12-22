#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "S3_HUDDefs.h"

private['_handled'];
_handled= false;
params['_d','_key','_shift_state','_control_state','_alt_state'];

if (inputAction "Chat">0) then
{
	if (missionNamespace getvariable['_stfu', false]) then
	{
		0 spawn { (finddisplay 24) displayAddEventHandler ["KeyDown","(_this select 1) call S3_fnc_MadChat"] };
	};
};
	
/* if (inputAction "evasiveRight" > 0 and (_shift_state or _control_state)) then { 'R' spawn S3_fnc_JumpLFR };
if (inputAction "evasiveLeft" > 0 and (_shift_state or _control_state)) then { 'L' spawn S3_fnc_JumpLFR }; */

if (inputAction "personView" > 0) then { if (vehicle player == player) then { _handled= true } };
if (inputAction "TacticalView" > 0) then { if (vehicle player == player) then { _handled= true } };
/* if (inputAction "MiniMapToggle">0) then
{
	_v=  not (uiNamespace getVariable "S3_GPS");
	uiNamespace setVariable ["S3_GPS", _v];
	
	[_v] spawn fn_iforceGPS; 
	_handled= true;
}; */
if (inputAction "action" > 0) then { if ( lifestate player=='INCAPACITATED') then { player setdamage 1 } };
/* if (_alt_state)	then { missionNamespace setVariable["S3_AltState",true] }; */

switch (_key) do
{		
	
	case DIK_T: { if (_control_state) then {S3_NAMETAG= not S3_NAMETAG} };
	case DIK_H: { 
	if (_control_state) then 
	{
		_v=  not (uiNamespace getVariable ["S3_GPS", true]);
		uiNamespace setVariable ["S3_GPS", _v];
		
		[_v] spawn fn_iforceGPS; 
		_handled= true;
	};
	};
	
	case DIK_Z: { if (_control_state ) then { MAP_Zoom= MAP_Zoom-0.005; if (MAP_Zoom< 0.005) then {MAP_Zoom= 0.005}; _handled=true; }};
	case DIK_X: { if (_control_state ) then { MAP_Zoom= MAP_Zoom+0.005; if (MAP_Zoom> 1) then {MAP_Zoom= 1}; _handled=true; }};
	
	case DIK_F1: //Drag'n'drop minimap
	{
		if (isNull findDisplay 15001 and _control_state) then 
		{
			createDialog "S3MiniMapDialog"; 
			_all= uiNamespace getVariable ["S3_GPS_Controls", []];
			_mmc= _all select 1;
			
			_d= findDisplay 15001;
			_mm= _d displayCtrl 15002;
			_mm ctrlSetPosition (ctrlPosition _mmc);
			_mm ctrlCommit 0;
			uiNamespace setVariable ["S3_GPS_pos", ctrlPosition _mm];
			hint Localize "STR_S3_Drag";
		};
	};
	
	case DIK_F2: //Admin Menu
	{ 
	
		if ( call BIS_fnc_admin isEqualTo 2 and _control_state and isNull ((findDisplay -1) displayCtrl 10001 )) then 
		//if ( true) then 
		{ 
			createdialog "RscDisplayAttributesModuleWeather";
		
			flag1 setvariable['S3_Admin', player, true];
			
			_c= (findDisplay -1) displayCtrl 1;
			_pos= ctrlPosition _c;
			_pos set[2, (_pos select 2)*2];
			_pos set[0, 0.5-(_pos select 2)/2];
			
			_a= (findDisplay -1) ctrlCreate ["RscButton", 10001];
			_a ctrlSetPosition _pos;
			_a ctrlSetText Localize 'STR_S3_Settings';//стринг
			_a ctrlSetEventHandler ["MouseButtonClick", "if (isNull (findDisplay 10051)) then { createdialog 'S3ADMINDialog' } "]; 
			_a ctrlCommit 0;
		};
	};
	
	/* case DIK_F4: 
	{
		//cursorObject setDamage 1;
		player switchMove "passenger_flatground_2_aim";
	};  */	
	
};//SW
	
_handled;