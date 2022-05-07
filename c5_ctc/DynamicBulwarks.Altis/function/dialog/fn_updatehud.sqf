/*/
File: fn_updateHUD
Description: Hud values have changed, update Hud.
Domain: Client
/*/
if (!isDedicated) then {
    disableSerialization;
    _player = player;

    _killPoints = _player getVariable "killPoints";
    if(isNil "_killPoints") then {
        _killPoints = 0;
    };

    _attackWave = 0;
    if(!isNil "attkWave") then {
        _attackWave = attkWave;
    };

	_respawnTickets = [west] call BIS_fnc_respawnTickets;
	if(isNil "_respawnTickets" || _respawnTickets < 0) then {
        _respawnTickets = 0;
    };
	
	//private _killsai = player getVariable ["AI_kills",0];
    _hudText = format ["<t size='0.7' shadow='2'>" + "Points: %1  |  Wave: %2  |  Tickets: %3 ",_killPoints, _attackWave, _respawnTickets];

    1000 cutRsc ["bulwarksHUD","PLAIN"];
    _ui = uiNameSpace getVariable "bulwarksHUD";
    _KillPointsHud = _ui displayCtrl 99999;
    _KillPointsHud ctrlSetStructuredText parseText _hudText;
    _KillPointsHud ctrlCommit 0;
};
