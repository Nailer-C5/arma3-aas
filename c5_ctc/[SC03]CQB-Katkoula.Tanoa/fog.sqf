_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};
	case 2: {0 setFog [0.4,0.6,3];};
	case 3: {0 setFog [0.2,1,9];};
	case 4: {0 setFog [0.6,-1,15];};
	case 5: {0 setFog 0.15;};
	case 6: {0 setFog 0.4;};
	
};


