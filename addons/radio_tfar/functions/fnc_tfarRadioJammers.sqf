#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

    The following script is based on a script (version 0.2.0) from Asherion and Rebel
    Originally available at: https://forums.bistudio.com/forums/topic/203810-release-radio-jamming-script-for-task-force-radio/

	Description:
        Script for TFAR jammers. SERVER ONLY!;

        Supports running multiple independent instances - one per side. Each side gets
        its own jammer list and its own per-frame handler, so jamming WEST does not
        affect EAST/INDEPENDENT/CIVILIAN etc. Calling the script again for the same side
        replaces that side's jammers/handler; calling it for a different side starts a
        brand new, independent instance.

    Parameter(s):
        0: ARRAY of object(s) (Required)- Objects that should be treated as TFAR jammers
        1: NUMBER (Optional)- Jammer working area radius in meters. Default: 1000.
        2: NUMBER (Optional)- Strength of the jammer. Default: 50.
        3: BOOL (Optional)- Debug mode (provides additional info in the console and map). Default: false.
        4: SIDE (Optional)- Side whose players should be affected by this jammer group. Default: sideUnknown (all sides).

	Example:
        [[jammer1, jammer2, jammer3]] call tis_main_radio_tfar_fnc_tfarRadioJammer;
        [[jammer1, jammer2, jammer3], 2000, 25, true] call tis_main_radio_tfar_fnc_tfarRadioJammer;

        // Run two independent jammer groups, one per side:
        [[westJammer1], 1000, 50, false, west] call tis_main_radio_tfar_fnc_tfarRadioJammer;
        [[eastJammer1, eastJammer2], 1500, 40, false, east] call tis_main_radio_tfar_fnc_tfarRadioJammer;
*/

if (!isServer) exitWith {};

params [
    ["_jammers", [], [[]]],
    ["_radius", 1000, [0]],
    ["_strength", 50, [0]],
    ["_debug", false, [true]],
    ["_side", sideUnknown, [sideUnknown]]
];

_strength = _strength - 1;

// Per-side storage. Each side gets its own entry so multiple instances can run concurrently.
if (isNil QGVAR(TfarJammers)) then {
    GVAR(TfarJammers) = createHashMap; // [side] => collection of [jammers]
};
if (isNil QGVAR(HandlesBySide)) then {
    GVAR(HandlesBySide) = createHashMap;
};

// Use the side's string representation as a stable HashMap key.
private _sideKey = str _side;

GVAR(TfarJammers) set [_sideKey, _jammers];

// If a handler is already running for this specific side, stop it before starting the new one.
// Handlers for other sides are left untouched.
private _existingHandle = GVAR(HandlesBySide) getOrDefault [_sideKey, ""];
if (_existingHandle isNotEqualTo "") then {
    [_existingHandle] call CBA_fnc_removePerFrameHandler;
    GVAR(HandlesBySide) set [_sideKey, ""];
};

// Compare distances between jammers and player to find nearest jammer for this side's jammer list.
private _findClosestJammer = {
    params ["_player", "_radius", "_jammersList"];
    private _jammer = objNull;
    private _closestDistance = _radius;
    {
        if (_x distance _player < _closestDistance) then {
            _jammer = _x;
            _closestDistance = _x distance _player;
        };
    } forEach _jammersList;
    _jammer;
};

private _debugMarkerName = format ["CIS_DebugMarker_%1", _sideKey];
private _debugMarker2Name = format ["CIS_DebugMarker2_%1", _sideKey];

private _handle = [
    {
        params ["_args", "_handleId"];
        _args params ["_radius", "_strength", "_debug", "_side", "_sideKey", "_findClosestJammer", "_debugMarkerName", "_debugMarker2Name"];

        // Check if this side's jammers are alive
        private _jammersList = GVAR(TfarJammers) getOrDefault [_sideKey, []];
        _jammersList = _jammersList select { alive _x };
        GVAR(TfarJammers) set [_sideKey, _jammersList];

        if (_jammersList isEqualTo []) exitWith {
            if (_debug) then {
                [[_side, _debugMarkerName, _debugMarker2Name], {
                    params ["_sideParam", "_markerName", "_marker2Name"];
                    systemChat format ["All jammers for side %1 are dead! Stopping jammer handler.", _sideParam];
                    deleteMarkerLocal _markerName;
                    deleteMarkerLocal _marker2Name;
                }] remoteExec ["spawn"];
            };
            private _handleToRemove = GVAR(HandlesBySide) getOrDefault [_sideKey, ""];
            if (_handleToRemove isNotEqualTo "") then {
                [_handleToRemove] call CBA_fnc_removePerFrameHandler;
                GVAR(HandlesBySide) set [_sideKey, ""];
            };
        };

        // Only affect players belonging to this jammer group's side.
        // sideUnknown is treated as a wildcard, meaning "affect all sides"
        private _affectedPlayers = allPlayers select { _side == sideUnknown || { side _x == _side } };

        {
            _player = _x;

            private _jammer = [_player, _radius, _jammersList] call _findClosestJammer;
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
                    deleteMarkerLocal _debugMarkerName;
                    deleteMarkerLocal _debugMarker2Name;
                };
                continue;
            };

            // Set variables
            _dist = _player distance _jammer;
            _distPercent = _dist / _radius;
            _interference = 1;
            _sendInterference = 1;

            if (_dist < _radius) then {
                _interference = _strength - (_distPercent * _strength) + 1; // Calculate the recieving interference, which has to be above 1 to have any effect.
                _sendInterference = 1/_interference; //Calculate the sending interference, which needs to be below 1 to have any effect.
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
                [[_radius, _dist, _distPercent, _interference, _sendInterference, _jammer, _jammersList, _debugMarkerName, _debugMarker2Name], {
                    params ["_rad", "_dist", "_distPercent", "_interference", "_sendInterference", "_jammer", "_jammersList", "_markerName", "_marker2Name"];

                    deleteMarkerLocal _markerName;
                    deleteMarkerLocal _marker2Name;
                    //Area marker
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
        } forEach _affectedPlayers;
    },
    5,
    [_radius, _strength, _debug, _side, _sideKey, _findClosestJammer, _debugMarkerName, _debugMarker2Name]
] call CBA_fnc_addPerFrameHandler;

GVAR(HandlesBySide) set [_sideKey, _handle];
