class CfgVehicles 
{
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class checkNvgBatteries {
                    displayName = ECSTRING(nvg,checkNvgBattery);
                    condition = QUOTE([_player] call EFUNC(nvg,hasNvg));
                    statement = QUOTE([_player] call EFUNC(nvg,checkNvgBatteryLife));
                };

                class replaceNvgBattery {
                    displayName = ECSTRING(nvg,replaceNvgBattery);
                    condition = QUOTE([_player] call EFUNC(nvg,hasBattery));
                    statement = QUOTE([ARR_2(_player,EGVAR(nvg,ShouldRemoveBatteryItemOnReplacement))] call EFUNC(nvg,replaceNvgBattery));
                };
            };
        };
    };
};
