//rev -10 experimental
#include "globalDefines.hpp"

player setUnitTrait ["medic",false];
player setUnitTrait ["engineer",false];
player setUnitTrait ["explosiveSpecialist",false];
player setUnitTrait ["UAVHacker ",false];

_str2='';

int _loadoutType = (_this select 3) select 1;
string _displayHint = (_this select 3) select 0;		// bool to say if player class hint should be displayed

//Class limitation
_exit=false;
if !(_loadoutType in [LOADOUT_CUSTOM,LOADOUT_SAVE]) then
{
	if (lastPlayerNonCustomClass!=_loadoutType) then
	{
		_cnt=0;
		_limit=(RULES_classList select _loadoutType) select CL_LIMIT;
		_friendlyPlayers=if (EAST_PLAYER) then {player_units_east} else {player_units_west};
		{
			if ((_x getVariable "AAS_Unit_Class")==_loadoutType) then
			{
				_cnt=_cnt+1;
			};
		} forEach _friendlyPlayers;

		if ((_cnt / (count _friendlyPlayers)) > _limit) then {_exit=true};
	};
};

if (_exit) exitWith
{
	hint format[localize "STR_AAS_such_class",(RULES_classList select _loadoutType) select CL_NAME];
};
//Class limitation^^^


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

_str2= localize "STR_AAS_Custom_loadout";

if( _loadoutType == LOADOUT_SAVE ) then
	{
		playerClass = LOADOUT_CUSTOM;
		_loadoutType = LOADOUT_CUSTOM;
		//SAVE//
		call AAS_Check_WM;
		missionNamespace setVariable ["custom_inventory", getUnitLoadout player];
		_str2= localize "STR_AAS_Custom_loadout_saved";
	}
	else
	{
		playerClass = _loadoutType;
		
		///////////////////////vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
		_PCL= RULES_classList select playerclass select 0;

		if ( _PCL==localize "STR_AAS_Medic" ) then { player setUnitTrait ["medic",true];};
		if ( _PCL==localize "STR_AAS_sapper" ) then { player setUnitTrait ["explosiveSpecialist",true];};
		if ( _PCL==localize "STR_AAS_repairman") then { player setUnitTrait ["engineer",true];};
		if ( _PCL==localize "STR_AAS_UAV_operator") then { player setUnitTrait ["UAVHacker",true];};
		///////////////////////vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

		
	};
	
	if( _displayHint ) then
	{
		if( playerClass == LOADOUT_CUSTOM ) then
			{
			hint _str2;
			player commandchat _str2;
			};
		nameClassMap = [ myPlayerQID , playerClass ];
		publicVariable "nameClassMap";
	};
	
