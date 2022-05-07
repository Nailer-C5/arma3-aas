/*/
File: fn_purchase
Description: Actor for the "Purchase building" dialog button.
Domain: Client
/*/

private _tvSelectedPath = tvCurSel 1500;
if (_tvSelectedPath isEqualTo [] OR {(count _tvSelectedPath) isEqualTo 1}) exitWith {
	hint "You do not have a valid selection made";
};
private _item = (BULWARK_BUILDITEMS select (_tvSelectedPath select 0)) select (_tvSelectedPath select 1);
shopVehic = objNull;

_shopPrice = _item select 0;
_shopName  = _item select 7;
_shopClass = _item select 1;
_VecRadius = _item select 3;
_shopDir   = _item select 4 select 0;
_VechAi = _item select 5;
_invincible = _item select 6;

// Script was passed an invalid number
if (_shopClass == "") exitWith {};

if (player getVariable "killPoints" >= _shopPrice && !(player getVariable "buildItemHeld")) then {
	[player, _shopPrice] remoteExec ["buls_fnc_spend", 2];
	if (_vechAi) then {
		_vechWithAi = [[0,0,300], 0, _shopClass, west] call BIS_fnc_spawnVehicle;
		shopVehic = _vechWithAi select 0;
	} else {
		shopVehic = _shopClass createVehicle [0,0,0];
	};
	shopVehic setVariable ["shopPrice", _shopPrice, true];
	shopVehic setVariable ["Radius", _VecRadius, true];
	//check if invincible
	if (_invincible) then {
		shopVehic enableSimulation false;
		shopVehic allowDamage false;
	};
	objPurchase = true;
} else {
	if (player getVariable "killPoints" < _shopPrice) then {
		[format ["<t size='0.6' color='#ff3300'>Not enough points for %1!</t>", _shopName], -0, -0.02, 2, 0.1] call BIS_fnc_dynamicText;
		objPurchase = false;
	} else {
		[format ["<t size='0.6' color='#ff3300'>You're already carrying an object!</t>", _shopName], -0, -0.02, 2, 0.1] call BIS_fnc_dynamicText;
		objPurchase = false;
	};
};

sleep 0.1;

if (objPurchase) then {
	closeDialog 0;
	// If it's a container, make sure it's empty
	clearItemCargoGlobal shopVehic;
	clearWeaponCargoGlobal shopVehic;
	clearMagazineCargoGlobal shopVehic;
	clearBackpackCargoGlobal shopVehic;

	[shopVehic, ShopCaller, [0,_VecRadius + 1.5,0.02], _shopDir] call bulc_fnc_pickup;
};