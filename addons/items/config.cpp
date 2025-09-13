#include "script_component.hpp"

class CfgPatches
{
	class TIS_Items
	{
		units[]={};
		weapons[]={};
		author="Quallex";
		requiredAddons[]=
		{
			"A3_Weapons_F"
		};
		requiredVersion=0.1;
	};
};
class CfgVehicles
{
	class B_Kitbag_rgr;
	class TIS_Invisible_Backpack: B_Kitbag_rgr
	{
		author="Quallex";
		scope=2;
		picture="TIS_Invisible_Backpack\data\icon\TIS_LOGO.paa";
		displayName="[TIS] Invisible Backpack";
		model="\TIS_Invisible_Backpack\model\hide.p3d";
		maximumLoad=2000;
		mass=1;
	};
};
