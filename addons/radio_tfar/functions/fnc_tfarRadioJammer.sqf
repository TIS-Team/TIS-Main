#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

    The following script is based on a script from Asherion and Rebel
    Version 0.2.0
    Originally available at: https://forums.bistudio.com/forums/topic/203810-release-radio-jamming-script-for-task-force-radio/

	Description:
        Script for TFAR jammers. SERVER ONLY!;

    Parameter(s):
        0: ARRAY of object(s) (Required)- Objects that should be treated as TFAR jammers
        1: NUMBER (Optional)- Jammer working area radius in meters. Default: 1000.
        2: NUMBER (Optional)- Strength of the jammer. Default: 50.
        3: BOOL (Optional)- Debug mode (provides additional info in the console and map). Default: false.

	Example:
        [[jammer1, jammer2, jammer3]] call tis_main_radio_tfar_fnc_tfarRadioJammer;
        [[jammer1, jammer2, jammer3], 2000, 25, true] call tis_main_radio_tfar_fnc_tfarRadioJammer;
*/

if (!isServer) exitWith {};

params [
    ["_jammers", [], [[]]],
    ["_radius", 1000, [0]],
    ["_strength", 50, [0]],
    ["_debug", false, [true]]
];

tisTfarJammers = _jammers;
_strength = _strength - 1;


//compare distances between jammers and player to find nearest jammer
tis_tfar_radio_fnc_findClosestJammerFunction = {
    params ["_player", "_radius"];
    _jammer = objNull;
    _closestDistance = _radius;
    {
        if (_x distance _player < _closestDistance) then {
            _jammer = _x;
            _closestDistance = _x distance _player;
        };
    } forEach tisTfarJammers;
    _jammer;
};

if (not (isNil QGVAR(JammersHandle)) && {GVAR(JammersHandle) isNotEqualTo ""}) then {
	[GVAR(JammersHandle)] call CBA_fnc_removePerFrameHandler;
	GVAR(JammersHandle) = "";
};

// Only one handler can be active at given time
GVAR(JammersHandle) = [
    {
        params ["_args", "_handleId"];
        private _radius = _args select 0;
        private _strength = _args select 1;
        private _debug = _args select 2;

        // Check if jammers are alive
        tisTfarJammers = tisTfarJammers select { alive _x };

        if (tisTfarJammers isEqualTo []) exitWith {
            if (_debug) then {
                [[], {
                    systemChat "All jammers are dead! Stopping jammer handler.";
                    deleteMarkerLocal "CIS_DebugMarker";
                    deleteMarkerLocal "CIS_DebugMarker2";
                }] remoteExec ["spawn"];
            };
	        [GVAR(JammersHandle)] call CBA_fnc_removePerFrameHandler;
	        GVAR(JammersHandle) = "";
        };

        {
            _player = _x;

            _jammer = [_player, _radius] call tis_tfar_radio_fnc_findClosestJammerFunction;
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
                    deleteMarkerLocal "CIS_DebugMarker";
                    deleteMarkerLocal "CIS_DebugMarker2";
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
                [[_radius, _dist, _distPercent, _interference, _sendInterference, _jammer, tisTfarJammers], {
                    params ["_rad", "_dist", "_distPercent", "_interference", "_sendInterference", "_jammer", "_jammers"];

                    deleteMarkerLocal "CIS_DebugMarker";
                    deleteMarkerLocal "CIS_DebugMarker2";
                    //Area marker
                    _debugMarker = createMarkerLocal ["CIS_DebugMarker", position _jammer];
                    _debugMarker setMarkerShapeLocal "ELLIPSE";
                    _debugMarker setMarkerSizeLocal [_rad, _rad];
                    
                    //Position Marker
                    _debugMarker2 = createMarkerLocal ["CIS_DebugMarker2", position _jammer];
                    _debugMarker2 setMarkerShapeLocal "ICON";
                    _debugMarker2 setMarkerTypeLocal "mil_dot";
                    _debugMarker2 setMarkerTextLocal format ["%1", _jammer];

                    systemChat format ["Distance: %1, Percent: %2, Interference: %3, Send Interference: %4", _dist,  100 * _distPercent, _interference, _sendInterference];
                    systemChat format ["Active Jammer: %1, Jammers: %2",_jammer, _jammers];
                }] remoteExec ["spawn"];
            };
        } forEach allPlayers;
    },
    5,
    [_radius, _strength, _debug]
] call CBA_fnc_addPerFrameHandler;
