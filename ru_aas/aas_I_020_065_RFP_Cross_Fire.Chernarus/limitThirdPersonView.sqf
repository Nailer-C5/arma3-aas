
#include "globalDefines.hpp"
if (difficultyOption "thirdPersonView"==1) then
{
	switch (AAS_Params_CameraView) do
	{
		case 1://vehicles only
		{
			while {(true)} do
			{
				if (cameraView == "External") then
				{
				if ((vehicle player) == player) then {player switchCamera "Internal";};
				};
				sleep 0.1;
			};
		};
		case 2://infantry only
		{
			while {(true)} do
			{
				if (cameraView == "External") then
				{
					if ((vehicle player) != player) then
					{
						(vehicle player) switchCamera "Internal";
					};
				};
				sleep 0.1;
			};
		};
		case 3://disabled
		{
			while {(true)} do
			{
				if (cameraView == "External") then
				{
					if ((vehicle player) == cameraOn) then
					{
						(vehicle player) switchCamera "Internal";
					};
				};
				sleep 0.1;
			};
		};
	};
};