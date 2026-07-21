#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Starts the single shared server-side per-frame handler that drives
        game logic (onUpdate/onEnd) for ALL active timers, once per second.
        This is fully decoupled from client display refresh rate.
        Self-terminates when no timers remain active; restarted automatically by tis_timer_fnc_timerStart whenever needed.
        
    Side:
        Should be executed on SERVER only.

    Params:
        NONE

    Returns: 
        NOTHING
*/

if (!isServer) exitWith {};
if (!isNil QGVAR(timerServerHandler)) exitWith {};

GVAR(timerServerHandler) = [{
    params ["_args", "_pfhHandle"];

    if (isNil QGVAR(activeTimersServer) || {GVAR(activeTimersServer) isEqualTo []}) exitWith {
        [_pfhHandle] call CBA_fnc_removePerFrameHandler;
        GVAR(timerServerHandler) = nil;
    };

    private _idsToRemove = [];

    {
        private _timerId = _x;
        (GVAR(activeTimersServer) get _timerId) params ["_endTime", "_label", "_codeOnUpdate"];
        private _remaining = _endTime - serverTime;

        if (_remaining <= 0) then {
            _idsToRemove pushBack _timerId;
        } else {
            [_timerId, _remaining, _label] call _codeOnUpdate;
        };
    } forEach (keys GVAR(activeTimersServer));

    {
        private _timerData = (GVAR(activeTimersServer) get _x);
        private _label = _timerData select 1;
        private _codeOnEnd = _timerData select 3;
        GVAR(activeTimersServer) deleteAt _x;
        [_x, _label] call _codeOnEnd;
    } forEach _idsToRemove;
}, 1, []] call CBA_fnc_addPerFrameHandler;
