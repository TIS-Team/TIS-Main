#include "script_component.hpp"

class CfgPatches
{
	class tis_main
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
        authorUrl = "https://github.com/Aquerr";
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
					onLoad = QUOTE((_this select 0) ctrlsettext 'PATHTOF(TIS4K.paa)');
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
					onLoad = QUOTE((_this select 0) ctrlsettext 'PATHTOF(TIS4K.paa)');
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
					onLoad = QUOTE((_this select 0) ctrlsettext 'PATHTOF(TIS4K.paa)');
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
			text = QPATHTOF(T1.paa);
			onButtonClick="connectToServer ['tispmc.pl', 25565, '132'];";
		};
		class LogoApex: Logo
		{
			text = QPATHTOF(T1.paa);
			onButtonClick="connectToServer ['tispmc.pl', 25565, '132'];";
		};
	};
};

#include "CfgEventHandlers.hpp"
