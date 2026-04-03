class CfgVehicles
{
    class Item_Base_F;

	class TIS_Anprc_152_Broken_Radio_Item: Item_Base_F
	{
		scope=2;
		scopeCurator=2;
		displayName = CSTRING(TIS_Anprc_152_Broken_Radio_DisplayName);
		author= ECSTRING(main,TISTeam);
		editorCategory="EdCat_Equipment";
		editorSubcategory="EdSubcat_InventoryItems";
		vehicleClass="Items";
		class TransportItems
		{
			MACRO_ADDITEM(TIS_Anprc_152_Broken_Radio,1);
		};
	};

	class TIS_Anprc_152_Discharged_Radio_Item: Item_Base_F
	{
		scope=2;
		scopeCurator=2;
		displayName = CSTRING(TIS_Anprc_152_Discharged_Radio_DisplayName);
		author= ECSTRING(main,TISTeam);
		editorCategory="EdCat_Equipment";
		editorSubcategory="EdSubcat_InventoryItems";
		vehicleClass="Items";
		class TransportItems
		{
			MACRO_ADDITEM(TIS_Anprc_152_Discharged_Radio,1);
		};
	};


    // ========================= BACKPACKS ============================
	class ReammoBox;
	class Bag_Base: ReammoBox {};
	class TFAR_Bag_Base: Bag_Base {};
	class TFAR_rt1523g: TFAR_Bag_Base {};
	class TFAR_rt1523g_sage: TFAR_rt1523g {};
	class TFAR_rt1523g_black: TFAR_rt1523g_sage {};
	class TFAR_rt1523g_black_broken: TFAR_rt1523g_black
	{
		author="TIS";
		displayName="Broken RT-1523G (ASIP) Black";
		tf_range = 0;
	};

	class B_Kitbag_rgr;
	class TFAR_Invisible_Radio: B_Kitbag_rgr
	{
		author="Quallex";
		scope=2;
		displayName="TFAR Invisible Radio";
		picture=QPATHTOEF(main,data\icon\TIS_LOGO.paa);
		model=QPATHTOEF(main,data\model\Hide.p3d);
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
		picture= QPATHTOEF(main,data\icon\TIS_LOGO.paa);
		model=QPATHTOEF(main,data\model\Hide.p3d);
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
