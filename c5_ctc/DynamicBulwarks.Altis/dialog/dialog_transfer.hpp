class transferPoints {
   idd = 5480;
   name = "transferPoints";
   movingenable = 1;
   enablesimulation = 1;
   class controls
   {
	   class transferPointsBackground
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.40375;
			y = safeZoneY + safeZoneH * 0.35444445;
			w = safeZoneW * 0.1925;
			h = safeZoneH * 0.28;
			style = 0;
			text = "";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
	   class transferPointsTitle
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.40375;
			y = safeZoneY + safeZoneH * 0.31444445;
			w = safeZoneW * 0.1925;
			h = safeZoneH * 0.04;
			style = 2;
			text = "Transfer Points";
			colorBackground[] = {0,0.2,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class transferclose : a3cMenuClose
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.56875;
			y = safeZoneY + safeZoneH * 0.31444445;
			w = safeZoneW * 0.0275;
			h = safeZoneH * 0.04;
		};
		class transfercloseButton : a3cMenuButtonClose
		{
			type = 1;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.56875;
			y = safeZoneY + safeZoneH * 0.31444445;
			w = safeZoneW * 0.0275;
			h = safeZoneH * 0.04;
		};
	   	class transferPointsEdit
		{
			type = 2;
			idc = 5487;
			x = safeZoneX + safeZoneW * 0.43875;
			y = safeZoneY + safeZoneH * 0.39333334;
			w = safeZoneW * 0.1175;
			h = safeZoneH * 0.04;
			style = 0+2;
			text = "0";
			autocomplete = "";
			colorBackground[] = {0.2,0.2,0.2,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaBold";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
	   	class transferPointsList
		{
			type = 4;
			idc = 5481;
			x = safeZoneX + safeZoneW * 0.43875;
			y = safeZoneY + safeZoneH * 0.47;
			w = safeZoneW * 0.1175;
			h = safeZoneH * 0.04;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.2,0.2,0.2,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.949,0.949,0.949,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			};
		};
	   class transferPointsButton : RscButton 
		{
			idc = 1601;
			x = safeZoneX + safeZoneW * 0.44;
			y = safeZoneY + safeZoneH * 0.54777778;
			w = safeZoneW * 0.115;
			h = safeZoneH * 0.04;
			text = "Send";
			colorBackground[] = {0.102,0.302,0.102,1};
			colorBackgroundActive[] = {1,0,0,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			action = "[] call bulc_fnc_send";
		};
   };
};

