#include "script_component.hpp"

params ["_unit", ["_batteryLifePoints", 1000, [0]]];

TRACE_1("_this",_this);

_unit setVariable [QGVAR(nvgBatteryLifePoints), _batteryLifePoints];
