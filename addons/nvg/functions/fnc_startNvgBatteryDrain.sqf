#include "script_component.hpp"

params [];

GVAR(NvgBatteryDrainHandle) = [
    {
        _isBlackScreenVisible = uiNamespace getVariable [QGVAR(BlackScreenVisible), false];
        _currentBattery = player getVariable [QGVAR(nvgBatteryLifePoints), 0];
        
        _isZeusInterface = not (isNull (findDisplay 312));
        if (_isZeusInterface) exitWith {
            if (_isBlackScreenVisible) exitWith {
                [QGVAR(NvgBatteryDrainedBlackScreenId), true, 3] call BIS_fnc_blackIn;
                uiNamespace setVariable [QGVAR(BlackScreenVisible), false]
            };;
        };

        // Drain power
        if (_currentBattery > 0) then {
            if (_isBlackScreenVisible) then {
                [QGVAR(NvgBatteryDrainedBlackScreenId), true, 3] call BIS_fnc_blackIn;
                uiNamespace setVariable [QGVAR(BlackScreenVisible), false];
            };

            _newBattery = _currentBattery - GVAR(PowerConsumptionSpeed);
            player setVariable [QGVAR(nvgBatteryLifePoints), _newBattery];
        } else {
            if (!_isBlackScreenVisible) then {
                [QGVAR(NvgBatteryDrainedBlackScreenId), true, 3] call BIS_fnc_blackOut;
                uiNamespace setVariable [QGVAR(BlackScreenVisible), true];
            };
        };
    },
    1
] call CBA_fnc_addPerFrameHandler;
