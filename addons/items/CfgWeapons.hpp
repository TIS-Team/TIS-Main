class CfgWeapons {

    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class TIS_Tisowianka: ACE_ItemCore {
        author = ECSTRING(main,TISTeam);
        scope = 2;
        displayName = CSTRING(Tisowianka_DisplayName);
        descriptionShort = CSTRING(Tisowianka_Description);
        model = "\a3\structures_f_epa\items\food\bottleplastic_v2_f.p3d";
        picture = QACEPATHTOF(field_rations,ui\item_waterbottle_full_co.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5;
        };
        XGVAR(consumeTime) = 10;
        XGVAR(thirstQuenched) = 20;
        XGVAR(consumeText) = CSTRING(Drinking);
        XGVAR(consumeAnims)[] = {QGVAR(drinkStand), QGVAR(drinkCrouch), QGVAR(drinkProne)};
        XGVAR(consumeSounds)[] = {QGVAR(drink1), QGVAR(drink1), QGVAR(drink2)};
        ACE_isFieldRationItem = 1;
    };
};
