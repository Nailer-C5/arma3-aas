//Squad Leader teleport for [AAS_T]5 flags
#include "globalDefines.hpp"
private ["_leader","_X","_Y","_Z"];
        _leader = leader player;
        waitUntil { alive player };
if (player == (_leader)) then 
	 { hint format[" %1 your the Squad Leader and you cannot teleport on yourself!",Player call getName];
	 breakTo "exit";};
if (player distance (leader player) <= 100) then 
	 { hint format["Squad Leader %2 is (too close) only %3m from you %1!",Player call getName,_leader call getName,floor (_leader distance player)];
	 breakTo "exit";};
if (flag2 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone Alpha (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag2)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";}; 
if (flag3 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone Bravo (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag3)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";};
if (flag4 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone Charlie (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag4)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";};
if (flag5 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone Delta (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag5)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";};
if (flag6 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone Echo (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag6)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";};
if (flag7 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone Foxtrot (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag7)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";};
if (flag8 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone Golf (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag8)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";}; 
if (flag9 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone Hotel (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag9)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";};
if (flag10 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone India (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag10)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";};
if (flag11 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone Juliet (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag11)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";};
if (flag12 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone Kilo (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag12)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";};
if (flag13 distance (leader player) <= RULES_SquadLeaderToFlagDist)then 
	 { hint format["%1,Your squad leader %2 is too close to zone Kilo (%3m remaining)!",Player call getName,_leader call getName,floor (_leader distance flag13)- RULES_SquadLeaderToFlagDist];
	breakTo "exit";};	  		 		  
if (!alive _leader) then 
	 {  hint format["%1, your squad leader %2 is Dead!",Player call getName,_leader call getName];
	 breakTo "exit";};        
if (vehicle _leader == _leader) then
        {            
_X = (getpos _leader select 0) +
                        (3*sin ((getDir _leader) -180));
_Y = (getpos _leader select 1) +
                        (3*cos ((getDir _leader) -180));
_Z = (getpos _leader select 2);
        
        player setpos [_X,_Y,_Z];
        }
        else
        {    
        if ((vehicle _leader) emptyPositions "cargo"==0) then
        {hint format["Sorry %1, squad leader %2 has no more seats!",Player call getName,_leader call getName];}
        else
        {
        player moveincargo vehicle _leader;
        };
        };                               
scopeName "exit";