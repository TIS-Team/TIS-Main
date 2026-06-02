#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for handling item removal caused by Fire Support Plus EMP Explosion.

	Parameter(s):
		0: OBJECT - the unit
		1: STRING - radio item class name

	Example:
        [_player, "TFAR_anprc152"] call tis_main_compat_fire_support_plus_fnc_handleEmpTisItemRemoval;
*/

params ["_unit", "_radioClassName"];

if(not (GVAR(AddBrokenItemVariantOnFireSupportEmpExplosion))) exitWith {};

if ("TFAR_anprc152" isEqualTo _radioClassName) then {
    [_unit, "TIS_Anprc_152_Broken_Radio"] call CBA_fnc_addItem;
};
