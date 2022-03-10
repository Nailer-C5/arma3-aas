_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};               //No fog
	case 2: {0 setFog [0.6,0.6,4];};     //Ground fog
	case 3: {0 setFog [0.002,0.09,100];};  //Coastal/Valley fog
	case 4: {0 setFog [0.003,-0.09,250];};   //Mountaintop fog
	case 5: {0 setFog 0.15;};            //Light fog
	case 6: {0 setFog 0.4;};             //Pea soup
	
};


