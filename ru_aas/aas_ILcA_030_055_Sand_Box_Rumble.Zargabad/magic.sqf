//v3
//player setDamage 0.25;
//player setBleedingRemaining 120;
PP_var_IN_hndl = ppEffectCreate ["ColorCorrections", 1707];
PP_var_IN_hndl ppEffectAdjust [1,0,0,[0.6,0,0,0.3],[1,0,0,0.2],[0.013,0.83,0.83,0],[0.5,0.3,-0.2,0.02,0,0,0.5]];
PP_var_IN_hndl ppEffectEnable false;
PP_var_IN_hndl ppEffectCommit 1.5;

PP_var_Blood_hndl = ppEffectCreate ["WetDistortion", 104];//WetDistortionFilmGrain
PP_var_Blood_hndl ppEffectAdjust [1, 1, 1, 4.10, 3.70, 2.50, 1.85, 0.001, 0.001, 0.002, 0.002, 0.5, 0.3, 20.0, 16.0];
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
		(lifestate player!='INCAPACITATED');
	};
	{_x ppEffectEnable false; _x ppEffectCommit 0 } forEach [PP_var_Blood_hndl, PP_var_IN_hndl]; 

};

AAS_RESETHUD= {
_0= 10 spawn { sleep _this; resetHUD = true;};
};	

AAAobj=[];

_magic = createTrigger["EmptyDetector", [0,0,0],false];
_magic setTriggerArea[0, 0, 0, true];
_magic setTriggerTimeout [0.1, 0.1, 0.1, false];
_magic setTriggerActivation["ANY","PRESENT", true]; 
_magic setTriggerStatements
[
"lifestate player=='INCAPACITATED'", 
"player switchCamera 'INTERNAL'; [true] spawn fnc_PPEffect_INC; ",
" AAAobj= nearestObjects [player, ['Man'], 2]-[player]; if (count AAAobj <1 or lifestate player =='DEAD-RESPAWN') exitwith {};  [AAAobj select 0, 3 ] remoteExec ['addScore', 0, false]; systemchat format ['Score +3 (%1)', name (AAAobj select 0)]; call AAS_RESETHUD; "
];
//[false] spawn fnc_PPEffect_INC;