_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};               //No fog
	case 2: {0 setFog [0.6,0.6,14];};     //Ground fog
	case 3: {0 setFog [0.008,0.09,100];};  //Coastal/Valley fog
	case 4: {0 setFog [0.8,-1,76];};   //Mountaintop fog
	case 5: {0 setFog 0.52;};            //Light fog
	case 6: {0 setFog 0.8;};             //Pea soup
	
};


