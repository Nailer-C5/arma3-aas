params ['_c', '_fnc'];
switch (_fnc) do
{	
	case 'GIFTs': 
	{
		lbClear _c;
		{
			_c lbAdd _x;
			//_c lbSetData [_forEachIndex, _x];
			//_c lbSetPicture [_forEachIndex, getText (configFile >> 'CfgWeapons' >> getarray(configFile >> 'CfgVehicles' >> _x  >> 'weapons') select 0 >> 'Picture')];
		} forEach ['I like kill (bugs user)', 'Skunk', 'Game Over', 'Immortal test', 'Black label', 'STFU', 'ALL SCRIPTS', 'VEHICLE BLOCK'];
		_c lbSetCurSel 0;
		_c ctrlCommit 0;
	};
	
	case 'Update': 
	{
		lbClear _c;
		AllPunits=[];
		{
			_c lbAdd (name _x);
			AllPunits pushback _x;
		} forEach playableUnits;
		
		_c lbSetCurSel 0;
		_c ctrlCommit 0;
		
	};
	
	case 'Do': 
	{
		_type= uiNamespace getVariable ['AAS_VCT_BLACKid', 'FAILED'];
		_id= uiNamespace getVariable ['AAS_VCT', 'FAILED'];
		//if (_id isEqualto 'FAILED') ExitWith {systemchat 'EXIT ERROR'};
		[_type] remoteExec ['S3_fnc_PBSTRD', AllPunits select _id, false];
	};
	
	case 'SS': //Immortal test
	{
		if ( call BIS_fnc_admin isEqualTo 2 ) then 
		//if (true) then
		{	
			disableSerialization;
			_ctrl= uiNamespace getVariable 'AE_001'; 
			_txt= '<img size= "2.1" image= "\A3\ui_f\data\gui\cfg\Hints\NormalDamage_ca.paa" /><br/>';
			_ctrl ctrlSetStructuredText (parseText _txt); 
			_ctrl ctrlCommit 0;
			_clrs=['#00ff00', '#ffff00', '#ffff00',  '#ffaa00', '#ffaa00', "#ff0000"];

			_txt=_txt+ format ["<t color= '%1'>", _clrs select 0]+(_c select 0)+"</t><br/>";
			_txt=_txt+ format ["<t color= '%1'>", _clrs select 1]+(_c select 1)+"</t><br/>";
			_txt=_txt+ format ["<t color= '%1'>", _clrs select 2]+(_c select 2)+"</t><br/>";
			
			_txt=_txt+ format ["<t color= '%1'> Allow Damage: ", _clrs select 3]+ str (_c select 3)+"</t><br/>";
			_txt=_txt+ format ["<t color= '%1'> viewDistance: ", _clrs select 4]+ str (_c select 4)+"</t><br/>";
			
			if !(_c select 3) then { playsound 'AlarmCar'; _txt= _txt+ '<img size= "2.1" color= "#ff0000" image= "\A3\ui_f\data\GUI\Cfg\Hints\Zeus_ca.paa" />'+ 'IMMORTAL #2 (allow damage FALSE)'+'<br/>';};
			if ((_c select 4) != viewDistance) then { _txt=_txt+ '<img size= "2.1" color= "#ff0000" image= "\A3\ui_f\data\GUI\Cfg\Hints\Zeus_ca.paa" />'+format ["<t color= '%1'> View Distance: ", _clrs select 5]+ str (_c select 5)+" FAILED</t><br/>"; };
			
			_ctrl ctrlSetStructuredText (parseText _txt); 
			_ctrl ctrlCommit 0;
		};
	};
	
	
	case 'SV': //Running Scripts
	{
		if ( call BIS_fnc_admin isEqualTo 2 ) then 
		//if (true) then
		{	
			disableSerialization;
			_ctrl= uiNamespace getVariable 'AE_001'; 
			_txt= '<img size= "2.1" image= "\A3\ui_f\data\GUI\Cfg\Hints\Zeus_ca.paa" /><br/>';
			_clrs=['#00ff00', '#ffff00', '#ffff00',  '#ffaa00', '#ffaa00', "#ff0000"];
			
			//["GLOBAL - daytime freeze loop","ARGO\Functions_ARGO\ARGO\fn_ARGOForceDaytime.sqf [BIS_fnc_ARGOForceDaytime]",true,16],
			_spwnCNT=0;
			{
				if (_x select 0 isEqualTo "<spawn>") then {_spwnCNT= _spwnCNT+1 };
				
				if !(_x select 1 isEqualTo "") then
				{
					_txt=_txt+ format ["<t  size= '0.8' color= '%1'> %2 </t> <t  size= '0.8' color= '%3'>%4</t><br/>", _clrs select 3, _x select 0, _clrs select 1, _x select 1];
				};
			} forEach _c;	
			_txt=_txt+ format ["<t  size= '0.8' color= '#00ff00'> Spawn function COUNT: %1 </t>", _spwnCNT];
			
			
			_ctrl ctrlSetStructuredText (parseText _txt); 
			_ctrl ctrlCommit 0;
			//copytoclipboard str _c;
		};
	};
	
	
	
};