#include "script_component.hpp"

ADDON = false;

#include "cba_settings.inc.sqf"
#include "XEH_PREP.hpp"

if (hasInterface) then {
    
    // Passed args ["_jammersHashMap"];
    [QGVAR(TfarJammersClientSyncEvent), {
        params ["_jammers"];
        TRACE_1("_jammers",_jammers);
        [_jammers] call FUNC(jammersSyncClient);
    }] call CBA_fnc_addEventHandler;  
};

ADDON = true;
