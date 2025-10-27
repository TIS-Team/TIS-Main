#include "script_component.hpp"
private _message = _this apply {if ((_x isEqualType "") && {isLocalized _x}) then {localize _x} else {_x}};
[objNull, format _message] call BIS_fnc_showCuratorFeedbackMessage;
