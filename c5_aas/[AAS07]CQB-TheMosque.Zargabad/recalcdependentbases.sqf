#include "globalDefines.hpp"
if( count (saas_baselist select 0) > 6 ) then
	{
	int _bfCtr=0;
	for "_bfctr" from 0 to ((count saas_baselist) - 1) do
		{
		int _dq = BASEA(_bfCtr,DEPQTY);
		if( _dq > 0 ) then
			{
			int _bcred  = { BASEA(_x,TEAM) == TEAM_RED  } count BASEA(_bfCtr,DEPEND);
			int _bcblue = { BASEA(_x,TEAM) == TEAM_BLUE } count BASEA(_bfCtr,DEPEND);
			DEBUG_LOG format["_bfCtr %1, _bcred = %2 , _bcblue = %3",_bfCtr,_bcred,_bcblue];
			SETBASEA(_bfctr,TEAM,TEAM_NEUTRAL);
			if( _bcred  >= _dq and _bcblue < _dq ) then { SETBASEA(_bfctr,TEAM,TEAM_RED ); };
			if( _bcblue >= _dq and _bcred  < _dq ) then { SETBASEA(_bfctr,TEAM,TEAM_BLUE); };
			};
		};
	
	};
