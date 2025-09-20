#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
        name = COMPONENT_NAME;
		authors[]= {"Quallex", "Nerdi", "TIS"};
		requiredAddons[]=
		{
			"cba_main",
			"A3_Data_F_Enoch_Loadorder"
		};
        requiredVersion = REQUIRED_VERSION;
		units[]={};
		weapons[]={};
        authorUrl = "https://github.com/TIS-Team";
        VERSION_CONFIG;
	};
};
class RscStandardDisplay;
class RscPicture;
class RscButton;
class RscDisplayConfigure
{
	enableDisplay=1;
};
class RscDisplayMain: RscStandardDisplay
{
	idd=0;
	idc=1;
	access=1;
	enableDisplay=1;
	text=QPATHTOF(data\TIS_MENU.jpg);
	class RscActiveText;
	class RscActivePicture: RscActiveText
	{
		style=48;
		color[]={1,1,1,0.5};
		colorActive[]={1,1,1,1};
	};
	class Spotlight
	{
	};
	class controls
	{
		class Spotlight1
		{
		};
		class Spotlight2
		{
		};
		class Spotlight3
		{
		};
		class BackgroundSpotlightRight
		{
		};
		class BackgroundSpotlightLeft
		{
		};
		class BackgroundSpotlight
		{
		};
		class B_Credits
		{
		};
		class ConnectDiscord: RscButton
		{
			idc=-1;
			text="Discord Kanal Glowny";
			style=2;
			url="https://discord.com/channels/1265652940547293254/1265652941251940517";
			colorBackground[]={0,0,0,0.69999999};
			colorBackgroundActive[]={1,0,0,0,2};
			borderSize=0.055;
			colorBorder[]={0,0,0,0};
			x="safeZoneX + safeZoneW - 0.7";
			y="safeZoneY + 0.03 * safeZoneH";
			w="0.25";
			h="0.05";
		};
		class ConnectServer: RscButton
		{
			idc=-1;
			text="Dolacz na server TIS";
			style=2;
			onbuttonclick="connectToServer ['tispmc.pl', 2302, '132']";
			colorBackground[]={0,0,0,0.69999999};
			colorBackgroundActive[]={1,0,0,0,2};
			borderSize=0.055;
			colorBorder[]={0,0,0,0};
			x="safeZoneX + 0.19* safeZoneW";
			y="safeZoneY + 0.03 * safeZoneH";
			w="0.24";
			h="0.05";
		};
	};
	class controlsBackground
	{
		class LoadingPicture_TIS: RscPicture
		{
			idc=1;
			access=1;
			colorText[]={1,1,1,1};
			x="SafeZoneX";
			y="SafeZoneY";
			h="SafeZoneH";
			w="SafeZoneW";
			text= QPATHTOF(data\TIS_MENU.jpg);
		};
	};
};
