#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Starts the single shared CBA per-frame handler that drives
        the display for ALL active timers on this client - one handler
        regardless of how many timers are running concurrently.
        Actively updates the display, either in GUI or HINT.

    Side:
        Should be executed on CLIENT only.

    Params: None
*/

if (!isNil QGVAR(timerClientHandler)) exitWith {};

GVAR(timerClientHandler) = [{
    private _lines = [];
    private _idsToRemove = [];

    {
        private _timerId = _x;
        (GVAR(activeTimers) get _timerId) params ["_endTime", "_label", "_targets"];
        private _remaining = _endTime - serverTime;

        if (_remaining <= 0) then {
            _idsToRemove pushBack _timerId;
        } else {
            private _visible = [_targets] call FUNC(timerMatchesTarget);

            switch (GVAR(timerDisplayMode)) do {
                case "gui": {
                    [_timerId, _visible] call FUNC(updateTimerVisibility);
                    if (_visible) then {
                        [_timerId, _remaining, _label] call FUNC(onTimerUpdateDisplay);
                    };
                };
                default {
                    if (_visible) then {
                        _lines pushBack format ["%1  %2",
                            _label,
                            ([_remaining,"MM:SS.MS"] call BIS_fnc_secondsToString)
                        ];
                    };
                };
            };
        };
    } forEach (keys GVAR(activeTimers));

    if (GVAR(timerDisplayMode) == "hint") then {
        if (_lines isNotEqualTo []) then {
            hintSilent (_lines joinString toString [13, 10]);
        } else {
            hintSilent "";
        };
    };

    {
        private _label = (GVAR(activeTimers) get _x) select 1;
        GVAR(activeTimers) deleteAt _x;
        [_x, _label] call FUNC(onTimerEnd);
    } forEach _idsToRemove;

    if (GVAR(activeTimers) isEqualTo []) then {
        [GVAR(timerClientHandler)] call CBA_fnc_removePerFrameHandler;
        GVAR(timerClientHandler) = nil;
        if (GVAR(timerDisplayMode) == "hint") then { hintSilent ""; };
    };
}] call CBA_fnc_addPerFrameHandler;
