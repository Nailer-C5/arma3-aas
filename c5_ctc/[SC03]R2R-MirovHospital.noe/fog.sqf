_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};               //No fog
	case 2: {0 setFog [1,0.6,100];};     //Ground fog
	case 3: {0 setFog [1,0.15,102];};  //Coastal/Valley fog
	case 4: {0 setFog [1,-0.7,115];};   //Mountaintop fog
	case 5: {0 setFog 0.75;};            //Light fog
	case 6: {0 setFog 1;};             //Pea soup
	
};


