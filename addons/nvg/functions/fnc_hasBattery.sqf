#include "script_component.hpp"

params ["_player"];

private _batteryItems = GVAR(BatteryItemsArray);
private _foundBatteryItem = false;
{
	private _batteryItem = _x;
	_foundBatteryItem = [_player, _batteryItem] call BIS_fnc_hasItem;
	if (_foundBatteryItem) then {
		break;
	};

} forEach _batteryItems;

_foundBatteryItem;
