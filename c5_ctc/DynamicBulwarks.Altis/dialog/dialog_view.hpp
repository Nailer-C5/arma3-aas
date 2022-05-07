#include "..\macros.hpp"
class taw_viewDistance {
idd = MENU_IDD;
	name = "taw_viewDistance";
	movingEnabled = 0;
	enableSimulation = 1;
	
	onLoad = "((_this select 0) displayCtrl 2999) ctrlSetFade 1; ((_this select 0) displayCtrl 2999) ctrlCommit 0;";

	class controlsBackground {
		class TitleBackground : tawRscText {
			colorBackground[] = { "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])" };
			idc = -1;
			x = .3;
			y = .2;
			w = .5;
			h = (1 / 25);
		};

		class MainBackground : tawRscText {
			colorBackground[] = { 0, 0, 0, .7 };
			idc = -1;
			x = .3;
			y = .2 + (11 / 250);
			w = .5;
			h = .57 - (22 / 250);
		};
		
		class Title : RscTitle {
			colorBackround[] = { 0, 0, 0, 0 };
			idc = -1;
			text = "View Settings";
			x = .3;
			y = .2;
			w = .8;
			h = (1 / 25);
		};

		class OnFootText : tawRscText {
			idc = -1;
			text = "Infantry:";
			x = .32;
			y = .258;
			w = .275;
			h = .04;
		};

		class inCarText : OnFootText {
			text = "Ground:";
			y = .305;
		};

		class inAirText : OnFootText {
			text = "Air:";
			y = .355;
		};

		class ObjectText : OnFootText {
			text = "Object:";
			y = .655;
		};
		
		class DroneText : OnFootText {
			text = "Drone:";
			y = .405;
		};

		class TerrainBackground : TitleBackground {
			text = "Grass Settings";
			shadow = 0;
			y = .46;
		};

		class ObjectBackground : TitleBackground {
			text = "Object Settings";
			y = .55;
		};

		class ButtonClose : tawRscButtonMenu {
			idc = -1;
			text = "Close";
			onButtonClick = "closeDialog 0;";
			x = 0.3;
			y = 0.77 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
		
		class SaveManagerBtn:ButtonClose {
			text = "Saves";
			onButtonClick = "[] call bulc_fnc_openSaveManager;";
			x = .465;
		};
	};

	class controls {

		//Sliders
		class VD_onFoot_slider : RscXSliderH {
			idc = INFANTRY_SLIDER;
			text = "";
			onSliderPosChanged = "[0, _this select 1] call bulc_fnc_onSliderChanged;";
			toolTip = "View Distance while on foot";
			x = .42;
			y = .30 - (1 / 25);
			w = "9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};

		class VD_inCar_slider : VD_onFoot_slider {
			idc = GROUND_SLIDER;
			toolTip = "View distance while in a ground vehicle";
			onSliderPosChanged = "[1, _this select 1] call bulc_fnc_onSliderChanged;";
			y = .35 - (1 / 25);
		};

		class VD_inAir_slider : VD_onFoot_slider {
			idc = AIR_SLIDER;
			toolTip = "View distance while in an aircraft";
			onSliderPosChanged = "[2, _this select 1] call bulc_fnc_onSliderChanged;";
			y = .40 - (1 / 25);
		};

		class VD_Object_slider : VD_onFoot_slider {
			idc = OBJECT_SLIDER;
			toolTip = "Object rendering distance";
			onSliderPosChanged = "[3, _this select 1] call bulc_fnc_onSliderChanged;";
			y = .7 - (1 / 25);
		};
		
		class VD_Drone_slider:VD_onFoot_slider {
			idc = DRONE_SLIDER;
			toolTip = "View distance while operating a UAV/UGV";
			onSliderPosChanged = "[4, _this select 1] call bulc_fnc_onSliderChanged;";
			y = .45 - (1 / 25);
		}

		//Values (RscEdit Butons)
		class VD_onFoot_Edit : tawRscEdit {
			idc = INFANTRY_EDIT;
			text = "";
			onKeyUp = "[_this select 0, _this select 1, 'ground',true] call bulc_fnc_onChar;";

			x = .7;
			y = .258;
			w = .08;
			h = .04;
		};

		class VD_inCar_Edit : VD_onFoot_Edit {
			idc = GROUND_EDIT;
			onKeyUp = "[_this select 0, _this select 1, 'vehicle',true] call bulc_fnc_onChar;";
			y = .31;
		};

		class VD_inAir_Edit : VD_onFoot_Edit {
			idc = AIR_EDIT;
			onKeyUp = "[_this select 0, _this select 1, 'air',true] call bulc_fnc_onChar;";
			y = .36;
		};
		
		class VD_inDrone_Edit:VD_onFoot_Edit {
			idc = DRONE_EDIT;
			onKeyUp = "[_this select 0, _this select 1, 'drone',true] call bulc_fnc_onChar;";
			y = .41;
		};

