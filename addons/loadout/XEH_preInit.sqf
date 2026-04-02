#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"
#include "cba_settings.inc.sqf"

ADDON = true;


if (hasInterface) then {
	
	// TIS custom ace arsenal box actions
	if (EGVAR(main,isAceArsenalLoaded)) then {
		["ace_arsenal_boxInitialized", {
			params ["_arsenalBox", "_items"];
			if (GVAR(AddSaveAndResetLoadoutActionsToArsenal) && {not (_arsenalBox getVariable ["tis_ace_arsenal_actions_added", false])}) then {
				_arsenalBox addAction [
					format ["<t color='#FFaa00'>%1</t>", "Save respawn loadout"],
					{
						player setVariable [QGVAR(SavedLoadout), getUnitLoadout player];
						hint LLSTRING(RespawnLoadoutSaved);
					}
				];
				_arsenalBox addAction [
					format ["<t color='#FFaa00'>%1</t>", "Reset respawn loadout"],
					{
						player setVariable [QGVAR(SavedLoadout), []];
						hint LLSTRING(RespawnLoadoutReset);
					}
				];
				_arsenalBox setVariable ["tis_ace_arsenal_actions_added", true];
			};
		}] call CBA_fnc_addEventHandler;
	};
};
