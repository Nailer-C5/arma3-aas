#include "globalDefines.hpp"
array _compressedData = [ xmitseq + 1 ];
xmitseq = xmitseq + 1;
if( xmitseq > 200 ) then { xmitseq=0; };
int _cb=0;
for "_pscounter" from 1 to ((count saas_baselist) - 1) do
	{	
	_compressedData set [count _compressedData,_psCounter];
	_compressedData set [count _compressedData,BASEA(_psCounter,TEAM)];
	_compressedData set [count _compressedData,((round SRVBASECACHEA(_psCounter,CAPLEVEL))+1)];
	};
v1 = toString _compressedData;
