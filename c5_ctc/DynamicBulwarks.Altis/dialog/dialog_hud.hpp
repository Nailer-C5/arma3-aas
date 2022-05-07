class bulwarksHUD {
	idd = 767901;
	movingEnable =  0;
	enableSimulation = 1;
	enableDisplay = 1;
	duration     =  10e10;
	fadein       =  0;
	fadeout      =  0;
	name = "bulwarksHUD";
	onLoad = "with uiNameSpace do { bulwarksHUD = _this select 0 }";
	class controls {
		class structuredText {
			access = 0;
			type = 13;
			idc = 99999;
			style = 0x00;
			lineSpacing = 1;
			x = 0.103165 * safezoneW + safezoneX;
			y = 0.007996 * safezoneH + safezoneY;
			w = 0.778208 * safezoneW;
			h = 0.0660106 * safezoneH;
			size = 0.055;
			colorBackground[] = {0,0,0,0};
			colorText[] = {0.34,0.33,0.33,0};//{1,1,1,1}
			text = "";
			font = "PuristaSemiBold";
			class Attributes {
				font = "PuristaSemiBold";
				color = "#C1C0BB";
				align = "CENTER";
				valign = "top";
				shadow = true;
				shadowColor = "#000000";
				underline = false;
				size = "4";
			};
		};
	};
};