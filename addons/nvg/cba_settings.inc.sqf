[
    QGVAR(BatteryPowerConsumption),
    "CHECKBOX",
    LLSTRING(SETTING_BatteryPowerConsumption),
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Nvg)],
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(PowerConsumptionSpeed),
    "SLIDER",
    [LLSTRING(PowerConsumptionSpeed), LLSTRING(PowerConsumptionSpeedTooltip)],
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Nvg)],
    [1, 100, 7, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;
