#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_object"];

private _jammersMap = GVAR(TfarJammers);
private _sides = keys _jammersMap;

{
	private _side = _x;

	private _sideJammers = _jammersMap get _side;
	private _index = _sideJammers findIf { _x isEqualTo _object };
	if (_index != -1) then {
		_sideJammers deleteAt _index;
	};

} forEach _sides;
