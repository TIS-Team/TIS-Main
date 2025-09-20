#include "script_component.hpp"
#include "CfgLoadingScreens.hpp"

class CfgPatches
{
	class ADDON
	{
        name = COMPONENT_NAME;
		units[]={};
		weapons[]={};
        requiredVersion = REQUIRED_VERSION;
		requiredAddons[]={"cba_main"};
        authorUrl = "https://github.com/TIS-Team";
        VERSION_CONFIG;
	};
};
