#include "script_component.hpp"

/*
 * Author: Aquerr (Nerdi)
 * Toggles diagnostic monitor.
 *
 * 0: The module logic <OBJECT>
 * 1: Synchronized units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC, [], true] call tis_main_zeus_fnc_moduleToggleDiagnosticMonitor;
 *
 */

 params [["_logic", objNull, [objNull]]];

if (!local _logic) exitWith {};

[LLSTRING(ToggledDiagMonitor)] call FUNC(showZeusFeedbackMessage);
[player] call EFUNC(main,toggleDiagnosticMonitor);

deleteVehicle _logic;
