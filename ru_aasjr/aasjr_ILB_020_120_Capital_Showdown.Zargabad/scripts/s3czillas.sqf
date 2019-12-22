//CheatZillas//R2U
/***
1. Chat protect
2. Txt Screen
***/

//What need add
//1 User Action check
//2 Running scripts names

S3Checker= objNull;

//vars
fnc_S3DisableFnc= { S3DisableMon=true };


fnc_S3ShowDispData=
{
	disableserialization;
	_id= _this;
	//!!!
	//copyToClipboard  str (S3ADdata select _id);
	//hintc str (S3ADdata select _id);
	createDialog "AdminPreviewDialog";

	_d=  finddisplay 11002;
	{
		//systemchat str _x;
		switch (_x select 0) do //ctrltype
		{
			case 5: 
				{
					//systemchat format["Listbox: %1", str _x];
					_l = _d ctrlCreate ["RscListBox", -1];
					_l ctrlSetPosition (_x select 1);
					
					{_l lbAdd format["%1", _x ]; } forEach (_x select 3);
					
					_l ctrlCommit 0;	
				}; //listbox
				
			 default 
				{
					_b = _d ctrlCreate ["RscText", -1];
					
					_b ctrlSetBackgroundColor [0,0,0,0.5];
					_b ctrlSetText (_x select 2);
					if (_x select 0 in [100,101]) then { _b ctrlSetBackgroundColor [1,1,0,0.5]; _b ctrlSetText Localize 'STR_S3_MAP';};//стринг
					_b ctrlSetPosition (_x select 1);
					
					_b ctrlCommit 0;	
				}; //txt	
		};

	} forEach (S3ADdata select _id select 1);

	hint Localize 'STR_S3_DONE';
};

S3UpdateData= {
	//if admin check need
	if !(call S3_fnc_getAdmin isEqualTo player) ExitWith {}; 
	S3ADdata= _this;
	
	//copyToClipboard str S3ADdata;
	if (count S3ADdata <1) ExitWith {};

	disableserialization;
	_d= finddisplay 11001;
	_lb= _d displayCtrl 1500;
	lbClear _lb;
	{_lb lbAdd format["%1     CC: %2", S3ADdata select _forEachIndex select 0, count (S3ADdata select _forEachIndex select 1) ]; } forEach S3ADdata;
	_lb ctrlSetEventHandler ["LBSelChanged","  (_this select 1) spawn fnc_S3ShowDispData;"];
};

S3UpdateAMenu= {
	disableserialization;
	_d= finddisplay 11001;
	_cb= _d displayCtrl 1499;
	lbClear _cb;
	S3PYL=[];
	//if (isNull S3Checker) then
	//{
	
	//};
	{S3PYL pushBack [_x, getPlayerUID _x ];   _cb lbAdd format ["N: %1 G: %2", name _x, getPlayerUID _x ];} forEach AllUnits; //PlayableUnits; стринг
	_cb lbSetCurSel 0;
	//_cb ctrlCommit 0;
	_cb ctrlSetEventHandler ["LBSelChanged",
	"  
	S3Checker = S3PYL select (_this select 1) select 0; 
	_Menutxt= finddisplay 11001 displayCtrl 1000; 
	_Menutxt ctrlSetText format [Localize 'STR_S3_ADMIN_MENU_2', name S3Checker]; 
	_Menutxt ctrlCommit 0;	 "];
	
	_btnClose= _d displayCtrl 1602;
	_btnClose ctrlSetEventHandler ["MouseButtonClick","closeDialog 0;"]; 	

	_btnRefresh= _d displayCtrl 1600;
	_btnRefresh ctrlSetEventHandler ["MouseButtonClick"," 0 spawn S3UpdateAMenu;"]; 	

	_btnC= _d displayCtrl 1601; //Check btn
	_btnC ctrlSetEventHandler ["MouseButtonClick"," player remoteExec ['S3_CZilla', S3Checker, false]"]; 	// S3Checker remoteExec ["S3_CZilla", 0, false]; 
	
	_btnS= _d displayCtrl 1603; //Stop btn
	_btnS ctrlSetEventHandler ["MouseButtonClick"," true remoteExec ['fnc_S3DisableFnc', 0, false]; ALLDisp remoteExec ['S3UpdateData', player, false];"]; 	// S3Checker remoteExec ["S3_CZilla", 0, false]; 
	
	
	//_btnC ctrlSetEventHandler ["MouseButtonClick"," S3Checker spawn S3_CZilla;"]; 
	
	_Menutxt= _d displayCtrl 1000;
	_Menutxt ctrlSetText format [Localize "STR_S3_ADMIN_MENU_2", name S3Checker]; 
	_Menutxt ctrlCommit 0;	
	
};

S3_CZilla= {
	_admin= _this;
	//systemChat ('Admin '+ name _admin);
	//if (_this!= player) exitwith {};
	ALLDisp=[];
	S3DisableMon=false;

	waituntil 
	{
		disableserialization;
		_timestart= time;
		{
			ALLCtrls=[];
			_d= _x;
			{
				if ((ctrlPosition _x)select 2>0 and  ctrlShown _x  ) then // and  ctrlShown _x and ctrlVisible (ctrlIDC _x)
				{
					_type = ctrlType _x; // 2
					_c= _x;
					_LB=[];
					_count =(lbSize _x)-1;
					
					for "_i" from 0 to _count  do {  _LB pushback (_c lbText  _i);  };
					//};
					//ALLCtrls pushBackUnique [ctrlType _x, ctrlPosition _x , (ctrlText _x )+' '+str (ctrlIDC _x) , _LB];//ctrlType 
					ALLCtrls pushBackUnique [ctrlType _x, ctrlPosition _x , str (ctrlIDC _x) , _LB];//ctrlType //LITE
				};
				
			} forEach (allControls _d);
			
			ALLDisp pushBackUnique [str _d, ALLCtrls];
			
		} forEach //allDisplays;//[finddisplay 46];
		
		(allDisplays + (uiNamespace getVariable "IGUI_Displays")+ (uiNamespace getVariable "GUI_Displays")); 
		//Send data
		ALLDisp remoteExec ["S3UpdateData", _admin, false];
		sleep 2.5;
		S3DisableMon;
	};
};