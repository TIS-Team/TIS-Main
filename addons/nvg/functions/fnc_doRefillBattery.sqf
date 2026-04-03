#include "script_component.hpp"
params ["_unit", "_batteryLifePoints"];

_unit setVariable [QGVAR(nvgBatteryLifePoints), _batteryLifePoints];
