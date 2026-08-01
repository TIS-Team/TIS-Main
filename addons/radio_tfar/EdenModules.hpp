class Logic;
class Module_F: Logic {
    class AttributesBase {
        class Edit;
        class Checkbox;
        class Default;
        class Combo;
        class ModuleDescription;
    };
    class ModuleDescription;
};

// Base module
class GVAR(baseEdenModule): Module_F {
    author = ECSTRING(main,TISTeam);
    category = QGVAR(TIS_TFAR);
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
    function = QFUNC(edenModuleTfarRadioJammers);
    scope = 2;
    class Attributes: AttributesBase {
        class Radius: Edit {
            property = QGVAR(edenModuleTfarRadioJammers_Radius);
            displayName = ECSTRING(main,RadiusLabel);
            tooltip = ECSTRING(main,RadiusTooltip);
            typeName = "NUMBER";
            defaultValue = "1000";
        };
        class Strength: Edit {
            property = QGVAR(edenModuleTfarRadioJammers_Strength);
            displayName = ECSTRING(main,StrengthLabel);
            typeName = "NUMBER";
            defaultValue = "50";
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

class GVAR(edenModuleTfarRadioJammersDeactivateAction): GVAR(baseEdenModule) {
    displayName = CSTRING(Module_TfarRadioJammersDeactivateAction_DisplayName);
    function = QFUNC(edenModuleTfarRadioJammers);
    scope = 2;
    class Attributes: AttributesBase {
        class ActionType: Combo {
            displayName = CSTRING(ActionType);
            tooltip = CSTRING(ActionType);
            property = QGVAR(edenModuleTfarRadioJammersDeactivateAction_ActionType);
            typeName = "STRING";
            class values {
                class Scroll {
                    name = "Scroll";
                    value = "SCROLL";
                    default = 1;
                };
                class Hold {
                    name = "Hold";
                    value = "HOLD";
                };
                class None {
                    name = "None";
                    value = "NONE";
                };
            };
        };
        class ActionName: Edit {
            property = QGVAR(edenModuleTfarRadioJammersDeactivateAction_ActionName);
            displayName = CSTRING(ActionName);
            typeName = "STRING";
            defaultValue = "''";
        };
        class ActionTime: Edit {
            property = QGVAR(edenModuleTfarRadioJammersDeactivateAction_ActionTime);
            displayName = CSTRING(ActionTimeLabel);
            typeName = "NUMBER";
            defaultValue = "5";
        };        
        class ShouldCreateAceAction: Checkbox {
            property = QGVAR(edenModuleTfarRadioJammersDeactivateAction_ShouldCreateAceAction);
            displayName = CSTRING(ShouldCreateAceActionLabel);
            typeName = "BOOL";
            defaultValue = "false";
        };        
        class Condition: Default {
            property = QGVAR(edenModuleTfarRadioJammersDeactivateAction_Condition);
            displayName = ECSTRING(main,RequiredItem);
            typeName = "STRING";
            defaultValue = "''";
            control = "editcodemulti5";
        };        
     
        class ShouldHideActionAfterUse: Checkbox {
            property = QGVAR(edenModuleTfarRadioJammersDeactivateAction_ShouldHideActionAfterUse);
            displayName = CSTRING(ShouldHideActionAfterUse);
            typeName = "BOOL";
            defaultValue = "false";
        };        
        class OnDeactivationCode: Default {
            property = QGVAR(edenModuleTfarRadioJammersDeactivateAction_OnDeactivationCode);
            displayName = CSTRING(OnDeactivationCode);
            typeName = "STRING";
            defaultValue = "''";
            control = "editcodemulti5";
        };
        class ModuleDescription: ModuleDescription {};
    };
    class ModuleDescription: ModuleDescription {
        description = CSTRING(Module_TfarRadioJammers_Description);
    };
};
