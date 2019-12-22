class GUIPicture
{
	access = 0;
	type = 0;
	idc = -1;
	style = 48;
	colorBackground[] =
	{
		0,
		0,
		0,
		0
	};
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
};
class GUIPictureKeepAspect: GUIPicture
{
	style = "0x30 + 0x800";
};
//NAILER[C5] - MODIFY LOAD SCREEN PIC...
class AAS_LoadScreen
{
	idd = -1;
	duration = 10e10;
	fadein = 0;
	fadeout = 0;
	name = "Loading Screen";
	class ControlsBackground
	{
		class Loading_CE2: GUIPictureKeepAspect
		{
			x = "(7.5/100)	* SafeZoneW + SafeZoneX";
			y = "(7.5/100)	* SafeZoneH + SafeZoneY";
			w = "(85/100)	* SafeZoneW";
			h = "(85/100)	* SafeZoneH";
			text = "pictures\loadscreen.jpg";
		};
	};
	class controls {};
};