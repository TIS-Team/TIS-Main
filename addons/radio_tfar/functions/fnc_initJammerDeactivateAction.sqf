#include "script_component.hpp"

params [
    ["_object"],
    ["_actionType", "SCROLL", ['string']], // SCROLL, HOLD, NONE
    ["_actionName", "Deactivate Jammer", ["string"]], 
    ["_actionTime", 5, [5]], // Only valid for HOLD action
    ["_shouldCreateAceAction", false, [true]], // TRUE/FALSE
    ["_condition", {}, [{}]], 
        // _target: Object - The object to which action is attached
        // _caller: Object - Caller person to whom the action is shown (or not shown if condition returns false)

    ["_hideActionOnUse", false, [true]], 
    ["_onDeactivationCode", {}, [{}]],
    ["_global", true, [true]]
];

if ((isNil "_object") || {isNull(_object)}) exitWith { "[InitJammerDeactivateAction] Must select and object!" };

TRACE_1("_global:",_global);

// Code for server + future players
if (isServer && {_global && {isMultiplayer && {isNil {_object getVariable QGVAR(initTfarRadioJammerDeactivateAction_JIP)}}}}) exitWith {

    private _id = [QGVAR(initTfarRadioJammerDeactivateActionEvent), [_object, _actionType, _actionName, _actionTime, _shouldCreateAceAction, _condition, _hideActionOnUse, _onDeactivationCode, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _object] call CBA_fnc_removeGlobalEventJIP;

    _object setVariable [QGVAR(initTfarRadioJammerDeactivateAction_JIP), _id, true];
};

if (!hasInterface) exitWith {};

_object setVariable ["tis_tfar_jammer_activation_condition", _condition];

TRACE_1("_object",_object);

switch (_actionType) do {
    case "SCROLL": {
        _object addAction [
            _actionName,
            {
                params ["_target", "_caller", "_actionId", "_arguments"];
                [QGVAR(requestJammerDeactivation), [_target, _caller]] call CBA_fnc_globalEvent;
                [_target, _caller] call (_arguments select 0);
            },
            [_onDeactivationCode],
            1.5,
            true,
            _hideActionOnUse,
            "",
            toString ({
                params ["_target", "_caller", "_originalTarget"];

                _condition = (_originalTarget getVariable ["tis_tfar_jammer_deactivation_condition", {}]);
                private _canAccess = [_originalTarget, _caller] call _condition;
                _canAccess;
            })
        ];
    };
    case "HOLD": {
        [
            _object,
            _actionName,
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
            toString ({
                params ["_target", "_caller"];

                _condition = (_target getVariable ["tis_tfar_jammer_deactivation_condition", {}]);
                private _canAccess = [_target, _caller] call _condition;
                _canAccess;
            }),
            toString ({
                params ["_target", "_caller"];

                _condition = (_target getVariable ["tis_tfar_jammer_deactivation_condition", {}]);
                private _canAccess = [_target, _caller] call _condition;
                _canAccess;
            }),
            {},
            {},
            {
                params ["_target", "_caller", "_actionId", "_arguments"]; // same as codeStart
                [QGVAR(requestJammerDeactivation), [_target, _caller]] call CBA_fnc_globalEvent;
                [_target, _caller] call (_arguments select 0);
            },
            {},
            [_onDeactivationCode], 
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
        diag_log "[TIS-MAIN][Jammer][DeactivateAction] ACE 3 is not loaded";
        hint "[TIS-MAIN][Jammer][DeactivateAction]: ACE 3 not loaded";
    };

    TRACE_1("_object",_object);

    // Create ACE action
    if (not ((_object getVariable ["tis_tfar_jammer_parent_action_initialized", false]))) then {
        _jammerParentAction = ["tis_tfar_jammer", "Jammer", "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
        [_object, 0, ["ACE_MainActions"], _jammerParentAction] call ace_interact_menu_fnc_addActionToObject;
        _object setVariable ["tis_tfar_jammer_parent_action_initialized", true];
    };

    _jammerDeactivateAction = ["tis_tfar_jammer", _actionName, "",
    {
        params ["_target", "_player", "_arguments"];
        [QGVAR(requestJammerDeactivation), [_target, _player]] call CBA_fnc_globalEvent;
        [_target, _player] call (_arguments select 0);

    }, {
        params ["_target", "_player", "_arguments"];
        private _condition = (_arguments select 1);
        private _canInvoke = call _condition;
        _canInvoke;
    }, {}, [_onDeactivationCode, _condition]] call ace_interact_menu_fnc_createAction;

    [_object, 0, ["ACE_MainActions", "tis_tfar_jammer"], _jammerDeactivateAction] call ace_interact_menu_fnc_addActionToObject;
};
