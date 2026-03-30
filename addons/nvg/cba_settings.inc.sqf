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

[
    QGVAR(BatteryItemsSetting),
    "EDITBOX",
    [LLSTRING(SETTING_BatteryItems), LLSTRING(SETTING_BatteryItemsTooltip)],
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Nvg)],
    "['ACE_UAVBattery']",
    true,
    {
        GVAR(BatteryItemsArray) = parseSimpleArray GVAR(BatteryItemsSetting);
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(ShouldRemoveBatteryItemOnReplacement),
    "CHECKBOX",
    [LLSTRING(SETTING_ShouldRemoveBatteryItemOnReplacement), LLSTRING(SETTING_ShouldRemoveBatteryItemOnReplacementTooltip)],
    [TIS_MAIN_SETTINGS_CAT, LSTRING(SubCategory_Nvg)],
    true,
    true,
    {},
    false
] call CBA_fnc_addSetting;
