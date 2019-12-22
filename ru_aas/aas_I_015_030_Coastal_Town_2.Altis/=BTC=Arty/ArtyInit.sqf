while {true} do 
{
	_arty = vehicle player;
	if (/*_arty isKindOf "M119" or _arty isKindOf "M252_US_EP1" or _arty isKindOf "rhs_2b14_82mm_Base" or _arty isKindOf "RHS_M252_Base" _arty isKindOf "B_Mortar_01_F"*/ _arty isKindOf "StaticMortar") then 
	{
		if (player == (gunner _arty)) then
		{
			/*if (_arty isKindOf "M119") then 
			{
				nul = [_arty,"M119"] execVM "=BTC=Arty\mira.sqf";
				waitUntil {!(player == (gunner _arty))};
			};
			if (_arty isKindOf "StaticMortar") then 
			{
				nul = [_arty,"StaticMortar"] execVM "=BTC=Arty\mira.sqf";
				waitUntil {!(player == (gunner _arty))};
			};*/
			if (_arty isKindOf "rhs_2b14_82mm_Base") then 
			{
				nul = [_arty,"rhs_weap_2b14"] execVM "=BTC=Arty\mira.sqf";
				waitUntil {!(player == (gunner _arty))}; 
			};
			if (_arty isKindOf "RHS_M252_Base") then 
			{
				nul = [_arty,"rhs_mortar_81mm"] execVM "=BTC=Arty\mira.sqf";
				waitUntil {!(player == (gunner _arty))}; 
			};
			if (_arty isKindOf "B_Mortar_01_F") then 
			{
				nul = [_arty,"mortar_82mm"] execVM "=BTC=Arty\mira.sqf";
				waitUntil {!(player == (gunner _arty))}; 
			};
		};
	sleep 0.1;
	};
};

if(true) exitWith {}; 

//RHS_M252_Base  rhs_2b14_82mm_Base