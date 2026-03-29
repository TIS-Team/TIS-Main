#include "Constants.hpp"

class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscText;
class RscEdit;
class ctrlToolbox;

class RscDisplayAttributes {
    class Controls {
        class Background;
        class Title;
        class Content: RscControlsGroup {
        };
        class ButtonOK;
        class ButtonCancel;
    };
};

class GVAR(RscConvertToBoss): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscConvertToBoss))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscConvertToBoss))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class controlsGroup: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(call FUNC(ui_convertToBoss));
                    idc = -1;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(5.5));
                    class controls {
                        class NameLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,NameLabel);
                            x = 0;
                            y = 0;
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class NameEdit: RscEdit {
                            idc = ZEUS_CONVERTTOBOSS_DIALOG_NAME_EDIT_ID;
                            x = QUOTE(W_PART(10.1));
                            y = 0;
                            w = QUOTE(W_PART(13.9));
                            h = QUOTE(H_PART(1));
                        };
                        class HPLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,HPLabel);
                            x = 0;
                            y = QUOTE(H_PART(1.1));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class HPEdit: RscEdit {
                            idc = ZEUS_CONVERTTOBOSS_DIALOG_HP_EDIT_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(1.1));
                            w = QUOTE(W_PART(13.9));
                            h = QUOTE(H_PART(1));
                        };
                        class ShowBossBarLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,ShowBossBarLabel);
                            x = 0;
                            y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class ShowBossBarToggle: ctrlToolbox {
                            idc = ZEUS_CONVERTTOBOSS_DIALOG_SHOW_HEALTHBAR_TOGGLE_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            rows = 1;
                            columns = 2;
                            strings[] = {ECSTRING(common,No), ECSTRING(common,Yes)};
                        };
                        class ShouldMakeMeleeInvincibleLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,ShouldMakeMeleeInvincibleLabel);
                            x = 0;
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class ShouldMakeMeleeInvincibleToggle: ctrlToolbox {
                            idc = ZEUS_CONVERTTOBOSS_DIALOG_SHOULD_MAKE_MELEE_INVINCIBLE_TOGGLE_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(3.3));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            rows = 1;
                            columns = 2;
                            strings[] = {ECSTRING(common,No), ECSTRING(common,Yes)};
                        };
                        class CustomHealthVarNameLabel: RscText {
                            idc = -1;
                            text = ECSTRING(main,CustomHealthVarNameLabel);
                            x = 0;
                            y = QUOTE(H_PART(4.4));
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.5};
                        };
                        class CustomHealthVarNameEdit: RscEdit {
                            idc = ZEUS_CONVERTTOBOSS_DIALOG_CUSTOM_HEALTH_VAR_NAME_EDIT_ID;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(4.4));
                            w = QUOTE(W_PART(13.9));
                            h = QUOTE(H_PART(1));
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
