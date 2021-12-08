#include "globalDefines.hpp"
_display = _this select 0;
int _keypressed = _this select 1;
bool _shift_state = _this select 2;
bool _control_state = _this select 3;
bool _alt_state = _this select 4;
bool _return = false;
int _KEYSCANCODE_ESC = 1;
int _KEYSCANCODE_ENTER = 28;
int _KEYSCANCODE_WINL  = 220;
array _charmap = [
	"","","1","2","3","4","5","6","7","8","9","0","","","","",	// 0
	"q","w","e","r","t","y","u","i","o","p","","","","","a","s",	// 10
	"d","f","g","h","j","k","l","","","","","","z","x","c","v",	// 20
	"b","n","m","","","","","","","","","","","","","",		// 30
	"","","","","","","","","","","","","","","","",		// 40
	"","","","","","","","","","","","","","","","",		// 50
	"","","","","","","","","","","","","","","","",		// 60
	"","","","","","","","","","","","","","","","",		// 70
	"","","","","","","","","","","","","","","","",		// 80
	"","","","","","","","","","","","","","","","",		// 90
	"","","","","","","","","","","","","","","","",		// A0
	"","","","","","","","","","","","","","","","",		// B0
	"","","","","","","","","","","","","","","","",		// C0
	"","","","","","","","","","","","","","","","",		// D0
	"","","","","","","","","","","","","","","","",		// E0
	"","","","","","","","","","","","","","","",""];		// F0
if (spawnDialogReady && (_keypressed == _KEYSCANCODE_ESC)) then {_return = true;};
_return