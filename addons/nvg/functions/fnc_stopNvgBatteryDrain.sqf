#include "script_component.hpp"

params [];

if (not (isNil QGVAR(NvgBatteryDrainHandle)) && {GVAR(NvgBatteryDrainHandle) isNotEqualTo ""}) then {
	[GVAR(NvgBatteryDrainHandle)] call CBA_fnc_removePerFrameHandler;
	GVAR(NvgBatteryDrainHandle) = "";
};

