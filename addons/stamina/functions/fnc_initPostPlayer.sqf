#include "script_component.hpp"

params ["_unit", ["_isRespawn", true]];

if (_unit isNotEqualTo player) exitWith {};
if (!local _unit) exitWith {};

if (!_isRespawn) then {
    _unit addEventHandler ["Respawn", {[(_this select 0), true] call FUNC(initPostPlayer)}];
};

// The actual code below

if (GVAR(RemoveStaminaOnRespawn)) then {
    _unit enableStamina false;
    _unit enableFatigue false;
};
