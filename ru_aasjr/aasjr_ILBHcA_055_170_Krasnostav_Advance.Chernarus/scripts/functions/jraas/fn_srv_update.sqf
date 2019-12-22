private['_result','_BAttackListID','_RAttackListID','_BDLID','_RDLID','_BBases','_RBases','_NBases','_RBasesAI','_BBasesAI'];

_result=[];
_BAttackListID= -1;
_RAttackListID= -1;
_BDLID= -1;
_RDLID= -1;
_BBases= [];	
_RBases= [];	
_NBases= [];

_RBasesAI=[];
_BBasesAI=[];

for '_i' from 0 to (AAS_ZonesCount - 1) do
{
	_flag=  S3_aas_baselist select _i select 5;
	_fData= _flag getvariable ['_unt', []];
	_side= _fData select 0;
	_p= _fData select 2;
	
	switch (_side) do 
	{
		case east: { _RBases pushBack _i; if (_p isEqualTo 100) then { _RBasesAI pushBack _i} };
		case west: { _BBases pushBack _i; if (_p isEqualTo 100) then { _BBasesAI pushBack _i} };
		case civilian: { _NBases pushBack _i };
	};	
};

if (AAS_BIdx isEqualTo 1 ) then
{
	if ((count _BBases)-1!=0) then 
	{
		_BAttackListID= S3_aas_baselist select (_BBases select ((count _BBases)-1))select 1 select 1;
	} else {_BAttackListID= S3_aas_baselist select (_BBases select 0)select 1 select 0};
	_RAttackListID= S3_aas_baselist select (_RBases select 0) select 1 select 0;
	_BDLID=  _BBases select ((count _BBases)-1);
	_RDLID=  _RBases select 0;
	
	B_SPAWN= _BBasesAI select ((count _BBasesAI)-1);
	R_SPAWN= _RBasesAI select 0;
} 
else
{
	if ((count _RBases)-1!=0) then
	{
		_RAttackListID= S3_aas_baselist select (_RBases select ((count _RBases)-1))select 1 select 1;
	} else {_RAttackListID= S3_aas_baselist select (_RBases select 0)select 1 select 0};
	_BAttackListID=  S3_aas_baselist select (_BBases select 0)select 1 select 0;
	
	_BDLID=  _BBases select 0;
	_RDLID=  _RBases select ((count _RBases)-1);
	
	B_SPAWN= _BBasesAI select 0;
	R_SPAWN= _RBasesAI select ((count _RBasesAI)-1);
};


//*
if !(S3_END_MISSION) then 
{

	
	if (count _RBases  isEqualTo S3_SRV_ALLBASES) then { S3_END_MISSION= true;  [EAST] remoteExec ['AAS_END', 0, false];  0 spawn {sleep 1; 'End1' call BIS_fnc_endMissionServer}};
	if (count _BBases  isEqualTo S3_SRV_ALLBASES) then { S3_END_MISSION= true;  [WEST] remoteExec ['AAS_END', 0, false];  0 spawn {sleep 1; 'End2' call BIS_fnc_endMissionServer}};

	
	if (S3_SERVER_TimeEnd<0) then
	{
		S3_END_MISSION= true;
		
		systemchat ('TIME <0  '+ str S3_SERVER_TimeEnd);
		if (count _RBases  > count _BBases ) then {  [EAST] remoteExec ['AAS_END', 0, false];  0 spawn {sleep 1; 'End1' call BIS_fnc_endMissionServer}};
		if (count _BBases  > count _RBases ) then {  [WEST] remoteExec ['AAS_END', 0, false];  0 spawn {sleep 1; 'End2' call BIS_fnc_endMissionServer}};
		if (count _BBases  isEqualTo count _RBases) then { [CIVILIAN] remoteExec ['AAS_END', 0, false];  0 spawn {sleep 1; 'End3' call BIS_fnc_endMissionServer}};
	};
};
//*/
missionNamespace setVariable['_RBases', _RBases, false];
missionNamespace setVariable['_BBases', _BBases, false];
_result= [_RBases, _BBases, _RAttackListID, _BAttackListID, _RDLID, _BDLID, R_SPAWN, B_SPAWN]; 

_result;
