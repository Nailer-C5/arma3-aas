while {true} do 
{
	_arty = vehicle player;
	if (/*_arty isKindOf "StaticCannon" or */_arty isKindOf "StaticMortar") then 
	{
		if (player == (gunner _arty)) then
		{		
			nul = [_arty, currentWeapon _arty] execVM "=BTC=Arty\mira.sqf";
			waitUntil {!(player == (gunner _arty))};
		};
	sleep 0.1;
	};
};

if(true) exitWith {}; 