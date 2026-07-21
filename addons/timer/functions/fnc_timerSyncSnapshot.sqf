#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Accepts a timer snapshots array and starts all timers.
        Used as a helper function when player connects to the server in progress (JIP).
        
    Side:
        Should be executed on CLIENT only.

    Params:
        0: ARRAY of [timerId, endTime, label, targets]
*/

params ["_timerSnapshots"];

{
    _x params ["_timerId", "_endTime", "_label", "_targets"];
    [_timerId, _endTime, _label, _targets] call FUNC(onTimerStart);
} forEach _timerSnapshots;
