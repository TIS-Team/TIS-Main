#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Work in progress...

        GUI mode only. 
        
        Updates one timer's control text.
        Called every frame, per active timer, by the shared PFH.
        
        Format: MM:SS.MS

    Side:
        Should be executed on CLIENT only.

    Params:
        0: STRING - timer id
        1: NUMBER - remaining time (seconds left)
        2: STRING - label
*/

params ["_timerId", "_remaining", "_label"];

private _ctrl = GVAR(timerRscControls) getOrDefault [_timerId, controlNull];
if (isNull _ctrl) exitWith {};

_ctrl ctrlSetText format ["%1  %2",
    _label,
    ([_remaining,"MM:SS.MS"] call BIS_fnc_secondsToString)
];
