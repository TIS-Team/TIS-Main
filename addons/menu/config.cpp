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

class CfgCommands
{
    allowedHTMLLoadURIs[] += {
        "https://www.tispmc.pl",
        "https://tispmc.pl"
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
	text=QPATHTOF(data\TIS_MENU.jpg);
	class RscActiveText;
	class RscActivePicture: RscActiveText
	{
		style=48;
		color[]={1,1,1,0.5};
		colorActive[]={1,1,1,1};
	};
	class controls
	{
		class Spotlight1 {};
		class Spotlight2 {};
		class Spotlight3 {};
		class SpotlightPrev {};
		class SpotlightNext {};
		class BackgroundSpotlightRight {};
		class BackgroundSpotlightLeft {};
		class BackgroundSpotlight {};
		class B_Credits {};

		class TisConnectServer: RscButtonMenu
		{
			idc = -1;
			text = "Dołącz na serwer";
			onbuttonclick = "connectToServer ['tispmc.pl', 2302, '132']";
			colorBackground[]={0,0,0,0};
			colorBackground2[]={1,1,1,1};
			style = "0x02 + 0xC0";
			size="1.25 * 	(pixelH * pixelGrid * 2)";
			x="0.5 - (	5 + 3 * 10) * 	(pixelW * pixelGrid * 2)";
			y="safezoneY + 2 * 	(pixelH * pixelGrid * 2)";
			w="10 * (pixelW * pixelGrid * 2)";
			h="2 * 	(pixelH * pixelGrid * 2)";

			class Attributes
			{
				align="center";
				color="#ffffff";
				font="PuristaLight";
				shadow=0;
				size=1;
			};
			class TextPos
			{
				left="0.1 * 		2 * 	(pixelW * pixelGrid * 2)";
				top="0.18 * 		2 * 	(pixelH * pixelGrid * 2)";
				right="0.1 * 		2 * 	(pixelW * pixelGrid * 2)";
				bottom="0.18 * 		2 * 	(pixelH * pixelGrid * 2)";
			};
		};

		class TisOpenWebiste: TisConnectServer
		{
			idc = -1;
			text = "Strona TIS";
			tooltip = "Strona TIS";
			url = "https://tispmc.pl/";
			x="0.5 + (5 + 10 * 2) * (pixelW * pixelGrid * 2)";
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
