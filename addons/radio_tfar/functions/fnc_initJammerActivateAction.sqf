#include "script_component.hpp"

params [
    ["_object"],
    ["_jammerRadius", 1000, [0]],
    ["_jammerStrength", 50, [0]],
    ["_jammerSide", sideUnknown, [sideUnknown]],
    ["_actionType", "SCROLL", ['string']], // SCROLL, HOLD, NONE
    ["_actionName", "Activate Jammer", ["string"]], 
    ["_actionTime", 5, [5]], // Only valid for HOLD action
    ["_shouldCreateAceAction", false, [true]], // TRUE/FALSE
    ["_condition", "{}", ["string"]], 
        // Passed Args (same as BI addAction):
        // _target: Object - The object to which action is attached or, if the object is a unit inside of vehicle, the vehicle
        // _caller: Object - Caller person to whom the action is shown (or not shown if condition returns false)
        // _actionId: Number - checked action's ID (same as addAction's return value)
        // _arguments: ARRAY - arguments

    ["_hideActionOnUse", false, [true]], 
    ["_onActivationCode", {}, [{}]],
    ["_global", true, [true]]
];

// Code for server + future players
if (isServer && {_global && {isMultiplayer && {isNil {_object getVariable QGVAR(initTfarRadioJammerActivateAction_JIP)}}}}) exitWith {

    private _id = [QGVAR(initTfarRadioJammerActivateActionEvent), [_object, _jammerRadius, _jammerStrength, _jammerSide, _actionType, _actionName, _actionTime, _shouldCreateAceAction, _condition, _hideActionOnUse, _onActivationCode, false]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _object] call CBA_fnc_removeGlobalEventJIP;

    _object setVariable [QGVAR(initTfarRadioJammerActivateAction_JIP), _id, true];
};

if (!hasInterface) exitWith {};

switch (_actionType) do {
    case "SCROLL": {
        _object addAction [
            _actionName,
            {
                params ["_target", "_caller", "_actionId", "_arguments"];
                _arguments params ["_radius", "_strength", "_side"];
                [QGVAR(requestJammerActivation), [_target, _caller, _radius, _strength, _side]] call CBA_fnc_globalEvent;
            },
            [_jammerRadius, _jammerStrength, _jammerSide],
            1.5,
            true,
            _hideActionOnUse,
            "",
            compile _condition
        ];
    };
    case "HOLD": {
        [
            _object,
            _actionName,
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa", 
            "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
            _condition, 
            _condition,
            {},
            {},
            {
                params ["_target", "_caller", "_actionId", "_arguments"]; // same as codeStart
                _arguments params ["_radius", "_strength", "_side"];
                [QGVAR(requestJammerActivation), [_target, _caller, _radius, _strength, _side]] call CBA_fnc_globalEvent;
            },
            {},
            [_jammerRadius, _jammerStrength, _jammerSide], 
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
    if (not ((_object getVariable ["tis_tfar_jammer_parent_action_initialized", false]))) then {
        _jammerParentAction = ["tis_tfar_jammer", "Jammer", "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
        [_object, 0, ["ACE_MainActions"], _jammerParentAction] call ace_interact_menu_fnc_addActionToObject;
        _object setVariable ["tis_tfar_jammer_parent_action_initialized", true];
    };

    _jammerActivateAction = ["tis_tfar_jammer", _actionName, "",
    {
        params ["_target", "_player", "_actionParams"];
        _actionParams params ["_radius", "_strength", "_side"];
        [QGVAR(requestJammerActivation), [_target, _player, _radius, _strength, _side]] call CBA_fnc_globalEvent;

    }, {true}, {}, [_jammerRadius, _jammerStrength, _jammerSide]] call ace_interact_menu_fnc_createAction;

    [_object, 0, ["ACE_MainActions", "tis_tfar_jammer"], _jammerActivateAction] call ace_interact_menu_fnc_addActionToObject;
};
