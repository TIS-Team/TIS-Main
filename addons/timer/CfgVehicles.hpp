class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Edit;
            class Combo;
            class Checkbox;
            class ModuleDescription;
        };
        class ModuleDescription;
    };

    class GVAR(baseEdenModule): Module_F {
        author = ECSTRING(main,TISTeam);
        category = QEGVAR(main,TIS_MAIN);
        function = QEFUNC(main,emptyFunction);
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 0;
        scope = 0; // 2 for EDEN and Zeus, 1 for Zeus.
        scopeCurator = 0; // 0 hidden from Zeus
    };

    class GVAR(edenModuleCountdownTimer): GVAR(baseEdenModule) {
        scope = 2;
        category = QEGVAR(main,TIS_MAIN);
        displayName = CSTRING(Module_CountdownTimer_DisplayName);
        function = QFUNC(moduleCountdownTimer);
        isTriggerActivated = 1; // 1 = only starts when synced to and triggered by a Trigger module;
                                 // set to 0 to have it start immediately at mission start instead

        class Arguments: AttributesBase {
            class Duration: Edit {
                displayName = CSTRING(edenModuleCountdownTimer_Duration);
                tooltip = CSTRING(edenModuleCountdownTimer_Duration_Tooltip);
                property = QGVAR(edenModuleTimerProperty_Duration);
                typeName = "NUMBER";
                defaultValue = "60";
            };
            class Context: Edit {
                displayName = CSTRING(edenModuleCountdownTimer_ContextLabel);
                tooltip = CSTRING(edenModuleCountdownTimer_ContextLabel_Tooltip);
                property = QGVAR(edenModuleTimerProperty_Context);
                typeName = "STRING";
                defaultValue = "";
            };
            class TargetSide: Combo {
                displayName = CSTRING(edenModuleCountdownTimer_TargetSide);
                tooltip = CSTRING(edenModuleCountdownTimer_TargetSide_Tooltip);
                property = QGVAR(edenModuleTimerProperty_Side);
                typeName = "STRING";
                class values {
                    class All {
                        name = "All Sides";
                        value = "ALL";
                        default = 1;
                    };
                    class West {
                        name = "West";
                        value = "WEST";
                    };
                    class East {
                        name = "East";
                        value = "EAST";
                    };
                    class Independent {
                        name = "Independent";
                        value = "INDEPENDENT";
                    };
                    class Civilian {
                        name = "Civilian";
                        value = "CIVILIAN";
                    };
                };
            };
            class IncludeGroups: Checkbox {
                displayName = CSTRING(edenModuleCountdownTimer_IncludeGroups);
                tooltip = CSTRING(edenModuleCountdownTimer_IncludeGroups_Tooltip);
                property = QGVAR(edenModuleTimerProperty_IncludeGroups);
                typeName = "BOOL";
                defaultValue = "false";
            };
            class OnStartFunction: Default {
                property = QEGVAR(main,edenModulePropertyCommon_OnStartCode);
                displayName = CSTRING(edenModuleCountdownTimer_OnStartCode);
                tooltip = CSTRING(OnStartCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class OnProgressFunction: Default {
                property = QEGVAR(main,edenModulePropertyCommon_OnProgressCode);
                displayName = CSTRING(edenModuleCountdownTimer_OnProgressCode);
                tooltip = CSTRING(OnProgressCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class OnCompleteFunction: Default {
                property = QGVAR(edenModulePropertyCommon_OnCompleteCode);
                displayName = CSTRING(edenModuleCountdownTimer_OnCompleteCode);
                tooltip = CSTRING(OnCompleteCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_CountdownTimer_Description);
        };
    };
};
