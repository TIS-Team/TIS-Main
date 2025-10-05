#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
        name = COMPONENT_NAME;
		units[]={};
		weapons[]={};
		author="TIS";
		requiredAddons[]=
		{
			"cba_main",
			"tis_main_main",
			"ace_logistics_uavbattery"
		};
        requiredVersion = REQUIRED_VERSION;
        authorUrl = "https://github.com/TIS-Team";
		VERSION_CONFIG;
	};
};

#include "CfgEventHandlers.hpp"
#include "AceSelfActions.hpp"
