#include "script_component.hpp"

// Server Only

params ["_unit", "_name", "_hpNumber", ["_showHealthBar", true, [true]]];

TRACE_4("Convert to boss",_unit,_name,_hpNumber,_showHealthBar);

private _healthVariable = "tis_unit_custom_health";
private _healthVariableName = "tis_unit_custom_health_var_name";

// Check if WBK_Zombie
if (GVAR(isWbkZombiesLoaded) && { getText (configOf _unit >> "faction") isEqualTo "WBK_AI_ZHAMBIES"}) then {
	_healthVariable = "WBK_SynthHP";
	_unit setVariable [_healthVariableName, _healthVariable, true];
	_unit setVariable [_healthVariable, _hpNumber, true];
} else {
	_unit allowDamage false;
	_unit setVariable [_healthVariableName, _healthVariable, true];
	_unit setVariable [_healthVariable, _hpNumber, true];

	[_unit, _name, _hpNumber, _showHealthBar] remoteExec [QFUNC(convertToBossLocal), 0, true];
};

if (_showHealthBar) then {
	[_unit, _healthVariable, _name] remoteExec [QFUNC(showBossBar)];
};
