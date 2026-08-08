#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

    The following script is based on a script (0.2.0) from Asherion and Rebel
    Originally available at: https://forums.bistudio.com/forums/topic/203810-release-radio-jamming-script-for-task-force-radio/

	Description:
        Script for TFAR jammers. SERVER ONLY!;

        Supports independent per-side jammer configuration, but uses only ONE global
        per-frame handler for all sides combined (registered once, reused for every side).

        Each jammer object can additionally have its OWN radius/strength, stored as object
        variables:
            tis_tfar_jammer_radius   (NUMBER, meters)
            tis_tfar_jammer_strength (NUMBER)
        Set them with setVariable before/after adding the jammer, e.g.:
            jammer1 setVariable ["tis_tfar_jammer_radius", 500];
            jammer1 setVariable ["tis_tfar_jammer_strength", 80];
        A jammer without these variables set falls back to the _radius/_strength defaults
        passed into this function for its side/group.

        When a player is within range of several jammers at once (possibly with different
        radius/strength), the STRONGEST resulting interference is applied - i.e. jammers
        don't "hide" each other, the worst-case jammer for that player's exact position wins.

        Calling this function again for a side already configured replaces that side's jammers
        and default settings. Calling it for a new side just adds an entry - the single handler
        picks it up automatically on its next tick.

        To stop jamming for a side entirely, call it with an empty jammers array for that side.

    Parameter(s):
        0: ARRAY of object(s) (Required)- Objects that should be treated as TFAR jammers.
           Each object may optionally define its own "tis_tfar_jammer_radius"/"tis_tfar_jammer_strength"
           variables to override the defaults below.
        1: NUMBER (Optional)- Default jammer working area radius in meters, used for jammers
           that don't define their own tis_tfar_jammer_radius variable. Default: 1000.
        2: NUMBER (Optional)- Default strength of the jammer, used for jammers that don't
           define their own tis_tfar_jammer_strength variable. Default: 50.
        3: BOOL (Optional)- Debug mode (provides additional info in the console and map). Default: false.
        4: SIDE (Optional)- Side whose players should be affected by this jammer group. Default: sideUnknown (affects ALL sides, same as legacy behavior).

	Example:
        [[jammer1, jammer2, jammer3]] call tis_main_radio_tfar_fnc_radioJammers;
        [[jammer1, jammer2, jammer3], 2000, 25, true] call tis_main_radio_tfar_fnc_radioJammers;

        // Two sides, single shared handler under the hood:
        [[westJammer1], 1000, 50, false, west] call tis_main_radio_tfar_fnc_radioJammers;
        [[eastJammer1, eastJammer2], 1500, 40, false, east] call tis_main_radio_tfar_fnc_radioJammers;

        // Give one jammer its own, stronger/wider settings before adding it:
        eastJammer1 setVariable ["tis_tfar_jammer_radius", 2500];
        eastJammer1 setVariable ["tis_tfar_jammer_strength", 90];
        [[eastJammer1, eastJammer2], 1500, 40, false, east] call tis_main_radio_tfar_fnc_radioJammers;

        // Stop jamming EAST only:
        [[], 1500, 40, false, east] call tis_main_radio_tfar_fnc_radioJammers;
*/

if (!isServer) exitWith {};

params [
    ["_jammers", [], [[]]],
    ["_radius", 1000, [0]],
    ["_strength", 50, [0]],
    ["_debug", false, [true]],
    ["_side", sideUnknown, [sideUnknown]]
];

// Per-side jammer lists and per-side default config, both keyed by str(side).
// A single per-frame handler reads from these every tick - no per-side handlers.
if (isNil QGVAR(TfarJammers)) then {
    GVAR(TfarJammers) = createHashMap;
};
if (isNil QGVAR(ConfigBySide)) then {
    GVAR(ConfigBySide) = createHashMap;
};

private _sideKey = toUpperANSI (str _side);

GVAR(TfarJammers) set [_sideKey, _jammers];
GVAR(ConfigBySide) set [_sideKey, [_radius, _strength, _debug, _side, _sideKey]];

private _findStrongestJammerEffect = {
    params ["_player", "_jammersList", "_defaultRadius", "_defaultStrength"];

    private _bestInterference = 1;
    private _bestSendInterference = 1;
    private _activeJammer = objNull;
    private _activeDist = 0;
    private _activeRadius = _defaultRadius;

    {
        private _jamRadius = _x getVariable ["tis_tfar_jammer_radius", _defaultRadius];
        private _jamStrength = (_x getVariable ["tis_tfar_jammer_strength", _defaultStrength]) - 1;
        private _dist = _x distance _player;

        if (_dist < _jamRadius) then {
            private _distPercent = _dist / _jamRadius;
            private _interference = _jamStrength - (_distPercent * _jamStrength) + 1;

            if (_interference > _bestInterference) then {
                _bestInterference = _interference;
                _bestSendInterference = 1 / _interference;
                _activeJammer = _x;
                _activeDist = _dist;
                _activeRadius = _jamRadius;
            };
        };
    } forEach _jammersList;

    [_activeJammer, _bestInterference, _bestSendInterference, _activeDist, _activeRadius];
};
GVAR(FindStrongestJammerEffectFnc) = _findStrongestJammerEffect;

