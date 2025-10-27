#include "script_component.hpp"

params ["_unit","_param","_name"];

if (!hasInterface) exitWith {};

_healthBarPicture = findDisplay 46 ctrlCreate ["RscPictureKeepAspect", 20004]; 
_healthBarPicture ctrlSetPosition [0.319531 * safeZoneW + safeZoneX, 0.00500001 * safeZoneH + safeZoneY,0.0360937 * safeZoneW,0.066 * safeZoneH]; 
_healthBarPicture ctrlSetTextColor [1, 0.05, 0, 0.8]; 
_healthBarPicture ctrlSetText "\a3\ui_f\data\IGUI\Cfg\Revive\overlayIcons\f100_ca.paa";
_healthBarPicture ctrlCommit 0; 
_healthBarBackground = findDisplay 46 ctrlCreate ["RscBackground", 20001];
_healthBarBackground ctrlSetPosition [0.355625 * safeZoneW + safeZoneX, 0.016 * safeZoneH + safeZoneY, 0.299062 * safeZoneW, 0.044 * safeZoneH];   
_healthBarBackground ctrlSetBackgroundColor [0.2, 0.2, 0.2, 0.3];   
_healthBarBackground ctrlEnable false;   
_healthBarBackground ctrlCommit 0;
_healthBarProgress = findDisplay 46 ctrlCreate ["RscProgress", 20002];
_healthBarProgress ctrlSetPosition [0.360781 * safeZoneW + safeZoneX, 0.027 * safeZoneH + safeZoneY, 0.28875 * safeZoneW, 0.022 * safeZoneH]; 
_healthBarProgress ctrlSetTextColor [1, 0.15, 0, 0.8];
_healthBarProgress progressSetPosition 1;
_healthBarProgress ctrlCommit 0; 
_healthBarName = findDisplay 46 ctrlCreate ["RscStructuredText", 20003];
_healthBarName ctrlSetPosition [0.402031 * safeZoneW + safeZoneX, 0.0245 * safeZoneH + safeZoneY, 0.211406 * safeZoneW, 0.025 * safeZoneH];
_healthBarName ctrlCommit 0;
_healthBarName ctrlSetStructuredText parseText format["<t color='#F7E8E8' align='center' size='1.1' font = 'PuristaMedium'>%1</t>",_name];
_progressBarUpdaterHandle = [{
        _array = _this select 0;
        _unit = _array select 0;
        _param = _array select 1;
        _progressBar = _array select 2;
        _paramInitial = _array select 3;
        _healthBarPosition =  (_unit getVariable _param) / _paramInitial;
        if !(alive _unit) exitWith {_progressBar progressSetPosition 0;};
        _progressBar progressSetPosition _healthBarPosition;
    }, 
    0.1, 
    [_unit, _param,_healthBarProgress, _unit getVariable _param]
] call CBA_fnc_addPerFrameHandler;
waitUntil {!alive _unit};

_healthBarPicture ctrlSetTextColor [1, 1, 1, 1]; 
_healthBarProgress progressSetPosition 0;
[_progressBarUpdaterHandle] call CBA_fnc_removePerFrameHandler;
{
    _ctrl = (findDisplay 46) displayCtrl _x;
    _ctrl ctrlSetFade 1;
    _ctrl ctrlCommit 6;
} forEach [20001,20002,20003,20004];

uiSleep 8;
ctrlDelete ((findDisplay 46) displayCtrl 20001);
ctrlDelete ((findDisplay 46) displayCtrl 20002);
ctrlDelete ((findDisplay 46) displayCtrl 20003);
ctrlDelete ((findDisplay 46) displayCtrl 20004);
