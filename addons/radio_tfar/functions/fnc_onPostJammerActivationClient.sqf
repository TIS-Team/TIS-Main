#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Adds the given jammer on the client side. Client only.

	Parameter(s):
		0: OBJECt - the jammer
        1: UNIT - who activated the jammer

	Example:
        [_side] call tis_main_radio_tfar_onPostJammerActivationClient;

    Public API: No 
*/

if (!hasInterface) exitWith {};

params ["_jammer", "_unit"];

