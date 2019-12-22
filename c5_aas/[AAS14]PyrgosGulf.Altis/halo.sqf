//Squad Leader Halo for [AAS_T]5 flags
#include "globalDefines.hpp"
code _magAndQtyAdd =
	{
	int _lpct=0;
	for "_lctr" from 0 to ((_this select 1) - 1) do
		{
		player addMagazine (_this select 0);
		};
	};	
 private ["_mkr","_X","_Y","_Z"];
 
if (WEST_PLAYER) then
        {  _mkr = flag5;}
        else
        {_mkr = flag12;};
        waitUntil { alive player };      
if (alive player) then
        {            
_X = (visiblePosition _mkr select 0) +
                        (3*sin ((getDir _mkr) -180));
_Y = (visiblePosition _mkr select 1) +
                        (3*cos ((getDir _mkr) -180));
_Z = (visiblePosition _mkr select 2);
        removeBackpack player;
        removeHeadgear player;
        player addBackpack "B_Parachute";
        player addHeadgear   "H_PilotHelmetFighter_B";
        player setpos [_X,_Y,14000]; 
waitUntil {((visiblePosition player select 2) < 1.5)};
MoveOut player;
		myRifles = (RULES_classList select playerClass) select CL_WESTRIFLES;
		if( EAST_PLAYER ) then { myRifles = (RULES_classList select playerClass) select CL_EASTRIFLES; };
		myRifleIndex = myRifleIndex  mod (count myRifles);
					
		if( WEST_PLAYER and myRifleIndex >= count ((RULES_classList select playerClass) select CL_WESTRIFLES) ) then { myRifleIndex = 0 };
		if( EAST_PLAYER and myRifleIndex >= count ((RULES_classList select playerClass) select CL_EASTRIFLES) ) then { myRifleIndex = 0 };
sleep 2.0;		
if (surfaceIsWater position player && (visiblePositionASL player select 2) < -2.0) then
          {
                if( WEST_PLAYER ) then
			{
			removeHeadgear player;
			removeUniform player;
			removeGoggles player;
			removeVest player;
			player addVest "V_RebreatherB";
			{ player addBackpack   _x; } forEach ((RULES_classList select playerClass) select CL_WESTBACKBACKS);			
			string _curRifle = ((RULES_classList select playerClass) select CL_WESTRIFLES) select myRifleIndex;
			string _curMags = _curRifle call getDefaultMags;
			{ _x call _magAndQtyAdd; } forEach _curMags;
			player addWeapon _curRifle;
			{ _x call _magAndQtyAdd; } forEach ((RULES_classList select playerClass) select CL_WESTMAGS);
			{ player addWeapon   _x; } forEach ((RULES_classList select playerClass) select CL_WESTWEPS);
			player addUniform "U_B_Wetsuit";
			player addGoggles "G_Diving";
			{ player addweapon   _x; } forEach ((RULES_classList select playerClass) select CL_BINOS);
			{ player addItem   _x; } forEach ((RULES_classList select playerClass) select CL_WESTITEMS);
			{ player addPrimaryWeaponItem   _x; } forEach ((RULES_classList select playerClass) select CL_PRIITEMS);
			player selectWeapon _curRifle;
			}
		else
			{
			removeHeadgear player;
			removeUniform player;
			removeGoggles player;
			removeVest player;
			player addVest "V_RebreatherIR";
			{ player addBackpack   _x; } forEach ((RULES_classList select playerClass) select CL_EASTBACKBACKS);		
			string _curRifle = ((RULES_classList select playerClass) select CL_EASTRIFLES) select myRifleIndex;
			string _curMags = _curRifle call getDefaultMags;
			
			{ _x call _magAndQtyAdd; } forEach _curMags;
			player addWeapon _curRifle;
			
			{ _x call _magAndQtyAdd; } forEach ((RULES_classList select playerClass) select CL_EASTMAGS);
			{ player addWeapon   _x; } forEach ((RULES_classList select playerClass) select CL_EASTWEPS);
			player addUniform "U_O_Wetsuit";
			player addGoggles "G_Diving";
			{ player addweapon   _x; } forEach ((RULES_classList select playerClass) select CL_BINOS);
			{ player addItem   _x; } forEach ((RULES_classList select playerClass) select CL_EASTITEMS);
			{ player addPrimaryWeaponItem   _x; } forEach ((RULES_classList select playerClass) select CL_PRIITEMS);
			player selectWeapon _curRifle;
			}; 
         
    }
    else
    {
	         if( WEST_PLAYER ) then
			{
			removeHeadgear player;
			{ player addBackpack   _x; } forEach ((RULES_classList select playerClass) select CL_WESTBACKBACKS);
			{ player addHeadgear   _x; } forEach ((RULES_classList select playerClass) select CL_WESTHEADGEARS);
			{ _x call _magAndQtyAdd; } forEach ((RULES_classList select playerClass) select CL_WESTMAGS);
			}
		else
			{
			removeHeadgear player;	
			{ player addBackpack   _x; } forEach ((RULES_classList select playerClass) select CL_EASTBACKBACKS);
			{ player addHeadgear   _x; } forEach ((RULES_classList select playerClass) select CL_EASTHEADGEARS);
			{ _x call _magAndQtyAdd; } forEach ((RULES_classList select playerClass) select CL_EASTMAGS);
			}; 
	 };
};                                
scopeName "exit";