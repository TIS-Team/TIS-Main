#include "script_component.hpp"

params ["_object", "_radius", "_strength", "_debug", "_side"];

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

if (_mouseOverType != "OBJECT") then {
    [LLSTRING(MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_object, _radius, _strength, _debug, _side] remoteExec [QEFUNC(main,tfarRadioJammers), 2];
    [LLSTRING(JammerCreated)] call FUNC(showZeusFeedbackMessage);
};
