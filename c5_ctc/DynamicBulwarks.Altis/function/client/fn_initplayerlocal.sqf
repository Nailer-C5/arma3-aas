//Welcome message
//call bulc_fnc_welcome;

#include "..\..\briefing.sqf"

player setCustomAimCoef 0.2;
player setUnitRecoilCoefficient 0.5;
player enableStamina FALSE;
"START_KILLPOINTS" call BIS_fnc_getParamValue;
player setVariable ["RevByMedikit", false, true];
player setVariable ["buildItemHeld", false];
enableSentences false;
enableEnvironment [false, true];

// Lower recoil, lower sway, remove stamina on respawn
player addEventHandler ['Respawn',{
    player setCustomAimCoef 0.2;
    player setUnitRecoilCoefficient 0.5;
    player enableStamina FALSE;
}];

//setup Kill Points
_killPoints = ("START_KILLPOINTS" call BIS_fnc_getParamValue);
player setVariable ["killPoints", _killPoints, true];
[] call bulc_fnc_updateHud;

// Delete all map markers on clients
{
    _currMarker = toArray _x;
    if(count _currMarker >= 4) then {
        _currMarker resize 8; _currMarker = toString _currMarker;
        if(_currMarker == "bulwark_") then{ deleteMarker _x; };
    };
} foreach allMapMarkers;

hitMarkers = [];

//Show the Bulwark label on screen
onEachFrame {
    if(!isNil "bulwarkBox") then {
        _textPos = getPosATL bulwarkBox vectorAdd [0, 0, 1.5];
        drawIcon3D ["", [1,1,1,0.5], _textPos, 1, 1, 0, "Bulwark", 0, 0.04, "RobotoCondensed", "center", true];
    };

    if (HITMARKERPARAM == 1) then {
      {
          _pos    = _x select 0;
          _label  = _x select 1;
          _unit   = _x select 2;
          _age    = _x select 3;
          _active = _x select 4;
          _colour = _x select 5;

          if(_active) then {
              _x set [3, _age + 1];

              _alpha = 1;
              _scale = 0;
              if(_age > 0 && _age <= 10) then {
                  _scale = 0.035 * _age / 10;
              };
              if(_age > 10) then {
                  _scale = 0.035;
              };
              if(_age > 30 && _age <= 40) then {
                  _alpha = 1 - ((_age - 40) / 10);
              };
              _textPos = _pos vectorAdd [0, 0, 1 +_age / 100];

              if(_age > 40) then {_x set [4, false];};
              drawIcon3D ["", [_colour select 0, _colour select 1, _colour select 2, _alpha], _textPos, 1, 1, 0, format ["%1", _label], 0, _scale, "RobotoCondensed", "center", false];
			  
          };
      } foreach hitMarkers;
    };
};

//Make player immune to fall damage and immune to all damage while incapacitated
waitUntil {!isNil "TEAM_DAMAGE"};
player removeAllEventHandlers 'HandleDamage';
player addEventHandler ["HandleDamage", {
_beingRevived = player getVariable "RevByMedikit";
TEAM_DAMAGE = missionNamespace getVariable "TEAM_DAMAGE";
_incDamage = _this select 2;
_hitpoint = _this select 5;
_currentPointDamage = player getHitIndex _hitpoint;
_totalDamage = _incDamage + _currentPointDamage;
_playerItems = items player;
_players = allPlayers;
if ((_this select 4) == "" || lifeState player == "INCAPACITATED" || _beingRevived || ((_this select 3) in _players && !TEAM_DAMAGE && !((_this select 3) isEqualTo player))) then {
	0
} else {
	if (_totalDamage >= 0.89) then {
	_playerItems = items player;
		if ("Medikit" in _playerItems) then {
		player removeItem "Medikit";
		player setVariable ["RevByMedikit", true, true];
		player playActionNow "agonyStart";
		player playAction "agonyStop";
		player setDamage 0;
		[player] remoteExec ["buls_fnc_revivePlayer", 2];
		0;
		}else{
			_this call bis_fnc_reviveEhHandleDamage;
		};
	} else {
		_this call bis_fnc_reviveEhHandleDamage;
	};
};
}];
  
[] spawn bulc_fnc_keyhandler;
[] call bulc_fnc_drag;

waitUntil {!isNil "bulwarkLocation"};

// kill player if they disconnected and rejoined during a wave
_buildPhase = missionNamespace getVariable ["buildPhase", true];
waitUntil {alive player && !isnil "playersInWave" && !isnil "attkWave"};

if (getPlayerUID player in playersInWave && attkWave > 0 && !_buildPhase) then {
    player setDamage 1;
};

[] spawn {
sleep 5; 
hint format ["Custom Keybinds\n[HOME] - View Distance\n[END] - Toggle Earplugs\n[CTRL + R] - Mag Repack\n[H] - Holster Weapon"];
};