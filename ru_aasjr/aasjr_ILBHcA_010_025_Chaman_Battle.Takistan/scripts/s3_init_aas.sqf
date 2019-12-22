AAS_V_CA=[];
S3_CAP_LOCK=false;
S3_INITJRPP = compileFinal preprocessFileLineNumbers "Rules\S3_INITJR.sqf";
call S3_INITJRPP;

//X-ray protect
_pZone= "ProtectionZone_Invisible_F";
_pZone createVehicleLocal (position (S3_aas_baselist select 0 select 4));
_pZone createVehicleLocal (position (S3_aas_baselist select ((count S3_aas_baselist)-1)  select 4));
//
/*
#define S3_SPEEDCAP 10
#define S3_CALC 1 //0.25
*/

//#define S3_SPEEDCAP  0.1	//class ver
#define S3_SPEEDCAP 0.2 //arsenal ver
#define S3_CALC  0.1 // same as initserver sleep


S3_fnc_AAS_TriggerL=
{
	params['_t'];
	sleep 3;
	_idx= parseNumber (triggerText _t);
	_zoneName= S3_aas_baselist select _idx select 3;   
	private ['_tlist1','_endTime', '_startTime', '_calcP', '_m'];
	_flag=  S3_aas_baselist select _idx select 5;
	_zoneC=  S3_aas_baselist select _idx select 0;
	_fc= true;
	
	_playSnd= true;
	
	_tlist1= List _t;//[];
	_m= 'Respawn'+str (_idx+1);
	_flag setvariable ['_unt', [_zoneC, [0,0], S3_aas_baselist select _idx select 2], true];

	while {true} do
	{
		//sleep random 0.5;
		if (_idx in AAS_V_CA) then 
		{
			_fData= _flag getvariable ['_unt', []];
			_zoneC= _fData select 0;
			_calcP= _fData select 2;
			
			_rCount= count (_tlist1 select {alive _x and side _x isEqualTo EAST and count (crew _x)>0});
			_bCount= count (_tlist1 select {alive _x and side _x isEqualTo WEST and count (crew _x)>0});
			//26AI 0.24ms	with crew 	0.152 w/o crew
			//76AI 0.673ms	with crew	0.46 w/o crew
			
			/*
			bCount=0; rCount=0;
			rCount= count (list T5 select {alive _x and side _x isEqualTo EAST and count (crew _x)>0}); 
			bCount= count (list T5 select {alive _x and side _x isEqualTo WEST and count (crew _x)>0});
			*/
			
			/* if (_bCount>_rCount and _fData select 0 isEqualTo WEST) then { _calcP= _calcP+ _bCount*S3_SPEEDCAP; };
			if (_bCount>_rCount and _fData select 0 != WEST) then {_calcP=_calcP-_bCount*S3_SPEEDCAP; };
			
			if (_rCount>_bCount and _fData select 0 isEqualTo EAST) then { _calcP= _calcP+ _rCount*S3_SPEEDCAP; };
			if (_rCount>_bCount and _fData select 0 != EAST) then {_calcP=_calcP-_rCount*S3_SPEEDCAP; }; */
			
			_bcx= (_bCount-_rCount)*S3_SPEEDCAP;
           _rcx= (_rCount-_bCount)*S3_SPEEDCAP;
 
           if (_bCount>_rCount and _fData select 0 isEqualTo WEST) then { _calcP= _calcP + _bcx };
           if (_bCount>_rCount and _fData select 0 != WEST) then { _calcP= _calcP - _bcx };
   
            if (_rCount>_bCount and _fData select 0 isEqualTo EAST) then { _calcP= _calcP + _rcx };
			if (_rCount>_bCount and _fData select 0 != EAST) then { _calcP= _calcP - _rcx };
			
			if (_calcP<0) then 
			{
				_calcP=0; 
				
				_flag spawn {
				_capA= (position _this) nearestObject 'Man'; 
				//systemchat str _capA;
				if !(isNull _capA and alive _capA) then 
				{
				_capA doMove position _this;
				};
				//systemchat str _capA;
				};
				
				
			};
			if (_calcP>100 ) then { _calcP=100; _fc= true}; 
			
			
			
			if (_calcP isEqualTo 0 and !S3_CAP_LOCK ) then //
			{
				//S3_CAP_LOCK=true;
				_nMans= nearestObjects [_flag, ['Man'], 6];
				
				_nMAN=ObjNull; 
				_dd=100;
				
				{
					_dst= _x distance _flag;
					if (_dst <_dd) then {_dd= _dst; _nMAN= _x };
				} forEach _nMans;
				
				
				
				if (count _nMans >0) then
				{
					
					_ne= _nMAN;//_nMans call bis_fnc_selectrandom;
					_sd= side _ne;
					
					if (_flag distance _ne < 15 and _zoneC != _sd and lifeState _ne in ['HEALTHY', 'INJURED']  ) then
					//if (_flag distance _ne < 6 and _zoneC != _sd and alive _ne) then
					{
						//systemchat ('CAP'+str _ne); 
						S3_CAP_LOCK=true;
						0 spawn 
						{
							sleep 2;
							S3_CAP_LOCK=false;
						};
						
						[_ne,_idx] remoteExec ["S3_fnc_TAKEFLAG", 0, false]; //-2
						_ne addScore 10; 
						_calcP= 1;
						
						_zoneC= side _ne;
						_clr= ["ColorBlue", "\A3\Data_F\Flags\Flag_blue_CO.paa"];
						if (side _ne isEqualTo east ) then {_clr= ["ColorRed", "\A3\Data_F\Flags\Flag_red_CO.paa"]};
						
						_m setMarkerColor (_clr select 0);
						
						_flag setFlagTexture (_clr select 1);
						
						//systemchat (str time+ str (S3_aas_baselist select (AAS_V_CA select 0) select 3));
						//_flag setvariable ['_unt', [_zoneC, [_rCount,_bCount], _calcP], true]; //FIX
						
						_fc= true;
						
						
						
						
						_idx spawn {
							sleep 5;
							/*
							{ 
								_x move getposATL (S3_aas_baselist select _this select 4);
							} forEach (All_Reds_grp+All_Blues_grp);
							*/
							//{_x move getposATL (S3_aas_baselist select(AAS_V_CA select 0) select 4)} forEach All_Reds_grp;
							//{_x move getposATL (S3_aas_baselist select(AAS_V_CA select 1) select 4)} forEach All_Blues_grp;
							
						};
					};
				};
				
			};
			_m setMarkerAlpha (0.5+_calcP/200);//ok

			if (_calcP <100 and _fc) then {_playSnd=false; _fc= false; [_zoneC,_idx] remoteExec ["S3_fnc_LBASE", 0, false] };
			
			_flag setvariable ['_unt', [_zoneC, [_rCount,_bCount], _calcP], true];
			
			//systemchat format['Loop>>> Zone: %1 All: %2 t: %3 CurrentA: %4 # %5', _zoneName, 47, [_rCount,_bCount],AAS_V_CA, _calcP];//_tlist1
		} /*fix*/ else
		{  
			_flag setvariable ['_unt', [_zoneC, [0,0], 100], true];
			_m setMarkerAlpha 1;
		};
		sleep (S3_CALC);	
	};
};
 

