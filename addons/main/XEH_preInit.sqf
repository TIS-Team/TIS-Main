#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"
// #include "cba_settings.inc.sqf"

GVAR(isAceInteractionMenuLoaded) = isClass (configFile >> "CfgPatches" >> "ace_interact_menu");
GVAR(isWbkZombiesLoaded) = isClass (configFile >> "CfgPatches" >> "WBK_ZombieCreatures");

ADDON = true;
