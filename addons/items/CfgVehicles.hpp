class CfgVehicles
{
    // ========================= BACKPACKS ============================
	class B_Kitbag_rgr;
	class TIS_Invisible_Backpack: B_Kitbag_rgr
	{
		author="Quallex";
		scope=2;
		picture=QPATHTOF(data\icon\TIS_LOGO.paa);
		displayName="[TIS] Invisible Backpack";
		model=QPATHTOF(model\hide.p3d);
		maximumLoad=2000;
		mass=1;
	};
	
	class TFAR_Invisible_Radio: B_Kitbag_rgr
	{
		author="Quallex";
		scope=2;
		displayName="TFAR Invisible Radio";
		picture=QPATHTOF(data\icon\TIS_LOGO.paa);
		model=QPATHTOF(model\Hide.p3d);
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
		picture= QPATHTOF(data\icon\TIS_LOGO.paa);
		model=QPATHTOF(model\Hide.p3d);
		maximumLoad=5000;
		mass=0;
		tf_dialogUpdate="call TFAR_fnc_updateLRDialogToChannel;";
		tf_hasLRradio=1;
		tf_range=100000;
		tf_encryptionCode="tf_west_radio_code";
		tf_dialog="rt1523g_radio_dialog";
		tf_subtype="digital_lr"; 
	};

    // ========================== MISC ============================

    class ACE_WaterBottle_Item;
    class TIS_Tisowianka_Item: ACE_WaterBottle_Item {
        author = ECSTRING(main,TISTeam);
        displayName = CSTRING(Tisowianka_DisplayName);
        class TransportItems {
            MACRO_ADDITEM(TIS_Tisowianka,1);
        };
    };
};
