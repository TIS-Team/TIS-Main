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

params ["_object", "_unit", "_radius", "_strength", "_side"];

// Check if a handler is already running for this specific side. 
// If no, run regular radioJammers initialization.
// If yes, add jammer to given side. 
private _sideKey = (toUpperANSI (str _side));
private _existingJammers = GVAR(TfarJammers) getOrDefault [_sideKey, []];
if (_existingJammers isEqualTo []) then {
	// Regular init
	[[_object], _radius, _strength, false, _sideKey] call FUNC(radioJammers);
} else {
	// Add jammer to existing jammers
	private _jammersMap = GVAR(TfarJammers);
	private _sideJammers = _jammersMap get _side;
	_object setVariable ["tis_tfar_jammer_radius", _radius];
	_object setVariable ["tis_tfar_jammer_strength", _strength];
	_sideJammers pushBack _object;
};
