class dialog_build
{
    idd = 9999;
    name= "dialog_build";
    movingEnabled = false;

    class controls
    {
    	class bw_background
		{
			type = CT_STATIC;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.24444445;
			w = safeZoneW * 0.4125;
			h = safeZoneH * 0.5;
			style = ST_LEFT;
			text = "";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class bw_titlebar
		{
			type = CT_STATIC;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.24444445;
			w = safeZoneW * 0.4125;
			h = safeZoneH * 0.04;
			style = ST_CENTER;
			text = "A3 Dynamic Bulwarks";
			colorBackground[] = {0,0.2,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		class bw_close : a3cMenuClose
		{
			type = CT_STATIC;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.67875;
			y = safeZoneY + safeZoneH * 0.24444445;
			w = safeZoneW * 0.0275;
			h = safeZoneH * 0.04;
		};
		class bw_close_button : a3cMenuButtonClose
		{
			type = CT_BUTTON;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.67875;
			y = safeZoneY + safeZoneH * 0.24444445;
			w = safeZoneW * 0.0275;
			h = safeZoneH * 0.04;

		};	
		class startBox_buildList : a3cTreeView 
		{
			idc = 1500;
			x = safeZoneX + safeZoneW * 0.305;
			y = safeZoneY + safeZoneH * 0.30111112;
			w = safeZoneW * 0.19;
			h = safeZoneH * 0.36666667;
		};
		class ObjectPicture: RscPicture
        {
            idc = 1502;
			text="resource\image\a3db.paa";
			x = safeZoneX + safeZoneW * 0.505;
			y = safeZoneY + safeZoneH * 0.30333334;
			w = safeZoneW * 0.19;
			h = safeZoneH * 0.14444445;
        };
        class startBox_buildButton: RscButton
        {
            idc = 1600;
            text = "Purchase Building";
			x = safeZoneX + safeZoneW * 0.30375;
			y = safeZoneY + safeZoneH * 0.68777778;
			w = safeZoneW * 0.19;
			h = safeZoneH * 0.04;
            action = "_nil=[] spawn bulc_fnc_purchaseBuild";
        };
        class startBox_supportLst: RscListbox
        {
            idc = 1501;
			x = safeZoneX + safeZoneW * 0.505;
			y = safeZoneY + safeZoneH * 0.45777778;
			w = safeZoneW * 0.19;
			h = safeZoneH * 0.21;
        };
        class startBox_supportButton: RscButton
        {
            idc = 1601;
            text = "Purchase Support";
			x = safeZoneX + safeZoneW * 0.505;
			y = safeZoneY + safeZoneH * 0.68777778;
			w = safeZoneW * 0.19;
			h = safeZoneH * 0.04;
            action = "_nil=[] spawn bulc_fnc_purchaseSupport";
        };
  };
};
