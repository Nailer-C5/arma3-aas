fnc_AAS_LOW_GEAR={
_pv= vehicle player;
_pv setVariable ["Low gear", !(_pv getVariable ["Low gear", false]),true];
_speed = 2.8; //turbo acc

if (_pv getVariable ["Low gear", false]) then 
{
hint Localize "STR_S3_Low_gear_on";
waituntil
{
	_vel = velocity _pv;
	_dir = direction _pv;

	if ((Driver _pv ==player) and (inputAction "MoveForward" >0)) then 
	{
		if (speed _pv <20) then { _pv setVelocity [(_vel select 0) + (sin _dir *_speed), (_vel select 1) + (cos _dir*_speed), (_vel select 2)]; }; 
		if (speed _pv >30) then { _pv setVelocity [(_vel select 0) - (sin _dir* _speed/2), (_vel select 1) - (cos _dir*_speed/2), (_vel select 2)];};
	};
	sleep 0.2;
	(!(_pv getVariable ["Low gear",false]) or (isNull (Driver _pv)) or (isOnRoad _pv)or !(canMove _pv));
};
_pv setVariable ["Low gear", false,true];
hint Localize "STR_S3_Low_gear_off";
};
};

fnc_AAS_GUNNER_F=
{//r15
private ["_vehP", "_pylons", "_pylonPaths","_pylAmmo","_pilot"];
if ( (Driver (vehicle player) == player) or (gunner (vehicle player) == player) ) then
{
	_vehP= (vehicle player);
	_pilot= _vehP getVariable ["S3_PC", true];
	_pylons= getPylonMagazines _vehP;
	_pylAmmo=[];
	{ _pylAmmo = _pylAmmo+ [_vehP AmmoOnPylon (_foreachindex+1)]; } forEach _pylons;   
	{ _vehP removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach _pylons;	
	if (_pilot) then 
	{//PILOT
		{ 				
			_vehP setPylonLoadOut [_forEachIndex + 1, _x, true, []]; //[_vehP,[_forEachIndex + 1, _x,true,[]]] remoteexec ["setPylonLoadOut",[]];	
			_vehP setAmmoOnPylon [_forEachIndex + 1, _pylAmmo select _forEachIndex]; //[_vehP,[_forEachIndex + 1,_pylAmmo select _forEachIndex]] remoteexec ["SetAmmoOnPylon",[]];
		} forEach _pylons;		
		(vehicle player) vehiclechat Localize "STR_S3_PILOT_CONTROL";
	}
	else
	{//GUNNER
		_pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _vehP >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
		{ 
			_vehP setPylonLoadOut [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex]; 
			//[_vehP,[_forEachIndex + 1, _x,true,_pylonPaths select _forEachIndex]] remoteexec ["setPylonLoadOut",0];	
			_vehP setAmmoOnPylon [_forEachIndex + 1, _pylAmmo select _forEachIndex]; 
			//[_vehP,[_forEachIndex + 1,_pylAmmo select _forEachIndex]] remoteexec ["SetAmmoOnPylon",0];
		} forEach _pylons;
			(vehicle player) vehiclechat  Localize "STR_S3_GUNNER_CONTROL";
	};	 
	_vehP setVariable ["S3_PC", not (_pilot), true];
};

};

fnc_AAS_SAB_BOMB={
_pv= vehicle player;
_pv setvariable ["bomb",[true, side player], true];
player removeMagazineGlobal "DemoCharge_Remote_Mag";
waituntil 
{
	sleep 0.5;
	isEngineOn _pv; 
};
_pv setvariable ['bomb',[false,civilian]];
sleep (1+random 3);
[player, _pv] remoteExec ['AAS_BombVehicle', 2, false];//to server
};

fnc_AAS_JUMPAIR={
[player,(position player select 2)-10] call BIS_fnc_halo; 
};

fnc_AAS_ADD_V_ACTIONS={
params['_vehicle'];
_vehicle disableTIEquipment true;  

if (_vehicle getvariable ['bomb',[false,civilian]] select 1 == side player) then
{
	hintc Localize 'STR_S3_Team_Member';//стринг
	playSound 'AlarmCar';
};

if (_vehicle isKindof 'Tank') then
{
	_vehicle setVariable ["Low gear", false,true];
	_vehicle addAction [Localize "STR_S3_Low_gear_on_2",{0 spawn fnc_AAS_LOW_GEAR}, -1, 6, true, true,"", "(Driver _target == player) and (!isOnRoad _target) and !(_target getvariable 'Low gear') and (speed _target <30)"];
	_vehicle addAction [Localize "STR_S3_Low_gear_off_2",{0 spawn fnc_AAS_LOW_GEAR}, -1, 6, true, true,"", "(Driver _target == player) and (_target getvariable 'Low gear')"];
};

if (_vehicle isKindof 'Air') then 
{
	_vehicle addAction [Localize "STR_S3_Bail_Out",{0 spawn fnc_AAS_JUMPAIR}, -1,9, false, true, "", "(player in _target) and ( (getPosATL _target) select 2 >100)"];
//	3 fadeSound 0.4; 
//	hint composeText ["AUTO EARPLUGS INSERTED"];
    _pylons= getPylonMagazines _vehicle;
	if (count (_pylons)>1) then
	{
		_vehicle addAction [Localize "STR_S3_GUNNER_DRIVER_Fire", {[] spawn fnc_AAS_GUNNER_F}, -1, 9, false, true, "", "(player in _target)"];			
	};
};

if (_vehicle isKindof 'land') then 
{
  //  3 fadeSound 0.4; 
  //	hint composeText ["AUTO EARPLUGS INSERTED"];
	_vehicle addAction ["",{[] spawn fnc_AAS_SAB_BOMB}, -1, 6, false, true, "", "(player in _target) and ('DemoCharge_Remote_Mag' in magazines player) and !((_target getvariable ['bomb',[false, civilian]])select 0) and !(isEngineOn _target)"];
};	

};

//SETUP
player addEventHandler ["GetInMan", " (_this select 2) spawn fnc_AAS_ADD_V_ACTIONS;"]; 
player addEventHandler ["GetOutMan", "removeAllActions (_this select 2); 10 fadeSound 1;"];

fnc_AAS_EARPLUGS={
	_ea= !(player getvariable['_EARPLUGS',false]); 
	if (_ea) then 
	{
		player setUserActionText [AAS_VM_EA_ID, localize "STR_EARPLUGS_OFF"]; 
		3 fadeSound 0.4; 
		{_x setSpeaker "NoVoice";} forEach allUnits;
		hint parseText localize "STR_EARPLUGS_ON2";
	} else 
	{ 
		player setUserActionText [AAS_VM_EA_ID, localize "STR_EARPLUGS_ON3"]; 
		3 fadeSound 1; 
		hint parseText localize "STR_EARPLUGS_OFF2";
	}; 
	player setvariable['_EARPLUGS', _ea, false]  
};

fnc_AAS_AIGroup= {
	_grP= group player;
	[cursorObject] join grpNull;
	[cursorObject] join _grP;
	cursorObject setVariable ['_jrGroup', _grP, true]; 
	doStop (units player);
	_grP selectLeader player;
	(units player) doFollow leader _grP;
	0 spawn 
	{
		hint 'AI ready';
		sleep 2;
		hintsilent '';
	};
	
};

//Player Actions
fnc_AAS_ADD_PLAYER_ACTIONS={
	//player enableFatigue false;
	missionNamespace setVariable["S3_AltState",false];
	missionnamespace setvariable ['S3_TKC',0, false];
	//player addrating 5000000;
	
    //[unit,uniformMags,vestMags,BackpackMags] call BIS_fnc_limitAmmunition 
	[player,[],[0.1,0.1],[0,0.5]]  call BIS_fnc_limitAmmunition;
		
	//player setCustomAimCoef 0.5; 
    //player setUnitRecoilCoefficient 0.65;
	
	player setvariable['_EARPLUGS', false, false];
	AAS_VM_EA_ID= player addAction [Localize "STR_EARPLUGS_ON",{ [] spawn fnc_AAS_EARPLUGS }, -1,0,false, true, "", ""];	
/* 
	player addAction ["<t size='1.2' color='#22FF22'> Follow me</t>","call fnc_AAS_AIGroup", -1, 100,true, true, "", "cursorObject isKindOf 'MAN' and (side cursorObject) isEqualTo playerSide and (Player distance cursorTarget < 6)"]; */
	
	player addAction [Localize "STR_MELEE","call S3_fnc_Melee", nil, 76, true, true, "", "(Player != cursorTarget) and ! ((cursorTarget getVariable[ '_side',playerSide]) isEqualTo playerside) and (Player distance cursorTarget < 2.5) and (cursorTarget isKindOf 'Man')&& alive cursorTarget "];
	
	player addAction[Localize "STR_FLIP", {cursorObject setVectorUp [0,0,1]}, 0,10, true, true, "", "_CO = cursorObject; (vectorUp _CO select 2 < 0.5 and _CO iskindOf 'LandVehicle' and player distance _CO < 5 )"];
	
};





//*

arrow = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
arrow setObjectTexture [0, "#(rgb,8,8,3)color(1,1,0,0.0)"];
arrow setObjectMaterial [0,"A3\Structures_F\Data\Windows\window_set.rvmat"];

//SETUP
0 spawn fnc_AAS_ADD_PLAYER_ACTIONS;
player addEventHandler ["Respawn", { params['_new']; 0 spawn fnc_AAS_ADD_PLAYER_ACTIONS; }]; 


//v3
//player setDamage 0.25;
//player setBleedingRemaining 120;
PP_var_IN_hndl = ppEffectCreate ["ColorCorrections", 1707];
PP_var_IN_hndl ppEffectAdjust [1,0,0,[0.6,0,0,0.3],[1,0,0,0.2],[0.013,0.83,0.83,0],[0.5,0.3,-0.2,0.02,0,0,0.5]];
PP_var_IN_hndl ppEffectEnable false;
PP_var_IN_hndl ppEffectCommit 1.5;

PP_var_Blood_hndl = ppEffectCreate ["WetDistortion", 140];//WetDistortionFilmGrain 104
PP_var_Blood_hndl ppEffectAdjust [1, 1, 1, 4.10, 3.70, 2.50, 1.85, 0.004, 0.004, 0.002, 0.002, 0.5, 0.3, 20.0, 16.0];
PP_var_Blood_hndl ppEffectEnable false;
PP_var_Blood_hndl ppEffectCommit 1.5;



fnc_PPEffect_INC= {
	params ['_enabled'];
	player action ["nvGogglesOff",player];
	{_x ppEffectEnable _enabled; _x ppEffectCommit 1 } forEach [PP_var_Blood_hndl, PP_var_IN_hndl]; 
	waituntil 
	{	
		PP_var_IN_hndl ppEffectAdjust [1,0,0,[0.4,0,0,1],[1,0,0,0.2],[0.013,0.83,0.83,0],[0.5,0.0,-0.2,0.02,0,0,0.5]];
		PP_var_IN_hndl ppEffectCommit 0.5;
		sleep 1;
		PP_var_IN_hndl ppEffectAdjust [1,0,0,[0.4,0,0,1],[1,0,0,0.2],[0.013,0.83,0.83,0],[0.5,0.3,-0.2,0.02,0,0,0.5]];
		PP_var_IN_hndl ppEffectCommit 0.5;
		sleep 1;
		!(lifestate player in ['INCAPACITATED','DEAD-RESPAWN']);
	};
	{_x ppEffectEnable false; _x ppEffectCommit 0 } forEach [PP_var_Blood_hndl, PP_var_IN_hndl]; 
	player switchCamera 'INTERNAL';
};

AAAobj=[];

_magic = createTrigger["EmptyDetector", [0,0,0],false];
_magic setTriggerArea[0, 0, 0, true];
_magic setTriggerTimeout [0.1, 0.1, 0.1, false];
_magic setTriggerActivation["ANY","PRESENT", true]; 
_magic setTriggerStatements
[
"lifestate player in ['INCAPACITATED','DEAD-RESPAWN']", 
"player switchCamera 'INTERNAL'; [true] spawn fnc_PPEffect_INC; ",
/* " AAAobj= nearestObjects [player, ['Man'], 2]-[player]; if (count AAAobj <1 or lifestate player =='DEAD-RESPAWN'or !(alive(AAAobj select 0))) exitwith {};   [AAAobj select 0, 3 ] remoteExec ['addScore', 0, false]; systemchat format ['Score +3 (%1)', name (AAAobj select 0)] ;  " */ //glitch
" AAAobj= nearestObjects [player, ['Man'], 2]-[player]; if (count AAAobj <1 or lifestate player =='INCAPACITATED') exitwith {};   [AAAobj select 0, 3 ] remoteExec ['addScore', 0, false]; systemchat format ['Score +3 (%1)', name (AAAobj select 0)] ;  "

];
//[false] spawn fnc_PPEffect_INC;
