#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Work in progress...

        GUI mode only

        Creates or destroys one timer's GUI control based on whether it's currently visible to this player.
        Called every frame by the shared PFH (cheap: only acts when the visibility state actually flips, 
        e.g. control already exists and stays visible does nothing here).
        
    Side:
        Should be executed on CLIENT only.

    Params:
        0: STRING - timer id
        1: BOOLEAN - true/false (if timer is visible)
*/

params ["_timerId", "_visible"];

private _ctrl = GVAR(timerRscControls) getOrDefault [_timerId, controlNull];

if (_visible) then {
    if (isNull _ctrl) then {
        [] call FUNC(ensureTimerDisplay);

        private _display = findDisplay TIS_TIMER_DISPLAY_IDD;
        _ctrl = _display ctrlCreate ["RscText", -1];
        _ctrl ctrlSetBackgroundColor [0, 0, 0, 0.5];
        _ctrl ctrlSetTextColor [1, 1, 1, 1];
        _ctrl ctrlCommit 0;

        GVAR(timerRscControls) set [_timerId, _ctrl];
        [] call FUNC(reflowTimerControls);
    };
} else {
    if (!isNull _ctrl) then {
        ctrlDelete _ctrl;
        GVAR(timerRscControls) deleteAt _timerId;
        [] call FUNC(reflowTimerControls);
        if (GVAR(timerRscControls) isEqualTo []) then { 0 cutRsc ["", "PLAIN"]; };
    };
};
