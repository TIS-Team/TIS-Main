#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
        name = COMPONENT_NAME;
		authors[]= { "TIS" };
		units[]={
			QGVAR(moduleConvertToBoss),
			QGVAR(moduleRefillNvgBattery),
			QGVAR(moduleToggleDiagnosticMonitor),
			QGVAR(moduleAddAceArsenalAmmoOnly)
		};
		weapons[]={};
        requiredVersion = REQUIRED_VERSION;
		requiredAddons[]=
		{
			"A3_Modules_F",
			"cba_main",
			"tis_main_main"
		};
        authorUrl = "https://github.com/TIS-Team";
		VERSION_CONFIG;
	};
};

#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
#include "ui\RscAttributes.hpp"
