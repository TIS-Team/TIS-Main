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
			"A3_Weapons_F",
			"cba_main",
			"tis_main_main",
			"WNZ_EMP_SystemsXEH"
		};
		skipWhenMissingDependencies = 1;
        requiredVersion = REQUIRED_VERSION;
        authorUrl = "https://github.com/TIS-Team";
		VERSION_CONFIG;
	};
};

#include "CfgEventHandlers.hpp"
