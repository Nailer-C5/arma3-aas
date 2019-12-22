//if (true) ExitWith {};
if !(isServer) ExitWith {};//exit if client
params ['_unit'];
[_unit] spawn 
{
	params ['_unit'];
	//sleep 1;
	_oldWP= _unit getVariable '_CWP'; 
	_oT= waypointType _oldWP;
	
	//systemchat format['WP complete: %1 Type: %2', _oldWP, _oT ];//DEBUG

	//deleteWaypoint _oldWP;
	_wg= group _unit;
	
	while {(count (waypoints _wg)) > 0} do
	{
		deleteWaypoint ((waypoints _wg) select 0);
	};
	
	deleteVehicle (_unit getVariable ['_hlp',objNull]);  
	
	
	_att= _unit getVariable ['_s', 0]; 
	
	_target=  (S3_aas_baselist select(AAS_V_CA select _att) select 5);
	
	
	
	
	//_target=_unit;

	_wType= 'Move';

	if (_oT=='GETOUT') then { _wType= 'Move'; };
	if (_oT=='GETIN') then { _wType= 'Move';};
	//if (_oT=='MOVE' and typeOf vehicle _unit isKindOf 'CAR') then { _wType= 'GETOUT'};
	if (_oT=='MOVE' and !(typeOf vehicle _unit isKindOf 'MAN')) then { _wType= 'GETOUT'};
	
	if (_oT in ['MOVE'] and typeOf vehicle _unit isKindOf 'MAN') then 
	{
		//_unit setSkill ['courage', 1]; 
		//playsound 'alarm'; 
		if (random 1<0.5) then
		{
			_nO= (nearestObjects [_unit, ["Car","Tank","Air"], 100]) select {alive _x};
			if (count _nO>0)  then 
			{
				_wType= 'GETIN';
				_veh= _nO call bis_fnc_selectrandom;
				_target= _veh;
				_unit reveal _target;
				sleep 1;
				//systemChat str(_veh);//DEBUG
			};
		};

		
	};
	
	/*
	_hlp= createVehicle ["Sign_Arrow_Green_F", [0,0,0],[],0,"CAN_COLLIDE"];
	_unit setVariable ['_hlp', _hlp, false];  
	_hlp attachTo [_target,[0,0,2]];
	*/
	
	_wp1 = (group _unit) addWaypoint [_target, 5 ]; 
	_wp1 setWaypointType _wType;
	
	_wp1 waypointAttachObject _target;
	sleep 3;
	_wp1 setWaypointStatements ['true', "[this] call S3_fnc_BastardWP;"];
	//_wp1 setWaypointCompletionRadius 0;
	//currentWaypoint groupName 

	_wp1 setWaypointSpeed "FULL";
	
	
    //_wp1 setWaypointPosition [ position _pos, 12];
	
	_unit setVariable ['_CWP', _wp1, false];  
	
	_wg setCurrentWaypoint _wp1;
	//_wg setCurrentWaypoint _wp1;
	
	
	
	//_wp1 setWaypointBehaviour "AWARE";
//	systemchat  format['CUR WP: %1 p: %2', waypointType ((waypoints _wg) select ( currentWaypoint _wg)), _target ];//DEBUG
	//systemchat  format['ALL WP: %1',(waypoints _wg) ];//DEBUG
};