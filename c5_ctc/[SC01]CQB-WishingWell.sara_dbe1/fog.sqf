_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};               //No fog
	case 2: {0 setFog [1,0.9,80];};     //Ground fog
	case 3: {0 setFog [1,0.9,100];};  //Coastal/Valley fog
	case 4: {0 setFog [1,-1,120];};   //Mountaintop fog
	case 5: {0 setFog 0.9;};            //Light fog
	case 6: {0 setFog 1;};             //Pea soup
	
};


