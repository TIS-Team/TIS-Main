#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
        name = COMPONENT_NAME;
		units[]={
			"TIS_Invisible_Backpack"
		};
		author="TIS";
		requiredAddons[]=
		{
			"A3_Weapons_F",
			"cba_main",
			"tis_main_main"
		};
        requiredVersion = REQUIRED_VERSION;
        authorUrl = "https://github.com/TIS-Team";
		VERSION_CONFIG;
	};
};

#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
