_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};               //No fog
	case 2: {0 setFog [1,1,16];};     //Ground fog
	case 3: {0 setFog [0.65,0.6,22];};  //Coastal/Valley fog
	case 4: {0 setFog [0.2,-0.7,29];};   //Mountaintop fog
	case 5: {0 setFog 0.6;};            //Light fog
	case 6: {0 setFog 1;};             //Pea soup
	
};


