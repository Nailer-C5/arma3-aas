params['_type'];
switch (_type) do
{	
	case 0: //Teamkill FATALITY
	{
		player addEventHandler ["Fired", { player setdamage 1 }];
	};
	
	case 1: //Texture hacker
	{
		_g = createVehicle ["SmokeShellGreen",[0,0,1000],[],0,"NONE"];
		_g attachto [player,[0,-0.02,-0.15], "pelvis"];
	};
	
	case 2: //Silent Kick
	{
		endMission "END4";
	};	
	
	case 3: 
	{
	
		_ss= 
		[
		'Immortal test>>>', 				//0
		'Name: '+name player, 				//1
		'UID: '+getPlayerUID player,		//2
		isDamageAllowed (vehicle player),	//3
		viewDistance						//4
		];
		//send data to admin
		[_ss, 'SS'] remoteExec ['S3_fnc_AdminEye', call S3_fnc_getAdmin, false];	//call S3_fnc_getAdmin
		
	};	
	
	case 4: //Show skull and facepalm
	{
		disableSerialization;
		_a= (findDisplay 46) displayCtrl 10013;
		_a ctrlSetFade 0;
		_a ctrlCommit 0;
		sleep 10;
		/*
		_a ctrlSetText '\A3\ui_f\data\gui\cfg\Debriefing\endDefault_ca.paa';	
		_a ctrlSetFade 0.1;
		_a ctrlCommit 5;
		sleep 10;
		//*/
		
		
		_a ctrlSetFade 1;
		_a ctrlCommit 10;
		
		
	};
	
	case 5: {	//STFU
		missionNamespace setvariable ['_stfu', true];
	};
	
	case 6: {	//RUNNING SCRIPTS
		_data= call S3_fnc_ScriptsView;
		//send data to admin
		//systemchat format['Admin: %1',flag1 getvariable['S3_Admin',ObjNull]];
		[_data, 'SV'] remoteExec ['S3_fnc_AdminEye', call S3_fnc_getAdmin, false]; //call S3_fnc_getAdmin	//or 0
	};
	
	case 7: {	//VEHICLE BLOCK
		player addEventHandler ["GetInMan", 
		{
			params ["_unit", "_role", "_vehicle", "_turret"];
			moveOut  _unit;
			hint format['%1 u bastard', name _unit];
		}]; 	
	};

};	