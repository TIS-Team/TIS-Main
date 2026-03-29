#include "script_component.hpp"

// Server Only

params ["_unit", "_name", "_hpNumber", ["_showHealthBar", true, [true]], ["_shouldMakeMeleeInvincible", false, [true]], ["_customHealthVarName", "", ["string"]]];

TRACE_4("Convert to boss",_unit,_name,_hpNumber,_showHealthBar);

scopeName "convertToBoss";
private _healthVariable = "tis_unit_custom_health";
private _healthVariableName = "tis_unit_custom_health_var_name";

if(_shouldMakeMeleeInvincible) then {
	_unit setVariable ['IMS_IsUnitInvicibleScripted', 1, true];
};

if (_customHealthVarName isEqualTo "") then {
	private _knownCustomHealthVariables = ["WBK_SynthHP", "IMS_CustomHealthDamage", "AI_GardenStateCustomHp"];
	private _unitVariables = allVariables _unit;
	{
		private _variableName = _x;
		{
			private _knownHealthVariable = _x;
			if ((toLowerANSI _variableName) isEqualTo (toLowerANSI _knownHealthVariable)) then {
				_healthVariable = _variableName;
				breakTo "convertToBoss";
			};
		} forEach _knownCustomHealthVariables;
	} forEach _unitVariables;
} else {
	_healthVariable = _customHealthVarName;
};

private _shouldAddCustomDamageHandler = false;
private _isIMSAi = _unit getVariable ["IMS_ISAI", 0];
if (_isIMSAi != 1) then {
	_shouldAddCustomDamageHandler = true;
	_unit allowDamage false;
};

_unit setVariable [_healthVariableName, _healthVariable, true];
_unit setVariable [_healthVariable, _hpNumber, true];

if (_shouldAddCustomDamageHandler) then {
	[_unit, _name, _hpNumber, _showHealthBar] remoteExec [QFUNC(convertToBossLocal), 0, true];
};

if (_showHealthBar) then {
	[_unit, _healthVariable, _name] remoteExec [QFUNC(showBossBar)];
};
