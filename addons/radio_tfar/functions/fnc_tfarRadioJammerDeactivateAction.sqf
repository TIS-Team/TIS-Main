#include "script_component.hpp"

params [
    ["_object"],
    ["_actionType", "SCROLL", ['string']], // SCROLL, HOLD, NONE
    ["_actionName", "Deactivate Jammer", ["string"]], 
    ["_actionTime", 5, [5]], // Only valid for HOLD action
    ["_shouldCreateAceAction", false, [true]], // TRUE/FALSE
    ["_condition", "{}", ["string"]], 
        // Passed Args (same as BI addAction):
        // _target: Object - The object to which action is attached or, if the object is a unit inside of vehicle, the vehicle
        // _this: Object - Caller person to whom the action is shown (or not shown if condition returns false)
        // _originalTarget: Object - The original object to which the action is attached, regardless if the object/unit is in a vehicle or not
        // _actionId: Number - checked action's ID (same as addAction's return value)

    ["_hideActionOnUse", false, [true]], 
    ["_onDeactivationCode", {}, [{}]],
    ["_global", true, [true]]
];

// Code for server + future players
if (isServer && {_global && {isMultiplayer && {isNil {_object getVariable QGVAR(initTfarRadioJammerDeactivateAction_JIP)}}}}) exitWith {

    private _id = [QGVAR(initTfarRadioJammerDeactivateActionEvent), [_object, _actionType, _actionName, _actionTime, _shouldCreateAceAction, _condition, _hideActionOnUse, _onDeactivationCode]] call CBA_fnc_globalEventJIP;

    // Remove JIP EH if object is deleted
    [_id, _object] call CBA_fnc_removeGlobalEventJIP;

    _object setVariable [QGVAR(initTfarRadioJammerDeactivateAction_JIP), _id, true];
};

if (!hasInterface) exitWith {};

if (_actionType isEqualTo "SCROLL") then {

};

if(EGVAR(main,isAceInteractionMenuLoaded)) then {
    // Create ACE action
};
