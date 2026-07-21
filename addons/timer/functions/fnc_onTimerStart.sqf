#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Registers the active timer locally and starts the timer client handler.

        Called (via CBA event "tis_main_timer_timerStarted", or during JIP snapshot restore) 
        when a timer begins or resets. 

    Side:
        Should be executed on CLIENT only.

    Params:
        0: STRING - timer id
        1: NUMBER - end time  (serverTime-based)
        2: STRING - custom label
        3: ARRAY - targets - [] means visible to everyone; otherwise a mix
           of unit/group/side entries (see tis_timer_fnc_timerMatchesTarget)
*/

params ["_timerId", "_endTime", "_label", ["_targets", []]];

if (isNil QGVAR(activeTimers))  then { GVAR(activeTimers) = createHashMap; };
if (isNil QGVAR(timerRscControls)) then { GVAR(timerRscControls) = createHashMap; };

GVAR(activeTimers) set [_timerId, [_endTime, _label, _targets]];

[] call FUNC(timerClientHandlerStart);
