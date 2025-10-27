#include "script_component.hpp"

params ["_unit", "_name", "_hpNumber", "_showHealthBar"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LELSTRING(main,MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_unit, _name, _hpNumber, _showHealthBar] remoteExec [QEFUNC(main,convertToBoss), 2];
    [LLSTRING(BossCreated)] call FUNC(showZeusFeedbackMessage);
};
