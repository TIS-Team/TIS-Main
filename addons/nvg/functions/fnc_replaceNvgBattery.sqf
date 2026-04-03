#include "script_component.hpp"

params ["_player", ["_removeBattery", true, [false]]];

private _batteryItems = GVAR(BatteryItemsArray);
private _foundBatteryItem = "";
{
	private _batteryItem = _x;
	private _hasItem = [_player, _batteryItem] call BIS_fnc_hasItem;
	if (_hasItem) then {
        _foundBatteryItem = _batteryItem;
		break;
	};

} forEach _batteryItems;


if (_removeBattery) then {
    [_player, _foundBatteryItem] call CBA_fnc_removeItem;
};

[_player, NvgBatteryMaxLifepoints] call FUNC(doRefillBattery);
