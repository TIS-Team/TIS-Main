#include "script_component.hpp"

// Both sides
[QGVAR(initTfarRadioJammerDeactivateActionEvent), { call FUNC(initJammerDeactivateAction)}] call CBA_fnc_addEventHandler;
[QGVAR(initTfarRadioJammerActivateActionEvent), { call FUNC(initJammerActivateAction)}] call CBA_fnc_addEventHandler;

if (hasInterface) then {
    GVAR(TfarJammersClient) = createHashMap;

    // Passed args ["_jammer", "_side", "_unit"];
    [QGVAR(postTfarJammerActivationEvent), { call FUNC(onPostJammerActivationClient)}] call CBA_fnc_addEventHandler;
    // Passed args ["_jammer", "_side", "_unit" OR objNull];
    [QGVAR(postTfarJammerDeactivationEvent), { call FUNC(onPostJammerDeactivationClient)}] call CBA_fnc_addEventHandler;
};

// Server only
if (isServer) then {
    if (isNil QGVAR(TfarJammers)) then {
        GVAR(TfarJammers) = createHashMap;
    };

    [QGVAR(requestJammerDeactivation), { _this call FUNC(jammerDoDeactivate) }] call CBA_fnc_addEventHandler;
    [QGVAR(requestJammerActivation), { _this call FUNC(jammerDoActivate) }] call CBA_fnc_addEventHandler;

    // JIP support: push a full snapshot of currently active timers to any
    // player who joins in progress, so they see running timers immediately.
    addMissionEventHandler ["PlayerConnected", {
        params ["_id", "_uid", "_name", "_jip", "_owner"];

        if (_jip) then {
            private _jammers = createHashMap;
            {
                (GVAR(TfarJammers) get _x) params ["_jammers"];
                _jammers set [_x, _jammers];
            } forEach (keys GVAR(TfarJammers));

            if (_jammers isNotEqualTo (createHashMap)) then {
                [_jammers] remoteExec [QFUNC(jammersSyncClient), _owner];
            };
        };
    }];
};
