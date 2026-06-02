#include "script_component.hpp"

params ["_unit", "_radioClassName"];

if ("TFAR_anprc152" isEqualTo _radioClassName) then {
    [_unit, "TIS_Anprc_152_Broken_Radio"] call CBA_fnc_addItem;
};
