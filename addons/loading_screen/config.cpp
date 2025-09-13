#include "script_component.hpp"
#include "CfgLoadingScreens.hpp"

class CfgPatches
{
	class TIS_LoadingScreen
	{
        name = COMPONENT_NAME;
		units[]={};
		weapons[]={};
        requiredVersion = REQUIRED_VERSION;
		requiredAddons[]={"cba_main"};
        VERSION_CONFIG;
	};
};
