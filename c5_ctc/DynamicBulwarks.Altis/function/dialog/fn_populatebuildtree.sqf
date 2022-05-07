/*/
File: populateBuildTree
Description:
	Populates the build objects tree view with the build items.
	Activates from the control's onLoad event.
Parameters:
	0: _tv : <CONTROL> - The control of the tree view you want to populate
	1: _buildables_array : <ARRAY> - Category-aggregated array of buildable items
Example: [myTreeControl, [[item1, item2], [item3]]] call bulc_fnc_populateBuildTree;
Author(s): Ansible2 // Cipher // Peter
@NOTE: Does not handle nested categories :(
/*/
// CIPHER COMMENT: alot of this should be cached in the future for optimization
params ["_tv", "_buildables_array"];

disableSerialization;

private _categoriesList = [];

private [
	"_displayName",
	"_category",
	"_price",
	"_class",
	"_categoryIndex",
	"_itemIndex",
	"_itemPath",
	"_itemText"
];

{
	_category = _x select 0 select 2;
	_categoryIndex = _tv tvAdd [[],_category];
	{
		_class = _x select 1;
		//_displayName = [configFile >> "cfgVehicles" >> _class] call BIS_fnc_displayName;
		_displayName = _x select 7;
		// add item to list
		_price = _x select 0;
		_itemText = format ["%1 - %2",_price,_displayName];
		_itemIndex = _tv tvAdd [[_categoryIndex],_itemText];

		_itemPath = [_categoryIndex,_itemIndex];

		_tv tvSetValue [_itemPath,_price];
	} forEach _x; // Outer array is categories
} forEach _buildables_array;