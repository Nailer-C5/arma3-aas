#include "globalDefines.hpp"
if( (damage player > 0) and (floor (random 10)) == 1 ) then
	{
	int _damctr=0;
	for "_damctr" from 0 to ((count player_units_myteam) - 1) do
		{
		unit _thisPlayer = player_units_myteam select _damctr;
		if( _thisPlayer != player and (alive _thisPlayer) and (alive player) ) then
			{
			bool _tplayerIsMedic=false;
			int _tplayerClass=(_thisPlayer getVariable "playerclass");
			if( _tplayerClass != LOADOUT_CUSTOM ) then
				{
				if( (RULES_classList select _tplayerClass) select CL_CANREVIVE ) then { _tplayerIsMedic = true; };
				};
			if( (player distance _thisPlayer) < MEDIC_HEAL_RANGE and _tplayerIsMedic ) then
				{
				float _dam=damage player;			
				_dam = _dam - MEDIC_HEAL_AMOUNT; 
				player setDammage _dam;
				string _healMsg =  format["Healed by %1... %2%3", _thisPlayer call getName, round ((1-_dam) * 100), "%"];
				hintSilent _healMsg;
				diag_log format["CLI processPlayerEffects : %1",_healMsg];
				};
			};
		};
	};
	
