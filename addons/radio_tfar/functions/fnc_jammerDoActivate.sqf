#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for activating TFAR jammer. SERVER ONLY!;

    Parameter(s):
        0: OBJECT - Object to convert to jammer
        1: OBJECT - Unit that activated the jammer

	Example:
		[jammer1, player] call tis_main_radio_tfar_jammerDoDeactivate;
*/

if (!isServer) exitWith {};

params ["_object", "_unit", "_radius", "_strength", ["_side", sideUnknown, [west, east, resistance, civilian, sideUnknown]]];

// Check if a handler is already running for this specific side. 
// If no, run regular radioJammers initialization.
// If yes, add jammer to given side. 

private _existingJammers = [_side] call FUNC(getJammersForSide);
if (_existingJammers isEqualTo []) then {
	// Regular init
	[[_object], _radius, _strength, false, _side] call FUNC(radioJammers);
	[QGVAR(postTfarJammerActivationEvent), [_object, _side, _unit]] call CBA_fnc_globalEvent;
} else {
	// Add jammer to existing jammers
	private _jammersMap = GVAR(TfarJammers);
	_object setVariable ["tis_tfar_jammer_radius", _radius];
	_object setVariable ["tis_tfar_jammer_strength", _strength];

	private _index = _existingJammers findIf { _x isEqualTo _object };
	if (_index == -1) then { // Add jammer only if not already added
		_existingJammers pushBack _object;
		private _sideKey = (toUpperANSI (str _side));
		GVAR(TfarJammers) set [_sideKey, _existingJammers];
		[QGVAR(postTfarJammerDeactivationEvent), [_object, _side, _unit]] call CBA_fnc_globalEvent;
	};
};
