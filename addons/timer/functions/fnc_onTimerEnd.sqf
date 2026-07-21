#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Works only in GUI mode.
        Called when a timer reaches 0 (detected locally by the shared PFH) or
         is force-ended early (via CBA event "tis_main_timer_timerForceEnd").
        Removes its GUI control (if any) and re-centers the remaining stack.

    Side:
        Should be executed on CLIENT only.

    Params:
        0: STRING _timerId
        1: STRING _context
*/

params ["_timerId", "_context"];

if (GVAR(timerDisplayMode) == "gui") then {
    private _ctrl = GVAR(timerRscControls) getOrDefault [_timerId, controlNull];
    if (!isNull _ctrl) then { ctrlDelete _ctrl; };
    GVAR(timerRscControls) deleteAt _timerId;

    [] call FUNC(reflowTimerControls);

    if (GVAR(timerRscControls) isEqualTo []) then { 0 cutRsc ["", "PLAIN"]; };
};
