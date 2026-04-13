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
        5: BOOLEAN - if built-in hint messages (on start, progress and finish) should be displayed. Default: true
        6: CODE - code on strat. Default: empty code block
        7: CODE - code on progress. Default: empty code block
        8: CODE - code on connection lost, valid only when caller distance is set to true. Default: empty code block
        9: CODE - code on completion. Default: empty code block
        10: BOOLEAN - display builtin hint messages. Default: true

	Example:
        [_player, _device] call tis_main_main_fnc_dataDownload;
        [_player, _device, 2.5, true, "Toolkit", {hint "finished!"}] call tis_main_main_fnc_dataDownload;
*/

if (!isServer) exitWith {};

params [
    "_caller",
    "_device",
    ["_speed", 1.0, [1.0]],
    ["_considerCallerDistance", false, [true]],
    ["_requiredItem", "", ["string"]],
    ["_displayBuiltInHintMessages", true, [true]],
    ["_onStartFunction", {}, [{}]],
    ["_onProgressFunction", {}, [{}]],
    ["_onConnectionLostFunction", {}, [{}]],
    ["_onCompleteFunction", {}, [{}]]
];

_device setVariable ["tis_is_downloading", true, true];
if (_displayBuiltInHintMessages) then {
    [LLSTRING(DataDownloadStarted)] remoteExec ["hint"];
};

// On start function
if (!(isNil "_onStartFunction")) then {
    [_caller, _device] call _onStartFunction;
};

[_caller, _device, _speed, _considerCallerDistance, _requiredItem, _onStartFunction, _onProgressFunction, _onConnectionLostFunction, _onCompleteFunction, _displayBuiltInHintMessages] spawn {

    // Initial delay
    sleep 0.5;

    params ["_caller", "_device", "_speed", "_considerCallerDistance", "_requiredItem", "_onStartFunction", "_onProgressFunction", "_onConnectionLostFunction", "_onCompleteFunction", "_displayBuiltInHintMessages"];

    private _bestWaitTime = 0.5;
    private _worstWaitTime = _bestWaitTime * 3;
    private _sleepTime = _bestWaitTime; // Changes based on player location if _considerCallerDistance == true
    private _progress = (_device getVariable ["tis_progress_before_connection_lost", 0.0]) * 0.8;
    private _endTime = diag_tickTime + 100;
    while {_progress < 100} do {

        // Check caller distance if _considerCallerDistance == true
        if (_considerCallerDistance) then {
            private _meters = _caller distance _device;
            if (_meters <= 3) then {
                _sleepTime = _bestWaitTime;
            };
            if (_meters >= 4 && _meters <= 7) then {
                _sleepTime = _bestWaitTime * 2;
            };
            if (_meters > 7) then {
                _sleepTime = _worstWaitTime;
            };
        };

        if (_considerCallerDistance && (!alive _caller || (_caller distance _device > 11))) exitWith {
            _device setVariable ["tis_is_downloading", false, true];
            _device setVariable ["tis_progress_before_connection_lost", _progress, true];

            if(_displayBuiltInHintMessages) then {
                [LLSTRING(DataDownloadConnectionLost)] remoteExec ["hint"];
            };

            // On failure function
            if (!(isNil "_onConnectionLostFunction")) then {
                [_caller, _device] call _onConnectionLostFunction;
            };
        };

        _hasRequiredItem = true;
        if ("" isNotEqualTo _requiredItem) then {
            _hasRequiredItem = [_caller, _requiredItem] call BIS_fnc_hasItem;
        };

        if (!_hasRequiredItem) exitWith {
            if (_displayBuiltInHintMessages) then {
                [LLSTRING(DataDownloadConnectionLostMissingItem)] remoteExec ["hint"];
            };

            // On failure function
            if (!(isNil "_onConnectionLostFunction")) then {
                [_caller, _device] call _onConnectionLostFunction;
            };
        };

        sleep _sleepTime;
        _progress = _progress + _speed;

        if (_displayBuiltInHintMessages) then {
            [format [LLSTRING(DataDownloadProgress), _progress]] remoteExec ["hintSilent"];
        };
        
        // On progress function
        if (!(isNil "_onProgressFunction")) then {
            [_caller, _device, _progress] call _onProgressFunction;
        };
    };

    if (_progress >= 100) then {
        _device setVariable ["tis_progress_before_connection_lost", 0.0, true];

        if (_displayBuiltInHintMessages) then {
            [LLSTRING(DataDownloadCompleted)] remoteExec ["hint"];
        };
        if (!(isNil "_onCompleteFunction")) then {
            [_caller, _device] call _onCompleteFunction;
        };
    };

    _device setVariable ["tis_is_downloading", false, true];
};
