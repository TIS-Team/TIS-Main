#include "script_component.hpp"

params ["_logic"];

TRACE_1("logic",_logic);

private _unit = attachedTo _logic;
TRACE_1("unit",_unit);

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];
if (_mouseOverType != "OBJECT") then {
    [LELSTRING(main,MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    [_unit, NvgBatteryMaxLifepoints] remoteExec [QEFUNC(nvg,doRefillBattery), _unit];
    [LLSTRING(NvgBatteryRefilled)] call FUNC(showZeusFeedbackMessage);
};
