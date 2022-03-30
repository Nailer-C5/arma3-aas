_fog = ["ParamsSetFog",1] call BIS_fnc_getParamValue;

switch (_fog) do
{
	case 1: {0 setFog 0;};               //No fog
	case 2: {0 setFog [1,1,12];};     //Ground fog
	case 3: {0 setFog [0.5,1,17];};  //Coastal/Valley fog
	case 4: {0 setFog [0.08,-1,24];};   //Mountaintop fog
	case 5: {0 setFog 0.5;};            //Light fog
	case 6: {0 setFog 0.8;};             //Pea soup
	
};


