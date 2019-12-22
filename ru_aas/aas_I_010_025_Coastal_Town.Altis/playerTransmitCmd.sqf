#include "globalDefines.hpp"
_cmdString = toString _this;
_xmitVarName = "xmit" + format["%1",player];
call compile format["%1 = _cmdString;",_xmitVarName];
publicVariable _xmitVarName;
