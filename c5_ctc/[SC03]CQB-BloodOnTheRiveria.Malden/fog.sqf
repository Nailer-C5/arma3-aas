_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};               //No fog
	case 2: {0 setFog [0.6,0.8,5];};     //Ground fog
	case 3: {0 setFog [0.003,0.4,25];};  //Coastal/Valley fog
	case 4: {0 setFog [0.05,-0.6,27];};   //Mountaintop fog
	case 5: {0 setFog 0.5;};            //Light fog
	case 6: {0 setFog 1;};             //Pea soup
	
};


