#include "script_component.hpp"

// Client only below
if (!hasInterface) exitWith {};

["visionMode", {
    params ["_unit", "_corpse"];

    TRACE_1("Player vision mode changed",(name _unit));

    [] call FUNC(toggleNvgBatteryDrain);

}] call CBA_fnc_addPlayerEventHandler;
