#include "globalDefines.hpp"
private["_cursorTarget","_draggedUnit"];
obj _cursorTarget = cursorTarget;
obj _draggedUnit = player getVariable "AAS_DraggedUnit";
switch (true) do
{
	case (_cursorTarget isKindOf "LandVehicle"):
	{
		private["_vehicleCrew","_deadCrewInsideVehicle"];
		_vehicleCrew = crew _cursorTarget;
		_deadCrewInsideVehicle = false;
		{
			if (!(alive _x)) exitWith {_deadCrewInsideVehicle = true;};
		} forEach _vehicleCrew;

		if (_deadCrewInsideVehicle && ((player distance _cursorTarget) < 4)) then
		{
			private["_getBodiesOutAnimation"];
			_getBodiesOutAnimation = "AmovPercMstpSnonWnonDnon_AcrgPknlMstpSnonWnonDnon_getInLow";
			player playMove _getBodiesOutAnimation;

			waitUntil {sleep 0.01; ((animationState player) == _getBodiesOutAnimation)};
			waitUntil {sleep 0.01; ((animationState player) != _getBodiesOutAnimation)};

			if ((alive player) && (!(isNull _cursorTarget))) then
			{
				{
					if (!(alive _x)) then {_x setPosATL (getPosATL _x);};//TODO: move next to vehicle
				} forEach (crew _cursorTarget);
			};
		};
	};
	case (!(isNil "_draggedUnit")):
	{
		player setVariable ["AAS_DraggedUnit",nil];
		player playAction "released";
		detach _draggedUnit;

		AAS_PublicSwitchMoveObject = [_draggedUnit,AAS_DEADSTATE];
		publicVariable "AAS_PublicSwitchMoveObject";
		_draggedUnit switchMove "DeadState";

		_draggedUnit setPosATL (getPosATL _draggedUnit);
	};
	case (_cursorTarget isKindOf "CAManBase"):
	{
		if (((player distance _cursorTarget) < 3) && (!(alive _cursorTarget)) && (!((animationState player) in ["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb"]))) then
		{
			player playActionNow "grabdrag";
			sleep 1;
			if (alive player) then
			{
				private["_direction"];
				detach _cursorTarget;

				AAS_PublicSwitchMoveObject = [_cursorTarget,AAS_AINJPPNEMSTPSNONWRFLDB_STILL];
				publicVariable "AAS_PublicSwitchMoveObject";
				_cursorTarget switchMove "ainjppnemstpsnonwrfldb_still";

				_cursorTarget attachTo [player,[0.1,1.01,0]];
				player setVariable ["AAS_DraggedUnit",_cursorTarget];

				_direction = 180;
				AAS_PublicSetDirObject = [_cursorTarget,_direction];
				publicVariable "AAS_PublicSetDirObject";
				sleep 0.001;
				_cursorTarget setDir _direction;
			};
		};
	};
};