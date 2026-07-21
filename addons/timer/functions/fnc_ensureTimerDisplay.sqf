#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Opens the RscTitles layer used for GUI-mode timer boxes,
        if it isn't already open. Safe to call repeatedly.

    Side:
        Should be executed on CLIENT only.

    Params: None
*/

if (isNull (findDisplay TIS_TIMER_DISPLAY_IDD)) then {
    0 cutRsc ["TIS_TimerDisplay", "PLAIN"];
};
