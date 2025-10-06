#include "script_component.hpp"

params ["_player", ["_removeBattery", true, [false]]];

if (_removeBattery) then {
    [_player, "ACE_UAVBattery"] call CBA_fnc_removeItem;
};
_player setVariable [QGVAR(nvgBatteryLifePoints), NVG_BATTERY_MAX_LIFEPOINTS];
