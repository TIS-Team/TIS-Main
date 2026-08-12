class CfgVehicles {
    class Logic;
    class Module_F: Logic {};

    // Base module
    class GVAR(baseModule): Module_F {
        author = ECSTRING(main,TISTeam);
        category = QGVAR(TIS_ZEUS);
        function = QFUNC(emptyFunction);
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        scope = 1; // 2 for EDEN and Zeus, 1 for Zeus.
        scopeCurator = 2; // 0 hidden from Zeus
    };

    ///////////////////////////////////////////////////////////
    // Zeus modules
    class GVAR(moduleConvertToBoss): GVAR(baseModule) {
        curatorCanAttach = 1;
        displayName = CSTRING(Module_ConvertToBoss_DisplayName);
        curatorInfoType = QGVAR(RscConvertToBoss);
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };

    class GVAR(moduleRefillNvgBattery): GVAR(baseModule) {
        category = QGVAR(TIS_NVG);
        curatorCanAttach = 1;
        displayName = CSTRING(Module_RefillNvgBattery_DisplayName);
        function = QFUNC(moduleRefillNvgBattery);
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };

    class GVAR(moduleToggleDiagnosticMonitor): GVAR(baseModule) {
        category = QGVAR(TIS_UTILS);
        curatorCanAttach = 0;
        displayName = CSTRING(Module_ToggleDiagnosticMonitor_DisplayName);
        function = QFUNC(moduleToggleDiagnosticMonitor);
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };

    class GVAR(moduleAddAceArsenalAmmoOnly): GVAR(baseModule) {
        category = QGVAR(TIS_ARSENAL);
        curatorCanAttach = 1;
        displayName = CSTRING(Module_AddAceArsenalAmmoOnly_DisplayName);
        function = QFUNC(moduleAddAceArsenalAmmoOnly);
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };

    class GVAR(moduleTfarRadioJammer): GVAR(baseModule) {
        category = QGVAR(TIS_TFAR);
        curatorCanAttach = 1;
        displayName = CSTRING(Module_TfarRadioJammer_DisplayName);
        curatorInfoType = QGVAR(RscTfarRadioJammer);
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };
};
