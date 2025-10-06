#include "script_component.hpp"

params [];

_visionMode = currentVisionMode player;
_isBlackout = uiNamespace getVariable [QGVAR(NvgIsBlackout), false];

if (_visionMode > 0) then {
    // If night/thermal vision
    [] call FUNC(restartNvgBatteryDrain);
} else {
    // Normal vision
    if (_isBlackout) then {
        [QGVAR(NvgBatteryDrainedBlackout), true, 3] call BIS_fnc_blackIn;
        uiNamespace setVariable [QGVAR(NvgIsBlackout), false];
    };

    [] call FUNC(stopNvgBatteryDrain); 
};