if( !classChangeLocked ) then
	{	
	if( _displayHint ) then
	{
	if( playerClass != LOADOUT_CUSTOM ) then { hint format [ localize "STR_AAS_loadout_selected",(RULES_classList select playerClass) select CL_NAME]; };
	nameClassMap = [ myPlayerQID , playerClass ];
	publicVariable "nameClassMap";
	};
	
	  //_hClearAll = 0 spawn {
	  removeAllPrimaryWeaponItems player;
	  { player removeSecondaryWeaponItem _x; } forEach (secondaryWeaponItems player);
	  removeAllHandgunItems player;
      removeAllWeapons player;
      removeAllItems player;
      removeUniform player;
      removeVest player;
      removeBackpack player;
      removeHeadgear player;
	  removeGoggles player;
	  //};
      //waitUntil { sleep 0.2; scriptDone _hClearAll;  };
	  
	if( playerClass == LOADOUT_CUSTOM ) then
		{
		//Load//
		//[player, [missionNamespace, "custom_inventory"]] call BIS_fnc_loadInventory;
		player setUnitLoadout (missionNamespace getVariable "custom_inventory");
		
		playerCanRevive = RULES_customClassCanRevive;
		
		//===several class limitation===
		player setVariable ["AAS_Unit_Class",lastPlayerNonCustomClass,true];
		//===several class limitation===
		//============end===============
		}
	else
		{
		//===several class limitation===
		lastPlayerNonCustomClass = playerClass;
		player setVariable ["AAS_Unit_Class",lastPlayerNonCustomClass,true];
		//===several class limitation===
		//============end===============
			
		myRifles = (RULES_classList select playerClass) select CL_WESTRIFLES;
		if( EAST_PLAYER ) then 
		{ 
			myRifles = (RULES_classList select playerClass) select CL_EASTRIFLES;	
		};
		myRifleIndex = myRifleIndex  mod (count myRifles);
		
		playerCanRevive = (RULES_classList select playerClass) select CL_CANREVIVE;
			
		if( WEST_PLAYER and myRifleIndex >= count ((RULES_classList select playerClass) select CL_WESTRIFLES) ) then { myRifleIndex = 0 };
		if( EAST_PLAYER and myRifleIndex >= count ((RULES_classList select playerClass) select CL_EASTRIFLES) ) then { myRifleIndex = 0 };
		if( WEST_PLAYER ) then
			{
			{ player addVest   _x; } forEach ((RULES_classList select playerClass) select CL_WESTVESTS);
			
			if (count (RULES_classList select playerClass select CL_WESTBACKBACKS)>0) then
			{
			player addBackpack (RULES_classList select playerClass select CL_WESTBACKBACKS select 0);	
			};

			//Weapons items/////////////////////////////
			string _curRifle = ((RULES_classList select playerClass) select CL_WESTRIFLES) select myRifleIndex select 0;
			string _curMags = _curRifle call getDefaultMags;
			{ _x call _magAndQtyAdd; } forEach _curMags;
			player addWeapon _curRifle;
			_items_count= count ( RULES_classList select playerClass select CL_WESTRIFLES select myRifleIndex ) -1;
			if (_items_count>0) then
				{
				for "_i" from 1 to _items_count do 
				{ 
				_get_WPitem= ( RULES_classList select playerClass select CL_WESTRIFLES select myRifleIndex select _i );
				player addPrimaryWeaponItem _get_WPitem;
				}; 
				};
			//Weapons items/////////////////////////////^^^
			
			
			{ _x call _magAndQtyAdd; } forEach ((RULES_classList select playerClass) select CL_WESTMAGS);
			
			
			//begin
			_ct= count ((RULES_classList select playerClass) select CL_WESTWEPS);
			if (_ct>0) then
			{
			player addWeapon ((RULES_classList select playerClass) select CL_WESTWEPS select 0);
			_items_count= count ((RULES_classList select playerClass) select CL_WESTWEPS) -1;
			if (_items_count>0) then
				{
				for "_i" from 1 to _items_count do 
				{ 
				_get_WPitem= ((RULES_classList select playerClass) select CL_WESTWEPS select _i );
				player addWeaponItem [((RULES_classList select playerClass) select CL_WESTWEPS select 0), _get_WPitem];
				}; 
				};
			};
			//end
			
			//{ player forceforceAddUniform   _x; } forEach ((RULES_classList select playerClass) select CL_WESTUNIFORMS);
			player forceAddUniform (RULES_classList select playerClass select CL_WESTUNIFORMS select 0);
			
			{ player addGoggles   _x; } forEach ((RULES_classList select playerClass) select CL_WESTGOGGLES);
			
			{ player addweapon   _x; } forEach ((RULES_classList select playerClass) select CL_WESTBINOS);
			{ player addHeadgear   _x; } forEach ((RULES_classList select playerClass) select CL_WESTHEADGEARS);
			{ player addItem   _x; } forEach ((RULES_classList select playerClass) select CL_WESTITEMS);
			player selectWeapon _curRifle;
			}
		else
			{
			{ player addVest   _x; } forEach ((RULES_classList select playerClass) select CL_EASTVESTS);
			
			//{ player addBackpack   _x; } forEach ((RULES_classList select playerClass) select CL_EASTBACKBACKS);
			if (count (RULES_classList select playerClass select CL_EASTBACKBACKS)>0) then
			{
			player addBackpack (RULES_classList select playerClass select CL_EASTBACKBACKS select 0);	
			};
			
			//Weapons items/////////////////////////////
			string _curRifle = ((RULES_classList select playerClass) select CL_EASTRIFLES) select myRifleIndex select 0;
			string _curMags = _curRifle call getDefaultMags;
			{ _x call _magAndQtyAdd; } forEach _curMags;
			player addWeapon _curRifle;
			_items_count= count ( RULES_classList select playerClass select CL_EASTRIFLES select myRifleIndex ) -1;
			if (_items_count>0) then
				{
				for "_i" from 1 to _items_count do 
				{ 
				_get_WPitem= ( RULES_classList select playerClass select CL_EASTRIFLES select myRifleIndex select _i ); 
				player addPrimaryWeaponItem   _get_WPitem;
				}; 
				};	
			//Weapons items/////////////////////////////^^^
			
			{ _x call _magAndQtyAdd; } forEach ((RULES_classList select playerClass) select CL_EASTMAGS);
			//begin
			_ct= count ((RULES_classList select playerClass) select CL_EASTWEPS);
			if (_ct>0) then
			{
			player addWeapon ((RULES_classList select playerClass) select CL_EASTWEPS select 0);
			_items_count= count ((RULES_classList select playerClass) select CL_EASTWEPS) -1;
			if (_items_count>0) then
				{
				for "_i" from 1 to _items_count do 
				{ 
				_get_WPitem= ((RULES_classList select playerClass) select CL_EASTWEPS select _i );
				player addWeaponItem [((RULES_classList select playerClass) select CL_EASTWEPS select 0), _get_WPitem];
				}; 
				};
			};
			//end
			//{ player forceAddUniform   _x; } forEach ((RULES_classList select playerClass) select CL_EASTUNIFORMS);
			player forceAddUniform (RULES_classList select playerClass select CL_EASTUNIFORMS select 0);
			
			{ player addGoggles   _x; } forEach ((RULES_classList select playerClass) select CL_EASTGOGGLES);
			{ player addweapon   _x; } forEach ((RULES_classList select playerClass) select CL_EASTBINOS);
			
			{ player addHeadgear   _x; } forEach ((RULES_classList select playerClass) select CL_EASTHEADGEARS);
			{ player addItem   _x; } forEach ((RULES_classList select playerClass) select CL_EASTITEMS);
			//{ player addPrimaryWeaponItem   _x; } forEach ((RULES_classList select playerClass) select CL_PRIITEMS);
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
		player action ["nvGogglesOff", player];
	};
	};