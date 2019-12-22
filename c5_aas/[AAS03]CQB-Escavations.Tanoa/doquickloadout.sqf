#include "globalDefines.hpp"
int _loadoutType = (_this select 3) select 1;
string _displayHint = (_this select 3) select 0;		// bool to say if player class hint should be displayed
code _magAndQtyAdd =
	{
	int _lpct=0;
	for "_lctr" from 0 to ((_this select 1) - 1) do
		{
		player addMagazine (_this select 0);
		};
	};	
if(( _loadoutType != LOADOUT_SAVE ) && (_loadoutType != LOADOUT_CUSTOM)) then
{
	showChooserTime=CHOOSER_DURATION;
};
lastChooserPos = getPos player;
if( !classChangeLocked ) then
	{
	if( _loadoutType == LOADOUT_SAVE ) then
		{
		playerClass = LOADOUT_CUSTOM;
		_loadoutType = LOADOUT_CUSTOM;
            call saveLoadout;
   sleep 1;
		hint "Gear Saved.";
		}
	else
		{
		playerClass = _loadoutType;
		};
	if( _displayHint ) then
		{
		if( playerClass != LOADOUT_CUSTOM ) then
			{
			hint format [ "%1 loadout selected.",(RULES_classList select playerClass) select CL_NAME];
			}
		else
			{
			hint "Custom Loadout Saved";
			};
		nameClassMap = [ myPlayerQID , playerClass ];
		publicVariable "nameClassMap";
		};
	removeAllPrimaryWeaponItems player;
      removeAllWeapons player;
      removeAllItems player;
      removeUniform player;
      removeVest player;
      removeBackpack player;
      removeHeadgear player;
      
	if( playerClass == LOADOUT_CUSTOM ) then
		{
		call loadGear;
		player selectWeapon (primaryWeapon player);
		playerCanRevive = RULES_customClassCanRevive;
		}
	else
		{
		myRifles = (RULES_classList select playerClass) select CL_WESTRIFLES;
		if( EAST_PLAYER ) then { myRifles = (RULES_classList select playerClass) select CL_EASTRIFLES; };
		myRifleIndex = myRifleIndex  mod (count myRifles);
		
		playerCanRevive = (RULES_classList select playerClass) select CL_CANREVIVE;
			
		if( WEST_PLAYER and myRifleIndex >= count ((RULES_classList select playerClass) select CL_WESTRIFLES) ) then { myRifleIndex = 0 };
		if( EAST_PLAYER and myRifleIndex >= count ((RULES_classList select playerClass) select CL_EASTRIFLES) ) then { myRifleIndex = 0 };
		if( WEST_PLAYER ) then
			{
			{ player addVest   _x; } forEach ((RULES_classList select playerClass) select CL_WESTVESTS);
			{ player addBackpack   _x; } forEach ((RULES_classList select playerClass) select CL_WESTBACKBACKS);			
			string _curRifle = ((RULES_classList select playerClass) select CL_WESTRIFLES) select myRifleIndex;
			string _curMags = _curRifle call getDefaultMags;
			{ _x call _magAndQtyAdd; } forEach _curMags;
			player addWeapon _curRifle;
			{ _x call _magAndQtyAdd; } forEach ((RULES_classList select playerClass) select CL_WESTMAGS);
			{ player addWeapon   _x; } forEach ((RULES_classList select playerClass) select CL_WESTWEPS);
			{ player addUniform   _x; } forEach ((RULES_classList select playerClass) select CL_WESTUNIFORMS);
			{ player addweapon   _x; } forEach ((RULES_classList select playerClass) select CL_BINOS);
			{ player addGoggles   _x; } forEach ((RULES_classList select playerClass) select CL_GOGGLES);
			{ player addHeadgear   _x; } forEach ((RULES_classList select playerClass) select CL_WESTHEADGEARS);
			{ player addItem   _x; } forEach ((RULES_classList select playerClass) select CL_WESTITEMS);
			{ player addPrimaryWeaponItem   _x; } forEach ((RULES_classList select playerClass) select CL_PRIITEMS);
			player selectWeapon _curRifle;		
			}
		else
			{
			{ player addVest   _x; } forEach ((RULES_classList select playerClass) select CL_EASTVESTS);
			{ player addBackpack   _x; } forEach ((RULES_classList select playerClass) select CL_EASTBACKBACKS);		
			string _curRifle = ((RULES_classList select playerClass) select CL_EASTRIFLES) select myRifleIndex;
			string _curMags = _curRifle call getDefaultMags;
			
			{ _x call _magAndQtyAdd; } forEach _curMags;
			player addWeapon _curRifle;
			
			{ _x call _magAndQtyAdd; } forEach ((RULES_classList select playerClass) select CL_EASTMAGS);
			{ player addWeapon   _x; } forEach ((RULES_classList select playerClass) select CL_EASTWEPS);
			{ player addUniform   _x; } forEach ((RULES_classList select playerClass) select CL_EASTUNIFORMS);
			{ player addweapon   _x; } forEach ((RULES_classList select playerClass) select CL_BINOS);
			{ player addGoggles   _x; } forEach ((RULES_classList select playerClass) select CL_GOGGLES);
			{ player addHeadgear   _x; } forEach ((RULES_classList select playerClass) select CL_EASTHEADGEARS);
			{ player addItem   _x; } forEach ((RULES_classList select playerClass) select CL_EASTITEMS);
			{ player addPrimaryWeaponItem   _x; } forEach ((RULES_classList select playerClass) select CL_PRIITEMS);
			player selectWeapon _curRifle;		
			};
		};
	if( _displayHint ) then
		{
		lastClassChangeTime=time;
		}
	else
		{
		lastClassChangeTime=time-(CLASS_CHANGE_SETTLE_TIME*2);
		};
	if ((daytime < 4) || (daytime > 23)) then
	{
		player action ["GunLightOn",player];
	};
	};