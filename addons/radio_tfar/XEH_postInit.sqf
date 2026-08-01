#include "script_component.hpp"

// Both sides
[QGVAR(initTfarRadioJammerDeactivateActionEvent), { call FUNC(initJammerDeactivateAction)}] call CBA_fnc_addEventHandler;

// Server only
if (isServer) then {
    [QGVAR(requestJammerDeactivation), { _this call FUNC(jammerDoDeactivate) }] call CBA_fnc_addEventHandler;
};
