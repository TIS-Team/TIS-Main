[
    QGVAR(SaveAndReplaceAceLoadout),
    "CHECKBOX",
    LLSTRING(SETTING_SaveAndReplaceAceLoaduout),
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Loadout)],
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(SaveAndReplaceVanillaLoadout),
    "CHECKBOX",
    LLSTRING(SETTING_SaveAndReplaceVanillaLoaduout),
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Loadout)],
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;
