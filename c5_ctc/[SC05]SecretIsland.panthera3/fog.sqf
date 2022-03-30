_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};               //No fog
	case 2: {0 setFog [0.9,0.6,4];};     //Ground fog
	case 3: {0 setFog [0.001,0.5,23];};  //Coastal/Valley fog
	case 4: {0 setFog [0.3,-0.5,40];};   //Mountaintop fog
	case 5: {0 setFog 0.15;};            //Light fog
	case 6: {0 setFog 0.4;};             //Pea soup
	
};


