#include "script_component.hpp"

// Both sides
[QGVAR(initTfarRadioJammerDeactivateActionEvent), { call FUNC(initJammerDeactivateAction)}] call CBA_fnc_addEventHandler;
[QGVAR(initTfarRadioJammerActivateActionEvent), { call FUNC(initJammerActivateAction)}] call CBA_fnc_addEventHandler;

// Server only
if (isServer) then {
    [QGVAR(requestJammerDeactivation), { _this call FUNC(jammerDoDeactivate) }] call CBA_fnc_addEventHandler;
    [QGVAR(requestJammerActivation), { _this call FUNC(jammerDoActivate) }] call CBA_fnc_addEventHandler;
};