{//Setup triggers
	_id= _ForEachIndex+1;
	_side= _x select 1;
	//_x set [5, call compile format ['Flag%1', _id]];
	_t= _x select 4;
	_flag= _x select 5; 
	
	_m= createMarkerLocal [format ["Respawn%1", _id], getPos _t];
	
	_side= _x select 0;
	if (_side isEqualTo west) then { _m setMarkerColorLocal 'colorBlue'; _flag setFlagTexture "\A3\Data_F\Flags\Flag_blue_CO.paa";};
	if (_side isEqualTo east) then { _m setMarkerColorLocal 'colorRed'; _flag setFlagTexture "\A3\Data_F\Flags\Flag_red_CO.paa";};
	if (_side isEqualTo civilian) then {_m setMarkerColorLocal 'colorGreen', };
	
	_tsize= triggerArea _t;
	
	//[a, b, angle, isRectangle, c], where: 	
	_m setMarkerSize (_tsize select [0,2]); 
	
	_m setMarkerDirLocal (_tsize select 2);	
	if (_tsize select 3) then
	{
		_m setMarkerShape "RECTANGLE";
	} else {_m setMarkerShape "ELLIPSE"};
	
	_m setMarkerBrushLocal "SolidBorder";
	
	
	_t setTriggerText str (_id-1); //_t setTriggerText str (_id-1); 
	if (isServer) then 
	{
		_flag setVariable ['_unt', [_x select 0, [0,0], _x select 2], true];
		//_m= format ['Respawn%1', _id];
		//_t = createTrigger["EmptyDetector", getMarkerPos _m, false];
		
		//_size = getMarkerSize _m;
		//systemchat str _size;
		
		//_isRectangle= false;
		//if (markerShape _m == "RECTANGLE") then {_isRectangle= true;};
		//_t setTriggerArea [_size select 0, _size select 1,  markerDir _m, _isRectangle, 10];
		
		//to DEL
		_t setTriggerTimeout [0.5, 0.5, 0.5, false];
		_t setTriggerActivation["ANY","PRESENT", true]; //repeating true??? DEl
		//_t setTriggerStatements["this", "",""];
	
		//"Hint ('OFF'+triggerText thistrigger )"
		_t spawn  S3_fnc_AAS_TriggerL;
		
		//systemchat str (TriggerStatements _t);
		//hint str (list _t)
	}
	
	else
	{
		//to DEL
		_t setTriggerTimeout [1, 1, 1, false];
		_t setTriggerActivation["ANY","PRESENT", true]; //repeating true??? DEl
		_t setTriggerStatements["player inarea thisTrigger", "Hint format[Localize 'STR_S3_You_in_zone', S3_aas_baselist select (parseNumber (TriggerText thisTrigger)) select 3];","hint '';"];
		//_t setTriggerStatements["player inarea thisTrigger", "Hint ('You in zone '+ S3_aas_baselist select _id select 3);","hint '';"];
	};
	
	
} forEach S3_aas_baselist;

