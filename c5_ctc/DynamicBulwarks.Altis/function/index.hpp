class bulc {
    tag = "bulc";
	class build
    {
        file = "function\build";
        class drop {};
		class move {};
		class pickup {};
		class place {};
		class reset{};
		class sell {};
    };
	class bulwark
    {
        file = "function\bulwark";
		class checkBuildings {};
		class checkLocation {};
        class dropBulwark {};
		class moveBulwark {};
		class purchaseBuild {};
		class selectLocation {};
    };
	class client
    {
        file = "function\client";
        class createBlur {};
		class drag {};
		class hitMarker {};
		class initPlayerLocal {};
		class keyhandler {};
		class magRepack {};
		class say3D {};
		class welcome {};
    };
	class dialog
    {
        file = "function\dialog";
		class populateBuildTree {};
        class purchaseGUI {};
		class scoreTransfer {};
		class updateHUD {};
    };
	class loot {
        file = "function\loot";
        class deleteEmpty {};
		class getLoot {};
		class lootDrone {};
		class lootPoints {};
    };
	class score {
        file = "function\score";
		class receive {};
		class score {};
		class send {};
    };
	class support {
        file = "function\support";
        class ammoDrop {};
		class purchaseSupport {};
		class ragePack {};
    };
	class taw {
		file = "function\taw";
		class stateTracker {
			ext = ".fsm";
			postInit = 1;
			headerType = -1;
		};
		class onSliderChanged {};
		class onTerrainChanged {};
		class updateViewDistance {};
		class openMenu {};
		class onChar {};
		class openSaveManager {};
		class onSavePressed {};
		class onSaveSelectionChanged {};
	};
	class util {
        file = "function\util";
        class findPlaceAround {};
		class numberText {};
    };
	
};