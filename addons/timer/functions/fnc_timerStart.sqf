#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Starts (or resets) a countdown timer. 
        Calling this again with the same _timerId while it's still active
        resets that timer's remaining time to _duration (acts as a restart/extend).
        
    Side:
        Should be executed on SERVER only.

    Params:
        0: NUMBER - _duration - seconds until the timer ends
        1: STRING -  _context  - label used for display + logic dispatch, can be empty
        2: STRING -  _timerId  - unique tag for this timer, e.g. "evac", can be nil
        3: CODE - code to be executed on timer start (code is executed on server)
        4: CODE - code to be executed on timer update (each second) (code is executed on server)
        5: CODE - code to be executed on tiemr end (code is executed on server)
        3: (optional) _targets - who can SEE the countdown display. Accepts:
             - default           -> all sides
             - OBJECT (a unit)        -> only that player
             - GROUP                  -> only members of that group
             - SIDE (west/east/...)   -> only that side
             - ARRAY mixing any of the above, e.g. [unit1, group2, east]
           This only affects who SEES the countdown - server-side game logic always runs for everyone regardless.

    Returns: Nothing

    Example:
        [] call tis_main_timer_fnc_timerStart
*/

if (!isServer) exitWith {};

params [
    "_duration", 
    ["_label", ""], 
    ["_timerId", "TIMER_ID_1", ["string"]], 
    ["_codeOnStart", {}, [{}]], 
    ["_codeOnUpdate", {}, [{}]], 
    ["_codeOnEnd", {}, [{}]],
    ["_displayTargets", [east, west, independent, civilian, sideLogic]]
];

if (isNil QGVAR(activeTimersServer)) then { GVAR(activeTimersServer) = createHashMap; };

while { (count (GVAR(activeTimersServer) getOrDefault [_timerId, []])) != 0 } do {
    _timerId = format ["TIMER_ID_%1", floor random 99999];
};

private _endTime = serverTime + _duration;
private _normalizedTargets = if (_displayTargets isEqualType []) then { _displayTargets } else { [_displayTargets] };

GVAR(activeTimersServer) set [_timerId, [_endTime, _label, _codeOnUpdate, _codeOnEnd, _normalizedTargets]];

[_timerId, _label] call _codeOnStart;

[QGVAR(timerStarted), [_timerId, _endTime, _label, _normalizedTargets]] call CBA_fnc_globalEvent;

[] call FUNC(timerServerHandlerStart);
