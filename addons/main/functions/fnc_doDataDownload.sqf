#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for data download but can also be used for other things. Progress is displayed in hint message.

    Side:
        Should be executed on server side only.

	Parameter(s):
		0: OBJECT - the unit/player that starts data download
		1: OBJECT - the object that data download is attached to
		2: NUMBER - download speed. Default: 1.0
        3: BOOLEAN - if distance to object should be taken to account and stop the download when distance is more than 11 meteres. Default: false
		4: STRING - required item to start data download. Default: empty
        6: CODE - after completion code. Default: nothing

	Example:
        [_player, _device] call tis_main_main_dataDownload;
        [_player, _device, 2.5, true, "Toolkit", {hint "finished!"}] call tis_main_main_dataDownload;
*/

if (!isServer) exitWith {};

params [
    "_caller", 
    "_device", 
    ["_speed", 1.0, [1.0]], 
    ["_considerCallerDistance", false, [true]], 
    ["_requiredItem", "", ["string"]], 
    ["_onStartFunction", {}],
    ["_onProgressFunction", {}],
    ["_onConnectionLostFunction", {}],
    ["_onCompleteFunction", {}]
];

_device setVariable ["tis_is_downloading", true, true];
["Data download started!"] remoteExec ["hint"];

// On start function
if (!(isNil "_onStartFunction")) then {
    [_device] call _onStartFunction;
};

[_caller, _device, _speed, _considerCallerDistance, _requiredItem, _onStartFunction, _onProgressFunction, _onConnectionLostFunction, _onCompleteFunction] spawn {

    params ["_caller", "_device", "_speed", "_considerCallerDistance", "_requiredItem", "_onStartFunction", "_onProgressFunction", "_onConnectionLostFunction", "_onCompleteFunction"];

    private _bestSpeed = 0.5;
    private _worstSpeed = _bestSpeed * 3;
    private _sleepTime = _bestSpeed; // Changes based on player location if _considerCallerDistance == true
    private _progress = (_device getVariable ["tis_progress_before_connection_lost", 0.0]) * 0.8;
    private _endTime = diag_tickTime + 100;
    while {_progress < 100} do {

        // Check caller distance if _considerCallerDistance == true
        if (_considerCallerDistance) then {
            private _meters = _caller distance _device;
            if (_meters <= 3) then {
                _sleepTime = _bestSpeed;
            };
            if (_meters >= 4 && _meters <= 7) then {
                _sleepTime = _bestSpeed * 2;
            };
            if (_meters > 7) then {
                _sleepTime = _worstSpeed;
            };
        };

        if (_considerCallerDistance && (!alive _caller || (_caller distance _device > 11))) exitWith {
            _device setVariable ["tis_is_downloading", false, true];
            _device setVariable ["tis_progress_before_connection_lost", _progress, true];
            ["Connection lost... Go to device and reconnect."] remoteExec ["hint"];
            // On failure function
            if (!(isNil "_onConnectionLostFunction")) then {
                [_device] call _onConnectionLostFunction;
            };
        };

        _hasRequiredItem = true;
        if ("" isNotEqualTo _requiredItem) then {
            _hasRequiredItem = [_caller, _requiredItem] call BIS_fnc_hasItem;
        };

        if (!_hasRequiredItem) exitWith {
            ["Connection lost... You don't have required item to download data."] remoteExec ["hint"];

            // On failure function
            if (!(isNil "_onConnectionLostFunction")) then {
                [_device] call _onConnectionLostFunction;
            };
        };

        sleep _sleepTime;
        _progress = _progress + _speed;
        [format ["Progress: %1", _progress]] remoteExec ["hintSilent"];
        
        // On progress function
        if (!(isNil "_onProgressFunction")) then {
            [_device, _progress] call _onProgressFunction;
        };
    };

    if (_progress >= 100) then {
        _device setVariable ["tis_progress_before_connection_lost", 0.0, true];
        ["Download complete!"] remoteExec ["hint"];
        if (!(isNil "_onCompleteFunction")) then {
            [_device] call _onCompleteFunction;
        };
    };

    _device setVariable ["tis_is_downloading", false, true];
};
