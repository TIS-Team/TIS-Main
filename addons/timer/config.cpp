#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "TIS";
        name = COMPONENT_NAME;
        url = "https://github.com/TIS-Team";
        requiredAddons[] = {"cba_main", "tis_main_main"};
        units[] = { QGVAR(edenModuleCountdownTimer) };
        weapons[] = {};
        authorUrl = "https://github.com/TIS-Team";
        requiredVersion = REQUIRED_VERSION;
		VERSION_CONFIG;
    };
};

// Dynamic GUI-mode countdown boxes are created/destroyed at runtime;
// this just defines the display layer they attach to.
class RscTitles {
    class TIS_TimerDisplay {
        idd = TIS_TIMER_DISPLAY_IDD;
        duration = 1e10;
        fadein = 0;
        fadeout = 0;
        name = "TIS_TimerDisplay";
        class controls {};
    };
};

#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
