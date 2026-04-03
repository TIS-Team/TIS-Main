#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
        name = COMPONENT_NAME;
		units[]={
			"TIS_Anprc_152_Broken_Radio_Item",
			"TIS_Anprc_152_Discharged_Radio_Item",
			"TIS_TFAR_Invisible_Radio",
			"TIS_TFAR_Invisible_Radio_Zeus"
		};
		weapons[]={
			"TIS_Anprc_152_Broken_Radio",
			"TIS_Anprc_152_Discharged_Radio"
		};
		author="TIS";
		requiredAddons[]=
		{
			"A3_Weapons_F",
			"cba_main",
			"tis_main_main",
			"tfar_core"
		};
		skipWhenMissingDependencies = 1;
        requiredVersion = REQUIRED_VERSION;
        authorUrl = "https://github.com/TIS-Team";
		VERSION_CONFIG;
	};
};

#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
