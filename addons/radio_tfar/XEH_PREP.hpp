PREP(radioJammers);
PREP(initJammerDeactivateAction);
PREP(initJammerActivateAction);
PREP(jammerDoDeactivate);
PREP(jammerDoActivate);
PREP(getJammersForSide);
PREP(jammersSyncClient);
PREP(isJammerActive);
PREP(onPostJammerActivationClient);
PREP(onPostJammerDeactivationClient);

// Eden
PREP_BY_PATH(edenModuleTfarRadioJammers,functions\eden\fnc_edenModuleTfarRadioJammers.sqf);
PREP_BY_PATH(edenModuleTfarRadioJammerDeactivateAction,functions\eden\fnc_edenModuleTfarRadioJammerDeactivateAction.sqf);
PREP_BY_PATH(edenModuleTfarRadioJammerActivateAction,functions\eden\fnc_edenModuleTfarRadioJammerActivateAction.sqf);
