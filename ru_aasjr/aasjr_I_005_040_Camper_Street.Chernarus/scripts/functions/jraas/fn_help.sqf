waitUntil {alive player};
_cc= uiNamespace getVariable ['S3_HELP_CTRL', controlNull];
_cc ctrlSetBackgroundColor [0,0,0,0.95];

_txt= "<br/><a align='Center' color= '#FFFFFF00' size='1.3'>AASJR</a><br/>";
_txt= _txt+ localize "STR_This_is";

_txt= _txt+ localize "STR_S3_Controls";

_txt= _txt+ localize "STR_S3_MiniMap";
_txt= _txt+ localize "STR_S3_Zoom";
_txt= _txt+ localize "STR_S3_Drag_N_Drop";
_txt= _txt+ localize "STR_S3_Toggle_MiniMap";

_txt= _txt+ localize "STR_S3_Toggle_Nametags";

_txt= _txt+ localize "STR_S3_DIVE";
_txt= _txt+ localize "STR_S3_Dive_SHIFT";

_txt= _txt+ localize "STR_S3_Help_Respawn";

_txt= _txt+ localize "STR_S3_Capture_base";

_txt= _txt+ "<br/><img align='Left' size='10' image='Images\AAS_Arma3.paa'/><br/>"; //ru ver
//_txt= _txt+ "<br/><img align='Left' size='10' image='Images\aasjr.paa'/><br/>";//arsenal ver

_cc ctrlSetStructuredText parseText _txt;

if (ctrlFade _cc>0.5) then 
{ 
	_cc ctrlSetFade 0; 
	//_cc ctrlEnable true; 
	_cc ctrlCommit 1.5; 
};
/*

else 
{
	_cc ctrlSetFade 1;
	//_cc ctrlEnable false; 
	_cc ctrlCommit 1.5; 
};
*/
