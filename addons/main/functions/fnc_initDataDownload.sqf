#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for data download but can also be used for other things. Progress is displayed in hint message.

    Side:
       This script should be executed locally only. It setups an action for data download.

	Parameter(s):
		0: OBJECT - the object that data download is attached to
        1: STRING - the action name. Default: "Download data"
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
        [_device] call tis_main_main_fnc_initDataDownload;
        [_device, "Refuel vehicle", 2.5, true, "Toolkit", false, {hint "DOWNLOAD STARTED!"}] call tis_main_main_fnc_initDataDownload;
*/

params [
    "_device", 
    ["_actionTitle", "Download data", ["string"]], 
    ["_speed", 1.0, [1.0]], 
    ["_considerCallerDistance", false, [true]], 
    ["_requiredItem", "", ["string"]], 
    ["_displayBuiltInHintMessages", true, [true]],
    ["_onStartFunction", {}],
    ["_onProgressFunction", {}],
    ["_onConnectionLostFunction", {}],
    ["_onCompleteFunction", {}],
    ["_global", true, [true]]
];

// Code for server + future players
if (isServer && {_global && {isMultiplayer && {isNil {_device getVariable QGVAR(init_dataDownload_JIP)}}}}) exitWith {

    private _id = [QGVAR(initDataDownloadEvent), [_device, _actionTitle, _speed, _considerCallerDistance, _requiredItem, _onStartFunction, _onProgressFunction, _onConnectionLostFunction, _onCompleteFunction, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _device] call CBA_fnc_removeGlobalEventJIP;

    _device setVariable [QGVAR(init_dataDownload_JIP), _id, true];
};

if (!hasInterface) exitWith {};

[
    _device,
    _actionTitle,
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
    "_this distance _target < 5",
    "_caller distance _target < 5",
    {},
    {},
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        private _device = _arguments select 0;
        private _isDownloading = _device getVariable ["tis_is_downloading", false];
        if (_isDownloading) exitWith {
            hint "Download is already in progress";
        };
        private _requiredItem = _arguments select 3;
        _hasRequiredItem = true;
        if ("" isNotEqualTo _requiredItem) then {
            _hasRequiredItem = [_caller, _requiredItem] call BIS_fnc_hasItem;
        };

        if (!_hasRequiredItem) exitWith {
            hint "You don't have required item to download data";
        };

        ([_caller] + _arguments) remoteExec [QFUNC(dataDownload), 2];
    },
    {},
    [_device, _speed, _considerCallerDistance, _requiredItem, _displayBuiltInHintMessages, _onStartFunction, _onProgressFunction, _onConnectionLostFunction, _onCompleteFunction],
    5,
    1,
    false,
    false
] call BIS_fnc_holdActionAdd;
