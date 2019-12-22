S3InitZonesPP = compile preprocessFile "Scripts\S3_Init_AAS.sqf";
call S3InitZonesPP;
#include "Rules\S3_INITJRMission.h"
enableEngineArtillery false; 
#include "=BTC=Arty\angles.sqf"
_arty = execVM "=BTC=Arty\ArtyInit.sqf";
_hook = execVM "=BTC=Arty\AttachInit.sqf";
if (isNil "paramsArray") then
{
 	PjrAAS_time=1800;
	PjrAAS_hardcore=false;
    PjrAAS_ViewDistance =1000;
} else
{
	for "_i" from 0 to ((count paramsArray) - 1) do
	{
		missionNamespace setVariable [configName ((missionConfigFile >> "Params") select _i), paramsArray select _i];
	};
};

setViewDistance PjrAAS_ViewDistance;
setObjectViewDistance (PjrAAS_ViewDistance * 0.75);

if (hasInterface) then
{

#include "Scripts\S3_HUDDefs.h"
#include "Scripts\S3_HUD_CONSTS.h"
//setViewDistance 650;

showGPS false;

if (PjrAAS_hardcore isEqualto 0) then //noob mode
{
	[] spawn  S3_fnc_drawNametag;
};


_rules= "Light.sqf";
if (PjrAAS_rules isEqualto 0) then
{
	_rules= "Light.sqf";
}
else
{
	_rules= "Heavy.sqf";
};

S3InitRulesPP= compile preprocessFile ("Rules\"+ _rules);
call S3InitRulesPP;

//#include "Scripts\S3_RULES.sqf"
//???

//Vars///////////////////////////////////////////////////////////////////////
_txt = 'Info';

S3_AllTeamColors = [[1, 0, 0, 1], [0, 0.6, 1, 1], [0, 1, 0, 1]];
S3_NAMETAG = true;
S3_MyTeamColor = [0, 0, 0, 1];
S3_xray = "respawn_west";
S3_Sideid = 0;
S3_MarkerColor = 'colorWhite';
S3CurAction = 0;
S3_V_ZtoSpawn = 0;
S3_INFO_A = [0, 0];
S3_V_prevMarker = '';
missionnamespace setvariable ['S3_TKC', 0, false];

S3_PlayerData = [0, S3_JrAAS_RULES select 0 select 1 select 0 select 1];
jrAASAVoice = [['AAS_X', 'AAS_Y'], 'AAS_A', 'AAS_B', 'AAS_C', 'AAS_D', 'AAS_E', 'AAS_F', 'AAS_G', 'AAS_H', 'AAS_I', 'AAS_J', 'AAS_K', 'AAS_L', 'AAS_M', 'AAS_N', 'AAS_O', 'AAS_P', 'AAS_Q', 'AAS_R', 'AAS_S', 'AAS_T', 'AAS_U', 'AAS_V', 'AAS_W', 'AAS_Z'];
missionnamespace setvariable ['S3_PlayerCustomDataServer', [100, S3_JrAAS_RULES select 0 select 1 select 0], false];

S3_ACtionsLbFH = 0.04;
MAP_Zoom = 0.051;

S3_V_ActiveRespawn = true;


switch (playerSide) do
{
    case (east):
    {
        S3_MyTeamColor = [1, 0, 0, 0.7];
        S3_xray = "respawn_east";
        S3_Sideid = 0;
        S3_MarkerColor = 'colorRed';
    };
    case (west):
    {
        S3_MyTeamColor = [0, 0.6, 1, 0.7];
        S3_xray = "respawn_west";
        S3_Sideid = 1;
        S3_MarkerColor = 'colorBlue';
    };
};


S3_SPAWNPOS = getMarkerPos S3_xray;
S3_HUD_STATUSZColor = S3_MyTeamColor;
//Vars///////////////////////////////////////////////////////////////////////END

//*
S3_LOAD = false;
//addMissionEventHandler ["PreloadStarted", { systemchat 'PreloadStarted'; } ];

addMissionEventHandler ["PreloadFinished", { systemchat localize 'STR_PreloadFinished'; S3_LOAD = TRUE }];
waitUntil {S3_LOAD};
//*/

//RGO

S3_keyspressed = compile preprocessFile "Scripts\S3_Keyboard.sqf";
S3CZillasPP = compileFinal preprocessFileLineNumbers "Scripts\S3CZillas.sqf";
call S3CZillasPP;

S3VehicleMagicPP = compile preprocessFile "Scripts\S3_VehiclesMagic.sqf";
call S3VehicleMagicPP;

S3_UpdateMarkers =
{
    {
        _id = _forEachIndex + 1;
        _side = _x select 0;
        _x set [5, call compile format ['Flag%1', _id]];
        _flag = _x select 5;
        _fData = _flag getvariable ['_unt', [civilian, [0, 0], 50]];
        _side = _fData select 0;
        _p = _fData select 2;
        _marker = format ['Respawn%1', _id];
        if (_side isEqualTo west) then { _marker setMarkerColor 'colorBlue'; _flag setFlagTexture "\A3\Data_F\Flags\Flag_blue_CO.paa";};
        if (_side isEqualTo east) then { _marker setMarkerColor 'colorRed'; _flag setFlagTexture "\A3\Data_F\Flags\Flag_red_CO.paa";};
        if (_side isEqualTo civilian) then {_marker setMarkerColor 'colorGreen' };
    } forEach S3_aas_baselist;
};
//call S3_UpdateMarkers; //WTF??



S3_fnc_HUD_PreviewShow =
{
    _cc = uiNamespace getVariable ['S3_HUD_PREVIEWLB', controlNull];
    _ccb = uiNamespace getVariable ['S3_HUD_PREVIEWBG', controlNull];

    if (ctrlFade _cc > 0.5) then
    {
        {_x ctrlSetFade 0; _x ctrlEnable true; _x ctrlCommit 1.5;  } forEach [_cc, _ccb];
    }
    else
    {
        {
            _x ctrlSetFade 1;
            _x ctrlEnable false;
            _x ctrlCommit 1.5;
        }
        forEach [_cc, _ccb];
    };
};

S3_ifnc_TK =
{
    if !(hasInterface) ExitWith {};
    //player addrating -6000;
    _TCS = missionnamespace getvariable ['S3_TKC', 0];
    _TCS = _TCS + 1;
    missionnamespace setvariable ['S3_TKC', _TCS, false];
    hint format ['Team kill counter: %1', S3_TKC];
    if (_TCS >= 4) then
    {
        playsound 'S3_TK';
        [4] spawn S3_fnc_PBSTRD;
        [Localize 'STR_TEAM_KILLER', format[localize "STR_AAS_TK" + '<br/> <t color="#FFAACC">%1 </t> <br/> <img size="4" shadow="2" align="Left" image="A3\ui_f\data\GUI\Cfg\Debriefing\endDefault_ca.paa"/>', Name player ], [1, 1, 0, 1]] spawn S3_fnc_S3_setTextHint;
        player setUnitLoadout [getunitLoadout 'C_scientist_F', true];
    };
};

S3_fnc_Apply =
{
    disableSerialization;
    _cc = uiNamespace getVariable ['S3_HUD_CL', controlNull];
    _classId = lbCurSel _cc;

    _cc = uiNamespace getVariable ['S3_HUD_CLASSLB', controlNull];
    _data = _cc lbData (lbCurSel _cc);
    _iCount = 0;
    _allPlayersMside = allPlayers select { side _x isEqualTo PlayerSide };
    _mUnits = count _allPlayersMside;
    {
        if (_x getvariable ['UCL', -1] isEqualTo _classId) then { _iCount = _iCount + 1 };
    } forEach _allPlayersMside;
    //Class Limination
    _lPercent = S3_JrAAS_RULES select _classId select 0 select 2;
    _TPercent = floor ((_mUnits * _lPercent ) / 100)+1;
    _can = _TPercent - _iCount;
    //systemchat format[Localize 'STR_Class_already', S3_JrAAS_RULES select _classId select 0 select 0, _iCount, _TPercent];
	//systemchat format[Localize 'STR_Class_already', localize format['STR_%1', S3_JrAAS_RULES select _classId select 0 select 0, _iCount, _TPercent]];
	systemchat format[Localize 'STR_Class_already', localize format['STR_%1', S3_JrAAS_RULES select _classId select 0 select 0], _iCount, _TPercent];
    if (_can < 1 and _classId != S3_PlayerData select 0) then
    {
        //[Localize 'STR_Warning', format[Localize 'STR_Class_not_available', S3_JrAAS_RULES select _classId select 0 select 0 ], [1, 0.75, 0, 0.9], 'HintS3'] spawn S3_fnc_S3_setTextHint;
		[Localize 'STR_Warning', format[Localize 'STR_Class_not_available', localize format['STR_%1', S3_JrAAS_RULES select _classId select 0 select 0 ], [1, 0.75, 0, 0.9], 'HintS3']] spawn S3_fnc_S3_setTextHint;
    }
    else
    {
        S3_PlayerData = [_classId, _data];
        player setVariable ['UCL', _classId, true];
        if (_data find '[' > -1) then //Array loadout
        {
            S3_PlayerData = [_classId, call compile _data];
        };
        ////000
        {//reset
        	player setUnitTrait[_x,false]
        } forEach ["Medic", "explosiveSpecialist", "engineer", "UAVHacker"/*,"REPAIRMAN"*/];
        ////000

        if (S3_JrAAS_RULES select (S3_Playerdata select 0) select 0 select 0=='MEDIC') then {player setUnitTrait["Medic",true]};
        if (S3_JrAAS_RULES select (S3_Playerdata select 0) select 0 select 0=='SAPPER') then {player setUnitTrait["explosiveSpecialist",true]};
        //if (S3_JrAAS_RULES select (S3_Playerdata select 0) select 0 select 0=='REPAIRMAN') then {player setUnitTrait["engineer",true]};
        if (S3_JrAAS_RULES select (S3_Playerdata select 0) select 0 select 0=='UAV OPERATOR') then {player setUnitTrait["UAVHacker",true]};
        //hint format[Localize 'STR_You_select', S3_JrAAS_RULES select (S3_PlayerData select 0) select 0 select 0]; 
		hint format[Localize 'STR_You_select', localize format['STR_%1', S3_JrAAS_RULES select (S3_PlayerData select 0) select 0 select 0]];
    };
};

S3_fnc_LBASE =
{
    params['_side', '_idx'];
    sleep 0.1;
    _zone =  S3_aas_baselist select _idx select 3;
    _clr = "#00FF00";
    _clr2 = [0, 1, 0, 1];
    if (_side isEqualTo WEST) then { _clr = "#00AFFA"; _clr2 = S3_AllTeamColors select 1};
    if (_side isEqualTo EAST) then { _clr = "#FF1000"; _clr2 = S3_AllTeamColors select 0};
    if (_side isEqualTo PlayerSide) then
    {
        hint parseText format[localize "STR_AAS_LBASE" + '<br/><t color="%1" size="1.4">%2 </t>', _clr, _zone];
        playsound "cap_zone";
    }
    else
    {
        hint parseText format[localize "STR_AAS_SCBASE" + '<br/><t color="%1" size="1.4">%2</t>', _clr, _zone];
        playsound "HintS3";
    };
};

S3_fnc_TAKEFLAG =
{
    params['_hero', '_idx'];
    _zone =  S3_aas_baselist select _idx select 3;
    systemchat format[localize "STR_AAS_CAPTURE", Name _hero, _zone];
    //playSound "cap_zone";
    _color = [0, 0, 0, 1];
    if (side _hero isEqualto WEST) then { _color = S3_AllTeamColors select 1 };
    if (side _hero isEqualto EAST) then { _color = S3_AllTeamColors select 0 };
    [localize 'STR_Info', format[localize "STR_AAS_CAPTURE" + localize 'STR_Score_10', '<t color="#FFAA00">' + Name _hero + '</t>', _zone], _color] spawn S3_fnc_S3_setTextHint;
    if !(side _hero isEqualto playerSide) then
    {
        _zone spawn
        {
            sleep 0.1;
            [localize 'STR_Bad_news:', format[localize 'STR_You_team_fuck', _this ], [1, 0.75, 0, 0.9]] spawn S3_fnc_S3_setTextHint;/* playsound 'AlarmCar'; */
        };
    };
};

S3_fnc_S3_setTextHint =
{
    disableSerialization;
    params['_caption', '_txt', '_color', '_snd'];
    _ctrls = uinamespace getVariable 'S3HintHud';
    if !(isNil '_snd') then {playSound _snd};
    {
        _x ctrlSetPosition [(SafeZoneW + SafeZoneX) / 2 - 0.21, 0.3 - 0.2 + S3_UI_BH];
        _x ctrlCommit 0;
    } forEach _ctrls;
    _c = _ctrls select 0;
    _c ctrlSetText _caption;
    _c ctrlSetBackgroundColor _color;
    _c ctrlSetPosition [SafeZoneX, 0.3 - 0.2];
    _c ctrlSetFade 0;
    _c ctrlCommit 0.5;
    _c = _ctrls select 1;
    _c ctrlSetPosition [SafeZoneX, 0.3 - 0.2 + S3_UI_BH + 0.003];
    _c ctrlSetFade 0;
    _c ctrlCommit 0.5;
    _c = _ctrls select 2;
    _c ctrlSetStructuredText parseText _txt;
    _c ctrlSetPosition [SafeZoneX, 0.3 - 0.2 + S3_UI_BH + 0.006];
    _c ctrlSetFade 0;
    _c ctrlCommit 0.5;
    sleep 1;
    {
        _x ctrlSetFade 1;
        _x ctrlCommit 5;
    } forEach _ctrls;
};

HUD_ADDCLASSES =
{
    _cl =  uiNamespace getVariable ['S3_HUD_CL', controlNull];
    {
        _idx = _forEachIndex;
        //_cl lbAdd (_x select 0 select 0);
		_cl lbAdd localize format ["STR_%1", _x select 0 select 0];
        _cl lbSetData [_idx, str _idx];
        _cl lbSetPicture [_idx, _x select 0 select 1];
    } forEach S3_JrAAS_RULES;
    _cl lbSetCurSel 0;
};

S3_fnc_HUD_CLASSChange =
{
    disableserialization;
    params ['_c', '_Class'];
    _cc = uiNamespace getVariable ['S3_HUD_CLASSLB', controlNull];
    lbClear _cc;
    {
        if (_forEachIndex != count (S3_JrAAS_RULES select _Class select 1) - 1) then
        {
            if (_x isEqualType []) then
            {
                _txt = _x select 0;
                _cc lbAdd _txt;
                _cc lbSetData [_forEachIndex, str  (_x select 1) ];
                _cc lbSetPicture [_forEachIndex, getText (configFile >> 'CfgWeapons' >>  _x select 1 select 0 select 0 >> 'Picture') ];
            }
            else
            {
                _txt = gettext(configFile >> 'CfgVehicles' >> _x  >> 'displayName');
                _cc lbAdd _txt;
                _cc lbSetData [_forEachIndex, _x];
                _cc lbSetPicture [_forEachIndex, getText (configFile >> 'CfgWeapons' >> getarray(configFile >> 'CfgVehicles' >> _x  >> 'weapons') select 0 >> 'Picture')];
            };
        };

    } forEach (S3_JrAAS_RULES select _Class select 1);
    _cc ctrlSetPosition (ctrlposition _cc);

    _cc lbSetCurSel 0;
    _cc ctrlCommit 0;
};

f_time =
{
    disableSerialization;
    params['_c', '_pos'];
    _h = floor (_pos / 60);
    _m = floor(_pos mod 60);
    _date = date;
    _date set [3, _h];
    _date set [4, _m];
    [_date] remoteExec ['setDate', 0, true];
    _txt = uiNamespace getVariable "AAS_timeXCtrl";
    if (_m < 10) then { _m = "0" + str _m };
    _txt ctrlSetText format['Time %1:%2', _h, _m];
    _txt ctrlCommit 0;
};

AAS_END =
{
    params ['_side'];
    if (playerSide isEqualTo _side) then { playmusic "match_win" }
    else
    {
        playmusic "match_loss"
    };
    [false] spawn fn_iforceGPS;
    call S3_fnc_HideRespawnDialog;
};


S3_fnc_HideRespawnDialog =
{
    //  player setVariable ['side',playerside,true];
    S3_V_ActiveRespawn = false;
    _d = uiNamespace getVariable ["S3_RESPAWN_DLG", -1];
    {
        _c = _x;
        _c ctrlShow false;
        _c ctrlCommit 0;
    } forEach (allcontrols _d);
    uiNamespace setVariable ["S3_MapSave", [+(ctrlMapScale (uiNamespace getVariable ["S3_Map", controlNull]))] ];
    _mp = uiNamespace getVariable ["S3_Map", controlNull];
    _dta = uiNamespace getVariable ["S3_MapSave", [0] ];
    _z = _dta select 0;
    _d closeDisplay 1;
    switch (S3_SpecialRespawn) do
    {
        case (0):
        {
            player setVehiclePosition [[S3_SPAWNPOS select 0, S3_SPAWNPOS select 1, 100], [], 0, "CAN_COLLIDE"];
        };
        case (1):
        {
            player setVehiclePosition [[S3_SPAWNPOS select 0, S3_SPAWNPOS select 1, 1], [], 0, "NONE"];
        };
        case (2):
        {
            player setVehiclePosition [[S3_SPAWNPOS select 0, S3_SPAWNPOS select 1, 100], [], 0, "NONE"];
        };
        case (3):
        {
            player setVehiclePosition [[S3_SPAWNPOS select 0, S3_SPAWNPOS select 1, 1], [], 0, "CAN_COLLIDE"];
        };
    };
    player linkItem "ItemGPS";
    showGPS false;
    _initial_show = true;
    uiNamespace setVariable ["S3_GPS", _initial_show];
    [_initial_show] call fn_iforceGPS;
    doStop (units player);
    (units player) doFollow leader _grP;
    S3V_ShowArmorHint = true;
    [] spawn
    {
        scriptName "S3>>>RESPAWN ARMOR";
        if (missionNamespace getVariable ['useArmor', false]) then
        {
            hint parseText Localize "STR_S3_ARMOR_ENABLED";
			_endTimer= time+7;
			while {_endTimer>time and S3V_ShowArmorHint and alive vehicle player} do
			{
				hintSilent parseText (Localize "STR_S3_ARMOR_ENABLED" + format["<t size='2.1'> %1</t>",round (_endTimer- time)]);
			};
            if (S3V_ShowArmorHint) then
            {
                hint parseText Localize "STR_S3_ARMOR_DISABLED";
				S3V_ShowArmorHint = false;
                player allowDamage true;
                sleep 3;
                hintsilent '';
            };
        } else 
		{
			//если расстояние до флага <10
			//убрать броню и не показывать хинт STR_S3_NO_ARMOR
			S3V_ShowArmorHint= false; 
			player allowDamage true;
			hint parseText Localize "STR_S3_ARMOR_DISABLED";
		};//whine patch 1 >>>all line
    };
    vehicle player switchCamera "Internal";
};

fn_isaveGPS =
{
    _allc = uiNamespace getVariable ["S3_GPS_Controls", []];
    _d1 = findDisplay 15001;
    _mm = _d1 displayCtrl 15002;
    _pos = (ctrlPosition _mm) select [0, 2];

    uiNamespace setVariable ["S3_GPS_pos", _pos];
    {
        _x ctrlSetPosition _pos;
        _x ctrlCommit 0;
    } forEach _allc;

    //*
    _pos set [1, (_pos select 1) - 0.04];
    _header = uiNamespace getVariable "S3GPS_Header";
    _header ctrlSetPosition _pos;
    _header ctrlCommit 0;
    //*/
};

fn_iforceGPS =	//[true] spawn fn_iforceGPS; //Show
{
    params ['_visible'];
    disableSerialization;
    _allc = uiNamespace getVariable ["S3_GPS_Controls", []];
    {
        _x ctrlShow _visible;
        _x ctrlCommit 0;
    } forEach _allc;
    _header = uiNamespace getVariable "S3GPS_Header";
    _header ctrlShow _visible;
    _header ctrlCommit 0;
};

S3_fnc_MapClickRespawn =
{
    disableserialization;
    params ['_pos'];
    _mp = uiNamespace getVariable ["S3_Map", controlNull];
    _dta = uiNamespace getVariable ["S3_MapSave", [0] ];
    _z = _dta select 0;

    _mp ctrlMapAnimAdd [0.25, _z, S3_SPAWNPOS];
	_defSPos= _mp ctrlMapScreenToWorld (_mp posWorldToScreen (getMarkerPos format ['Respawn%1', S3_V_ZtoSpawn]));
    if (S3_V_ActiveRespawn) then
    {
        _result = '';
        {
            _markerName = format ["Respawn%1", _forEachIndex + 1];
            _dS = (S3_aas_baselist select _forEachIndex select 5) getvariable ['_unt', ['', [0, 0]]];
            if (_pos inArea _markerName and _dS select 0 isEqualTo playerSide and _dS select 2 isEqualTo 100) ExitWith
            {
                _result = _markerName;
                "SSEL" setMarkerPosLocal getMarkerPos _markerName;
                "SSEL" setMarkerSizeLocal [2, 2];// getMarkerSize _markerName;
                "CUSTOM_RESPAWN" setMarkerPosLocal _pos;
                _pos pushBack 0;
                _nnPos1 = +_pos;
                _nnPos1 set [2, 1000];
                _objI = lineIntersectsSurfaces [ AGLToASL _nnPos1, AGLToASL _pos, objNull, objNull, true, 1, "GEOM", "NONE" ];
                if (count _objI != 0) then
                {
                    _objI = [_objI select 0 select 2];
                };
				
				S3_SpecialRespawn = 0;	//0- ground 1- indoor
                if (count _objI isEqualTo 0) then
                {
                    //empty position - ground
                    S3_SPAWNPOS = _pos;
                    S3_SpecialRespawn = 0;
                    if (surfaceIsWater S3_SPAWNPOS) then {hint localize 'STR_Respawn_in_water'}
                    else
                    {
                        hint localize 'STR_Respawn_on_ground'
                    };
                }
                else
                {
                    //Building detected
                    _nB = _objI call bis_fnc_selectrandom;
                    _allPos = [_nB] call BIS_fnc_buildingPositions;
                    if (count _allPos > 0) then
                    {
                        _nearestPos = _allPos select 0;
                        _ndist = _nearestPos distance _pos;
                        //systemchat format['1  _ndist %1', _ndist];
                        {
                            _ndistFind = _pos distance _x;
                            if ( _ndistFind < _ndist ) then { _nearestPos = _x };
                        } forEach _allPos;
                        S3_SpecialRespawn = 1;
                        S3_SPAWNPOS = _nearestPos;
                        "CUSTOM_RESPAWN"
                        setMarkerPosLocal _nearestPos;
                        hint format[localize 'STR_Respawn_in', gettext(configFile >> 'CfgVehicles' >> typeOf _nB  >> 'displayName'), _nearestPos];
                    }
                    else
                    {
                        //CANT ENTER
                        S3_SpecialRespawn = 2;
                        S3_SPAWNPOS = _pos;
                        if (typeOf _nb in ['Land_TentHangar_V1_F', 'Land_Shed_Small_F', 'Land_Shed_Big_F']) then {S3_SpecialRespawn = 3};
                        hint format['Respawn in %1 (NEAREST)', gettext(configFile >> 'CfgVehicles' >> typeOf _nB  >> 'displayName')];
                    };
                };
                if (missionNamespace getvariable ['S3_oldMarker', 'ERROR'] != _result) then
                {
                    missionNamespace setvariable ['S3_oldMarker', _result];
                    if (_forEachIndex == 0 or _forEachIndex == (count S3_aas_baselist) - 1) then
                    {
                        if (playerSide isEqualTo EAST) then { playsound (jrAASAVoice select 0 select 0) }
                        else
                        {
                            playsound  (jrAASAVoice select 0 select 1)
                        };
                    }
                    else
                    {
                        playsound  (jrAASAVoice select _forEachIndex)
                    };
                };
                ctrlMapAnimClear _mp;
                ctrlMapAnimCommit _mp;
                _dta = uiNamespace getVariable ["S3_MapSave", [0] ];
                _z = _dta select 0;
                _mp ctrlMapAnimAdd [0.5, _z, S3_SPAWNPOS];
                ctrlMapAnimCommit _mp;
                _p111 = getMarkerPos _markerName select [0, 2];
                _p222 = S3_SPAWNPOS select[0, 2];
                missionNamespace setVariable ['useArmor', false, false];
                if ( _p111 distance _p222 < 10) then
                {
                    missionNamespace setVariable ['useArmor', true, false];
                    //systemchat 'CAN USE ARMOR';
                }
                else
                {
                    _objects = nearestObjects [S3_SPAWNPOS, ['MAN'], 10];
					
					
					_enemyHere= count (_objects select {alive _x and !((_x getvariable ['_side', playerSide]) isEqualTo playerSide)} )>0;
					
					if (_enemyHere) then
					{
						//systemchat format["Enemy: %1 _defSPos: %2 Objs: %3", _enemyHere,_defSPos,_objects];
						S3_SPAWNPOS= _defSPos;
						"CUSTOM_RESPAWN" setMarkerPosLocal S3_SPAWNPOS;
						[Localize 'STR_Bad_news', format[Localize 'STR_ENEMY_HERE', 10 ], [1, 0.25, 0.1, 0.9]] spawn S3_fnc_S3_setTextHint;playsound 'HintS3';
					} else
					{
					//['Bad news:', format['NO ARMOR <br/> <t color="#FFAA00" size="1.4">Only %1 meters near flag </t>', 5 ], [1, 0.75, 0, 0.9], 'HintS3'] spawn S3_fnc_S3_setTextHint;
					[Localize 'STR_Bad_news', format[Localize 'STR_Near_Flag', 5 ], [1, 0.75, 0, 0.9]] spawn S3_fnc_S3_setTextHint;playsound 'HintS3';
					};
                };
            };
        } forEach S3_aas_baselist;
        //systemchat str _result;
    };
};

S3_fnc_UpdatePreview =
{
    disableSerialization;
    _d = uiNamespace getVariable 'S3_RESPAWN_DLG';
    _cc =  	uiNamespace getVariable ['S3_HUD_CL', controlNull];
    _classId = lbCurSel _cc;
    _cc = 	uiNamespace getVariable ['S3_HUD_CLASSLB', controlNull];
    _cc ctrlCommit 0;
    _data = _cc lbData (lbCurSel _cc);
    if (_data find '[' > -1) then //Array loadout
    {
        _loadout =  call compile _data;
        S3_PlayerDataP = [_classId, _loadout];
    }
    else
    {
        S3_PlayerDataP = [_classId, _data];
    };
    _cc = uiNamespace getVariable ['S3_HUD_PREVIEWLB', controlNull];
    //copytoclipboard str S3_PlayerDataP;
    _loadout = _data;
    _loadout = _data;
    if (_data find '[' > -1) then //Array loadout
    {
        _loadout =  call compile _data;
        //systemchat (str _loadout+ 'DATA');
    }
    else
    {
        _loadout = getUnitLoadout (S3_PlayerDataP select 1);
    };
    lbClear _cc;
    {
        _cfg = 'cfgWeapons';
        _marr = [];
        if (_x isEqualType []) then
        {
            _marr = _x;
        }
        else
        {
            if (_x != '') then
            {
                _color = [0.2, 0.9, 0.2, 1];
                _wType = _x call BIS_fnc_itemType;
                _cfg = 'cfgWeapons';
                switch (_wType select 1) do
                    {
                    case 'Glasses':
                    {
                        _color = [1, 0.91, 0.91, 1];
                        _cfg = 'cfgGlasses'
                    };
                    };
                _txt = getText (configFile >> _cfg >> _x >> 'DisplayName');
                _cc lbAdd _txt;
                _cc lbSetPicture [(lbSize _cc) - 1, getText (configFile >> _cfg >> _x >> 'Picture')];
                _cc lbSetColor [(lbSize _cc) - 1, _color];
            };
        };
        {
            if (_x isEqualType '') then
            {
                if (_x != '') then
                {
                    _cfg = 'cfgWeapons';
                    _color = [1, 0.9, 0.6, 1];
                    _wType = _x call BIS_fnc_itemType;
                    if (_wType select 1 == 'Backpack') then { _cfg = 'cfgVehicles'};
                    _txt = getText (configFile >> _cfg >> _x >> 'DisplayName');
                    switch (_wType select 0) do
                        {
                        case 'Weapon':
                        {
                            _color = [0.2, 1, 0, 1];
                        };
                        case 'Item':
                        {
                            if (_wType select 1 in ['AccessoryMuzzle', 'AccessoryPointer', 'AccessorySights', 'AccessoryBipod'] ) then
                            {
                                _txt = '               >' + _txt;
                                _color = [1, 1, 0, 1];
                            };
                        };
                        case 'Equipment':
                        {
                            if (_wType select 1 in ['Vest', 'Uniform', 'Backpack'] ) then { _color = [0.9, 0.5, 0.1, 1]; }
                            };
                        };
                    _cc lbAdd _txt;
                    _cc lbSetPicture [(lbSize _cc) - 1, getText (configFile >> _cfg >> _x >> 'Picture')];
                    _cc lbSetColor [(lbSize _cc) - 1, _color];
                };
            };
            if (_x isEqualType []) then //array detected
            {
                _arr = _x;
                if ( count _arr > 0) then
                {
                    {
                        private ['_name', '_cnt'];
                        if (_x isEqualType []) then
                        {
                            _name = _x select 0;
                            _cnt = _x select 1;
                            _cfg = 'CfgWeapons';
                            _wType = _name call BIS_fnc_itemType;
                            _color = [0.9, 0.7, 0.1, 1];
                            switch (_wType select 0) do
                                {
                                    //case 'Weapon': { _cfg= 'cfgWeapons' };
                                    //case 'Item': { _cfg= 'cfgItems' };
                                case 'Mine':
                                {
                                    _cfg = 'cfgMagazines'
                                };
                                case 'Magazine':
                                {
                                    _cfg = 'cfgMagazines'
                                };
                                };
                            if (_name isEqualType []) then //array detected
                            {
                                _tmpA = _name;
                                {
                                    if (_x isEqualType '') then
                                    {
                                        if (_x != '') then
                                        {
                                            _cc lbAdd format ['				[%1] %2',  _cnt, getText (configFile >> _cfg >> _x >> 'DisplayName')];
                                            _cc lbSetPicture [(lbSize _cc) - 1, getText (configFile >> _cfg >> _x >> 'Picture')];
                                            _cc lbSetColor [(lbSize _cc) - 1, _color];
                                        };
                                    };
                                } forEach _tmpA;
                            }
                            else
                            
                            {
                                _cc lbAdd format ['				[%1] %2',  _cnt, getText (configFile >> _cfg >> _name >> 'DisplayName')];
                                _cc lbSetPicture [(lbSize _cc) - 1, getText (configFile >> _cfg >> _name >> 'Picture')];
                                _cc lbSetColor [(lbSize _cc) - 1, _color];
                            };
                        };
                    };
                } forEach _arr;
            };
        } forEach _marr;
    } forEach _loadout;
    _cc ctrlCommit 0;
};

S3_fnc_ShowRespawnDialog =//RESPAWN DIALOG
{
    showGPS false;
    [false] spawn fn_iforceGPS;
    vehicle player switchCamera "Internal";
    S3_V_ActiveRespawn = true;
    S3_SPAWNPOS = getMarkerPos S3_xray;
    _mp = uiNamespace getVariable ["S3_Map", controlNull];
    ctrlMapAnimClear _mp;
    ctrlMapAnimCommit _mp;
    missionNamespace setvariable ['S3_oldMarker', 'ERROR'];
    _pos = _mp ctrlMapScreenToWorld (_mp posWorldToScreen (getMarkerPos format ['Respawn%1', S3_V_ZtoSpawn])); //Localize 'STR_Respawn_%',
    [_pos] call S3_fnc_MapClickRespawn;
    S3_V_OldRESPAWN = S3_V_ZtoSpawn;
    0 spawn
    {
        disableserialization;
        while {S3_V_ActiveRespawn and !(isNull (findDisplay RespawnDIDD))} do
        {
            {
                _markerName = format ["TMZ%1", _forEachIndex + 1];
                _markerName setMarkerDirLocal  (markerDir _markerName + 10);
            }
            forEach S3_aas_baselist;
            'SSEL'
            setMarkerDirLocal  (markerDir 'SSEL' - 20);
            _clr = getMarkerColor S3_V_prevMarker;
            if (S3_V_OldRESPAWN != S3_V_ZtoSpawn) then //
            {
                S3_V_OldRESPAWN = S3_V_ZtoSpawn;
                missionNamespace setvariable ['S3_oldMarker', 'ERROR'];
                _mp = uiNamespace getVariable ["S3_Map", controlNull];
                _pos = _mp ctrlMapScreenToWorld (_mp posWorldToScreen (getMarkerPos format ['Respawn%1', S3_V_ZtoSpawn])); //Localize 'STR_Respawn_%',
                [_pos] call S3_fnc_MapClickRespawn;
            };
            _mp = uiNamespace getVariable ["S3_Map", controlNull];
            uiNamespace setVariable ["S3_MapSave", [ctrlMapScale _mp]];
            sleep 0.05;
        };
        S3_V_ActiveRespawn = false;
        "SSEL"
        setMarkerPosLocal [0, 0, 0];
        "CUSTOM_RESPAWN"
        setMarkerPosLocal [0, 0, 0];
        if ((S3_PlayerData select 1) isEqualType []) then
        {
            player setUnitLoadout [S3_PlayerData select 1, true];
        }
        else
        {
            player setUnitLoadout [getUnitLoadout (S3_PlayerData select 1), true];
        };

        //*
        _cw = primaryWeapon player;
        if (_cw != '') then
        {
            _Wmodes = getArray (configFile >> "CfgWeapons" >> _cw >> "modes");
            player selectWeapon _cw;

            {
                _m = toUpper (_x);
                if (_m find 'FULLAUTO' > -1) ExitWith { player action ["SWITCHMAGAZINE", player, player, _forEachIndex];};
            } forEach _Wmodes;
        };

        call f_NO_SOUND_PATCH;
        [nil, 'WeaponReload'] spawn S3_fnc_jrFnc;

        //*/
        [true] spawn fn_iforceGPS;
        //Del if glitch
        //wtfit set dir player to attack zone
        _sel = S3_INFO_A select 0;
        if (playerside isEqualTo WEST) then {_sel = S3_INFO_A select 1};
        player setDir ([player, S3_aas_baselist select _sel select 5] call BIS_fnc_dirTo);
        ////
    };


};

AAS_C_Load =
{
    params['_loadout'];

    //Jr
    player setUnitLoadout [_loadout, true];
    call f_NO_SOUND_PATCH;
    S3_PlayerData = [100, _loadout];
    missionNamespace setvariable ['S3_PlayerCustomDataServer', _loadout, false];
    systemchat 'Custom loadout found';
};
//*
///BIS///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
fnc_SetPitchBankYaw =
{
    private ["_object", "_rotations", "_aroundX", "_aroundY", "_aroundZ", "_dirX", "_dirY", "_dirZ", "_upX", "_upY", "_upZ", "_dir", "_up", "_dirXTemp",
                        "_upXTemp"];
    _object = _this select 0;
    _rotations = _this select 1;
    _aroundX = _rotations select 0;
    _aroundY = _rotations select 1;
    _aroundZ = (360 - (_rotations select 2)) - 360;
    _dirX = 0;
    _dirY = 1;
    _dirZ = 0;
    _upX = 0;
    _upY = 0;
    _upZ = 1;
    if (_aroundX != 0) then {
        _dirY = cos _aroundX;
        _dirZ = sin _aroundX;
        _upY = -sin _aroundX;
        _upZ = cos _aroundX;
    };
    if (_aroundY != 0) then {
        _dirX = _dirZ * sin _aroundY;
        _dirZ = _dirZ * cos _aroundY;
        _upX = _upZ * sin _aroundY;
        _upZ = _upZ * cos _aroundY;
    };
    if (_aroundZ != 0) then {
        _dirXTemp = _dirX;
        _dirX = (_dirXTemp * cos _aroundZ) - (_dirY * sin _aroundZ);
        _dirY = (_dirY * cos _aroundZ) + (_dirXTemp * sin _aroundZ);
        _upXTemp = _upX;
        _upX = (_upXTemp * cos _aroundZ) - (_upY * sin _aroundZ);
        _upY = (_upY * cos _aroundZ) + (_upXTemp * sin _aroundZ);
    };
    _dir = [_dirX, _dirY, _dirZ];
    _up = [_upX, _upY, _upZ];
    _object setVectorDirAndUp [_dir, _up];
};
///BIS///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


AAS_END =
{
    params ['_side'];
    if (playerSide isEqualTo _side) then { playmusic "match_win" }
    else
    {
        playmusic "match_loss"
    };
    if (CIVILIAN isEqualTo _side) then { playmusic "round_close" };
    [false] spawn fn_iforceGPS;
};

AAS_CU = //Update Flags HUD
{
    //in [_BBases,_RBases,_BAttackListID,_RAttackListID];
	//systemchat str _this;
    disableSerialization;
    params ['_RB', '_BB', '_RA', '_BA', '_RD', '_BD', '_RS', '_BS'];
    _txt = '';
    S3_INFO_A = [_RA, _BA];
    _ctrls = uinamespace getVariable ['S3NewHud',[]];
	if (count _ctrls isEqualTo 0) ExitWith {};
    if (playerSide == west) then
    {
        _dataD = (S3_aas_baselist select _BD select 5) getvariable ['_unt', ['', [0, 0]]];
        _cntD = _dataD select 1;
        _p = _dataD select 2;
        //NEW
        _cP = _ctrls select 0; //Defend ctrl progress
        _cL = _ctrls select 1; //Defend ctrl Letter
        _cS = _ctrls select 2; //Defend ctrl Structured TXT
        _ps = 'A3\ui_f\data\IGUI\Cfg\HoldActions\progress2\progress_' + str (round ((24 * _p) / 100)) + '_ca.paa';
        _cP ctrlSetText _ps;
        if (_p < 100) then { _cP ctrlSetTextColor [1, 1, 1, 0.8] }
        else
        {
            _cP ctrlSetTextColor S3_MyTeamColor
        };
        _cP ctrlCommit 0;
        _LLL = 'A3\ui_f\data\IGUI\Cfg\simpleTasks\letters\'+ ((S3_aas_baselist select _BD select 3) splitString '' select 0) +'_ca.paa';
        _cL ctrlSetText _LLL;
        _colorNew = S3_AllTeamColors select 1;
        if (_p isEqualTo 0) then {_colorNew =  [1, 1, 0, 1]};
        _cL ctrlSetTextColor _colorNew;
        _cL ctrlCommit 0;
        _txtNew = format["<a shadow='2'><t size='1.1' color= '#FF1000'> %1 </t>vs<t size='1.1' color= '#00AFFA'> %2</t></a>", _cntD select 0, _cntD select 1];
        _txtNew = _txtNew + format["<br/><a shadow='2'> %1m </a>", round (vehicle player distance (S3_aas_baselist select _BD select 5))];
        _cS ctrlSetStructuredText parseText _txtNew;
        _cS ctrlCommit 0;
        /////
        _dataA = (S3_aas_baselist select _BA select 5) getvariable ['_unt', ['', [0, 0]]];
        _cntA = _dataA select 1;
        _p = _dataA select 2;
        _color = '#AAFF00';
        _colorNew = [0.5, 1, 0, 1];
        _side = _dataA select 0;
        if (west isEqualTo _side) then { _color = '#00AFFA'; _colorNew = S3_AllTeamColors select 1 };
        if (east isEqualTo _side) then { _color = '#FF1000'; _colorNew = S3_AllTeamColors select 0 };
        //NEW
        _cP = _ctrls select 3; //Defend ctrl progress
        _cL = _ctrls select 4; //Defend ctrl Letter
        _cS = _ctrls select 5; //Defend ctrl Structured TXT
        _ps = 'A3\ui_f\data\IGUI\Cfg\HoldActions\progress2\progress_' + str (round ((24 * _p) / 100)) + '_ca.paa';
        _cP ctrlSetText _ps;
        if (_p < 100) then { _cP ctrlSetTextColor [1, 1, 1, 0.8] }
            else
            {
                _cP ctrlSetTextColor _colorNew
            };
        _cP ctrlCommit 0;
        _LLL = 'A3\ui_f\data\IGUI\Cfg\simpleTasks\letters\'+ ((S3_aas_baselist select _BA select 3) splitString '' select 0) +'_ca.paa';
               _cL ctrlSetText _LLL;
        if (_p isEqualTo 0) then {_colorNew =  [1, 1, 0, 1];};
        _cL ctrlSetTextColor _colorNew;
        _cL ctrlCommit 0;
        _txtNew = format["<a shadow='2'><t size='1.1' color= '#FF1000'> %1 </t>vs<t size='1.1' color= '#00AFFA'> %2</t></a>", _cntA select 0, _cntA select 1];
        _txtNew = _txtNew + format["<br/><a shadow='2'> %1m </a>", round (vehicle player distance (S3_aas_baselist select _BA select 5))];
        _cS ctrlSetStructuredText parseText _txtNew;
        _cS ctrlCommit 0;
        S3_V_ZtoSpawn = _BS + 1;
    }
    else
    {
        _dataD = (S3_aas_baselist select _RD select 5) getvariable ['_unt', ['', [0, 0]]];
        _cntD = _dataD select 1;
        _p = _dataD select 2;
        //NEW
        _cP = _ctrls select 0; //Defend ctrl progress
        _cL = _ctrls select 1; //Defend ctrl Letter
        _cS = _ctrls select 2; //Defend ctrl Structured TXT
        _ps = 'A3\ui_f\data\IGUI\Cfg\HoldActions\progress2\progress_' + str (round ((24 * _p) / 100)) + '_ca.paa';
        _cP ctrlSetText _ps;
        if (_p < 100) then { _cP ctrlSetTextColor [1, 1, 1, 0.8] }
            else
            {
                _cP ctrlSetTextColor S3_MyTeamColor
            };
        _cP ctrlCommit 0;
        _LLL = 'A3\ui_f\data\IGUI\Cfg\simpleTasks\letters\'+ ((S3_aas_baselist select _RD select 3) splitString '' select 0) +'_ca.paa';
        _cL ctrlSetText _LLL;
        _colorNew = S3_AllTeamColors select 0;
        if (_p isEqualTo 0) then {_colorNew =  [1, 1, 0, 1]};
        _cL ctrlSetTextColor _colorNew;
        _cL ctrlCommit 0;
        _txtNew = format["<a shadow='2'><t size='1.1' color= '#FF1000'> %1 </t>vs<t size='1.1' color= '#00AFFA'> %2</t></a>", _cntD select 0, _cntD select 1];
        _txtNew = _txtNew + format["<br/><a shadow='2'> %1m </a>", round (vehicle player distance (S3_aas_baselist select _RD select 5))];
        _cS ctrlSetStructuredText parseText _txtNew;
        _cS ctrlCommit 0;
        /////
        _dataA = (S3_aas_baselist select _RA select 5) getvariable ['_unt', ['', [0, 0]]];
        _cntA = _dataA select 1;
        _p = _dataA select 2;
        _color = '#AAFF00';
        _colorNew = [0.5, 1, 0, 1];
        _side = _dataA select 0;
        if (west isEqualTo _side) then { _color = '#00AFFA'; _colorNew = S3_AllTeamColors select 1 };
        if (east isEqualTo _side) then { _color = '#FF1000'; _colorNew = S3_AllTeamColors select 0 };
        //NEW
        _cP = _ctrls select 3; //Defend ctrl progress
        _cL = _ctrls select 4; //Defend ctrl Letter
        _cS = _ctrls select 5; //Defend ctrl Structured TXT
        _ps = 'A3\ui_f\data\IGUI\Cfg\HoldActions\progress2\progress_' + str (round ((24 * _p) / 100)) + '_ca.paa';
        _cP ctrlSetText _ps;
        if (_p < 100) then { _cP ctrlSetTextColor [1, 1, 1, 0.8] }
            else
            {
                _cP ctrlSetTextColor _colorNew
            };
        _cP ctrlCommit 0;
        _LLL = 'A3\ui_f\data\IGUI\Cfg\simpleTasks\letters\'+ ((S3_aas_baselist select _RA select 3) splitString '' select 0) +'_ca.paa';
        _cL ctrlSetText _LLL;
        if (_p isEqualTo 0) then {_colorNew =  [1, 1, 0, 1]};
        _cL ctrlSetTextColor _colorNew;
        _cL ctrlCommit 0;
        _txtNew = format["<a shadow='2'><t size='1.1' color= '#FF1000'> %1 </t>vs<t size='1.1' color= '#00AFFA'> %2</t></a>", _cntA select 0, _cntA select 1];
        _txtNew = _txtNew + format["<br/><a shadow='2'> %1m </a>", round (vehicle player distance (S3_aas_baselist select _RA select 5))];
        _cS ctrlSetStructuredText parseText _txtNew;
        _cS ctrlCommit 0;
        S3_V_ZtoSpawn = _RS + 1;
    };
};

/* S3_fnc_SaveCustomLoadoutSRV =
{
    [player, getUnitLoadout player] remoteExec ["AAS_S_SI", 2, false];
    hint 'Custom Loadout Saved ';
    [player] remoteExec ["AAS_C_LI", 2, false];
};

S3_fnc_LoadCustomLoadoutSRV =
{
    _loadout = missionnamespace getvariable ['S3_PlayerCustomDataServer', []];
    //hintc str _loadout;
    if (_loadout isEqualTo []) then
    {
        hint 'SRV> Loadout not found';
    }
    else
    {
        player setUnitLoadout [_loadout, true];
        S3_PlayerData = [100, _loadout];
        hint 'Custom Loadout selected';
    };
    call f_NO_SOUND_PATCH;
}; */

S3_fnc_SaveCustomLoadout =
{
    _lt =  getUnitLoadout player;
    missionnamespace setvariable ['S3_PlayerCustomData', _lt];
    S3_PlayerData = [S3_PlayerData select 0, _lt]; //100
    hint Localize 'STR_Custom_SAVED';
};

S3_fnc_LoadCustomLoadout =
{
    _loadout = missionnamespace getvariable ['S3_PlayerCustomData', []];
    S3_PlayerData = [S3_PlayerData select 0, _loadout]; //100
    player setUnitLoadout [_loadout, true];
    call f_NO_SOUND_PATCH;
    hint localize 'STR_Custom_selected';
};

f_NO_SOUND_PATCH =
{
    0 spawn	//NO SOUND PATCH
    {
        sleep 0.5;
        _wi = weaponsItems player;
        _1wm = primaryWeaponMagazine player;
        _2wm = secondaryWeaponMagazine player;
        _3wm = handgunMagazine player;
        {
            player removePrimaryWeaponItem _x;
        } forEach _1wm;
        {
            player removeSecondaryWeaponItem _x;
        } forEach _2wm;
        {
            player removeHandgunItem _x;
        } forEach _3wm;
        sleep 0.5;
        {
            _wpn  = _x select 0;
            _mags = _x select 1;
            {player addWeaponItem [_wpn, _x]} forEach _mags;
        } forEach [[primaryWeapon player, _1wm], [secondaryWeapon player, _2wm], [handgunWeapon player, _3wm]];
    };
};

["Preload"] call BIS_fnc_arsenal;
[] spawn S3_fnc_Arsenal;
["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;




//DEBUG SCREEN
_a = (findDisplay 46) ctrlCreate ["RscStructuredText", 10003];
_a ctrlSetPosition [0.15, safezoneY, safezoneW, safezoneH];
_txt = "";
_a ctrlSetStructuredText parseText _txt;
_a ctrlCommit 0;



S3_mrk_Sel = createMarkerLocal ['SSEL', [0, 0, 0]];
S3_mrk_Sel setMarkerTypeLocal "selector_selectedMission";
S3_mrk_Sel setMarkerAlphaLocal 1;
S3_mrk_Sel setMarkerSizeLocal [1.5, 1.5];
S3_mrk_Sel setMarkerColor "ColorWhite";

_mmr = createMarkerLocal ['CUSTOM_RESPAWN', [0, 0, 0]];
_mmr setMarkerTypeLocal "mil_end";
_mmr setMarkerAlphaLocal 1;
_mmr setMarkerSizeLocal [0.5, 0.5];
_mmr setMarkerColor "ColorYellow";




//EH////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
player setVariable ['_side', playerside, true];
//player addMPEventHandler ["MPRespawn",

player allowDamage false;//New1 

player addEventHandler ["Respawn",
{
    params['_new', '_old'];
	player allowDamage false; //New1 //ON ARMOR
    if !(S3_V_ActiveRespawn) then { createDialog "S3RespawnDialog" };
    player setVariable ['_side', playerside, true];
    _old addaction ["<t size='2' color='#FF333333' > Hide Body ", 'params ["_target", "_caller", "_actionId", "_arguments"]; _caller action ["hideBody", _target]; ', nil, 101, true, true, "", "", 5, false];
    [_new, "NoVoice"] remoteExec ["setSpeaker", 0, true];
}];

player addEventHandler ["Fired",
{
	if (S3V_ShowArmorHint) then
    {
		hint parseText Localize "STR_S3_NO_ARMOR";
		player allowDamage true; //New1 //OFF ARMOR
		S3V_ShowArmorHint = false
	};
}];


player addEventHandler ["HandleRating",
{
	params ["_unit", "_rating"];
	if (_rating<0) then
	{
		_unit addrating (-_rating);
	};
}
];



player addEventHandler ["killed",
{
    params ['_unit', '_killer'];

    _us = _unit getvariable ['_side', 0];
    _ks = _killer getvariable ['_side', 0];

   // hint format['SIDES unit: %1 killer: %2', _us, _ks];

    if (_unit isEqualTo _killer) ExitWith {};

    if ( _us isEqualTo _ks) then
    {
        systemchat format [localize 'STR_kill_me', name _unit, name _killer];
        [] remoteExec ["S3_ifnc_TK", _killer, false];
    };
}];

player addEventHandler["GetOutMan", { player switchCamera "INTERNAL"}];

if (getFatigue player >0.4) then { player setFatigue 0.4; }; 

     player setCustomAimCoef 0.5; 
     player setUnitRecoilCoefficient 0.65;
	 
	 {_x setSpeaker "NoVoice"} foreach allunits;
	 
    /*  player setUnitTrait ["engineer",true];
     player setUnitTrait ["explosiveSpecialist",true];
     player setUnitTrait ["UAVHacker ",true]; */
	 
	
	 
	 AAS_Mines_Limit=10;	//EDIT
     AAS_Player_Mines=[];
     /* AAS_Zones=[];//Zones (Marker) AAS_Zones=["zone1".."zone7"..]
    for "_i" from 1 to ((count S3_aas_baselist) - 1) do 
    {_zone= format ["Respawn%1", _i];AAS_Zones pushBack _zone;}; */
    fnc_AAS_MinesLimit= {
	params['_unit','_weapon', '_muzzle', '_mode', '_ammo', '_magazine', '_projectile', '_vehicle'];
	if (_weapon !='Put') exitWith {};
	/* {if (player inArea _x) exitwith { deletevehicle _projectile; player addItem  _magazine; hint format ["No mines inside the zone ", _x];}; } forEach AAS_Zones;	 */
	AAS_Player_Mines pushBack _projectile;
	{if (isNull _x) then { AAS_Player_Mines deleteAt _forEachIndex; }; } forEach AAS_Player_Mines;
	if (count AAS_Player_Mines >AAS_Mines_Limit ) then { deletevehicle (AAS_Player_Mines select 0);  AAS_Player_Mines deleteAt 0; };
	};//END
    player addEventHandler ["Fired", { _this spawn fnc_AAS_MinesLimit; }];



player setpos (getMarkerPos S3_xray);
[player] remoteExec ["AAS_C_LI", 2, false];

showGPS false;

waituntil {sleep 0.5; !isnull (finddisplay 46)};
_display = findDisplay 46;
_display displayAddEventHandler ["MouseButtonUp", " missionNamespace setVariable['S3_AltState',false] "];

//ARMA III
_display displayAddEventHandler ["KeyUp", "if (inputAction 'personView' > 0) ExitWith { true };"];
_display displayAddEventHandler ["KeyDown", "_this call S3_keyspressed"];

//systemchat 'Create HUD...';//777
//waituntil { sleep 0.05; !isnull (finddisplay 46) };
_minimap = (findDisplay 12) displayCtrl 51;
//M  button -MAP

_minimap ctrlAddEventHandler
["Draw",
{
    _map = _this select 0;
    _p = getPos (vehicle player);
    _d = direction (vehicle player);
    _clr = +S3_MyTeamColor;
    _clr Set [3, 1];

    _map drawIcon [
     'A3\ui_f\data\IGUI\RscCustomInfo\Sensors\Threats\sector_ca.paa',

     [0.91, 0.91, 0.12, 1],
     _p,
     256,
     128,
     _d,
     '',
     0,
     1,
     'TahomaB',
     'right'
    ];
    {
        _map drawIcon ['A3\ui_f\data\IGUI\RscCustomInfo\Sensors\Threats\sector_ca.paa', _clr, getpos _x, 256, 128, getDir _x, name _x, 2, 0.04, 'TahomaB', 'center'];
    }  foreach ((Allunits - [player]) select { side _x isEqualTo Playerside});
}
];

//if !(isNull ((findDisplay 46) displayCtrl 10010)) ExitWith {};
//Scores
//*
//NEW HUD
//New hint
_aD = (findDisplay 46) ctrlCreate ["RscText", 10014];
_aD ctrlSetPosition [SafeZoneX + 0.5, 0.1, 0.42, S3_UI_BH * 0.9];
_aD ctrlSetBackgroundColor [(S3_MyTeamColor select 0) * 0.5, (S3_MyTeamColor select 1) * 0.5, (S3_MyTeamColor select 2) * 0.5, 0.5];
_aD ctrlSetText 'CAPTION';
_aD ctrlSetTextColor [0, 0, 0, 1];
_aD ctrlSetFade 1;
_aD ctrlCommit 0;

_aD1 = (findDisplay 46) ctrlCreate ["RscActivePicture", 10015];
_aD1 ctrlSetPosition [SafeZoneX + 0.5, 0.1 + S3_UI_BH + 0.003, 0.42, 0.15];
_aD1 ctrlSetText 'A3\ui_f\data\GUI\Rsc\RscDisplayInventory\gradient_gs.paa';

_aD1 ctrlSetTextColor [0, 0, 0, 0.7]; //S3_MyTeamColor;
_aD1 ctrlSetFade 1;
_aD1 ctrlCommit 0;

_aD2 = (findDisplay 46) ctrlCreate ["RscStructuredText", 10016];
_aD2 ctrlSetPosition [SafeZoneX + 0.5, 0.1 + S3_UI_BH + 0.006, 0.42, S3_UI_BH * 100];
_aD2 ctrlSetStructuredText parseText "Info";
_aD2 ctrlSetFade 1;
_aD2 ctrlCommit 0;

uinamespace setVariable ['S3HintHud', [_aD, _aD1, _aD2]];

_hud_x = safeZoneX + safeZoneW - 0.18;
_hud_y = safeZoneY + SafeZoneH / 4;
_aD = (findDisplay 46) ctrlCreate ["RscPictureKeepAspect", -1];
_aD ctrlSetPosition [_hud_x, _hud_y, 0.1, 0.1];
_aD ctrlSetText 'A3\ui_f\data\IGUI\Cfg\HoldActions\progress2\progress_24_ca.paa';
_aD ctrlSetFade 0;
_aD ctrlSetTextColor S3_MyTeamColor;//[1, 0, 0, 1];
_aD ctrlCommit 0;

_aLD = (findDisplay 46) ctrlCreate ["RscPictureKeepAspect", -1];
_aLD ctrlSetPosition [_hud_x + 0.02, _hud_y + 0.02, 0.1 - 0.04, 0.1 - 0.04];
_aLD ctrlSetText 'A3\ui_f\data\IGUI\Cfg\simpleTasks\letters\b_ca.paa';
_aLD ctrlSetFade 0;
_aLD ctrlSetTextColor S3_MyTeamColor;//[1, 0, 0, 1];
_aLD ctrlCommit 0;

_aSD = (findDisplay 46) ctrlCreate ["RscStructuredText", -1];
_txt = "Info";
_aSD ctrlSetPosition [_hud_x + 0.08, _hud_y, 0.2, 0.3];
_aSD ctrlSetStructuredText parseText _txt;
_aSD ctrlCommit 0;

_aA = (findDisplay 46) ctrlCreate ["RscPictureKeepAspect", -1];
_aA ctrlSetPosition [_hud_x, _hud_y + 0.12, 0.1, 0.1];
_aA ctrlSetText 'A3\ui_f\data\IGUI\Cfg\HoldActions\progress2\progress_24_ca.paa';
_aA ctrlSetFade 0;
_aA ctrlSetTextColor S3_MyTeamColor;//[1, 0, 0, 1];
_aA ctrlCommit 0;

_aLA = (findDisplay 46) ctrlCreate ["RscPictureKeepAspect", -1];
_aLA ctrlSetPosition [_hud_x + 0.02, _hud_y + 0.12 + 0.02, 0.1 - 0.04, 0.1 - 0.04];
_aLA ctrlSetText 'A3\ui_f\data\IGUI\Cfg\simpleTasks\letters\b_ca.paa';
_aLA ctrlSetFade 0;
_aLA ctrlSetTextColor S3_MyTeamColor;//[1, 0, 0, 1];
_aLA ctrlCommit 0;

_aSA = (findDisplay 46) ctrlCreate ["RscStructuredText", -1];
_txt = "Info";
_aSA ctrlSetPosition [_hud_x + 0.08, _hud_y + 0.12, 0.2, 0.3];
_aSA ctrlSetStructuredText parseText _txt;
_aSA ctrlCommit 0;

uinamespace setVariable ['S3NewHud', [_aD, _aLD, _aSD, _aA, _aLA, _aSA]];
//NEW HUD END

_a = (findDisplay 46) ctrlCreate ["RscPicture", 10001];
_a ctrlSetPosition [safezoneX, safezoneY, safezoneW, 0.06];
_a ctrlSetFade 0;
_a ctrlSetTextColor S3_MyTeamColor;//[1, 0, 0, 1];
_a ctrlCommit 0;


//WATER MARK
_a = (findDisplay 46) ctrlCreate ["RscPicture", 10001];

_a ctrlSetPosition [(safezoneX + SafeZoneW) / 2 - 0.12, (safezoneY + safeZoneH) / 2, 0.5, 0.5];
_a ctrlCommit 0;
_a ctrlSetPosition [safezoneX, safezoneY + safeZoneH - 0.06, 0.12, 0.06];
_a ctrlSetText 'images\wm.paa';
_a ctrlSetFade 0;
//_a ctrlSetTextColor S3_MyTeamColor;//[1, 0, 0, 1];
_a ctrlCommit 2;

//*
//PLAYERS COUNT
_a = (findDisplay 46) ctrlCreate ["RscStructuredText", -1];
//_a ctrlSetPosition [safezoneX+0.12, safezoneY+safeZoneH-0.05, 0.5, 0.06];
_a ctrlSetPosition [0, safezoneY + safeZoneH - 0.05, 1, 0.06];
_a ctrlSetStructuredText parseText "Players";
//_a ctrlSetBackgroundColor [0, 0, 0, 0.5];
_a ctrlCommit 0;
uiNamespace setVariable ['S3_INFOC', _a];

//*/

//*/

//BLACK LABEL
_a = (findDisplay 46) ctrlCreate ["RscPictureKeepAspect", 10013];
_a ctrlSetPosition [safezoneX, safezoneY, safezoneW, safezoneH];
_a ctrlSetText '\A3\ui_f\data\gui\cfg\Debriefing\endDeath_ca.paa';
_a ctrlSetFade 1;
_a ctrlSetTextColor [0, 0, 0, 1];
_a ctrlCommit 0;
//*/

//GPS
_a = (findDisplay 46) ctrlCreate ["RscPicture", 10010];
_minimap = (findDisplay 46) ctrlCreate ["S3_RscMapControl", 10011];
_pos = (ctrlPosition _minimap) select [0, 2];
_h = (ctrlPosition _minimap) select 3;
//A3
_pos set [1, safeZoneH + safeZoneY - _h - 0.02];

_minimap ctrlSetPosition _pos;
_minimap ctrlCommit 0;

_a ctrlSetPosition  ctrlposition _minimap;
_a ctrlSetText 'A3\ui_f\data\GUI\Rsc\RscDisplayInventory\gradient_gs.paa';
_a ctrlSetFade 0;
_a ctrlSetTextColor [S3_MyTeamColor select 0, S3_MyTeamColor select 1, S3_MyTeamColor select 2, 0.3];
_a ctrlCommit 0;

//Header
_h = (findDisplay 46) ctrlCreate ["RscStructuredText", 10012];

_tp = ctrlposition _minimap;
_tp set [1, (_tp select 1) - 0.04];
_tp set [3, 0.04];

_h ctrlSetPosition  _tp;

_h ctrlSetBackgroundColor [(S3_MyTeamColor select 0) * 0.5, (S3_MyTeamColor select 1) * 0.5, (S3_MyTeamColor select 2) * 0.5, 0.5];
//_h ctrlSetTextColor [1,1,0,0.4];
//_h ctrlSetForegroundColor [1, 1, 0, 1];

_h ctrlSetStructuredText parseText 'Welcome to AASJR';
_h ctrlSetFade 0;
_h ctrlCommit 0;

_minimap ctrlAddEventHandler
["Draw",
{
    _map = _this select 0;
    _p = getPos (vehicle player);
    _d = direction (vehicle player);
    _map ctrlMapAnimAdd [0, MAP_Zoom, _p];
    _map drawIcon [
     'A3\ui_f\data\IGUI\RscCustomInfo\Sensors\Threats\sector_ca.paa',//'A3\ui_f\data\IGUI\Cfg\Radar\viewdir_ca.paa',
     [0.91, 0.91, 0.12, 1],
     _p,
     256,
     128,
     _d,
     '',//txt
     0,
     1,
     'TahomaB',
     'right'
    ];

    _cAI = + S3_MyTeamColor;
    _cAI set [3, 0.9];
    {
        _p = getPos (vehicle _x);
        _d = direction (vehicle _x);
        _map drawIcon [
        'A3\ui_f\data\IGUI\Cfg\simpleTasks\interaction_pointer6_ca.paa',//'A3\ui_f\data\IGUI\RscCustomInfo\Sensors\Threats\sector_ca.paa',//'A3\ui_f\data\IGUI\Cfg\Radar\viewdir_ca.paa',
        _cAI,
        _p,
        48,
        48,
        _d,
        '',//txt
        0,
        1,
        'TahomaB',
        'right'
        ];
    } foreach ((nearestObjects [player, [], 50] - [player]) select {alive _x and side _x isEqualTo Playerside});
    ctrlMapAnimCommit (_this select 0);
}
];

uiNamespace setVariable ["S3_GPS_Controls", [_a, _minimap]];
uiNamespace setVariable ["S3GPS_Header", _h];
//////////////////////////////////////

createDialog "S3RespawnDialog";

[] spawn
{
    disableSerialization;
    scriptName "S3>>>CLIENT LOOP A3";
	
    waituntil
    {
        sleep 0.1;	//def 1
        if (cameraView == "GUNNER")	then { missionNamespace setVariable["S3_AltState", true] };
        player setCustomAimCoef 0.5;
        player setUnitRecoilCoefficient 0.65;
        if (getFatigue player > 0.4) then { player setFatigue 0.4; };
        _d = finddisplay 46;
        _cc = _d displayCtrl 10008;
        _cb = _d displayCtrl 10009;
        _time = (estimatedEndServerTime - serverTime) / 3600;
        //Minimap header
        _txt = format["<a size='0.8' color='#FFFFFF'><img  shadow= '0' color='#AAAAAAFF' image='A3\ui_f\data\GUI\Rsc\RscDisplayArsenal\compass_ca.paa'/>%1 	[%2]	 <img  shadow= '0' color='#AAFF0000' size='0.5' image='A3\ui_f\data\igui\cfg\actions\heal_ca.paa'/> %3 <t align= 'right'>%4 </t></a>",
                          round (direction vehicle player),  mapGridPosition getPos vehicle player, round ((1 - damage player) * 100), [_time, 'HH:MM:SS'] call bis_fnc_timetostring];
        _pInfo = uiNamespace getVariable "S3_INFOC";
        _class = '';
        if (S3_PlayerData select 0 == 100) then {_class = 'custom'}
            else
            {
                _class = S3_JrAAS_RULES select (S3_PlayerData select 0) select 0 select 0;
            };
        _txt1 = format["<a align='center'><t size='1'  color='#EE87FF00'>%4</t> <t size='1.1' shadow='0'> Players: <t size='1' color='#AA00AAFF'> %1 W</t> vs <t size='1' color='#AAFF0000'> %2 E</t>  [%3]</t> </a>",
                           playersNumber west, playersNumber east, (playersNumber west) + (playersNumber east), localize ('STR_' + _class)];
        _pInfo ctrlSetStructuredText parseText _txt1;
        _pInfo ctrlCommit 0;
        _c =	uiNamespace getVariable "S3GPS_Header";
        _c ctrlSetStructuredText parseText _txt;
        _c ctrlCommit 0;
        _rCount = count (AllUnits select {alive _x and _x getVariable ['S_', 'A'] isEqualTo 'E'; });
        _bCount = count (AllUnits select {alive _x and _x getVariable ['S_', 'A'] isEqualTo 'W'; });
        //hintSilent format ['AI Red=%1 Blue= %2 GC: %3', _rCount, _bCount, count allGroups ];
		//copytoclipboard  str (animationState player);
        false;
    };
};

};








////SERVER//////////////////////////////////////////////////////////////////////////////////////////////
////SERVER//////////////////////////////////////////////////////////////////////////////////////////////
////SERVER//////////////////////////////////////////////////////////////////////////////////////////////
////SERVER//////////////////////////////////////////////////////////////////////////////////////////////
////SERVER//////////////////////////////////////////////////////////////////////////////////////////////
////SERVER//////////////////////////////////////////////////////////////////////////////////////////////
////SERVER//////////////////////////////////////////////////////////////////////////////////////////////
////SERVER//////////////////////////////////////////////////////////////////////////////////////////////
if (isServer) then
{
		estimatedtimeleft 100001;
		//bulldozer
		{
			_m= _x;
			{
				if ( _x inArea _m ) then { hideObjectGlobal _x }
			}ForEach (nearestTerrainObjects [getMarkerPos _m, [], 200]); 	
		} forEach ['bulldozer1', 'bulldozer2', 'bulldozer3', 'bulldozer4'];






S3_EGR= createGroup [east, false];
S3_WGR= createGroup [west, false];

//VARS//////////
AAS_ZonesCount= (count S3_aas_baselist);
AAS_RIdx= -1;
AAS_BIdx= -1;

AAS_V_CA=[];
//VARS//////////

if ((S3_aas_baselist select 0 select 0) isEqualTo west) then
{
	AAS_RIdx= 0;
	AAS_BIdx= 1;
} else { AAS_RIdx= 1; AAS_BIdx= 0 };

S3_SRV_ALLBASES= (count S3_aas_baselist)-1;
R_SPAWN=0;
B_SPAWN=0;
AAS_V_CA= [];
AAS_V_CR= [];
AAS_V_CD= [];

//Settings/////////////////////////////////////////////////////////////////////////////////////
//systemChat 'CREATE AI NEW';
HP_dead=20;

BLUE_Units= [];
RED_Units= [];


BLUE_Units= S3_WEST_AI;
RED_Units = S3_EAST_AI;


/*PERFECT*/
/* BLUE_Units= ["B_Soldier_F","B_recon_medic_F","B_Soldier_AR_F","B_soldier_M_F","B_Soldier_AR_F"];
RED_Units = ["O_Soldier_F","O_recon_medic_F","O_Soldier_AR_F","O_soldier_M_F","O_soldierU_AR_F"]; */




All_Reds_grp= [];
All_Blues_grp= [];

//BehTypes=["CARELESS","CARELESS","SAFE","SAFE",,"AWARE","AWARE","COMBAT","COMBAT","COMBAT","STEALTH","STEALTH"];
BehTypes=["AWARE", "COMBAT"];
	
killedcntW=0;
killedcntE=0;	

//RED_A_Herd selectLeader _unit;
//BLUE_A_Herd selectLeader _unit;	

S3_smk= ["SmokeShell","SmokeShellYellow","SmokeShellRed","SmokeShellGreen","SmokeShellPurple","SmokeShellBlue","SmokeShellOrange"];

//	_wp1 =_grp addWaypoint [getposATL (S3_aas_baselist select(AAS_V_CA select 0) select 4), 1];
	//_wp1 setWaypointType 'HOLD';

//systemchat format['>:(   G: %1 U: %2 N: %3', _grp, _unit, name _unit];








//S3_INIT_DONE=false;

AAS_S_AISG= 
{
	PjrAAS_NumberOfAIgroups= _this select 0;
};

AAS_S_AISU= 
{ 
	PjrAAS_NumberOfAIunitsPerGroup= _this select 0;
};

fn_in_setServerDate= 
{
	params['_date'];
	S3_missionDATE= _date;
};

S3_fnc_CreateAI=
{
for "_i" from 0 to (PjrAAS_NumberOfAIgroups-1) do
{
	_group= createGroup [east, false];
	//sleep 1;
	systemchat format ['CreateGroup: %1 N: %2 _i: %3', _group, PjrAAS_NumberOfAIgroups, _i];
	All_Reds_grp pushBack _group;
	
	_ct=0;
	
	while {_ct<PjrAAS_NumberOfAIunitsPerGroup} do 
	{
		['E', _group] call S3_fnc_SpawnUnit;
		_ct=_ct+1;
		sleep 1;
	};

	_group= createGroup [west, false];
	//sleep 1;
	systemchat format ['CreateGroup: %1 N: %2 _i: %3', _group, PjrAAS_NumberOfAIgroups, _i];
	All_Blues_grp pushBack _group;
	
	_ct=0;
	while {_ct<PjrAAS_NumberOfAIunitsPerGroup} do 
	{
		['W', _group] call S3_fnc_SpawnUnit;
		_ct=_ct+1;
		sleep 1;
	};
};
};

AAS_BombVehicle= {
params ['_u','_v'];
_expl1= "HelicopterExploBig" createVehicle (position _v);//HelicopterExploSmall
_expl1 setShotParents [vehicle _u, _u]; 
};

S3_fnc_SpawnUnit= compileFinal 
"
	params ['_side','_grp'];
	
	[_side, _grp] spawn 
	{
		params ['_side','_grp'];
		sleep 7;
		private['_unit','_side','_pos','_Sunit','_grp','_ii', '_ca']; 
		_ii=-1;
		if (_side isEqualTo 'E') then 
		{	
			_Sunit=  RED_Units call bis_fnc_selectrandom;
			_ii= R_SPAWN;	
			_ca=0;
		};
		
		if (_side=='W') then 
		{	
			_Sunit= BLUE_Units call bis_fnc_selectrandom;
			_ii= B_SPAWN;
			_ca=1;
		};
		
		_flP=getposAtl (S3_aas_baselist select _ii select 5);
		
		_pos= _flP getPos [3 * sqrt random 1, random 360];
		_unit = _grp createUnit [_Sunit, _pos, [], 0, 'NONE'];
		
		_att= _unit setVariable ['_s', _ca, false];
		systemchat format['>:(   G: %1 U: %2 N: %3 F: %4', _grp, _unit, name _unit, (S3_aas_baselist select _ii select 5)];
		
		_unit  setVariable ['S_', _side, true]; 
		
		_unit reveal [_unit, 4];
		_unit setVariable ['_jrGroup', group _unit, false]; 
		
		_unit addMPEventHandler ['MPKilled', 
		{ 
			if !(isServer) ExitWith { };
			params ['_unit']; 
			_s= _unit getVariable ['S_', 'WTF'];
			_g= _unit getVariable '_jrGroup'; 
			while {(count (waypoints group _unit)) > 0} do
			{
				deleteWaypoint ((waypoints group _unit) select 0);
			};
			
			[_s, _g] call S3_fnc_SpawnUnit;
			
			(_this select 0) spawn 
			{ 
				_this removeAllMPEventHandlers 'MPKilled';
				_this removeAllEventHandlers 'hit'; 
				sleep 20; 
				deletevehicle _this; 
			};
		}];
		
		_unit setVariable ['BIS_noCoreConversations', true];  
		_unit allowFleeing 0;
		
		_target= (S3_aas_baselist select(AAS_V_CA select _ca) select 5);	
		_wType= 'MOVE';
		_wg= group _unit;
		
		if (random 100<50) then
		{
			_nO= (nearestObjects [_unit, ['Car','Tank','Air'], 50]) select {alive _x};
			if (count _nO>0)  then 
			{
				_wType= 'GETIN';
				_veh= _nO call bis_fnc_selectrandom;
				
				_target= _veh;
				_wg reveal _target;
				_wg reveal [_target, 4];
			};
		};
		
		_wp= (group _unit) addWaypoint [_target, 5];  
		_wp setWaypointType _wType; 
		
		if !(_target isKindOf 'Man') then 
		{
			_wp waypointAttachObject _target;
		};
		
		_unit setRank 'COLONEL';
		sleep 5;
		_wp setWaypointStatements ['true', ' [this] call S3_fnc_BastardWP;'];
		
		{
			_unit disableAI _x;
		} forEach ['FSM', 'COVER', 'AUTOCOMBAT'];
		
		_wp setWPPos getPos _target; 
		_unit setVariable ['_CWP', _wp, false];
		
		_wg setCurrentWaypoint _wp;
	};
	
";

AAS_S_DAI= { //Disable AI
	{
		_units= units _x;
		{deletevehicle _x} forEach _units;
		deleteGroup _x;
	} forEach (All_Reds_grp+All_Blues_grp);
	
	{
		deleteGroup (group _x);
		deletevehicle _x;
	} forEach AllUnits;
	
	All_Reds_grp=[];
	All_Blues_grp=[];
};

//SAVE
AAS_C_LI= { /* remoteExec ["AAS_C_Load", _player, false];	};//first connect load data from server block for rhs/class version

	
	params['_player'];
	_side= "Error";
	if (side _player isEqualTo WEST) then { _side= "west" };
	if (side _player isEqualTo EAST) then { _side= "east" };

	_varName= 'AAS_C5_'+_side+'_'+ getPlayerUID _player; 
	_loadout= profileNamespace getvariable [_varName,[]];
	if !(_loadout isEqualTo []) then
	{
		systemchat 'Custom found'; //custom found
		[_loadout]
	 */
};


AAS_S_SI= {/* 
	
	//save player loadout in server profile
	params['_player', '_loadout'];
	_side= "Error";
	if (side _player isEqualTo WEST) then { _side= "west" };
	if (side _player isEqualTo EAST) then { _side= "east" };

	_varName= 'AAS_C5_'+_side+'_'+ getPlayerUID _player; 
	profileNamespace setvariable [_varName, _loadout];
	_loadout= profileNamespace getvariable [_varName,[]]; */
	
};
//END SAVE<<<

AAS_S_PARAMS= 
{
	
	_viewDist= _this select 0;
	PjrAAS_ViewDistance= _viewDist;
	[] remoteExec ['S3_fnc_syncParams', -2, false]; //Update clients	//-2
};



S3InitZonesPP= compile preprocessFile "Scripts\S3_Init_AAS.sqf";
["Initialize", [true]] call BIS_fnc_dynamicGroups;

//waitUntil {S3_INIT_DONE};
//OLD_aasRespawn= compile preprocessFileLineNumbers "Scripts\vehicleRespawn.sqf";
//[this] call OLD_aasRespawn;






S3_SERVER_TimeEnd=566;
S3_END_MISSION= false;
disableSerialization;


//Flag1 setVariable['S3_params_VD', ["PjrAAS_ViewDistance", 699] call BIS_fnc_getParamValue, true];




estimatedtimeleft PjrAAS_time;

//waitUntil {S3_SERVER_TimeEnd= estimatedEndServerTime - serverTime; S3_SERVER_TimeEnd>1};
waitUntil {S3_SERVER_TimeEnd= estimatedEndServerTime - serverTime; estimatedEndServerTime > 0 and S3_SERVER_TimeEnd>0 and S3_INIT_DONE};

call S3_fnc_SRV_Update;
0 spawn { sleep 2; call S3_fnc_CreateAI;};
systemchat format['22S3_SERVER_TimeEnd: %1 estimatedEndServerTime: %2  serverTime: %3',S3_SERVER_TimeEnd,estimatedEndServerTime,serverTime];


waituntil 
{
	//systemchat 'DO SOMETHING';
	
	_stats= call S3_fnc_SRV_Update;
	_stats remoteExec ["AAS_CU", 0, false];

	AAS_V_CA= _stats select [2,2];//CURRENT ATTACK LIST
	AAS_V_CR= _stats select [0,2];//CURRENT RESPAWN LIST
	AAS_V_CD= _stats select [4,2];
	
	S3_SERVER_TimeEnd= estimatedEndServerTime - serverTime;
	//systemchat  str S3_SERVER_TimeEnd;
	/*
	_stats= call S3_fnc_SRV_Update;
	_stats remoteExec ["AAS_CU", 0, false];

	AAS_V_CA= _stats select [2,2];//CURRENT ATTACK LIST
	AAS_V_CR= _stats select [0,2];//CURRENT RESPAWN LIST
	AAS_V_CD= _stats select [4,2];
	//*/
	//systemchat format["Respawn%1",AAS_V_CD]; 
	//systemchat str AAS_V_CR;
	//AAS_ZDATA= _stats; //publicVariable "AAS_ZDATA";
	//systemchat str AAS_V_CA;
	

	
	
	
	
	sleep 0.1;
	false;
};

};


