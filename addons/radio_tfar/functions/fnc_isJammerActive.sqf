#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Helper function for checking if given jammer is active.
        Can be used both on clients and server.
        It uses different logic depending on which side it is called from.

	Parameter(s):
		0: OBJECt - the jammer

	Example:
        [_side] call tis_main_radio_tfar_isJammerActive;
*/

params ["_jammer"];

private _isActive = false;
private _jammersMap = objNull;

if (isServer) then {
	_jammersMap = GVAR(TfarJammers);

} else {
    _jammersMap = GVAR(TfarJammersClient);
};

{
    private _side = _x;
	private _sideJammers = _jammersMap get _side;
	private _index = _sideJammers findIf { _x isEqualTo _jammer };
    if (_index != -1) exitWith {
        _isActive = true;
	};

} forEach (keys _jammersMap);

_isActive;
