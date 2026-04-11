class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Edit;
            class Checkbox;
            class ModuleDescription;
        };
        class ModuleDescription;
    };

    // Base module
    class GVAR(baseEdenModule): Module_F {
        author = ECSTRING(main,TISTeam);
        category = QGVAR(TIS_MAIN);
        function = QFUNC(emptyFunction);
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 0;
        scope = 0; // 2 for EDEN and Zeus, 1 for Zeus.
        scopeCurator = 0; // 0 hidden from Zeus
    };

    ///////////////////////////////////////////////////////////////////////////////////
    //EDEN Modules

    class GVAR(edenModuleDataDownload): GVAR(baseEdenModule) {
        displayName = ECSTRING(main,Module_DataDownload_DisplayName);
        function = QFUNC(edenModuleDataDownload);
        scope = 2;
        class Attributes: AttributesBase {
            class ActionName: Edit {
                property = QGVAR(edenModuleDataDownload_ActionName);
                displayName = ECSTRING(main,ActionName);
                typeName = "STRING";
                defaultValue = "'Download data'";
            };
            class Speed: Edit {
                property = QGVAR(edenModuleDataDownload_Speed);
                displayName = ECSTRING(main,DownloadSpeedLabel);
                tooltip = CSTRING(DownloadSpeedTooltip);
                typeName = "NUMBER";
                defaultValue = "1.0";
            };
            class ConsiderCallerDistance: Checkbox {
                property = QGVAR(edenModuleDataDownload_ConsiderCallerDistance);
                displayName = ECSTRING(main,ConsiderCallerDistanceLabel);
                typeName = "BOOL";
                defaultValue = "false";
            };
            class RequiredItem: Edit {
                property = QGVAR(edenModuleDataDownload_RequiredItem);
                displayName = ECSTRING(main,RequiredItem);
                typeName = "STRING";
                defaultValue = "''";
            };
            class OnStartFunction: Default {
                property = QGVAR(edenModulePropertyCommon_OnStartCode);
                displayName = CSTRING(OnStartCodeLabel);
                tooltip = CSTRING(OnStartCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class OnProgressFunction: Default {
                property = QGVAR(edenModulePropertyCommon_OnProgressCode);
                displayName = CSTRING(OnProgressCodeLabel);
                tooltip = CSTRING(OnProgressCodeTooltip);
                typeName = "STRING";
                defaultValue = "''";
                control = "editcodemulti5";
            };
            class OnConnectionLostFunction: Default {
                property = QGVAR(edenModulePropertyCommon_OnConnectionLostCode);
                displayName = CSTRING(OnConnectionLostCodeLabel);
                tooltip = CSTRING(OnConnectionLostCodeTooltip);
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
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_DataDownload_Description);
        };
    };
};
