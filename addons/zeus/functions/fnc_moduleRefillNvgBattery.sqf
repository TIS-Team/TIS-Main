#include "script_component.hpp"

/*
 * Author: Aquerr (Nerdi)
 * Refills unit's NVG battery.
 *
 * Arguments:
 * 0: The module logic <OBJECT>
 * 1: Synchronized units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC, [thomas, stefan], true] call tis_main_zeus_fnc_moduleRefillNvgBattery;
 *
 */

params [["_logic", objNull, [objNull]]];

if (!local _logic) exitWith {};

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];
if (_mouseOverType != "OBJECT") then {
    [LLSTRING(MustSelectPlayer)] call FUNC(showZeusFeedbackMessage);
} else {
    _unit = _mouseOverUnit;
    if (isPlayer _unit) then {
        [_unit, EGVAR(nvg,BatteryPowerCapacity)] remoteExec [QEFUNC(nvg,doRefillBattery), _unit];
        [LLSTRING(NvgBatteryRefilled)] call FUNC(showZeusFeedbackMessage);   
    } else {
        [LLSTRING(MustSelectPlayer)] call FUNC(showZeusFeedbackMessage);
    };
};

deleteVehicle _logic;
