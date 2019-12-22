#include "globalDefines.hpp"
showcinemaborder false;
titleText ["", "BLACK FADED", 1];
sleep 3;
titleText [ spawnPrecursorMessage , "BLACK FADED", 0.4];
sleep 2;
_dialog_1 = createDialog "respawn_button_aas";
(findDisplay IDDRESPAWNDIALOG) displayAddEventHandler ["KeyDown","_this call KeyHandlerRespawnDialog"];
spawnDialogReady=true;