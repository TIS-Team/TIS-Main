#include "script_component.hpp"

params ["_control"];

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl 1; // IDC_OK
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
TRACE_1("Logic Object",_logic);

_control ctrlRemoveAllEventHandlers "SetFocus";

// Validate module target
private _unit = attachedTo _logic;
TRACE_1("unit",_unit);

scopeName "Main";

private _fnc_errorAndClose = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call FUNC(showZeusFeedbackMessage);
    breakOut "Main";
};

switch (false) do {
    case !(isNull _unit): {
        [LLSTRING(MustSelectObject)] call _fnc_errorAndClose;
    };
};

private _nameEditField = _display displayCtrl ZEUS_CONVERTTOBOSS_DIALOG_NAME_EDIT_ID;
private _hpEditField = _display displayCtrl ZEUS_CONVERTTOBOSS_DIALOG_HP_EDIT_ID;
private _showHealthBarToggle = _display displayCtrl ZEUS_CONVERTTOBOSS_DIALOG_SHOW_HEALTHBAR_TOGGLE_ID;
private _shouldMakeMeleeInvincibleToggle = _display displayCtrl ZEUS_CONVERTTOBOSS_DIALOG_SHOULD_MAKE_MELEE_INVINCIBLE_TOGGLE_ID;
private _customHealthVarName = _display displayCtrl ZEUS_CONVERTTOBOSS_DIALOG_CUSTOM_HEALTH_VAR_NAME_EDIT_ID;

////////////////////////////////////////////////////////////
// Default values
_nameEditField ctrlSetText "";
_hpEditField ctrlSetText "";
_showHealthBarToggle lbSetCurSel 1;
_shouldMakeMeleeInvincibleToggle lbSetCurSel 0;
_customHealthVarName ctrlSetText "";

/////////////////////////////////////////////////////////////
// Cancel and Confirmation
private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    deleteVehicle _logic;
};

private _fnc_onConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

	private _name = ctrlText (_display displayCtrl ZEUS_CONVERTTOBOSS_DIALOG_NAME_EDIT_ID);
	private _hpText = ctrlText (_display displayCtrl ZEUS_CONVERTTOBOSS_DIALOG_HP_EDIT_ID);
	private _showHealthBar = (lbCurSel (_display displayCtrl ZEUS_CONVERTTOBOSS_DIALOG_SHOW_HEALTHBAR_TOGGLE_ID)) > 0;
    private _shouldMakeMeleeInvincibleToggle = (lbCurSel (_display displayCtrl ZEUS_CONVERTTOBOSS_DIALOG_SHOULD_MAKE_MELEE_INVINCIBLE_TOGGLE_ID)) > 0;
    private _customHealthVarName = ctrlText (_display displayCtrl ZEUS_CONVERTTOBOSS_DIALOG_CUSTOM_HEALTH_VAR_NAME_EDIT_ID);

	private _hpNumber = _hpText call BIS_fnc_parseNumber;
	if (_hpNumber == -1) exitWith {
		[LLSTRING(HealthPointsMustBeNumeric)] call FUNC(showZeusFeedbackMessage);
	};

    [attachedTo _logic, _name, _hpNumber, _showHealthBar, _shouldMakeMeleeInvincibleToggle, _customHealthVarName] call FUNC(moduleConvertToBoss);
    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
