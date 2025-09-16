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
		class TFAR_Invisible_Radio: B_Kitbag_rgr
	{
		author="Quallex";
		scope=2;
		displayName="TFAR Invisible Radio";
		picture="TFAR_Invisible_Radio\data\icon\TIS_LOGO.paa";
		model="\TFAR_Invisible_Radio\Hide.p3d";
		maximumLoad=0;
		mass=0;
		tf_dialogUpdate="call TFAR_fnc_updateLRDialogToChannel;";
		tf_hasLRradio=1;
		tf_range=20000;
		tf_encryptionCode="tf_west_radio_code";
		tf_dialog="rt1523g_radio_dialog";
		tf_subtype="digital_lr";
	};
	class TFAR_Invisible_Radio_Zeus: B_Kitbag_rgr
	{
		author="Quallex";
		scope=2;
		displayName="TFAR Invisible Radio [TYLKO ZEUS]";
		picture="TFAR_Invisible_Radio\data\icon\TIS_LOGO.paa";
		model="\TFAR_Invisible_Radio\Hide.p3d";
		maximumLoad=5000;
		mass=0;
		tf_dialogUpdate="call TFAR_fnc_updateLRDialogToChannel;";
		tf_hasLRradio=1;
		tf_range=100000;
		tf_encryptionCode="tf_west_radio_code";
		tf_dialog="rt1523g_radio_dialog";
		tf_subtype="digital_lr";
	};
};
