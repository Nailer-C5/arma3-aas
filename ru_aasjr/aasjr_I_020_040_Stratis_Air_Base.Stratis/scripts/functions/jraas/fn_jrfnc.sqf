params ['_obj', '_fnc'];


//systemchat str _this;

switch (_fnc) do 
{	
	
	
	
	
	
	
	

	
	
	
	case 'InitInline': 
	{
	};

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	case 'AmmoBox': 
	{
		//RGO//
		
		_color= '#FFFF00';
		waituntil { alive player };
		if( playerSide == west ) then {	_color= '#00AAFF' };
		if( playerSide == east ) then {	_color= '#FF0000' };

		_obj addAction [format[localize "STR_S3_Heal", _color], 
		'player setDamage 0; hint localize "STR_S3_Healed"', nil, 101, true, true, "", "", 5, false];
		
		_obj addAction [format[localize "STR_S3_Respawn_M", _color], 
		'hint localize "STR_S3_RESPAWN_3"; createDialog "S3RespawnDialog"', nil, 99, false, true, "", "", 5, false];
		
		_obj addAction [format[localize "STR_S3_Save_2", _color], 
		'call S3_fnc_SaveCustomLoadout', nil, 98, false, true, "", "", 5, false];
		
		_obj addAction [format[localize "STR_S3_Load_2", _color], 
		'call S3_fnc_LoadCustomLoadout', nil, 97, false, true, "", "", 5, false];
	
		/////server////
		/* _obj addAction [format["<t size='1.5'color= '%1'> Save <img size='1.5' align='Right' color='#ffffff' shadow='1.5' image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\S_ca.paa'/>", _color], 
		'call S3_fnc_SaveCustomLoadoutSRV', nil, 96, false, true, "", "", 5, false]; */
			
		/* _obj addAction [format["<t size='1.5'color= '%1'> Load  <img size='1.5' align='Right' color='#ffffff' shadow='1.5' image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa'/>", _color], 
		'call S3_fnc_LoadCustomLoadoutSRV', nil, 95, false, true, "", "", 5, false];  */
		
		//class arsenal
		_obj addAction [format[localize "STR_S3_Arsenal", _color], 
		'call fnc_ADD_ARSENAL_content;["Open",[nil, VIRTUAL_BOX, player]] call bis_fnc_arsenal', nil, 100, true, true, "", "",10, false];

		//full arsenal
		/* _obj addAction [format["<t size='1.5'color= '%1'> Arsenal <img size='1.5' align='Right' color='#ffffff' shadow='1.5' image='\A3\ui_f\data\igui\cfg\actions\landingAutopilot_ON_ca.paa'/>", _color], 
		'["Open",[nil, VIRTUAL_BOX, player]] call bis_fnc_arsenal', nil, 100, true, true, "", "",10, false];  */
		
		//_obj addEventHandler ["HandleDamage",{0}];
		_obj allowDamage false;
	  #include "..\..\..\Rules\ammocrate.sqf"	//rhs

	//};
	};

	case 'WeaponReload': 
	{
		_wpnsp= [primaryWeapon player, secondaryWeapon player, handgunWeapon player]; 
		//_wpnsp= weapons player;
		_magsp= magazines player;
		{
		private['_type', '_muzzles'];
		_type =  _x;
		_muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");



		if (count _muzzles > 1) then
		{
		_supportMags= getArray (configFile >> "CfgWeapons" >> _type >> _muzzles select 1 >> "magazines");
		/*hint format ["TypeW: %1 Muzzles: %2 Magsplayer %3 SupportMags: %4",  _type, _muzzles,_magsp, _supportMags];*/
		{ if (_x in _supportMags) exitWith { player addWeaponItem [_type, [_x, 1, _muzzles select 1]]; /*player commandchat format["Im load %1",_x];*/ }; } forEach _magsp;
		};

		_supportMags= getArray (configFile >> "CfgWeapons" >> _type >> "magazines");
		{ if (_x in _supportMags) exitWith { player addWeaponItem [_type, _x]; }; } forEach _magsp;


		} forEach _wpnsp;
	};
			
		
};
