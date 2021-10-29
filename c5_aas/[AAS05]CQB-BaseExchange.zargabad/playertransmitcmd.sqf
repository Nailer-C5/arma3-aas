#include "globalDefines.hpp"
_cmdString = toString _this;
_xmitVarName = "xmit" + format["%1",player];
call compile format["%1 = _cmdString;",_xmitVarName];
publicVariable _xmitVarName;
DEBUG_LOG format["XMIT: %1 = %2", _xmitVarName , toArray _cmdString ];
