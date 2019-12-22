//scriptName "Scripts Viewer";
_Scripts= [];
{
	_Scripts pushBack _x;
} forEach diag_activeSQFScripts;
_Scripts


//BIS_fnc_getUnitByUid
/*

    allVariables namespace 
Parameters:
    namespace: Control, Team Member, Namespace, Object, Group, Task, Location
Return Value:
    Array of Strings - array of variable names. All names are in lower case (see toLower)
	
	
	
	
    One still can use allVariables in Multiplayer against profileNamespace and uiNamespace using config parser. In Description.ext
    _EXEC(somevar = allVariables profileNamespace)
    in code
    _allprofilevars = parsingNamespace getVariable "somevar"
    but list will be valid only at the moment of parsing config. 
*/