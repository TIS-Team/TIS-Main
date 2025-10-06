#include "script_component.hpp"

params ["_unit", ["_isRespawn", true]];

if (!_isRespawn) then {
    _unit addEventHandler ["Respawn", {[(_this select 0), true] call FUNC(initPlayer)}];
};

if (_unit isNotEqualTo player) exitWith {};
if (!local _unit) exitWith {};

[player, false] call FUNC(replaceNvgBattery);
