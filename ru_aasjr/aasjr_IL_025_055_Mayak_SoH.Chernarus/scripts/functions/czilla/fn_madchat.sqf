_key= _this;
if  (_key in [0x1C,0x9C]) then 
{
 	disableserialization;
	_c= finddisplay 24 displayCtrl 101;
	_txt= toUpper(ctrlText _c);
	{
	_pos=_txt find _x;
	if (_pos>=0)  exitwith  {_c ctrlSetText 'Im a schoolboy';}; //STOP CRY 
	} forEach ['BITCH','FUCK','SHIT','ASS','BASTARD','FAGGOT','NIGGER'];
};
//systemchat format ["Key: %1  %2", keyname _key, time]; 
false