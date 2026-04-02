[
    QGVAR(SaveAceLoadoutOnArsenalClose),
    "CHECKBOX",
    LLSTRING(SETTING_SaveAceLoadoutOnArsenalClose),
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Loadout)],
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(RestoreAceLoadoutOnRespawn),
    "CHECKBOX",
    LLSTRING(SETTING_RestoreAceLoadoutOnRespawn),
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Loadout)],
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(SaveVanillaLoadoutOnArsenalClose),
    "CHECKBOX",
    LLSTRING(SETTING_SaveVanillaLoadoutOnArsenalClose),
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Loadout)],
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(RestoreVanillaLoadoutOnRespawn),
    "CHECKBOX",
    LLSTRING(SETTING_RestoreVanillaLoadoutOnRespawn),
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Loadout)],
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(AddSaveAndResetLoadoutActionsToArsenal),
    "CHECKBOX",
    LLSTRING(SETTING_AddSaveAndResetLoadoutActionToArsenal),
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Loadout)],
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;

