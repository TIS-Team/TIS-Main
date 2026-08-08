[
    QGVAR(TFARJammersUpdateInterval),
    "SLIDER",
    [LLSTRING(SETTING_TFARJammersUpdateInterval), LLSTRING(TFARJammersUpdateIntervalTooltip)],
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Tfar)],
    [0.1, 30, 5, 1],
    true,
    {},
    true
] call CBA_fnc_addSetting;
