#include "globalDefines.hpp"
string _capCmd = format["capture:%1",(player call getName)];
if (srvCommand == _capCmd) then
{
	hint "+10 point bonus for base capture.";
	srvCommand = "";
};

if (chatCommand != "") then
{
	player globalChat chatCommand;
	chatCommand = "";
};

if (globalOvercast != myOvercast) then 
{
	myOvercast = globalOvercast;
	skipTime -24; 
	86400 setOvercast myOvercast; 
	skipTime 24; 
	forceWeatherChange;
};

if (globalRain != myRain) then 
{
	myRain = globalRain;
	0 setRain myRain;
	forceWeatherChange;
};

if (globalFog != myFog) then 
{
	myFog = globalFog;
	0 setFog myFog;
	forceWeatherChange;
};

if (globalGusts != myGusts) then 
{
	myGusts = globalGusts;
	0 setGusts myGusts;
	forceWeatherChange;
};

if (globalLightnings != myLightnings) then 
{
	myLightnings = globalLightnings;
	0 setLightnings myLightnings;
	forceWeatherChange;
};

if (globalRainbow != myRainbow) then 
{
	myRainbow = globalRainbow;
	0 setRainbow myRainbow;
	forceWeatherChange;
};


AAS_processServerCommand_Busy = false;