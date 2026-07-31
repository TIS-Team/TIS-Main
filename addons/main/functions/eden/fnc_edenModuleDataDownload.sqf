#include "..\script_component.hpp"

params [
	["_logic", objNull, [objNull]],		
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!_activated) exitWith {};

private _synchronizedObjects = synchronizedObjects _logic;

private _actionName = _logic getVariable ["ActionName", "Data download"];
private _speed = _logic getVariable ["Speed", 1.0];
private _considerCallerDistance = _logic getVariable ["ConsiderCallerDistance", false];
private _requiredItem = _logic getVariable ["RequiredItem", ""];
private _displayBuiltInHintMessages = _logic getVariable ["DisplayBuiltInHintMessages", true];
private _onStartFunction = compile (_logic getVariable ["OnStartFunction", ""]);
private _onProgressFunction = compile (_logic getVariable ["OnProgressFunction", ""]);
private _onConnectionLostFunction = compile (_logic getVariable ["OnConnectionLostFunction", ""]);
private _onCompleteFunction = compile (_logic getVariable ["OnCompleteFunction", ""]);

private _syncedTriggers = _synchronizedObjects select { _x isKindOf "EmptyDetector" };
private _connectedObjects = _synchronizedObjects select { not (_x isKindOf "EmptyDetector") };

private _initDataDownloadFunction = {
	_this call EFUNC(main,initDataDownload);
};

{
	private _params = [
		_x, 
		_actionName, 
		_speed, 
		_considerCallerDistance, 
		_requiredItem, 
		_displayBuiltInHintMessages,
		_onStartFunction, 
		_onProgressFunction,
		_onConnectionLostFunction, 
		_onCompleteFunction
	];
	if (_syncedTriggers isNotEqualTo []) then {
		{
			private _trigger = _x;
			// Trigger based init
			[
				_trigger,
				_params,
				_initDataDownloadFunction
			] spawn {
				params [
					"_trigger",
					"_params",
					"_initDataDownloadFunction"
				];

        		waitUntil { sleep 1; triggerActivated _trigger };

				_params call _initDataDownloadFunction;
			};
		} forEach _syncedTriggers;
	} else {
		// Regular init (no trigger)

		_params call _initDataDownloadFunction;
	};
} forEach _connectedObjects;
