#include "globalDefines.hpp"
if( (nameClassMap select 0) != 0 ) then
		{		
		playerClasses set [ nameClassMap select 0 , nameClassMap select 1 ];			
		nameClassMap = [ 0 , -1 ];
		};