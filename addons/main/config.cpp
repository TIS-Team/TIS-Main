#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
        name = COMPONENT_NAME;
		authors[]= { "Quallex", "Nerdi", "TIS" };
		units[]={};
		weapons[]={};
        requiredVersion = REQUIRED_VERSION;
		requiredAddons[]=
		{
			"cba_main",
			"A3_Data_F_Tank_Loadorder"
		};
        authorUrl = "https://github.com/TIS-Team";
		VERSION_CONFIG;
	};
};
class RscPictureKeepAspect;
class RscStandardDisplay;
class RscControlsGroup;
class RscDisplayStart: RscStandardDisplay
{
	class controls
	{
		class LoadingStart: RscControlsGroup
		{
			class controls
			{
				class Logo: RscPictureKeepAspect
				{
					onLoad = QUOTE((_this select 0) ctrlsettext 'PATHTOF(logo_4k.paa)');
				};
			};
		};
	};
};
class RscDisplayLoadMission: RscStandardDisplay
{
	class controls
	{
		class LoadingStart: RscControlsGroup
		{
			class controls
			{
				class Logo: RscPictureKeepAspect
				{
					onLoad = QUOTE((_this select 0) ctrlsettext 'PATHTOF(logo_4k.paa)');
				};
			};
		};
	};
};
class RscDisplayNotFreeze: RscStandardDisplay
{
	class controls
	{
		class LoadingStart: RscControlsGroup
		{
			class controls
			{
				class Logo: RscPictureKeepAspect
				{
					onLoad = QUOTE((_this select 0) ctrlsettext 'PATHTOF(logo_4k.paa)');
				};
			};
		};
	};
};
class RscActivePicture;
class RscDisplayMain: RscStandardDisplay
{
	class Controls
	{
		class Logo: RscActivePicture
		{
			tooltip="$STR_ConnectWithTIS";
			text = QPATHTOF(logo.paa);
			onButtonClick="connectToServer ['tispmc.pl', 25565, '132'];";
		};
		class LogoApex: Logo
		{
			text = QPATHTOF(logo.paa);
			onButtonClick="connectToServer ['tispmc.pl', 25565, '132'];";
		};
	};
};

#include "CfgEventHandlers.hpp"
