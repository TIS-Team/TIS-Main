class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Edit;
            class Checkbox;
            class ModuleDescription;
        };
        class ModuleDescription;
    };

    // Base module
    class GVAR(baseEdenModule): Module_F {
        author = ECSTRING(main,TISTeam);
        category = QGVAR(TIS_EDEN);
        function = QFUNC(emptyFunction);
        functionPriority = 1;
        isGlobal = 0;
        isTriggerActivated = 0;
        scope = 0; // 2 for EDEN and Zeus, 1 for Zeus.
        scopeCurator = 0; // 0 hidden from Zeus
    };

    ///////////////////////////////////////////////////////////////////////////////////
    //EDEN Modules

    class GVAR(edenModuleTfarRadioJammers): GVAR(baseEdenModule) {
        displayName = CSTRING(Module_TfarRadioJammers_DisplayName);
        function = QFUNC(tfarRadioJammer);
        scope = 2;
        class Attributes: AttributesBase {
            class Radius: Edit {
                property = QGVAR(edenModuleTfarRadioJammers_Radius);
                displayName = ECSTRING(main,RadiusLabel);
                tooltip = ECSTRING(main,RadiusTooltip);
                typeName = "NUMBER";
                defaultValue = "1.0";
            };
            class Strength: Edit {
                property = QGVAR(edenModuleTfarRadioJammers_Strength);
                displayName = ECSTRING(main,StrengthLabel);
                typeName = "NUMBER";
                defaultValue = "1.0";
            };
            class Debug: Checkbox {
                property = QGVAR(edenModuleTfarRadioJammers_Debug);
                displayName = ECSTRING(main,DebugLabel);
                typeName = "BOOL";
                defaultValue = "false";
            };
            class ModuleDescription: ModuleDescription {};
        };
        class ModuleDescription: ModuleDescription {
            description = CSTRING(Module_TfarRadioJammers_Description);
        };
    };
