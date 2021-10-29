if !( isServer) exitWith {};
KRON_UPS_Debug = 0;
R_WHO_IS_CIV_KILLER_INFO = 1;
KRON_UPS_sharedist = 1500;
KRON_UPS_comradio = 2;
KRON_UPS_Res_enemy = [west,east];
KRON_UPS_searchVehicledist = 400; // 700, 900
KRON_UPS_useVehicles = false;
if (AAS_Params_AIVehiclesUse == 1) then {KRON_UPS_useVehicles = true;};
KRON_UPS_vehicleUsePercentage = 10;
if (!(isNil "AAS_Params_AIVehiclesUsePercentage")) then {KRON_UPS_vehicleUsePercentage = AAS_Params_AIVehiclesUsePercentage;};  
KRON_UPS_useStatics = true;
KRON_UPS_useMines = true;
R_USE_SMOKE_wounded = 8;
R_USE_SMOKE_killed = 35;
KRON_UPS_flyInHeight = 90;
KRON_UPS_EAST_SURRENDER = 0;
KRON_UPS_WEST_SURRENDER = 0;
KRON_UPS_GUER_SURRENDER = 0;
R_knowsAboutEnemy = 1.49;
KRON_UPS_ambushdist = 100;
KRON_UPS_paradropdist = 250;
KRON_UPS_Cycle = 10; //org 20
KRON_UPS_react = 60;
KRON_UPS_minreact = 20; // org 30
KRON_UPS_maxwaiting = 30;
KRON_UPS_alerttime = 90;
KRON_UPS_safedist = 250; //org 300
KRON_UPS_closeenough = 300; 
KRON_UPS_reinforcement = false; 
R_GOTHIT_ARRAY =[0];
AcePresent = isClass(configFile/"CfgPatches"/"ace_main");
UPSMON_Version = "UPSMON 5.0.9";
KILLED_CIV_COUNTER = [0,0,0,0,0];
KRON_UPS_flankAngle = 45; //Angulo de flanqueo
KRON_UPS_INIT = 0; //Variable que indica que ha sido inicializado
KRON_UPS_EAST_SURRENDED = false;
KRON_UPS_WEST_SURRENDED = false;
KRON_UPS_GUER_SURRENDED = false;
KRON_AllWest=[]; //All west AI
KRON_AllEast=[]; //All east AI
KRON_AllRes=[]; //All resistance AI
KRON_UPS_East_enemies = [];
KRON_UPS_West_enemies = [];
KRON_UPS_Guer_enemies = [];
KRON_UPS_East_friends = [];
KRON_UPS_West_friends = [];
KRON_UPS_Guer_friends = [];
KRON_targets0 =[];//objetivos west
KRON_targets1 =[];//objetivos east
KRON_targets2 =[];//resistence
KRON_targetsPos =[];//Posiciones de destino actuales.
KRON_NPCs = []; //Lideres de los grupos actuales
KRON_UPS_Instances=-1;
KRON_UPS_Total=0;
KRON_UPS_Exited=0;
KRON_UPS_East_Total = 0;
KRON_UPS_West_Total = 0;
KRON_UPS_Guer_Total = 0;
KRON_UPS_ARTILLERY_UNITS = [];
KRON_UPS_ARTILLERY_WEST_TARGET = objnull;
KRON_UPS_ARTILLERY_EAST_TARGET = objnull;
KRON_UPS_ARTILLERY_GUER_TARGET = objnull;
KRON_UPS_flankAngle = 45;//Angulo de flanqueo
KRON_UPS_INIT = 0;	//Variable que indica que ha sido inicializado
KRON_AllWest = [];	//All west AI
KRON_AllEast = [];	//All east AI
KRON_targetsWest = [];	//objetivos west
KRON_targetsEast = [];	//objetivos east
KRON_TargetsResistance = [];	//resistence
KRON_targetsPos = [];	//Posiciones de destino actuales.
KRON_NPCs = [];		//Lideres de los grupos actuales
KRON_UPS_Instances = 0;
KRON_UPS_Total = 0;
KRON_UPS_Exited = 0;
KRON_UPS_TEMPLATES = [];
KRON_UPS_MG_WEAPONS = ["LMG_Mk200_F","arifle_MX_SW_F","LMG_Zafir_F"];
	if (isNil("KRON_UPS_INIT") || KRON_UPS_INIT == 0) then {
		call compile preprocessFileLineNumbers "features\UPSMON\common\MON_functions.sqf";
		UPSMON = compile preprocessFile "features\UPSMON\UPSMON.sqf";
private["_obj","_trg","_l","_pos"];
KRON_randomPos = {private["_cx","_cy","_rx","_ry","_cd","_sd","_ad","_tx","_ty","_xout","_yout"];_cx=_this select 0; _cy=_this select 1; _rx=_this select 2; _ry=_this select 3; _cd=_this select 4; _sd=_this select 5; _ad=_this select 6; _tx=random (_rx*2)-_rx; _ty=random (_ry*2)-_ry; _xout=if (_ad!=0) then {_cx+ (_cd*_tx - _sd*_ty)} else {_cx+_tx}; _yout=if (_ad!=0) then {_cy+ (_sd*_tx + _cd*_ty)} else {_cy+_ty}; [_xout,_yout]};
KRON_PosInfo = {private["_pos","_lst","_bld","_bldpos"];_pos=_this select 0; _lst=_pos nearObjects ["House",12]; if (count _lst==0) then {_bld=0;_bldpos=0} else {_bld=_lst select 0; _bldpos=[_bld] call KRON_BldPos}; [_bld,_bldpos]};
KRON_PosInfo3 = {private["_pos","_lst","_bld","_bldpos"];_pos=_this select 0; _lst= nearestObjects [_pos, [], 3];
if (count _lst==0) then {_bld=objnull;_bldpos=0} else {_bld = nearestbuilding (_lst select 0);
_bldpos=[_bld] call KRON_BldPos2}; [_bld,_bldpos]};
KRON_BldPos = {private ["_bld","_bldpos","_posZ","_maxZ"];_bld=_this select 0;_maxZ=0;_bi=0;_bldpos=0;while {_bi>=0} do {if (((_bld BuildingPos _bi) select 0)==0) then {_bi=-99} else {_bz=((_bld BuildingPos _bi) select 2); if (((_bz)>4) && ((_bz>_maxZ) || ((_bz==_maxZ) && (random 1>.8)))) then {_maxZ=_bz; _bldpos=_bi}};_bi=_bi+1};_bldpos};
KRON_BldPos2 = {private ["_bld","_bldpos"];
_bld=_this select 0; _bldpos = 1;
while {format ["%1", _bld buildingPos _bldpos] != "[0,0,0]"} do {_bldpos = _bldpos + 1;};
_bldpos = _bldpos - 1; _bldpos;};
KRON_getDirPos = {private["_a","_b","_from","_to","_return"]; _from = _this select 0; _to = _this select 1; _return = 0; _a = ((_to select 0) - (_from select 0)); _b = ((_to select 1) - (_from select 1)); if (_a != 0 || _b != 0) then {_return = _a atan2 _b}; if ( _return < 0 ) then { _return = _return + 360 }; _return};
KRON_distancePosSqr = {round(((((_this select 0) select 0)-((_this select 1) select 0))^2 + (((_this select 0) select 1)-((_this select 1) select 1))^2)^0.5)};
KRON_relPos = {private["_p","_d","_a","_x","_y","_xout","_yout"];_p=_this select 0; _x=_p select 0; _y=_p select 1; _d=_this select 1; _a=_this select 2; _xout=_x + sin(_a)*_d; _yout=_y + cos(_a)*_d;[_xout,_yout,0]};
KRON_rotpoint = {private["_cp","_a","_tx","_ty","_cd","_sd","_cx","_cy","_xout","_yout"];_cp=_this select 0; _cx=_cp select 0; _cy=_cp select 1; _a=_this select 1; _cd=cos(_a*-1); _sd=sin(_a*-1); _tx=_this select 2; _ty=_this select 3; _xout=if (_a!=0) then {_cx+ (_cd*_tx - _sd*_ty)} else {_cx+_tx}; _yout=if (_a!=0) then {_cy+ (_sd*_tx + _cd*_ty)} else {_cy+_ty}; [_xout,_yout,0]};
KRON_stayInside = {
private["_np","_nx","_ny","_cp","_cx","_cy","_rx","_ry","_d","_tp","_tx","_ty","_fx","_fy"];
_np=_this select 0; _nx=_np select 0; _ny=_np select 1;
_cp=_this select 1; _cx=_cp select 0; _cy=_cp select 1;
_rx=_this select 2; _ry=_this select 3; _d=_this select 4;
_tp = [_cp,_d,(_nx-_cx),(_ny-_cy)] call KRON_rotpoint;
_tx = _tp select 0; _fx=_tx;
_ty = _tp select 1; _fy=_ty;
if (_tx<(_cx-_rx)) then {_fx=_cx-_rx};
if (_tx>(_cx+_rx)) then {_fx=_cx+_rx};
if (_ty<(_cy-_ry)) then {_fy=_cy-_ry};
if (_ty>(_cy+_ry)) then {_fy=_cy+_ry};
if ((_fx!=_tx) || (_fy!=_ty)) then {_np = [_cp,_d*-1,(_fx-_cx),(_fy-_cy)] call KRON_rotpoint};
_np;
};
// Misc
KRON_UPSgetArg = {private["_cmd","_arg","_list","_a","_v"]; _cmd=_this select 0; _arg=_this select 1; _list=_this select 2; _a=-1; {_a=_a+1; _v=format["%1",_list select _a]; if (_v==_cmd) then {_arg=(_list select _a+1)}} foreach _list; _arg};
KRON_UPSsetArg = {private["_cmd","_arg","_list","_a","_v"];
_cmd=_this select 0;
_arg=_this select 1;
_list=_this select 2;
_a=-1;
{
_a=_a+1;
_v= format ["%1", _list select _a];
if (_v==_cmd) then {
_a=_a+1;
_list set [_a,_arg];
};
} foreach _list;
_list};
	KRON_deleteDead =
	{
		private["_u","_s"];
		_u = _this select 0;
		_s = _this select 1;
		_u removeAllEventHandlers "killed";
		sleep _s;
		deleteVehicle _u;
	};
	// MAIN UPSMON SERVER FUNCTION
	MON_MAIN_server =
	{
		//Main loop
		while {true} do
		{
			//Delete dead targets
			{
				if ((isNull(_x)) || (!(alive _x)) || (!(canMove _x))) then
				{
					KRON_targetsWest = KRON_targetsWest - [_x];
				};
			} forEach KRON_targetsWest;
			sleep 0.5;
			{
				if ((isNull(_x)) || (!(alive _x)) || (!(canMove _x))) then
				{
					KRON_targetsEast = KRON_targetsEast - [_x];
				};
			} forEach KRON_targetsEast;
			sleep 0.5;
			{
				if ((isNull(_x)) || (!(alive _x)) || (!(canMove _x))) then
				{
					KRON_TargetsResistance = KRON_TargetsResistance - [_x];
				};
			} forEach KRON_TargetsResistance;
			sleep 0.5;
			{
				switch (side _x) do
				{
					case WEST: {if (!(_x in KRON_AllWest)) then {KRON_AllWest set [count KRON_AllWest,_x];};};
					case EAST: {if (!(_x in KRON_AllEast)) then {KRON_AllEast set [count KRON_AllEast,_x];};};
				};
			} forEach allUnits;
			sleep 0.5;
			{
				if (!(alive _x)) then
				{
					KRON_AllWest = KRON_AllWest - [_x];
				};
			} forEach KRON_AllWest;
			sleep 0.5;
			{
				if (!(alive _x)) then
				{
					KRON_AllEast = KRON_AllEast - [_x];
				};
			} forEach KRON_AllEast;
			sleep 0.5;
			sleep KRON_UPS_Cycle;
		};
	};
	KRON_UPS_INIT = 1;
};
[] spawn MON_MAIN_server;
diag_log "--------------------------------";
diag_log (format["UPSMON started"]);
if(true) exitWith {};