		class VD_Object_Edit : VD_onFoot_Edit {
			idc = OBJECT_EDIT;
			onKeyUp = "[_this select 0, _this select 1, 'object',true] call bulc_fnc_onChar;";
			y = .656;
		};

		//Grass Settings
		class VD_terrain_none {
			idc = TERRAIN_NONE;
			type = 11;
			style = 0;
			font = "PuristaLight";
			color[] = { 1, 1, 1, 1 };
			colorActive[] = { 1, 0.2, 0.2, 1 };
			colorDisabled[] = {0, 0, 0, 1};
			soundEnter[] = { "\A3\ui_f\data\sound\RscCombo\soundExpand", 0.09, 1 };
			soundPush[] = { "\A3\ui_f\data\sound\CfgNotifications\taskCreated", 0.0, 0 };
			soundClick[] = { "\A3\ui_f\data\sound\RscButton\soundClick", 0.07, 1 };
			soundEscape[] = { "\A3\ui_f\data\sound\ReadOut\ReadoutHideClick1", 0.09, 1 };
			text = "None";
			action = "['none'] call bulc_fnc_onTerrainChanged;";
			sizeEx = 0.04;

			x = .38; y = .505;
			w = .275; h = .04;
		};

		class VD_terrain_low : VD_terrain_none {
			idc = -1;
			text = "Low";
			action = "['low'] call bulc_fnc_onTerrainChanged;";
			x = .47;
		};

		class VD_terrain_normal : VD_terrain_none {
			idc = -1;
			text = "Normal";
			action = "['norm'] call bulc_fnc_onTerrainChanged;";
			x = .56;
		};

		class VD_terrain_high : VD_terrain_none {
			idc = -1;
			text = "High";
			action = "['high'] call bulc_fnc_onTerrainChanged;";
			x = .67;
		};

		class ObjectSyncCheckbox : tawRscCheckbox
		{
			idc = 2931;
			x = .32; y = .6;
			tooltip = "Sync object rendering with view rendering";
			onCheckedChanged = "if((_this select 1) == 1) then {tawvd_syncObject = true;ctrlEnable [2941,false]; ctrlEnable [2942,false];} else {tawvd_syncObject = false; ctrlEnable [2942,true]; ctrlEnable [2941,true];};";
			w = 1 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H; 
		};

		class ObjectSynctext : tawRscText {
			idc = -1;
			text = "Sync with view";
			x = .345; y = .596;
			w = .35; h = .04;
		};
		
		class Manager:tawRscControlsGroup {
			idc = MANAGER_GROUP;
			
			x = -0.21; y = .2;
			w = .5; h = 3;
			class Controls {
				class SaveLoadGroup:RscControlsGroupNoScrollbars {
					idc = SAVELOAD_GROUP;
					
					x = 0;
					y = 0;
					w = .5;
					h = 3;
					
					class Controls {
						class MyTitleBackground:tawRscText {
							colorBackground[] = { "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])" };
							idc = -1;
							x = 0;
							y = 0;
							w = .5;
							h = (1 / 25);
						};
						
						class Title : RscTitle {
							colorBackround[] = { 0, 0, 0, 0 };
							idc = -1;
							text = "Save Manager";
							x = 0;
							y = 0;
							w = .8;
							h = (1 / 25);
						};
						
						class MainBackground:tawRscText {
							colorBackground[] = { 0, 0, 0, .7 };
							idc = -1;
							x = 0;
							y = 0 + (11 / 250);
							w = .5;
							h = .57 - (22 / 250);
						};
						
						class SaveList:tawRscListBox {
							idc = SAVES_LIST;
							sizeEx = 0.04;
							colorBackground[] = {0.1,0.1,0.1,0.9};
							x = 0; y = 0 + (11 / 250);
							w = .5; h = .49 - (22 / 250);
							
							onLBSelChanged = "_this call bulc_fnc_onSaveSelectionChanged;";
						};
						
						class SaveSlotName:VD_onFoot_Edit {
							idc = SLOT_NAME;
							text = "SAVE NAME";
							colorBackground[] = {0,0,0,0.6};
							onKeyUp = "";
							
							x = .025; y = .42 + (11 / 250);
							w = .45;
						};
						
						class SaveButton:tawRscButtonMenu {
							text = "Save";
							onButtonClick = "[] call bulc_fnc_onSavePressed;";
							x = 0;
							y = 0.57 - (1 / 25);
							w = (6.25 / 40);
							h = (1 / 25);
						};
						
						class HideButton:tawRscButtonMenu {
							text = "Hide";
							onButtonClick = "((findDisplay 2900) displayCtrl 2999) ctrlSetFade 1; ((findDisplay 2900) displayCtrl 2999) ctrlCommit 0.3;";
							x = .16;
							y = 0.57 - (1 / 25);
							w = (6.25 / 40);
							h = (1 / 25);
						};
					};
				};
			};
		};
	};
};