#include "script_component.hpp"

params [];

[] call FUNC(stopNvgBatteryDrain);

if (GVAR(BatteryPowerConsumption)) then {
    [] call FUNC(startNvgBatteryDrain);
};
