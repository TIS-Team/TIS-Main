#include "script_component.hpp"

// Local Only

params ["_unit", "_name", "_hpNumber", "_showHealthBar"];

_unit removeAllEventHandlers "HitPart";
_unit addEventHandler [
	"HitPart",
	{
		(_this select 0) params ["_target","_shooter","_bullet","_position","_velocity","_selection","_ammo","_direction","_radius","_surface","_direct"];
		if ((_target == _shooter) or !(alive _target)) exitWith {};
		_isExplosive = _ammo select 3;
		_hitPower = _ammo select 0;
		_healthVariableName = _target getVariable "tis_unit_custom_health_var_name";
		_currentHealth = _target getVariable _healthVariableName;
		_newHealth = _currentHealth - _hitPower;
		if (_newHealth <= 0) exitWith {
			_target setVariable [_healthVariableName,0,true]; 
			[_target, true] remoteExec ["allowDamage", _target];
		};
		_target setVariable [_healthVariableName,_newHealth,true];
	}
];
