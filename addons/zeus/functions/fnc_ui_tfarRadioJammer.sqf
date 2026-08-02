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

if (isNull _unit) exitWith {
    [LLSTRING(MustSelectObject)] call _fnc_errorAndClose;
};

private _radiusEditField = _display displayCtrl ZEUS_TFAR_RADIO_JAMMER_DIALOG_RADIUS_EDIT_ID;
private _strengthEditField = _display displayCtrl ZEUS_TFAR_RADIO_JAMMER_DIALOG_STRENGTH_EDIT_ID;
private _sideCombo = _display displayCtrl ZEUS_TFAR_RADIO_JAMMER_DIALOG_SIDE_COMBO_ID;
private _debugToggle = _display displayCtrl ZEUS_TFAR_RADIO_JAMMER_DIALOG_DEBUG_EDIT_ID;

////////////////////////////////////////////////////////////
// Default values
_radiusEditField ctrlSetText "";
_strengthEditField ctrlSetText "";
_sideCombo lbSetCurSel 0;
_debugToggle lbSetCurSel 0;

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

	private _radius = parseNumber (ctrlText (_display displayCtrl ZEUS_TFAR_RADIO_JAMMER_DIALOG_RADIUS_EDIT_ID));
	private _strength = parseNumber (ctrlText (_display displayCtrl ZEUS_TFAR_RADIO_JAMMER_DIALOG_STRENGTH_EDIT_ID));
    private _sideIndex = lbCurSel (_display displayCtrl ZEUS_TFAR_RADIO_JAMMER_DIALOG_SIDE_COMBO_ID);
    private _side = (_display displayCtrl ZEUS_TFAR_RADIO_JAMMER_DIALOG_SIDE_COMBO_ID) lbText _sideIndex;
    private _debug = (lbCurSel (_display displayCtrl ZEUS_TFAR_RADIO_JAMMER_DIALOG_DEBUG_EDIT_ID)) > 0;

    [attachedTo _logic, _radius, _strength, _debug, _side] call FUNC(moduleTfarRadioJammer);
    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
