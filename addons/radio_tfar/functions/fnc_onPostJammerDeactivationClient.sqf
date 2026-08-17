#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Cleans up the given jammer on the client side. Client only.

	Parameter(s):
		0: OBJECt - the jammer
        1: UNIT - who deactivated the jammer

	Example:
        [_side] call tis_main_radio_tfar_onPostJammerDeactivationClient;

    Public API: No 
*/

if (!hasInterface) exitWith {};

params ["_jammer", "_side", "_unit"];

private _jammersMap = GVAR(TfarJammersClient);
private _sides = keys _jammersMap;

{
	private _side = _x;

	private _sideJammers = _jammersMap get _side;
	private _index = _sideJammers findIf { _x isEqualTo _jammer };
	if (_index != -1) then {
		_sideJammers deleteAt _index;
	};

} forEach _sides;
