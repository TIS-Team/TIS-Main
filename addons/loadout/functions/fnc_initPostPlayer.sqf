#include "script_component.hpp"

params ["_unit", ["_isRespawn", true]];

if (!_isRespawn) then {
    _unit addEventHandler ["Respawn", {[(_this select 0), true] call FUNC(initPostPlayer)}];
    // BIS/Vanilla Arsenal
    [missionNamespace, "arsenalClosed", {   
        if (GVAR(SaveAndReplaceVanillaLoadout)) then {
            player setVariable [QGVAR(SavedLoadout), getUnitLoadout player];
        };
    }] call BIS_fnc_addScriptedEventHandler;
    

    ["ace_arsenal_displayClosed", {
        if (GVAR(SaveAndReplaceAceLoadout)) then {
            player setVariable [QGVAR(SavedLoadout), getUnitLoadout player];
        };
    }] call CBA_fnc_addEventHandler;
};

if (_unit isNotEqualTo player) exitWith {};
if (!local _unit) exitWith {};

if (GVAR(SaveAndReplaceVanillaLoadout) || {GVAR(SaveAndReplaceAceLoadout)}) then {
    private _loadout = player getVariable [QGVAR(SavedLoadout), []];
    if (count _loadout > 0) then {
        player setUnitLoadout _loadout;
    };
};
