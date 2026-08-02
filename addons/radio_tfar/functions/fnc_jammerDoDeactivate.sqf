#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for deactivating TFAR jammer. SERVER ONLY!;

    Parameter(s):
        0: OBJECT - Jammer object to deactivate
        1: OBJECT - Unit that deactivated the jammer

	Example:
		[jammer1, player] call tis_main_radio_tfar_jammerDoDeactivate;
*/

if (!isServer) exitWith {};

params ["_object", "_unit"];

private _jammersMap = GVAR(TfarJammers);
private _sides = keys _jammersMap;

{
	private _side = _x;

	private _sideJammers = _jammersMap get _side;
	private _index = _sideJammers findIf { _x isEqualTo _object };
	if (_index != -1) then {
		_sideJammers deleteAt _index;
	};

} forEach _sides;
