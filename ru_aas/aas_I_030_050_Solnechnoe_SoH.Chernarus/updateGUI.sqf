#include "globalDefines.hpp"
array _teamColor =
	[ [1,1,1,1] ,
	  [1,0,0,1] ,     // red team
	  [0,0.7,1,1] ,     // blue team
	  [0,1,0,1] ];  // green team
	
array _teamBackColor =
	[ [1,1,1,0.6] ,
	  [0,0,0,0.4] ,     // red team
	  [0,0,0,0.4] ,     // blue team
	  [0,0,0,0.5] ];  // green team
int _mySide=0;
int _myTeamColIdx=1;
if( WEST_PLAYER ) then
	{
	_mySide = 1; 
	_myTeamColIdx = 2;
	};
	array int _dispBaseList = redDefendList + redAttackList;
	int _leftvdisp=NUMRED;
	int _rightvdisp=NUMBLUE;
	int _myTeam=TEAM_RED;
	int _otherTeam=TEAM_BLUE;
	if( WEST_PLAYER ) then
		{
		_dispBaseList = blueDefendList + blueAttackList;
		_leftvdisp=NUMBLUE;
		_rightvdisp=NUMRED;		
		_myTeam=TEAM_BLUE;
		_otherTeam=TEAM_RED;
		};
      array int _composingControls = [ BOX             , NAMELABEL  , DISTLABEL  , CAPLEVLAB , LEFTNOS , RIGHTNOS , EXTRADATA , VERSUS   ];
      array int _controlFixedY =     [ YPOS_BB         , YPOS_BN    , YPOS_BD    , YPOS_BC   , YPOS_BL , YPOS_BR  , YPOS_BE   , YPOS_BV  ];			
   	array int _controlFixedX =     [ BASEBACKGROUND_X, BASENAME_X , BASEDIST_X , BASEBAR_X , LEFT_X  , RIGHT_X  , EXTRA_X   , VERSUS_X ];
	int _boxNo=0;
for "_boxno" from 0 to (NUM_DISP_BOXES - 1) do
		{
		array _controlNewText = [];
		int _curBase = 0;
		
		if( _boxNo < (count _dispBaseList) ) then
			{
			_curBase = _dispBaseList select _boxNo;
			_controlNewText = [ "" ] + 
							[ BASELETTER(_curBase) ] +                                                   // cur base name label
							[ format["%1m",floor (player distance (getMarkerPos BASENAME(_curBase)))] ] +       // distance to base
							[ "" ] + 
							[ format["%1",BASECACHEA(_curBase,_leftvdisp)] ] +                                 // our numbers in this base
							[ format["%1",BASECACHEA(_curBase,_rightvdisp)] ] +                                // their numbers in this base
							[ "" ];
			};
		int _elementNo=0;
	    for "_elementno" from 0 to (NUM_BOX_ELEMENTS - 1) do
			{			
			int _newID = (IDCBASE + (_composingControls select _elementNo) + _boxNo);
			control _control = _currentCutDisplay displayCtrl _newID;
			int _thisCtrlSort = _composingControls select _elementNo;
			if( _boxNo < (count _dispBaseList) ) then
				{ 
				_control ctrlShow true;
				if( (_composingControls select _elementNo) == CAPLEVLAB ) then
					{
					float _maxBarHeight = 0.04;
					_position = ctrlPosition _control;
					_position set [0, safeZoneW + safeZoneX - (1-BASEBAR_X)];
					_position set [1, safeZoneY + (BOX_START_OFFSET + YPOS_BC + (BOX_SPACING * _boxNo)) + _maxBarHeight - ( _maxBarHeight * BASECACHEA(_curBase,CAPLEVEL) / 100 )];				
					_position set[3,_maxBarHeight * BASECACHEA(_curBase,CAPLEVEL) / 100];	
					_control ctrlSetPosition _position;					
					}
				else
					{
					_position = ctrlPosition _control;
					_position set [ 0 , safeZoneW + safeZoneX - (1-(_controlFixedX select _elementNo)) ];
					_position set [ 1 , safeZoneY + (_controlFixedY select _elementNo) + BOX_START_OFFSET + (BOX_SPACING * _boxNo) ];	
					_control ctrlSetPosition _position;
					};
				//_newText = _controlNewText select _elementNo;
				if( true ) then {	
				_control ctrlSetText (_controlNewText select _elementNo); };
				if( _thisCtrlSort == DISTLABEL ) then
					{
					_control ctrlSetTextColor (_teamColor select BASEA(_curBase,TEAM));	//red
					};
				if( _thisCtrlSort == LEFTNOS   ) then { _control ctrlSetTextColor (_teamColor select _myTeam   ); };
				if( _thisCtrlSort == RIGHTNOS  ) then { _control ctrlSetTextColor (_teamColor select _otherTeam); };				
				if( _thisCtrlSort == BOX       ) then { _control ctrlSetBackgroundColor (_teamBackColor select BASEA(_curBase,TEAM)); };
				if( _thisCtrlSort == CAPLEVLAB ) then { _control ctrlSetBackgroundColor (_teamColor     select BASEA(_curBase,TEAM)); };
				if( _thisCtrlSort == NAMELABEL ) then
					{
						if( (floor time) % 2 == 0 and BASECACHEA(_curBase,CAPLEVEL) == 0 ) then
							{
							_control ctrlSetTextColor [1,1,0,1];		//yellow
							}
						else
							{
							_control ctrlSetTextColor (_teamColor select BASEA(_curBase,TEAM));	//red
							};
					};
				
				}
			else
				{
				_control ctrlShow false;		
				};
				
			_control ctrlCommit 0;
			};
		
		};