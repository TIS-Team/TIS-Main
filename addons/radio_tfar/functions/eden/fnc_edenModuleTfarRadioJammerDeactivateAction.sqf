#include "..\script_component.hpp"

if (!hasInterface) exitWith {};

params [
	["_logic", objNull, [objNull]],		
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!_activated) exitWith {};

private _synchronizedObjects = synchronizedObjects _logic;

private _actionType = _logic getVariable ["ActionType", "SCROLL"]; // SCROLL, HOLD, NONE
private _actionName = _logic getVariable ["ActionName", "Deactive Jammer"];
private _actionTime = _logic getVariable ["ActionTime", 4]; // Only valid for HOLD action
private _shouldCreateAceAction = _logic getVariable ["ShouldCreateAceAction", false]; // TRUE/FALSE
private _requiredItem = _logic getVariable ["RequiredItem", ""];
private _shouldRemoveRequiredItem = _logic getVariable ["ShouldRemoveRequiredItem", false];
private _hideActionOnSuccess = _logic getVariable ["ShouldHideActionAfterUse", false];
private _onDeactivationCode = compile (_logic getVariable ["OnDeactivationCode", {}]);

private _syncedTriggers = _synchronizedObjects select { _x isKindOf "EmptyDetector" };
private _connectedObjects = _synchronizedObjects select { not (_x isKindOf "EmptyDetector") };

private _deactiveJammerActionFunction = {
	_this call FUNC(tfarRadioJammerDeactivateAction);
};

{
	private _params = [
		_x, 
		_actionType, 
		_actionName, 
		_actionTime, 
		_shouldCreateAceAction, 
		_requiredItem,
		_shouldRemoveRequiredItem,
		_hideActionOnSuccess,
		_onDeactivationCode
	];
	if (_syncedTriggers isNotEqualTo []) then {
		{
			private _trigger = _x;
			// Trigger based init
			[
				_trigger,
				_params,
				_deactiveJammerActionFunction
			] spawn {
				params [
					"_trigger",
					"_params",
					"_deactiveJammerActionFunction"
				];

        		waitUntil { sleep 1; triggerActivated _trigger };

				_params call _deactiveJammerActionFunction;
			};
		} forEach _syncedTriggers;
	} else {
		// Regular init (no trigger)

		_params call _deactiveJammerActionFunction;
	};
} forEach _connectedObjects;

