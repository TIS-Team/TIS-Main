#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Force-stops a timer.
        Triggers onEnd logic and tells clients to remove the timer's display immediately 
        (clients otherwise only self-detect natural expiry).
        
    Side:
        Should be executed on SERVER only.

    Params:
        0: STRING - timer id

    Returns: Nothing
*/

if (!isServer) exitWith {};

params ["_timerId"];

if (isNil QGVAR(activeTimersServer)) exitWith {};

private _data = TIS_TIMER_activeTimersServer getOrDefault [_timerId, []];
if (_data isEqualTo []) exitWith {};
_data params ["_endTime", "_label", "_codeOnUpdate", "_codeOnEnd"];

GVAR(activeTimersServer) deleteAt _timerId;
[_timerId, _label] call _codeOnEnd;

[QGVAR(timerForceEnd), [_timerId, _label]] call CBA_fnc_globalEvent;
