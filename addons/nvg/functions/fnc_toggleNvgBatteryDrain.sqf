#include "script_component.hpp"

params [];

_visionMode = currentVisionMode player;
_isBlackScreenVisible = uiNamespace getVariable [QGVAR(BlackScreenVisible), false];

if (_visionMode > 0) then {
    // If night/thermal vision
    [] call FUNC(restartNvgBatteryDrain);
} else {
    // Normal vision
    if (_isBlackScreenVisible) then {
        [QGVAR(NvgBatteryDrainedBlackScreenId), true, 3] call BIS_fnc_blackIn;
        uiNamespace setVariable [QGVAR(BlackScreenVisible), false];
    };

    [] call FUNC(stopNvgBatteryDrain); 
};
