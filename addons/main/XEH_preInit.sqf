#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"
#include "cba_settings.inc.sqf"

GVAR(isAceArsenalLoaded) = isClass (configFile >> "CfgPatches" >> "ace_arsenal");
GVAR(isAceInteractionMenuLoaded) = isClass (configFile >> "CfgPatches" >> "ace_interact_menu");
GVAR(isWbkZombiesLoaded) = isClass (configFile >> "CfgPatches" >> "WBK_ZombieCreatures");
GVAR(isIMSLoaded) = isClass (configFile >> "CfgPatches" >> "WBK_MeleeMechanics");

ADDON = true;
