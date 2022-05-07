_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};               //No fog
	case 2: {0 setFog [1,1,3];};     //Ground fog
	case 3: {0 setFog [0.03,0.1,50];};  //Coastal/Valley fog
	case 4: {0 setFog [0.03,-0.3,75];};   //Mountaintop fog
	case 5: {0 setFog 0.45;};            //Light fog
	case 6: {0 setFog 0.7;};             //Pea soup
	
};


