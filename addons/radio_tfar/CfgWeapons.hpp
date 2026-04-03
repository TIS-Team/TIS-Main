class CfgWeapons {

    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;
    class TIS_Anprc_152_Broken_Radio: ACE_ItemCore {
        author = ECSTRING(main,TISTeam);
        scope = 2;
        displayName = CSTRING(TIS_Anprc_152_Broken_Radio_DisplayName);
        descriptionShort = CSTRING(TIS_Anprc_152_Broken_Radio_Description);
		picture = "\A3\Weapons_F\Data\UI\gear_item_radio_ca.paa";
		model = "\a3\Weapons_F\Ammo\mag_radio.p3d";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };

    class TIS_Anprc_152_Discharged_Radio: ACE_ItemCore {
        author = ECSTRING(main,TISTeam);
        scope = 2;
        displayName = CSTRING(TIS_Anprc_152_Discharged_Radio_DisplayName);
        descriptionShort = CSTRING(TIS_Anprc_152_Discharged_Radio_Description);
		picture = "\A3\Weapons_F\Data\UI\gear_item_radio_ca.paa";
		model = "\a3\Weapons_F\Ammo\mag_radio.p3d";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
};
