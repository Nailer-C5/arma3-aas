params['_s'];
if (vehicle player !=player) ExitWith {};
if (primaryWeapon player isEqualTo currentWeapon player and currentWeapon player!='') then
	{
	if (isTouchingGround player and  stance player in [ "STAND", "CROUCH"] ) then 
	{
		_anims= animationState player;
		_anim='';
		if (_s=='F') then { _anim= 'AovrPercMrunSrasWrflDf'; player setVelocityModelSpace [0, 5, 6]; };//0 5 6
		if (_s=='L') then { _anim= 'AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft'; player setVelocityModelSpace [-5, 0, 2] }; //7 0 6
		if (_s=='R') then { _anim= 'AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDright'; player setVelocityModelSpace [5, 0, 2] };
		[player, _anim] remoteExec ["SwitchMove",0,false];
	};
};