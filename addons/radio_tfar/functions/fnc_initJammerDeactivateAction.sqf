#include "script_component.hpp"

params [
    ["_object"],
    ["_actionType", "SCROLL", ['string']], // SCROLL, HOLD, NONE
    ["_actionName", "Deactivate Jammer", ["string"]], 
    ["_actionTime", 5, [5]], // Only valid for HOLD action
    ["_shouldCreateAceAction", false, [true]], // TRUE/FALSE
    ["_condition", {}, [{}]], 
        // Passed Args (same as BI addAction):
        // _target: Object - The object to which action is attached or, if the object is a unit inside of vehicle, the vehicle
        // _caller: Object - Caller person to whom the action is shown (or not shown if condition returns false)
        // _actionId: Number - checked action's ID (same as addAction's return value)
        // _arguments: ARRAY - arguments

    ["_hideActionOnUse", false, [true]], 
    ["_onDeactivationCode", {}, [{}]],
    ["_global", true, [true]]
];

// Code for server + future players
if (isServer && {_global && {isMultiplayer && {isNil {_object getVariable QGVAR(initTfarRadioJammerDeactivateAction_JIP)}}}}) exitWith {

    private _id = [QGVAR(initTfarRadioJammerDeactivateActionEvent), [_object, _actionType, _actionName, _actionTime, _shouldCreateAceAction, _condition, _hideActionOnUse, _onDeactivationCode, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _object] call CBA_fnc_removeGlobalEventJIP;

    _object setVariable [QGVAR(initTfarRadioJammerDeactivateAction_JIP), _id, true];
};

if (!hasInterface) exitWith {};

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
            _condition //To put as object variable and reference it later so that we have full control over passed parameters.
        ];
    };
    case "HOLD": {
        [
            _object,
            _actionName,
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
            toString _condition, //To put as object variable and reference it later so that we have full control over passed parameters.
            toString _condition, //To put as object variable and reference it later so that we have full control over passed parameters.
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
