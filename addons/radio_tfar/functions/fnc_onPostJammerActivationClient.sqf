#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Adds the given jammer on the client side. Client only.

	Parameter(s):
		0: OBJECt - the jammer
        1: UNIT - who activated the jammer

	Example:
        [_side] call tis_main_radio_tfar_onPostJammerActivationClient;

    Public API: No 
*/

if (!hasInterface) exitWith {};

params ["_jammer", "_side", "_unit"];

private _sideKey = toUpperANSI (str _side);

private _jammers = GVAR(TfarJammersClient);
private _jammersForSide = _jammers getOrDefault [_sideKey, []];

private _index = _jammersForSide findIf { _x isEqualTo _jammer };
if (_index == -1) then { // Add jammer only if not already added
    _jammersForSide pushBack _jammer;
    GVAR(TfarJammersClient) set [_sideKey, _jammersForSide];
};

_jammers set [_sideKey, _jammersForSide];
