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
};
