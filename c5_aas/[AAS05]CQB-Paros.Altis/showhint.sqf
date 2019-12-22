// File Description
// Name           : showHint.sqf
// Called by      : Client main thread, infrequently
// Referenced by  : ClientMainThread.sqf
// Client/Server  : client side
// Function area  : game UI
//
// Description
// This script displays a gameplay or otherwise useful hint
// It's actually quite important, because it ensures players
// continue to learn as they play, and pick up some of the cooler
// features

#include "globalDefines.hpp"

//NAILER[C5] - MODIFY HINTS FOR C5 GAMEPLAY
array _hints = [
  "Join us on Teamspeak at TS3.C5GAMING.COM",
  "Scroll on the large ammo crate to save your loadout.",
  "Get your load out at the ammo crates near the flag.",
  "To make a special loadout, select your kit at ammo crates, then select: Save Custom Loadout.",
  "Capture opposing zones in the top right display, look at the map to find where they are.",
  "Once an enemy base is de-camped touch the flag to capture the zone - you must exit from vehicles.",
  "To zoom the minimap in and out, use CTRL+Z and CTRL+X.",
  "Press CTRL+T to toggle the range at which green name tags display.",
  "X-ray is a safe zone. No shooting in or out of x-ray."
];
		
hintSilent format[ "HINT: %1", _hints select (floor random (count _hints)) ];

//array _hints = [
//	"Use the armoury near the flag to select teams, player classes and Custom classes.",
//      "When you respawn you join a queue; if the queue is too long, spawn further back.",
//      "Outnumber the enemy in their zone in order to capture the flag.",
//      "Save and Load your custom loadouts via scroll mouse at armoury.",
//      "Use Virtual Ammobox at Armoury to select Custom loadouts, and don't forget to save your custom loadouts",
//      "Once an enemy base is de-camped, get out of your vehicle and within 10m of the flag to capture it.",
//      "You can find more vehicles at X-Ray, but you have further to drive.",
//      "Use the distance meters in the top right to see how close you are to a base.",
//      "Keep an eye on the numbers within your home base, to spot when it is attacked.",
//      "Revive friendly soldiers using the 'Revive' option from the action menu.",
//      "Try a synchronised attack on the enemy base to gain the element of suprise.",
//      "Keep together with your team-mates to survive and revive each other.",
//      "At Armoury: Ctrl+D to change Weapons, Ctrl+C to change Classes and Ctrl+K to change Teams.",
//      "You may Save and Load Profile Custom Loadouts via Virtual Ammobox if Enabled.",
//      "To zoom the minimap in and out, use CTRL+Z and CTRL+X.",
//      "If the HUD is too cluttered for you, use CTRL+H to toggle HUD display.",
//      "The Special Air Service (SAS) class can ONLY use the HALO feature if enabled",
//      "Use the armoury near the flag to teleport or parachute onto the squad leader if enabled",
//      "Press CTRL+T to toggle the range at which green name tags display.",
//      "Keep an eye on the minimap to see where your teammates are.",
//      "Hold Ctrl when selecting classes and weapons at Armoury, to prevent it from locking you out.",
//      "Map/Mission/Ported/Edited: by [AUSCOG]Karmichael.",
//      "Spawn Armour helps with spawn killing. Once your time duration expires or when you pull your gun trigger your open for attack.",
//      "You earn 10 bonus points for being the one to capture an objective.",
//      "You earn 1 bonus point for every 30 seconds in the attacking zone.",
//      "You earn 1 bonus point for every 60 seconds in the defending zone.",
//      "You earn bonus points every time you revive a friendly player.",
//      "Special Thanks and Credit to CoolBox-SBS- [AAS Founder], Kju, Cat Toaster, Xeno, Norrin, Wormeaten, Monsada [UPSMON], Aeroson [Save/Load], Tonic [Virtual Ammobox] and the rest of the AAS community",
//      "If you get repeatedly killed at a spawn point, try spawning further back.",
//      "You need only capture and defend bases shown on the top right display."
//hintSilent format[ "TIP: %1", _hints select (floor random (count _hints)) ];

