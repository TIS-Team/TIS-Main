[
    QGVAR(TFARJammersUpdateInterval),
    "SLIDER",
    LLSTRING(SETTING_TFARJammersUpdateInterval),
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Tfar)],
    [0.01, 30, 5, 2, 0],
    true,
    {},
    true
] call CBA_fnc_addSetting;
