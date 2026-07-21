class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class Default;
        class AttributesBase;
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
        displayName = "Countdown Timer";
        function = QFUNC(moduleCountdownTimer);
        isTriggerActivated = 1; // 1 = only starts when synced to and triggered by a Trigger module;
                                 // set to 0 to have it start immediately at mission start instead

        class Arguments: AttributesBase {
            class Duration {
                displayName = "Duration (seconds)";
                tooltip = "How long the countdown runs before ending";
                property = QGVAR(edenModuleTimerProperty_Duration);
                control = "Edit";
                typeName = "NUMBER";
                class Attributes {};
                defaultValue = "60";
            };
            class Context {
                displayName = "Context Label";
                tooltip = "Shown on the countdown display, and passed to your logic dispatch functions";
                property = QGVAR(edenModuleTimerProperty_Context);
                control = "Edit";
                typeName = "STRING";
                class Attributes {};
                defaultValue = "";
            };
            class TimerId {
                displayName = "Timer ID (optional)";
                tooltip = "Unique ID for this timer. Leave blank to auto-generate one from the module itself";
                property = QGVAR(edenModuleTimerProperty_Id);
                control = "Edit";
                typeName = "STRING";
                class Attributes {};
                defaultValue = "";
            };
            class TargetSide {
                displayName = "Restrict to Side";
                tooltip = "Only players on this side see the countdown (combined with any synced units/groups below)";
                property = QGVAR(edenModuleTimerProperty_Side);
                control = "Combo";
                typeName = "STRING";
                class Attributes {};
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
            class IncludeGroups {
                displayName = "Sync = Whole Group";
                tooltip = "If enabled, syncing a single unit makes its entire group a target, not just that unit";
                property = QGVAR(edenModuleTimerProperty_IncludeGroups);
                control = "Checkbox";
                typeName = "BOOL";
                class Attributes {};
                defaultValue = "0";
            };
            class OnStartFunction: Default {
                property = QEGVAR(main,edenModulePropertyCommon_OnStartCode);
                displayName = "Code on start";
                tooltip = CSTRING(OnStartCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class OnProgressFunction: Default {
                property = QEGVAR(main,edenModulePropertyCommon_OnProgressCode);
                displayName = CSTRING(OnProgressCodeLabel);
                tooltip = CSTRING(OnProgressCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class OnCompleteFunction: Default {
                property = QGVAR(edenModulePropertyCommon_OnCompleteCode);
                displayName = CSTRING(OnCompleteCodeLabel);
                tooltip = CSTRING(OnCompleteCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
        };

        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_CountdownTimer_Description);
        };
    };
};
