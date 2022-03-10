while {(true)} do

		{
			if (cameraView == "External") then
			{
				if (driver(vehicle player) != player) then
				{
					player switchCamera "Internal";
				};
			};
			sleep 0.1;
		};