if (isNil QGVAR(Handle)) then {
    GVAR(Handle) = [
        {
            params ["_args", "_handleId"];

            // Clean up dead jammers once per tick, per side that currently has an entry.
            {
                _sideKeyIter = _x;
                private _jammersList = GVAR(TfarJammers) get _sideKeyIter;
                TRACE_1("_jammersList",_jammersList);
                _jammersList = _jammersList select { alive _x };
                GVAR(TfarJammers) set [_sideKeyIter, _jammersList];
            } forEach (keys GVAR(TfarJammers));

            // Single pass over all players - each player's side determines which
            // jammer list/default config applies to them, looked up in O(1).
            {
                _player = _x;
                private _sideKey = toUpperANSI (str (side _player));

                private _config = GVAR(ConfigBySide) getOrDefault [_sideKey, []];
                if (_config isEqualTo []) then {
                    _config = GVAR(ConfigBySide) getOrDefault [str sideUnknown, []];
                };

                // No config at all (neither side-specific nor wildcard) - leave this player alone.
                if (_config isEqualTo []) then { continue; };

                _config params ["_defaultRadius", "_defaultStrength", "_debug", "_configSide", "_configSideKey"];
                private _jammersList = GVAR(TfarJammers) getOrDefault [_configSideKey, []];

                if (_jammersList isEqualTo []) then {
                    private _receivingDistanceMultiplicator = _player getVariable ["tf_receivingDistanceMultiplicator", 0];
                    private _sendingDistanceMultiplicator = _player getVariable ["tf_sendingDistanceMultiplicator", 0];
                    if (_receivingDistanceMultiplicator != 1) then {
                        _player setVariable ["tf_receivingDistanceMultiplicator", 1, true];
                    };
                    if (_sendingDistanceMultiplicator != 1) then {
                        _player setVariable ["tf_sendingDistanceMultiplicator", 1, true];
                    };
                    continue;
                };

                private _result = [_player, _jammersList, _defaultRadius, _defaultStrength] call GVAR(FindStrongestJammerEffectFnc);
                _result params ["_jammer", "_interference", "_sendInterference", "_dist", "_activeRadius"];

                if (isNull _jammer) then {
                    private _receivingDistanceMultiplicator = _player getVariable ["tf_receivingDistanceMultiplicator", 0];
                    private _sendingDistanceMultiplicator = _player getVariable ["tf_sendingDistanceMultiplicator", 0];
                    if (_receivingDistanceMultiplicator != 1) then {
                        _player setVariable ["tf_receivingDistanceMultiplicator", 1, true];
                    };
                    if (_sendingDistanceMultiplicator != 1) then {
                        _player setVariable ["tf_sendingDistanceMultiplicator", 1, true];
                    };
                    if (_debug) then {
                        deleteMarkerLocal format ["CIS_DebugMarker_%1", _configSideKey];
                        deleteMarkerLocal format ["CIS_DebugMarker2_%1", _configSideKey];
                    };
                    continue;
                };

                // Set the TF receiving and sending distance multipliers
                private _receivingDistanceMultiplicator = _player getVariable ["tf_receivingDistanceMultiplicator", 0];
                private _sendingDistanceMultiplicator = _player getVariable ["tf_sendingDistanceMultiplicator", 0];
                if (_receivingDistanceMultiplicator != _interference) then {
                    _player setVariable ["tf_receivingDistanceMultiplicator", _interference, true];
                };
                if (_sendingDistanceMultiplicator != _sendInterference) then {
                    _player setVariable ["tf_sendingDistanceMultiplicator", _sendInterference, true];
                };

                // Debug chat and marker.
                if (_debug) then {
                    private _markerName = format ["CIS_DebugMarker_%1", _configSideKey];
                    private _marker2Name = format ["CIS_DebugMarker2_%1", _configSideKey];
                    private _distPercent = _dist / _activeRadius;
                    [[_activeRadius, _dist, _distPercent, _interference, _sendInterference, _jammer, _jammersList, _markerName, _marker2Name], {
                        params ["_rad", "_dist", "_distPercent", "_interference", "_sendInterference", "_jammer", "_jammersList", "_markerName", "_marker2Name"];

                        deleteMarkerLocal _markerName;
                        deleteMarkerLocal _marker2Name;
                        //Area marker - sized to the ACTIVE jammer's own radius
                        _debugMarker = createMarkerLocal [_markerName, position _jammer];
                        _debugMarker setMarkerShapeLocal "ELLIPSE";
                        _debugMarker setMarkerSizeLocal [_rad, _rad];

                        //Position Marker
                        _debugMarker2 = createMarkerLocal [_marker2Name, position _jammer];
                        _debugMarker2 setMarkerShapeLocal "ICON";
                        _debugMarker2 setMarkerTypeLocal "mil_dot";
                        _debugMarker2 setMarkerTextLocal format ["%1", _jammer];

                        systemChat format ["Distance: %1, Percent: %2, Interference: %3, Send Interference: %4", _dist,  100 * _distPercent, _interference, _sendInterference];
                        systemChat format ["Active Jammer: %1, Jammers: %2", _jammer, _jammersList];
                    }] remoteExec ["spawn"];
                };
            } forEach allPlayers;

            if (count GVAR(TfarJammers) == 0) then {
                [_handleId] call CBA_fnc_removePerFrameHandler;
                QGVAR(Handle) = nil;
            };
        },
        GVAR(TFARJammersUpdateInterval),
        []
    ] call CBA_fnc_addPerFrameHandler;

};
