#include "script_component.hpp"

// Client side

if (hasInterface) then {
    if (isNil QGVAR(activeTimers))  then { GVAR(activeTimers) = createHashMap; };
    if (isNil QGVAR(timerRscControls)) then { GVAR(timerRscControls) = createHashMap; };

    GVAR(timerDisplayMode) = "hint"; // Possible values: "hint" or "gui". GUI is work in progress... and not yet configurable.

    [QGVAR(timerStarted), {
        params ["_timerId", "_endTime", "_label", ["_targets", []]];
        [_timerId, _endTime, _label, _targets] call FUNC(onTimerStart);
    }] call CBA_fnc_addEventHandler;

    [QGVAR(timerForceEnd), {
        params ["_timerId", "_label"];
        if (!(_timerId in GVAR(activeTimers))) exitWith {};
        GVAR(activeTimers) deleteAt _timerId;
        [_timerId, _label] call FUNC(onTimerEnd);
    }] call CBA_fnc_addEventHandler;
};

// Server side

if (isServer) then {
    if (isNil QGVAR(activeTimersServer)) then { GVAR(activeTimersServer) = createHashMap; };

    // JIP support: push a full snapshot of currently active timers to any
    // player who joins in progress, so they see running timers immediately.
    addMissionEventHandler ["PlayerConnected", {
        params ["_id", "_uid", "_name", "_jip", "_owner"];

        if (_jip) then {
            private _timerSnapshots = [];
            {
                (GVAR(activeTimersServer) get _x) params ["_endTime", "_label", "_codeOnUpdate", "_codeOnEnd", "_targets"];
                _timerSnapshots pushBack [_x, _endTime, _label, _targets];
            } forEach (keys GVAR(activeTimersServer));

            if (_timerSnapshots isNotEqualTo []) then {
                [_timerSnapshots] remoteExec [QFUNC(timerSyncSnapshot), _owner];
            };
        };
    }];
};
