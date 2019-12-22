private["_array", "_player", "_hackType", "_hackValue"];

diag_log "ANTI-HACK 0.6.3 starting...";
AHAH = {
    diag_log "ANTI-HACK 0.6.3 starting...";
    if (isServer) exitWith {};
    _commonPaths = ["used for hacking", "wuat\screen.sqf", "scripts\defaultmenu.sqf", "menu\initmenu.sqf", "scr\exec.sqf", "scripts\exec.sqf",
            "menu\exec.sqf", "wuat\exec.sqf", "crinkly\keymenu.sqf", "scripts\ajmenu.sqf", "startup.sqf", "wookie_wuat\startup.sqf"
    ]; {
        _contents = format["", loadFile _x];
        if (_contents != "") then {
                diag_log "ANTI-HACK 0.6.3: hacker?!";

                hackFlag = [player, "hack menu", _x];
                publicVariableServer "hackFlag";
                sleep 5;
                for "_i"
                from 0 to 99 do {
                    (findDisplay _i) closeDisplay 0;
                };
        };
    }
    forEach _commonPaths;
    diag_log "ANTI-HACK 0.6.3: Starting loops!";
    [] spawn {
        private["_sleepVariableCheck", "_badPublicVariables"];
        _sleepVariableCheck = 30;
        _badPublicVariables = ["pic", "veh", "wuat_fpsMonitor", "unitList", "list_wrecked",
		"p", "fffffffffff", "markPos", "pos", "marker", "TentS", "VL", "MV",
		"mk2", "i", "j", "fuckmegrandma", "mehatingjews", "scode", "TTT5OptionNR",
		"igodokxtt", "omgwtfbbq", "namePlayer", "thingtoattachto", "HaxSmokeOn", "v",
		"antiloop", "ARGT_JUMP", "selecteditem", "moptions", "delaymenu", "gluemenu",
		"spawnweapons1", "abcd", "skinmenu", "playericons", "changebackpack", "keymenu",
		"img", "surrmenu", "footSpeedIndex", "ctrl_onKeyDown", "plrshldblcklst",
		"musekeys", "dontAddToTheArray", "morphtoanimals", "playerDistanceScreen", "pm",
		"debugConsoleIndex", "MY_KEYDOWN_FNC", "TAG_onKeyDown", "changestats", "helpmenu",
		"unitsmenu", "xZombieBait", "shnmenu", "slag", "xtags", "tempslag", "dayzRespawn2", "dayzRespawn3",
		"hangender", "addgun", "ESP", "BIS_fnc_3dCredits_n", "ViLayer", "maphalf", "activeITEMlist",
		"activeITEMlistanzahl", "xyzaa", "iBeFlying", "rem", "DAYZ_CA1_Lollipops", "bowonky", "HMDIR", "HDIR",
		"Monky_funcs_inited", "atext", "boost", "Ug8YtyGyvguGF", "inv", "rspwn", "nd", "qofjqpofq",
		"invall", "initarr", "reinit", "byebyezombies", "keymenu2", "hotkeymenu", "letmeknow", "Listw",
		"mahcaq", "mapm", "weapFun", "firstrun", "take1", "dwarden", "bowonky", "bowen", "monky", "pic",
		"god", "toggle_keyEH", "drawic", "mk2", "i", "j", "ptags", "abox1", "dayz_godmode", "testIndex", "g0d",
		"g0dmode", "zeus", "zeusmode", "cargod", "qopfkqpofqk", "monkytp", "pbx", "playershield", "zombieDistanceScreen",
		"theKeyControl", "plrshldblckls", "zombieshield", "pathtoscrdir", "footSpeedKeys", "wl", "spawnitems1",
		"lmzsjgnas", "vm", "Monky_hax_toggled", "pu", "nb", "vspeed", "godlol", "aesp", "godall", "initarr3", "initarr2", "DEV_ConsoleOpen", "LOKI_GUI_Key_Color"
        ];
        diag_log "ANTI-HACK 0.6.3: Detection of hack variables started!";
        while {
            true
        }
        do {
            {
                if !(isNil _x) exitWith {
                    diag_log "ANTI-HACK 0.6.3: Found a hack variable!";

                    hackFlag = [player, "hacked variable", _x];
                    publicVariableServer "hackFlag";
                    sleep 5;
                    for "_i"
                    from 0 to 99 do {
                        (findDisplay _i) closeDisplay 0;
                    };
                };
            }
            forEach _badPublicVariables;

            sleep _sleepVariableCheck;
        };
    };
    [] spawn {
        private["_keyDownHandlerCount", "_keyUpHandlerCount", "_ctrlDrawHandlerCount"];
        diag_log "ANTI-HACK 0.6.3: Hack menu check started!";
        while {
            true
        }
        do {
            (findDisplay 46) displayRemoveAllEventHandlers "KeyUp";
            ((findDisplay 12) displayCtrl 51) ctrlRemoveAllEventHandlers "Draw";
            if (!(isNull findDisplay 3030) || !(isNull findDisplay 155)) then {

                    diag_log "ANTI-HACK 0.6.3: Found a hack menu!";

                    hackFlag = [player, "hack menu", _x];
                    publicVariableServer "hackFlag";
                    sleep 5;
                    for "_i"
                    from 0 to 99 do {
                        (findDisplay _i) closeDisplay 0;
                    };
            };
            sleep 5;
        };
    };
    [] spawn {
        private["_sleepGodModeCheck", "_terrainGrid", "_recoilSettings", "_zombieCheck", "_damageHandler", "_unconsciousFunction"];
        _sleepGodModeCheck = 5;
        _terrainGrid = 25;
        _recoilSettings = unitRecoilCoefficient player;
        diag_log "ANTI-HACK 0.6.3: Godmode check started!";
        while {
            true
        }
        do {
            if (unitRecoilCoefficient player != _recoilSettings) exitWith {
                    diag_log "ANTI-HACK 0.6.3: Detected recoil hack!";
                    hackFlag = [player, "no recoil", "null"];
                    publicVariableServer "hackFlag";
                    sleep 5;
                    for "_i"
                    from 0 to 99 do {
                        (findDisplay _i) closeDisplay 0;
                    };
            };
            setTerrainGrid _terrainGrid;
            sleep _sleepGodModeCheck;
        };
    };
};

diag_log "ANTI-HACK 0.6.3: Adding public variable handler";
"hackFlag"
addPublicVariableEventHandler {
    _array = _this select 1;
    _player = _array select 0;
    _hackType = _array select 1;
    _hackValue = format["", _array select 2];
    diag_log format["ANTI-HACK:  () was detected for  with the value ''", name _player, getPlayerUID _player, _hackType, _hackValue];
    serverCommand format["#kick ", name _player];
    serverCommand format["#exec ban ", name _player];
};
"clientStarted"
addPublicVariableEventHandler {
    _client = _this select 1;
    (owner _client) publicVariableClient "AHAH";
    diag_log format["Starting anti-hack on client #", owner _client];
};

diag_log "ANTI-HACK 0.6.3: Anti-hack should be ready now!";