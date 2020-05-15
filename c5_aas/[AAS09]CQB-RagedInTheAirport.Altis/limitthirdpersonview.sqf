
#include "globalDefines.hpp"
if ((difficultyOption "thirdPersonView") isEqualTo 1) then
{
	switch (AAS_Params_CameraView) do
	{
		case 0: {};//server difficulty setting
		case 1://vehicles only
		{
			// Handle most commonly used setting in unscheduled enviroment JIG.
			waitUntil {spawnDialogReady};
			player switchCamera "INTERNAL";
			JIG_3rdPersonVeh = (findDisplay 46) displayAddEventHandler["KeyDown", {
				_keyOver = false;
				params['_display','_key','_shift','_ctrl','_alt'];
				if (inputAction 'personView' > 0 && {isNull objectParent player}) then {
					player switchCamera 'INTERNAL';
					_keyOver = true;
				};
				if (_key in [DIK_NUMPADENTER, DIK_DECIMAL, DIK_ABNT_C2] && {inputAction 'personView' isEqualTo 0} && {isNull objectParent player}) then {
					player switchCamera 'INTERNAL';
					_keyOver = true;
				};
				_keyOver
			}];
			player addEventHandler["GetOutMan", {if (cameraView isEqualTo "EXTERNAL") then {player switchCamera "INTERNAL"};}];
		};
		case 2://infantry only
		{
			while {(true)} do
			{
				if (cameraView isEqualTo "EXTERNAL") then
				{
					if !(isNull objectParent player) then
					{
						(vehicle player) switchCamera "INTERNAL";
					};
				};
				sleep 0.1;
			};
		};
		case 3://disabled
		{
			while {(true)} do
			{
				if (cameraView isEqualTo "EXTERNAL") then
				{
					if ((vehicle player) == cameraOn) then
					{
						(vehicle player) switchCamera "INTERNAL";
					};
				};
				sleep 0.1;
			};
		};
	};
};