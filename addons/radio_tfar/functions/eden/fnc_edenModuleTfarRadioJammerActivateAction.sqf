#include "..\script_component.hpp"

if (!hasInterface) exitWith {};

params [
	["_logic", objNull, [objNull]],		
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!_activated) exitWith {};

private _synchronizedObjects = synchronizedObjects _logic;
if (_synchronizedObjects isEqualTo []) exitWith {};

private _jammerVariableString = _logic getVariable ["JammerVariable", ""];
private _targetJammer = missionNamespace getVariable [_jammerVariableString, objNull];

private _jammerRadius = _logic getVariable ["Radius", 1000];
private _jammerStrength = _logic getVariable ["Strength", 50];
private _jammerSideString = _logic getVariable ["TargetSide", 'sideUnknown'];

private _jammerSide = [_jammerSideString] call EFUNC(main,sideFromStringResolver);

private _actionType = _logic getVariable ["ActionType", "SCROLL"]; // SCROLL, HOLD, NONE
private _actionName = _logic getVariable ["ActionName", "Activate Jammer"];
private _actionTime = _logic getVariable ["ActionTime", 4]; // Only valid for HOLD action
private _shouldCreateAceAction = _logic getVariable ["ShouldCreateAceAction", false]; // TRUE/FALSE
private _condition = compile (_logic getVariable ["Condition", "{true}"]);
private _hideOnUse = _logic getVariable ["ShouldHideActionAfterUse", false];
private _onActivationCode = compile (_logic getVariable ["OnActivationCode", "{}"]);

private _syncedTriggers = _synchronizedObjects select { _x isKindOf "EmptyDetector" };
private _connectedObjects = _synchronizedObjects select { not (_x isKindOf "EmptyDetector") };

private _activateJammerActionFunction = {
	_this call FUNC(initJammerActivateAction);
};

{
	private _params = [
		_x, 
		_targetJammer,
		_jammerRadius,
		_jammerStrength,
		_jammerSide,
		_actionType, 
		_actionName, 
		_actionTime, 
		_shouldCreateAceAction, 
		_condition,
		_hideOnUse,
		_onActivationCode
	];
	if (_syncedTriggers isNotEqualTo []) then {
		{
			private _trigger = _x;
			// Trigger based init
			[
				_trigger,
				_params,
				_activateJammerActionFunction
			] spawn {
				params [
					"_trigger",
					"_params",
					"_activateJammerActionFunction"
				];

        		waitUntil { sleep 1; triggerActivated _trigger };

				_params call _activateJammerActionFunction;
			};
		} forEach _syncedTriggers;
	} else {
		// Regular init (no trigger)
		_params call _activateJammerActionFunction;
	};
} forEach _connectedObjects;

