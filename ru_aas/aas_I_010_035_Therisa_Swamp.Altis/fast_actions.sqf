_type=_this select 0;

if (_type=="P") then		
{
	{player reveal _x} forEach nearestObjects [player, ["man"], 5];	
	if (animationState player != "acts_miller_knockout" and vehicle player == player) then
	{
	player playMove "acts_miller_knockout";  
	player setAnimSpeedCoef 3; 
	sleep 1;
	_ne= cursorTarget; //systemchat str _ne;
	if ((Player distance _ne < 2.5)&& (_ne isKindOf "Man")) then 
	{ 
	//FX
	if !(isPlayer _ne) then { /*systemchat 'AI';*/  _ne setDamage 1; };
	AAS_P_FX = [_ne,0];
	publicVariable "AAS_P_FX";	
	};
	player setAnimSpeedCoef 1; 
	[player,""] remoteExec ["switchMove",0,false]
	};	
};


if (_type=="P_E") then		
{	
	player setDamage ( damage player + random [0.7, 0.95,1]);
};