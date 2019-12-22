Script Created by Giallustio with the help of =BTC= Black Templars Clan.

With this script you can use artillery without "artillery computer" action;
when you get in as gunner a hint will appear displaing:
azimuth, elevation, and a range table.

In addition you can hook M119 and D30 with a truck and move them around the map.


Installation:
Put "=BTC=Arty" folder in your mission folder and add this line in mission init.sqf:
if you want to use truck to hook artillery add this line:
_hook = execVM "=BTC=Arty\AttachInit.sqf";
if you want to fire with artillery without "artillery computer"
_arty = execVM "=BTC=Arty\ArtyInit.sqf";

Version 1.1 As far as I know the script is bugs free and mp compatible


Bugs report would be appreciated at this page:
http://blacktemplarsclan.forumattivo.com/download-f10/btc-arty-t54.htm#218

Have a good tactical game ;)