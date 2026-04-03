#include "script_component.hpp"

params ["_player"];

_batteryLifePoints = _player getVariable [QGVAR(nvgBatteryLifePoints), 0];

hint format [LLSTRING(NvgBatteryPercentage), _batteryLifePoints / NvgBatteryMaxLifepoints * 100];
