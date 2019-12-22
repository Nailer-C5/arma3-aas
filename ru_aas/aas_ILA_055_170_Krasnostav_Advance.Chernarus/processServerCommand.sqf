#include "globalDefines.hpp"
string _capCmd = format[localize "STR_AAS_capture",(player call getName)];
if (srvCommand == _capCmd) then
{
hint localize "STR_AAS_bonus_base_capture";
srvCommand = "";
};
if (chatCommand select 0 != "0") then
{
	player globalChat format [localize "STR_AAS_captured_base", chatCommand select 0, chatCommand select 1];
	chatCommand = ["0","1"];
};
if (globalOvercast != -1) then
{
	if (globalOverCast != myOvercast) then {0 setOvercast globalOvercast; myOvercast = globalOvercast;};
	globalOvercast = -1; sleep 3;
	};
if (globalRain != -1) then
{
	if (globalRain != myRain) then {0 setRain globalRain; myRain = globalRain;};
	globalRain = -1; sleep 3;
	};
if (globalFog != -1) then
{
	if (globalFog != myFog) then {0 setFog globalFog; myFog = globalFog;};
	globalFog = -1; sleep 3;
};
if ((myRain != rain) && (myRain != -1) && (overcast > 0.6)) then {1 setRain myRain;};
AAS_processServerCommand_Busy = false;