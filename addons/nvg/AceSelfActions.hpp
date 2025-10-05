class CfgVehicles 
{
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class checkNvgBatteries {
                    displayName = CSTRING(checkNvgBattery);
                    condition = QUOTE([_player] call FUNC(hasNvg));
                    statement = QUOTE([_player] call FUNC(checkNvgBatteryLife));
                };

                class replaceNvgBattery {
                    displayName = CSTRING(replaceNvgBattery);
                    condition = QUOTE([_player] call FUNC(hasBattery));
                    statement = QUOTE([_player] call FUNC(replaceNvgBattery));
                };
            };
        };
    };
};
