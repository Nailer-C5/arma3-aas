#define CT_STATIC           0             //reqd
#define CT_BUTTON           1				//reqd
#define CT_ACTIVETEXT       11              //
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define DEFAULT_FONT     "PuristaMedium"
#define SECONDARY_FONT	 "TahomaB"
#define GUITEXT				0
#define IDCUNDEFINED		-1
class RespawnButtonBase 
{
	type = CT_BUTTON;
	style = ST_CENTER;    // hmmm this used to be ST_CENTRE which didnt exist (changing in r224 roughly)
	default = false;
	font = DEFAULT_FONT;
	sizeEx = 0.022;
	colorText[] = { 0, 0, 0, 1 };
	colorFocused[] = { 0.31, 0.31, 0.31, 0.31 };   
	colorDisabled[] = { 0, 0, 1, 0.7 };   
	colorBackground[] = { 1, 1, 1, 0.5 };
	colorBackgroundDisabled[] = { 1, 1, 1, 0.5 };   
	colorBackgroundActive[] = { 0.5, 0.5, 0.5, 0.5 };   
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorShadow[] = { 0, 0, 0, 0.5 };
	colorBorder[] = { 0.5, 0.5, 0.5, 0.5 };
	borderSize = 0;
	soundEnter[] = { "", 0, 1 };  
	soundPush[] = { "", 0.1, 1 };
	soundClick[] = { "", 0, 1 };  
	soundEscape[] = { "", 0, 1 };  
	w = 0.11; h = 0.04;
	text = "";
};
class QueueListBase
{
	type = GUITEXT;
	style = GUILEFT;
	colorText[] = {0.75,0.75,0.75,1};
	colorBackground[] = {0,0,0,0};
	font = SECONDARY_FONT;
	sizeEx = 0.025;
	w = 0.7;
	h = 0.04;
	text = "";
};
class respawn_button_aas {
  idd = IDDRESPAWNDIALOG;
  movingEnable = false;
  //controlsBackground[] = {};
  objects[] = { };
  controls[] = {}; // MKB new
	controlsBackGround[] = {TOP_BORDER,BOTTOM_BORDER,TITLE_DIALOG,MedicInfo,Respawn_0,Respawn_1,Respawn_2,Respawn_3,Respawn_4,Respawn_5,Respawn_6,Respawn_7,Respawn_8,Respawn_9,Respawn_10,Respawn_Cancel,Queue_0,Queue_1,Queue_2,Queue_3,Queue_4,Queue_5,Queue_6,Queue_7,Queue_8,Queue_9,Queue_10,CancelQueueInfoText};
class TOP_BORDER
{
	idc = -1;
	type = CT_STATIC;
	style = ST_CENTER;
		x = -5;
		y = -5;
		w = 10;
		h = 10;
	font = DEFAULT_FONT;
	sizeEx = 0.04;
	colorText[] = { 1, 1, 1, 1 };
	colorBackground[] = {0,0,0,1};
	text = "";	
};
class BOTTOM_BORDER
{
	idc = -1;
	type = CT_STATIC;
	style = ST_CENTER;
		x = -5;
		y = -5;
		w = 10;
		h = 10;
	font = DEFAULT_FONT;
	sizeEx = 0.04;
	colorText[] = { 1, 1, 1, 1 };
	colorBackground[] = {0,0,0,1};
	text = "";	
};	
class TITLE_DIALOG
{
	idc = -1;
	type = GUITEXT;
	style = ST_LEFT;
	x = 0.38; 
	y = -0.11;//SafeZoneY + 0.15;
	w = 0.4; 
	h = 0.10;
	font = DEFAULT_FONT;
	sizeEx = 0.05;
	colorText[] = { 1, 1, 1, 1 };
	colorBackground[] = {0,0,0,1};
	text = "Spawn Selector";
	default = true;
};
class RscText
{        
	type = CT_STATIC;        
	idc = -1;        
	style = ST_LEFT;        
	colorBackground[] = {0, 0, 0, 0};        
	colorText[] = {1, 1, 1, 1};     
	font = DEFAULT_FONT;        
	sizeEx = 0.02;
};
class MedicInfo: QueueListBase
{
	colorText[] = {0.7,0.55,0.1,1};
	idc = IDCMEDICINFO;
		x = 0.25;
		y = 0.04;//SafeZoneY + 0.3;
	text = "";
	sizeEx = 0.035;
};
class Respawn_0  : RespawnButtonBase { 	idc = 51; 	x = 0.85; y = 0.3; 	action = "[0,player]  execVM ""clickSpawnButton.sqf"""; };
class Respawn_1  : RespawnButtonBase {	idc = 52;	x = 0.85; y = 0.35;	action = "[1,player]  execVM ""clickSpawnButton.sqf"""; };
class Respawn_2  : RespawnButtonBase {	idc = 53;	x = 0.85; y = 0.4;	action = "[2,player]  execVM ""clickSpawnButton.sqf"""; };
class Respawn_3  : RespawnButtonBase {	idc = 54;	x = 0.85; y = 0.45;	action = "[3,player]  execVM ""clickSpawnButton.sqf"""; };
class Respawn_4  : RespawnButtonBase { 	idc = 55;	x = 0.85; y = 0.5;	action = "[4,player]  execVM ""clickSpawnButton.sqf"""; };
class Respawn_5  : RespawnButtonBase {	idc = 56;	x = 0.85; y = 0.55;	action = "[5,player]  execVM ""clickSpawnButton.sqf"""; };
class Respawn_6  : RespawnButtonBase {	idc = 57;	x = 0.85; y = 0.6;	action = "[6,player]  execVM ""clickSpawnButton.sqf"""; };
class Respawn_7  : RespawnButtonBase {	idc = 58;	x = 0.85; y = 0.65;	action = "[7,player]  execVM ""clickSpawnButton.sqf"""; };
class Respawn_8  : RespawnButtonBase {	idc = 59;	x = 0.85; y = 0.7;	action = "[8,player]  execVM ""clickSpawnButton.sqf"""; };
class Respawn_9  : RespawnButtonBase {	idc = 60;	x = 0.85; y = 0.75; action = "[9,player]  execVM ""clickSpawnButton.sqf""";	};
class Respawn_10 : RespawnButtonBase {	idc = 61;	x = 0.85; y = 0.8;	action = "[10,player] execVM ""clickSpawnButton.sqf"""; };
	class Respawn_Cancel: RespawnButtonBase	{idc = 62; x = 0.85; y = 0.20; action = "[99,player] execVM 'clickSpawnButton.sqf';"; text = "Cancel";};

class Queue_0  : QueueListBase   {     idc = 31;  	x = 0.05;	y = 0.3;	};
class Queue_1  : QueueListBase   {     idc = 32;  	x = 0.05; 	y = 0.35;	};
class Queue_2  : QueueListBase   {     idc = 33; 	x = 0.05;	y = 0.4;    };
class Queue_3  : QueueListBase   {     idc = 34;  	x = 0.05;	y = 0.45;   };
class Queue_4  : QueueListBase   {     idc = 35;   	x = 0.05;	y = 0.5;    };
class Queue_5  : QueueListBase   {     idc = 36; 	x = 0.05; 	y = 0.55;   };
class Queue_6  : QueueListBase   {     idc = 37; 	x = 0.05;	y = 0.6;    };
class Queue_7  : QueueListBase   {     idc = 38; 	x = 0.05;	y = 0.65;   };
class Queue_8  : QueueListBase   {     idc = 39;   	x = 0.05;	y = 0.7;    };
class Queue_9  : QueueListBase   {     idc = 40;  	x = 0.05;	y = 0.75;   };
class Queue_10 : QueueListBase   {     idc = 41; 	x = 0.05;	y = 0.8;    };
	class CancelQueueInfoText: RscText
	{
		x = 0.05;
		y = 0.2;
		w = 1;
		h = 0.04;
		sizeEx = 0.035;
		text = "Click a Base Spawn Location";
	};
};