#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Helper function for getting active jammers for given side. Server only.

	Parameter(s):
		0: OBJECt - the side

	Example:
        [_side] call tis_main_radio_tfar_getJammersForSide;
*/

if (!isServer) exitWith {};

params [["_side", sideUnknown, [west, east, resistance, civilian, sideUnknown]]];

if (isNil QGVAR(TfarJammers)) then {
    GVAR(TfarJammers) = createHashMap;
};

private _sideKey = (toUpperANSI (str _side));
private _existingJammers = GVAR(TfarJammers) getOrDefault [_sideKey, []];
_existingJammers;
