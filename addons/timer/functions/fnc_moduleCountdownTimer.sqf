#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Called automatically by the engine's module framework when a
        TIS_Timer_Module logic runs (either at mission start, or when its
        synced trigger activates, depending on the module's "Start Condition"
        attribute). Reads the module's Eden attributes and synced objects,
        then starts the underlying timer.

    Side:
        Should be executed on SERVER only.

    Params (standard module signature):
        0: OBJECT (module logic)
        1: ARRAY  (units the module is synced to / that activated it)
        2: BOOL   _activated
*/

params ["_logic", ["_units", []], ["_activated", true]];

if (!isServer) exitWith {};
if (!_activated) exitWith {};

private _duration        = _logic getVariable ["Duration", 60];
private _label         = _logic getVariable ["Context", ""];
private _targetSide        = _logic getVariable ["TargetSide", "ALL"];
private _includeGroups   = _logic getVariable ["IncludeGroups", false];
private _codeOnStart = compile (_logic getVariable ["OnStartFunction", ""]);
private _codeOnUpdate = compile (_logic getVariable ["OnProgressFunction", ""]);
private _codeOnEnd = compile (_logic getVariable ["OnCompleteFunction", ""]);

private _timerId          = "TIMER_ID_1";
if (_timerId == "") then { _timerId = str _logic; }; // auto-generate a stable unique ID from the module object

// Build the _targets array from synced units/groups and the side attribute.
private _targets = [];

{
    if (_x isKindOf "Man") then {
        if (_includeGroups) then {
            _targets pushBackUnique (group _x);
        } else {
            _targets pushBackUnique _x;
        };
    };
} forEach (synchronizedObjects _logic);

if (_targetSide != "ALL") then {
    private _side = switch (_targetSide) do {
        case "WEST": { west };
        case "EAST": { east };
        case "INDEPENDENT": { independent };
        case "CIVILIAN": { civilian };
        default { nil };
    };
    if (!isNil "_side") then { _targets pushBackUnique _side; };
} else {
    _targets = [west, east, independent, civilian, sideLogic];
};

[_duration, _label, _timerId, _codeOnStart, _codeOnUpdate, _codeOnEnd, _targets] call FUNC(timerStart);
