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
};
