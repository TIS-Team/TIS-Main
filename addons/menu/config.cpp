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
class RscShortcutButton;
class RscButtonMenu : RscShortcutButton {};
class Button : RscButtonMenu {};
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
		class TisConnectDiscord: Button
		{
			idc = -1;
			text = "Discord Kanal Glowny";
			url = "https://discord.com/channels/1265652940547293254/1265652941251940517";
			font = "RobotoCondensed";
			fontSecondary = "PuristaLight";
			color[] = {1,1,1,1};
			color2[] = {0,0,0,1};
			color2Secondary[] = {0,0,0,1};
			colorDisabled[] = {1,1,1,0.25};
			colorDisabledSecondary[] = {1,1,1,0.25};
			colorSecondary[] = {1,1,1,1};
			colorFocused[] = {0,0,0,1};
			colorFocusedSecondary[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {1,1,1,1};
			colorBackgroundFocused[] = {1, 1, 1, 1};
			colorText[] = {1,1,1,1};
			// colorBackgroundActive[] = {1,0,0,0.2};
			style = "0x02 + 0xC0";
			size = "1.25 * 	(pixelH * pixelGrid * 2)";
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
			sizeExSecondary = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
			borderSize = 0.055;
			x = "0.5 + (5 + 10 + 12) * (pixelW * pixelGrid * 2)";  // = 0.5 + 25U
			y = "safezoneY + 2 * (pixelH * pixelGrid * 2)";
			w = "12 * (pixelW * pixelGrid * 2)";
			h = "2 * (pixelH * pixelGrid * 2)";
		};
		class TisConnectServer: RscButtonMenu
		{
			idc = -1;
			text = "Dolacz na server TIS";
			onbuttonclick = "connectToServer ['tispmc.pl', 2302, '132']";
			font = "RobotoCondensed";
			fontSecondary = "PuristaLight";
			color[] = {1,1,1,1};
			color2[] = {0,0,0,1};
			color2Secondary[] = {0,0,0,1};
			colorDisabled[] = {1,1,1,0.25};
			colorDisabledSecondary[] = {1,1,1,0.25};
			colorSecondary[] = {1,1,1,1};
			colorFocused[] = {0,0,0,1};
			colorFocusedSecondary[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {1,1,1,1};
			colorBackgroundFocused[] = {1, 1, 1, 1};
			colorText[] = {1,1,1,1};
			// colorBackgroundActive[] = {1,0,0,0.2};
			style = "0x02 + 0xC0";
			size = "1.25 * 	(pixelH * pixelGrid * 2)";
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
			sizeExSecondary = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
			x = "0.5 - (5 + 2*10 + 12) * (pixelW * pixelGrid * 2)";  // = 0.5 - 35U
			y = "safezoneY + 2 * (pixelH * pixelGrid * 2)";
			w = "12 * (pixelW * pixelGrid * 2)";
			h = "2 * (pixelH * pixelGrid * 2)";
		};
	};
	class controlsBackground
	{
		class LoadingPicture_TIS: RscPicture
		{
			idc=1;
			access=1;
			colorText[]={1,1,1,1};
			colorFocused[] = {0,0,0,1};
			colorFocusedSecondary[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			colorBackground2[] = {1,1,1,1};
			colorBackgroundFocused[] = {1, 1, 1, 1};
			x="SafeZoneX";
			y="SafeZoneY";
			h="SafeZoneH";
			w="SafeZoneW";
			text= QPATHTOF(data\TIS_MENU.jpg);
		};
	};
};
