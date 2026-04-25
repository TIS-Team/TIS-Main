#include "script_component.hpp"

params ["_unit", ["_isRespawn", true]];

if (_unit isNotEqualTo player) exitWith {};
if (!local _unit) exitWith {};

if (!_isRespawn) then {
    _unit addEventHandler ["Respawn", {[(_this select 0), true] call FUNC(initPostPlayer)}];
    // BIS/Vanilla Arsenal
    [missionNamespace, "arsenalClosed", {   
        if (GVAR(SaveVanillaLoadoutOnArsenalClose)) then {
            player setVariable [QGVAR(SavedLoadout), getUnitLoadout player];
        };
    }] call BIS_fnc_addScriptedEventHandler;
    
    if (EGVAR(main,isAceArsenalLoaded)) then {
        ["ace_arsenal_displayClosed", {
            if (GVAR(SaveAceLoadoutOnArsenalClose)) then {
                player setVariable [QGVAR(SavedLoadout), getUnitLoadout player];
            };
        }] call CBA_fnc_addEventHandler;
    };
};

if (GVAR(RestoreVanillaLoadoutOnRespawn) || {GVAR(RestoreAceLoadoutOnRespawn)}) then {
    private _loadout = player getVariable [QGVAR(SavedLoadout), []];
    if (count _loadout > 0) then {
        [_loadout] spawn
        {
            params ["_loadout"];
            waitUntil {!isSwitchingWeapon player};
            player setUnitLoadout _loadout;
        };
    };
};
