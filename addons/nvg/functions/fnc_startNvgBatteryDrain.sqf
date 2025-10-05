#include "script_component.hpp"

params [];

GVAR(NvgBatteryDrainHandle) = [
    {
        _isBlackout = uiNamespace getVariable [QGVAR(NvgIsBlackout), false];
        _currentBattery = player getVariable [QGVAR(nvgBatteryLifePoints), 0];

        // Drain power
        if (_currentBattery > 0) then {
            if (_isBlackout) then {
                [QGVAR(NvgBatteryDrainedBlackout), true, 3] call BIS_fnc_blackIn;
                uiNamespace setVariable [QGVAR(NvgIsBlackout), false];
            };

            _newBattery = _currentBattery - GVAR(PowerConsumptionSpeed);
            player setVariable [QGVAR(nvgBatteryLifePoints), _newBattery];
        } else {
            if (!_isBlackout) then {
                [QGVAR(NvgBatteryDrainedBlackout), true, 3] call BIS_fnc_blackOut;
                uiNamespace setVariable [QGVAR(NvgIsBlackout), true];
            };
        };
    },
    1
] call CBA_fnc_addPerFrameHandler;
