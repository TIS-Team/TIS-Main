/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
                Resolves side object from string.

	Parameter(s):
		0: STRING - the side string

	Example:
        [_side] call tis_main_main_fnc_sideFromStringResolver;
*/

params ["_sideStr"];

private _sideObj = switch (toUpper _sideStr) do {
    case "WEST": {west};
    case "EAST": {east};
    case "GUER": {resistance};
    case "INDEPENDENT": {resistance};
    case "CIV": {civilian};
    case "CIVILIAN": {civilian};
    default {sideUnknown};
};

_sideObj;
