class CfgVehicles
{
    // ========================== MISC ============================
    class ACE_WaterBottle_Item;
    class TIS_Tisowianka_Item: ACE_WaterBottle_Item {
        author = ECSTRING(main,TISTeam);
		picture=QPATHTOEF(main,data\icon\TIS_LOGO.paa);
        displayName = CSTRING(Tisowianka_DisplayName);
        class TransportItems {
            MACRO_ADDITEM(TIS_Tisowianka,1);
        };
    };
};
