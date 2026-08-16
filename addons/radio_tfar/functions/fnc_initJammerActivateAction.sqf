#include "script_component.hpp"

params [
    "_actionObject",
    ["_targetJammer", objNull, [objNull]],
    ["_jammerRadius", 1000, [0]],
    ["_jammerStrength", 50, [0]],
    ["_jammerSide", sideUnknown, [west, east, resistance, civilian, sideUnknown]],
    ["_actionType", "SCROLL", ['string']], // SCROLL, HOLD, NONE
    ["_actionName", "Activate Jammer", ["string"]], 
    ["_actionTime", 5, [5]], // Only valid for HOLD action
    ["_shouldCreateAceAction", false, [true]], // TRUE/FALSE
    ["_condition", {}, [{true}]], 
        // _target: Object - The object to which action is attached
        // _caller: Object - Caller person to whom the action is shown (or not shown if condition returns false)

    ["_hideActionOnUse", false, [true]], 
    ["_onActivationCode", {}, [{}]],
    ["_global", true, [true]]
];

if ((isNil "_actionObject") || {isNull(_actionObject)}) exitWith { "[InitJammerActivateAction] Must select and object!" };

// If targetJammer is null then set action object as target jammer
if (isNull _targetJammer) then {
    _targetJammer = _actionObject;
};

// Code for server + future players
if (isServer && {_global && {isMultiplayer && {isNil {_actionObject getVariable QGVAR(initTfarRadioJammerActivateAction_JIP)}}}}) exitWith {

    private _id = [QGVAR(initTfarRadioJammerActivateActionEvent), [_actionObject, _targetJammer, _jammerRadius, _jammerStrength, _jammerSide, _actionType, _actionName, _actionTime, _shouldCreateAceAction, _condition, _hideActionOnUse, _onActivationCode, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _actionObject] call CBA_fnc_removeGlobalEventJIP;

    _actionObject setVariable [QGVAR(initTfarRadioJammerActivateAction_JIP), _id, true];
};

if (!hasInterface) exitWith {};

_actionObject setVariable ["tis_tfar_jammer_activation_condition", _condition];
_actionObject setVariable ["tis_tfar_jammer_target", _targetJammer];

switch (_actionType) do {
    case "SCROLL": {
        _actionObject addAction [
            _actionName,
            {
                params ["_target", "_caller", "_actionId", "_arguments"];
                _arguments params ["_radius", "_strength", "_side", "_onActivationCode", "_targetJammer"];
                [QGVAR(requestJammerActivation), [_targetJammer, _caller, _radius, _strength, _side]] call CBA_fnc_globalEvent;
                [_targetJammer, _caller] call _onActivationCode;
            },
            [_jammerRadius, _jammerStrength, _jammerSide, _onActivationCode, _targetJammer],
            1.5,
            true,
            _hideActionOnUse,
            "",
            toString ({
                params ['_target', '_caller', '_originalTarget'];

                private _condition = (_originalTarget getVariable ['tis_tfar_jammer_activation_condition', {true}]);
                private _targetJammer = (_originalTarget getVariable ["tis_tfar_jammer_target", objNull]);
                private _canAccess = [_targetJammer, _caller] call _condition;
                _canAccess;
            })
        ];
    };
    case "HOLD": {
        [
            _actionObject,
            _actionName,
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
            toString {
                [(_target getVariable ["tis_tfar_jammer_target", objNull]), _this] call (_target getVariable ["tis_tfar_jammer_activation_condition", {true}]);
            },
            toString {
                [(_target getVariable ["tis_tfar_jammer_target", objNull]), _this] call (_target getVariable ["tis_tfar_jammer_activation_condition", {true}])
            },
            {},
            {},
            {
                params ["_target", "_caller", "_actionId", "_arguments"];
                _arguments params ["_radius", "_strength", "_side", "_onActivationCode", "_targetJammer"];
                [QGVAR(requestJammerActivation), [_targetJammer, _caller, _radius, _strength, _side]] call CBA_fnc_globalEvent;
                [_targetJammer, _caller] call _onActivationCode;
            },
            {},
            [_jammerRadius, _jammerStrength, _jammerSide, _onActivationCode, _targetJammer], 
            _actionTime, 
            nil, 
            _hideActionOnUse, 
            false
        ] call BIS_fnc_holdActionAdd;
    };
    default {  };
};

if (_shouldCreateAceAction) then {
    if(not (EGVAR(main,isAceInteractionMenuLoaded))) then {
        diag_log "[TIS-MAIN][Jammer][ActivateAction] ACE 3 is not loaded";
        hint "[TIS-MAIN][Jammer][ActivateAction]: ACE 3 not loaded";
    };

    // Create ACE action
    if (not ((_actionObject getVariable ["tis_tfar_jammer_parent_action_initialized", false]))) then {
        _jammerParentAction = ["tis_tfar_jammer", "Jammer", "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
        [_actionObject, 0, ["ACE_MainActions"], _jammerParentAction] call ace_interact_menu_fnc_addActionToObject;
        _actionObject setVariable ["tis_tfar_jammer_parent_action_initialized", true];
    };

    _jammerActivateAction = ["tis_tfar_jammer", _actionName, "",
    {
        params ["_target", "_player", "_actionParams"];
        _actionParams params ["_radius", "_strength", "_side", "_onActivationCode", "_condition", "_targetJammer"];
        [QGVAR(requestJammerActivation), [_targetJammer, _player, _radius, _strength, _side]] call CBA_fnc_globalEvent;
        [_targetJammer, _player] call _onActivationCode;
    }, {
        params ["_target", "_player", "_actionParams"];
        _actionParams params ["_radius", "_strength", "_side", "_onActivationCode", "_condition", "_targetJammer"];
        private _canInvoke = [_targetJammer, _player] call _condition;
        _canInvoke;
    }, {}, [_jammerRadius, _jammerStrength, _jammerSide, _onActivationCode, _condition, _targetJammer]] call ace_interact_menu_fnc_createAction;

    [_actionObject, 0, ["ACE_MainActions", "tis_tfar_jammer"], _jammerActivateAction] call ace_interact_menu_fnc_addActionToObject;
};
