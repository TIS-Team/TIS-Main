if (!isServer) exitWith {};

params ["_object"];

private _index = tisTfarJammers findIf { _x isEqualTo _object };
if (_index != -1) then {
	tisTfarJammers deleteAt _index;
};
