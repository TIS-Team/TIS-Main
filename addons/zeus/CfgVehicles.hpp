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
        displayName = ECSTRING(main,Module_ConvertToBoss_DisplayName);
        curatorInfoType = QGVAR(RscConvertToBoss);
        icon = "a3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_config_ca.paa";
    };
};
