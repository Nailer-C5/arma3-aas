/*/
File: fn_score
Description: Initialize the score system.
Domain: Client
/*/
//@TODO this maybe should go in init
if (!isDedicated) then {
	[] call bulc_fnc_updateHud;
};