//Draw zones lines MArkers
//if !(hasInterface) then //777
_color="ColorOrange";
if (isServer) then 
{
	_S3countAllBases= (count S3_aas_baselist)-1;
	{
		if (_forEachIndex != _S3countAllBases) then
		{
			_pos1= getMarkerPos ('Respawn'+str(_forEachIndex+1));
			_pos2= getMarkerPos ('Respawn'+str(_forEachIndex+2));
			_angle = ((_pos2 select 0) - (_pos1 select 0)) atan2 ((_pos2 select 1) - (_pos1 select 1));	
			_dist = _pos1 distance2D _pos2;
			_centre = [(_pos1 select 0) + ((sin _angle) * _dist / 2), (_pos1 select 1) + ((cos _angle) * _dist / 2)];
			
			_mrk_line= createMarker [format ["Line%1", _forEachIndex], _centre];
			_mrk_line setMarkerShape "RECTANGLE";	
			_mrk_line setMarkerAlpha 0.8;
			_mrk_line setMarkerSize [3, _dist / 2];
			_mrk_line setMarkerColor _color;
			_mrk_line setMarkerDir _angle;	
		};
		
		_id = _forEachIndex + 1;
		_mrk_name = createMarker [format ["TMZ%1", _id], getmarkerPos ('Respawn' + str _id)];
		_mrk_name setMarkerType "mil_dot";
		_mrk_name setMarkerAlpha 0.95;
		_mrk_name setMarkerSize [1.5, 1.5];
		_mrk_name setMarkerText (_x select 3);
		_mrk_name setMarkerColor _color;
	} forEach S3_aas_baselist;
};
S3_INIT_DONE= true;