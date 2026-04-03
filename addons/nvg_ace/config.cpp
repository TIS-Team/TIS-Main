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
			"tis_main_nvg",
			"ace_interact_menu"
		};
		skipWhenMissingDependencies = 1;
        requiredVersion = REQUIRED_VERSION;
        authorUrl = "https://github.com/TIS-Team";
		VERSION_CONFIG;
	};
};

#include "AceSelfActions.hpp"
