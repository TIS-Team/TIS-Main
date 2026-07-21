#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Checks whether the LOCAL player should see a timer, given the normalized _targets array. 
        
    Side:
        Should be executed on CLIENT only.

    Params:
        0: ARRAY - normalized targets array (can contain players, groups or sides)

    Returns: 
        BOOLEAN - true/false if player matched the targets group
*/

params ["_targets"];

private _matched = false;
private _playerGroup = group player;
private _playerSide = side player;

{
    if (_x isEqualType objNull && { _x == player }) exitWith { _matched = true; };
    if (_x isEqualType grpNull && { _x == _playerGroup }) exitWith { _matched = true; };
    if (_x isEqualType west && { _x == _playerSide }) exitWith { _matched = true; };
} forEach _targets;

_matched
