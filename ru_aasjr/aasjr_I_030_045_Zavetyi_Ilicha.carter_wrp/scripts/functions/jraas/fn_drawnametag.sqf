S3tagCOLOR= [1,1,1,0.7];//צגוע רנטפעא
S3tagFS= 0.034;//׀אחלונ רנטפעא

fncDrawnametag=
{
//if (currentWeapon player isEqualTo binocular player) then { player forceWalk true } else { player forceWalk false }; 

	if !(missionNamespace getVariable ["S3_NAMETAG",true]) exitWith {};  
	{
		player reveal cursorObject;
		_name= '';  
		if (alive _x) then {_name= name _x};
		_d= damage _x;
		_ii=0;
		_pos= [0,0,0];
		
		_dist = (player distance _x);// / 15;
		_size=_dist/200;	
		if !(cameraview=='GUNNER') then { _size=  _size*3.5 };
		_pos= _x modelToWorldVisual [0,0,  (boundingBox _x select 1 select 2)+_size];
		
		if (_x isEqualTo vehicle _x) then  
		{  
			if (inputAction "lookAround" > 0) then
			{
				_name= format ['%1 (+%2) - %3m', _name, round ((1 - damage _x) * 100), round _dist];
			};
			drawIcon3D ['',S3tagCOLOR,_pos,0,0,0,_name,2,S3tagFS,'PuristaSemiBold','Center'];
		}
		else
		{
			_veh=vehicle _x;
			_dist = (player distance _veh);
			_size=_dist/200;	
			_idx= ( _veh getCargoIndex _x);	
			_pos= _x modelToWorldVisual [0,0, 5+ (boundingBox _x select 1 select 2)+_size+(_idx*_dist/100)];
			if (inputAction "lookAround" > 0 ) then
			{
				_name= format ['%1 (+%2) - %3m', _name, round ((1 - damage _x) * 100), round _dist];
			};
			drawIcon3D ['',S3tagCOLOR,_pos,0,0,0, _name,2,S3tagFS,'PuristaSemiBold','Right'];
		};
		
		_co=cursorTarget;
		if (_co isEqualTo _x) then 
		{ 
			_name= format ['Friendly %1', name _co];
			_tx= _x selectionPosition "spine1";
			_pos= _x modelToWorldVisual _tx;
			drawIcon3D ['A3\ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_toolbox_units_ca.paa',[0.1,0.75,0,0.85], _pos,0.9,0.9,0,_name,2, 0.04,'PuristaSemiBold','Right']; 	
		};	
	} foreach ((allUnits-[player]) select { side _x isEqualTo side player});	
};

["nameTag", "onEachFrame", { call fncDrawnametag }] call BIS_fnc_addStackedEventHandler;