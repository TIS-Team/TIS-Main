#include "..\script_component.hpp"

if (!isServer) exitWith {};

params [
	["_logic", objNull, [objNull]],		
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!_activated) exitWith {};

private _synchronizedObjects = synchronizedObjects _logic;

private _radius = _logic getVariable ["Radius", 1000];
private _strength = _logic getVariable ["Strength", 50];
private _debug = _logic getVariable ["Debug", false];
private _side = _logic getVariable ["TargetSide", sideUnknown];

private _syncedTriggers = _synchronizedObjects select { _x isKindOf "EmptyDetector" };
private _connectedObjects = _synchronizedObjects select { not (_x isKindOf "EmptyDetector") };

private _params = [
	_connectedObjects, 
	_radius, 
	_strength, 
	_debug,
	_side
];
if (_connectedObjects isEqualTo []) exitWith {};

if (_syncedTriggers isNotEqualTo []) then {
	{
		private _trigger = _x;
		// Trigger based init
		[
			_trigger,
			_params
		] spawn {
			params [
				"_trigger",
				"_params"
			];

			waitUntil { sleep 1; triggerActivated _trigger };

			_params call FUNC(radioJammers);
		};
	} forEach _syncedTriggers;
} else {
	// Regular init (no trigger)

	_params call FUNC(radioJammers);
};
