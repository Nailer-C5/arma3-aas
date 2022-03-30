_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};
	case 2: {0 setFog [0.2,0.5,25];};
	case 3: {0 setFog [0.01,0.15,60];};
	case 4: {0 setFog [0.3,-0.2,265];};
	case 5: {0 setFog 0.6;};
	case 6: {0 setFog 0.8;};
	
};


