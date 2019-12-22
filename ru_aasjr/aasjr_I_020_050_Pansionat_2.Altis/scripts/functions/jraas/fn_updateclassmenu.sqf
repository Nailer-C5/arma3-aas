disableSerialization;

params ['_display'];

_ctrlBG= uiNamespace getVariable 'fastClassDialog_BG';

//_fcCtrl= _display ctrlCreate ['RSCListBox', -1];

_idx= 0;

_1= _display ctrlCreate ["RscStructuredText", -1];

uiNamespace setVariable ['fastClass_1',_1];
S3_PreviewBOX=[];



Update_PR=
{
	params ['_control'];
	_data= _control getVariable 'S3_PreviewBOX';
	
	_1wTxt= format["<a align='Center' color= '#FFFF00' shadow='2'>%1</a><br/> <img align='Center' size='5' shadow='0' image='%2'/> <br/> <a align='Center' shadow='2'> %3</a> ",  _data select 1, _data select 2 select 0, _data select 2 select 1]; 
	_1wTxt= _1wTxt+format["<br/> <img align='Center' size='5' shadow='0' image='%1'/> <br/> <a align='Center' shadow='2'> %2</a> ",  _data select 3 select 0, _data select 3 select 1]; 
	
	_1wTxt= _1wTxt+format["<br/> <img align='Center' size='5' shadow='0' image='%1'/> <br/> <a align='Center' shadow='2'> %2</a> ",  _data select 5 select 0, _data select 5 select 1]; 
	
	_c1= uiNamespace getVariable 'fastClass_1';
	_c1 ctrlSetStructuredText parseText _1wTxt; 
	_c1 ctrlCommit 0; 
	
	
	
	systemchat str _data;
};

_py=0;
{
	_x params [	["_classData",[]],['_allClasses',[]]];
	_classData params [	["_className", ''], ["_classImage", ''] ];
	_classId= _forEachIndex;
	
	//systemchat str _allClasses;


	_a= _display ctrlCreate ["RscStructuredText", -1];
	_a ctrlSetPosition [safezoneX+0.308, _py+0.03, 0.5, 0.12];
	_txt= format["<img size='1.3' image='%1' /> <a shadow='2'>    %2 </a>", _classImage, _className];

	_a ctrlSetStructuredText parseText _txt;
	_a ctrlCommit 0;
	
	
	_temp_x= safezoneX+0.6;
	_subclassID=0;
	{
		if (_forEachIndex>4) ExitWith {};
		if (_forEachIndex != count (S3_JrAAS_RULES select _classId select 1)-1) then
		{
			
			_tc= _display ctrlCreate ["RscActivePictureKeepAspect", -1];
			_tc ctrlSetActiveColor [2,2,2,1];
			_tc ctrlSetTextColor [0,1,0,1];
			
			_tc ctrlSetEventHandler ["MouseEnter", "params ['_control']; [_control] call Update_PR "];
			_tc ctrlSetEventHandler ["MouseExit", "params ['_control']; _control ctrlSetScale 1; _control ctrlCommit 0; "];
			
	
			_tc ctrlSetPosition [_temp_x, _py, 0.12, 0.12];
			
			systemchat str _x;
			
			_pic='';
			_name='';
			
			_pich='';
			_nameh='';
			
			_picu='';
			_nameu='';
			if (_x isEqualType []) then 
			{
				_txt= _x select 0;
				_pic= getText (configFile >> 'CfgWeapons' >>  _x select 1 select 0 select 0 >> 'Picture');
				_name= getText (configFile >> 'CfgWeapons' >>  _x select 1 select 0 select 0 >> 'DisplayName');
				
				//[['SMG_05_F','','','',['30Rnd_9x21_Mag_SMG_02',30],[],''],[],['hgun_P07_F','','','',['16Rnd_9x21_Mag',16],[],''],['U_Flames_AM',[['30Rnd_9x21_Mag_SMG_02',9,30],['16Rnd_9x21_Mag',2,16]]],['V_Chestrig_blk',[]],[],'H_Booniehat_khk','G_Sport_Blackred',[],['ItemMap','ItemGPS','','ItemCompass','','']]]
				_pich= getText (configFile >> 'CfgWeapons' >>  _x select 1 select 2 select 0 >> 'Picture');
				_nameh =getText (configFile >> 'CfgWeapons' >>  _x select 1 select 2 select 0 >> 'DisplayName');
				
				_picu= getText (configFile >> 'CfgWeapons' >>  _x select 1 select 3 select 0 >> 'Picture');
				_nameu= getText (configFile >> 'CfgWeapons' >>  _x select 1 select 3 select 0 >> 'DisplayName');
				/*
				_fcCtrl lbAdd _txt;
				_fcCtrl lbSetData [_idx, str  (_x select 1) ];
				_fcCtrl lbSetPicture [_idx, getText (configFile >> 'CfgWeapons' >>  _x select 1 select 0 select 0 >> 'Picture') ];
				*/
				
			} 
			else
			{
				_txt= gettext(configFile >> 'CfgVehicles' >> _x  >> 'displayName');
				_pic= getText (configFile >> 'CfgWeapons' >> getarray(configFile >> 'CfgVehicles' >> _x  >> 'weapons') select 0 >> 'Picture');
				_name= getText (configFile >> 'CfgWeapons' >> getarray(configFile >> 'CfgVehicles' >> _x  >> 'weapons') select 0 >> 'DisplayName');
				
				/*_fcCtrl lbAdd _txt;
				_fcCtrl lbSetData [_idx, _x];
				_fcCtrl lbSetPicture [_idx, getText (configFile >> 'CfgWeapons' >> getarray(configFile >> 'CfgVehicles' >> _x  >> 'weapons') select 0 >> 'Picture')];
				*/
				
			};
			_tc ctrlSetText _pic;
			_tc setVariable ['S3_PreviewBOX',[[_classID, _subclassID],_txt, [_pic,_name],[_pich, _nameh],[],[_picu,_nameu] ] ];
			_tc ctrlCommit 0;
			_idx= _idx+1;
			_temp_x= _temp_x+0.12;
		};
		_subclassID= _subclassID+1;
	} forEach _allClasses;
	
	_py= _py+0.12;
	
	
	
	
} forEach S3_JrAAS_RULES;


_ctrlBG ctrlSetPosition [safezoneX+0.308, 0, 0.99,_py+0.03];
_ctrlBG ctrlSetBackgroundColor [0.3,0.3,0.3,0.6];
_ctrlBG ctrlCommit 0;

_box= uiNamespace getVariable 'fastClassDialog_BGP';

_box ctrlSetPosition [safezoneX+0.308+1, 0, 0.408, _py+0.03];
_box ctrlSetBackgroundColor [0.5,0.5,0.5,0.95];
_box ctrlCommit 0;

_1 ctrlSetPosition [safezoneX+0.308+1, 0.03, 0.5, _py+0.03];
_1 ctrlCommit 0;
/*
_fcCtrl ctrlSetPosition [safezoneX+0.8, 0, 0.5,_py+0.03];
_fcCtrl ctrlSetBackgroundColor  [1, 1, 0, 1];
_fcCtrl ctrlSetFontHeight S3_ACtionsLbFH;
_fcCtrl ctrlCommit 0;
*/