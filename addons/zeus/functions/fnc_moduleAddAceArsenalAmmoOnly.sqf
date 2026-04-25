#include "script_component.hpp"

/*
 * Author: Aquerr (Nerdi)
 * Creates ACE Arsenal on given object with ammo only.
 *
 * 0: The module logic <OBJECT>
 * 1: Synchronized units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC, [], true] call tis_main_zeus_fnc_moduleAddAceArsenalAmmoOnly;
 *
 */

 params [["_logic", objNull, [objNull]]];

if (!local _logic) exitWith {};

(GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];
if (_mouseOverType != "OBJECT") then {
    [LLSTRING(MustSelectObject)] call FUNC(showZeusFeedbackMessage);
} else {
    _object = _mouseOverUnit;
	[LLSTRING(CreatedAceArsenal)] call FUNC(showZeusFeedbackMessage);
	private _maganizeTypes = [16, 256, 512, 768];
	private _magaznieClasses = "true" configClasses (configFile >> "CfgMagazines");
	private _filteredClasses = (_magaznieClasses select { (getNumber (_x >> "type")) in _maganizeTypes }) apply { configName _x };
	[_object, _filteredClasses, true] call ace_arsenal_fnc_initBox;
};

deleteVehicle _logic;
