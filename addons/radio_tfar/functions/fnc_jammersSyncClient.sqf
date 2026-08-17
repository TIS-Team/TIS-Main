#include "script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Function for setting the jammers hashmap as new client jammers. Client only.

	Parameter(s):
		0: HASHMAP - the hashmap containin jammers 

	Example:
        [_side] call tis_main_radio_tfar_jammersSyncClient;
*/

if (!hasInterface) exitWith {};

params ["_jammers"];

if (isNil "_jammers" || {_jammers isEqualTo (createHashMap)}) exitWith {};

// Overwrite
GVAR(TfarJammersClient) = _jammers;
