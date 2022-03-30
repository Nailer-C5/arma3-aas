_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};               //No fog
	case 2: {0 setFog [1,1,15];};     //Ground fog
	case 3: {0 setFog [0.5,0.5,23];};  //Coastal/Valley fog
	case 4: {0 setFog [0.8,-0.5,28];};   //Mountaintop fog
	case 5: {0 setFog 0.6;};            //Light fog
	case 6: {0 setFog 0.85;};             //Pea soup
	
};


