#include "script_component.hpp"

params ["_unit", "_name", "_hpNumber", "_showHealthBar", "_shouldMakeMeleeInvincibleToggle", "_customHealthVarName"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LLSTRING(MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_unit, _name, _hpNumber, _showHealthBar, _shouldMakeMeleeInvincibleToggle, _customHealthVarName] remoteExec [QEFUNC(main,convertToBoss), 2];
    [LLSTRING(BossCreated)] call FUNC(showZeusFeedbackMessage);
};
