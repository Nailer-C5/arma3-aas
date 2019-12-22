/*
	
      AUTHOR: aeroson
	NAME: player_markers.sqf
	VERSION: 2.5		 			 	
*/			   
if (isDedicated) exitWith {}; // is server  
if (!isNil{aero_player_markers_pos}) exitWith {}; // already running
				   
private ["_marker","_markerText","_temp","_vehicle","_markerNumber","_show","_injured","_num","_getNextMarker","_getMarkerColor"];

#include "globalDefines.hpp"

aero_player_markers_pos = [0,0];
//onMapSingleClick "aero_player_markers_pos=_pos;";

_getNextMarker = {
	private ["_marker"]; 
	_markerNumber = _markerNumber + 1;
	_marker = format["um%1",_markerNumber];	
	if(getMarkerType _marker == "") then {
		createMarkerLocal [_marker, _this];
	} else {
		_marker setMarkerPosLocal _this;
	};
	_marker;
};

_getMarkerColor = {	
	[(((side _this) call bis_fnc_sideID) call bis_fnc_sideType),true] call bis_fnc_sidecolor;
};

while {true} do {
	  
	waitUntil {
		sleep 0.025;
		true;
	};
	
	_markerNumber = 0; 
	
	// show players or player's vehicles
	{
		_show = false;
		_injured = false;
	
		//if(true) then {
		if(side _x == side player) then {		
			if((crew vehicle _x) select 0 == _x) then {
				_show = true;
			};		
			if(!alive _x || damage _x > 0.9) then {
				_injured = true;
			};	  
			if(!isNil {_x getVariable "hide"}) then {
				_show = false;
			};  
			if(_x getVariable ["BTC_need_revive",-1] == 1) then {
				_injured = true;
				_show = false;
			};		  
			if(_x getVariable ["NORRN_unconscious",false]) then {
				_injured = true;
			};	  
		};
			  	 
		if(_show) then {
			_vehicle = vehicle _x;  				  	
			_pos = getPosATL _vehicle;		  					
			_color = _x call _getMarkerColor;  

			_markerText = _pos call _getNextMarker;						
			_markerText setMarkerColorLocal _color;	 						 				
 			_markerText setMarkerTypeLocal "c_unknown";		  			   
			_markerText setMarkerSizeLocal [0.1,0];

			_marker = _pos call _getNextMarker;			
                  if(alive _x) then {
	            if (_x == leader player ) then {_markerText setMarkerColorLocal "ColorBlack";};       
		      if(group _x == group player) then {
		        _marker setMarkerColorLocal "ColorWhite";
		      } else {
		        _marker setMarkerColorLocal _color;
		      };
		      _marker setMarkerDirLocal getDir _vehicle;
			_marker setMarkerTypeLocal "mil_triangle";
			_marker setMarkerTextLocal "";	
		      if(_x == player) then {
		      	_marker setMarkerSizeLocal [0.7,0.85];
				} else {
				_marker setMarkerSizeLocal [0.6,0.75];
		      };
		    } else {      
		      _marker setMarkerColorLocal "ColorKhaki";
		      _marker setMarkerTypeLocal "hd_objective";
		      _marker setMarkerSizeLocal [0.7,0.7];
		      sleep 5;  
		    };			
 			
		};
		
	} forEach playableUnits;


	// show player controlled uavs
	{
		if(isUavConnected _x) then {	
			_operator=(uavControl _x) select 0;
			if(isPlayer _operator && side _operator == playerSide) then {
				_color = _x call _getMarkerColor;								  										  				
				_pos = getPosATL _x;
				
				_marker = _pos call _getNextMarker;			
				_marker setMarkerColorLocal _color;
				_marker setMarkerDirLocal getDir _x;
				_marker setMarkerTypeLocal "mil_triangle";			
				_marker setMarkerTextLocal "";
				if(_operator == player) then {
					_marker setMarkerSizeLocal [0.7,0.85];
				} else {
					_marker setMarkerSizeLocal [0.6,0.75];
				};
									  		
				_markerText = _pos call _getNextMarker;	
				_markerText setMarkerColorLocal _color;	   
				_markerText setMarkerTypeLocal "c_unknown";
				_markerText setMarkerSizeLocal [0.8,0];
				_markerText setMarkerTextLocal format["%1", name _operator];				  
			};
		};
	} forEach allUnitsUav; 
	
	
	

	_markerNumber = _markerNumber + 1;
	_marker = format["um%1",_markerNumber];	
	while {(getMarkerType _marker) != ""} do {
		deleteMarkerLocal _marker;
		_markerNumber = _markerNumber + 1;
		_marker = format["um%1",_markerNumber];
	};
	 
};