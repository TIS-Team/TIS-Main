#include "../script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Re-centers all active GUI timer boxes as a block on the
        right side of the screen, vertically centered. Called whenever a timer
        is added or removed, so the whole stack re-centers around the new count.

    Side:
        Should be executed on CLIENT only.

    Params: None
*/

private _display = findDisplay TIS_TIMER_DISPLAY_IDD;
if (isNull _display) exitWith {};

private _w      = 0.22 * safeZoneW;
private _lineH  = 0.035 * safeZoneH;
private _count  = count GVAR(timerRscControls);

private _baseX  = safeZoneX + safeZoneW - _w - (0.02 * safeZoneW);
private _totalH = _count * _lineH;
private _baseY  = safeZoneY + (safeZoneH / 2) - (_totalH / 2);

private _i = 0;
{
    _x ctrlSetPosition [_baseX, _baseY + (_i * _lineH), _w, _lineH];
    _x ctrlCommit 0;
    _i = _i + 1;
} forEach (values GVAR(timerRscControls));
