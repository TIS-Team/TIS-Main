#include "..\script_component.hpp"

/*
	Author: Aquerr (also known as Nerdi)
	https://github.com/Aquerr

	Description:
        Script for diagnostic monitor that collects information about server and player. Information is then displayed in hint message.
		This script runs server side and send data to clients via network.

	Parameter(s):
        0: PLAYER - REQUIRED - the player that want to monitor its and server diagnoatics data
		1: NUMBER - OPTIONAL - refresh interval (applied only when server side handler initializes)
	Example:
		[player] call tis_main_main_fnc_toggleDiagnosticMonitor;
		[player, 15] call tis_main_main_fnc_toggleDiagnosticMonitor;
*/

params [
	["_player", objNull, [objNull]],
	["_interval", 5, [1]]
];

if (isNull _player) exitWith {
	hint "Player must be provided";
};

[[_player, _interval], {
	params ["_player", "_interval"];

	if (isNil QGVAR(DiagnosticMonitorPlayers)) then {
		GVAR(DiagnosticMonitorPlayers) = [_player];
	} else {
		private _playerInList = GVAR(DiagnosticMonitorPlayers) findIf { _x == _player } != -1;
		if (_playerInList) then {
			GVAR(DiagnosticMonitorPlayers) = GVAR(DiagnosticMonitorPlayers) select { _x != _player };
		} else {
			GVAR(DiagnosticMonitorPlayers) pushBack _player;
		};
	};

	if (!(isNil QGVAR(DiagnosticMonitorHandle)) && {GVAR(DiagnosticMonitorHandle) != -1}) exitWith {};

	GVAR(DiagnosticMonitorHandle) = [
		{
			params ["_args", "_handleId"];

			private _users = GVAR(DiagnosticMonitorPlayers);

			if (_users isEqualTo []) exitWith {
					[GVAR(DiagnosticMonitorHandle)] call CBA_fnc_removePerFrameHandler;
					GVAR(DiagnosticMonitorHandle) = -1;
			};

			// Server logic
			private _serverFps = diag_fps; 
			private _serverMinFps = diag_fpsMin; 
			private _serverActiveScripts = diag_activeScripts;  

			private _missionObjects = allMissionObjects "All";
			private _serverObjCount = count _missionObjects; 
			private _serverAIUnitsCount = count (_missionObjects select { (_x isKindOf "Man") && {!isPlayer _x} && {alive _x} });
			private _serverEnabledSimulationObjectsCount = count (_missionObjects select { simulationEnabled _x });

			{
				_user = _x;

				// Client logic
				[[_serverFps, _serverMinFps, _serverObjCount, _serverAIUnitsCount, _serverEnabledSimulationObjectsCount, _serverActiveScripts], {

					params ["_serverFps", "_serverMinFps", "_serverObjCount", "_serverAIUnitsCount", "_serverEnabledSimulationObjectsCount", "_serverActiveScripts"];

					private _serverSpawnedScripts = _serverActiveScripts select 0;
					private _serverExecVMScripts = _serverActiveScripts select 1;
					private _serverExecScripts = _serverActiveScripts select 2;
					private _serverExecFSMScripts = _serverActiveScripts select 3;

					private _clientFps = diag_fps;
					private _clientMinFps = diag_fpsMin;
					private _clientObjCount = count allMissionObjects "All";
					private _clientActiveScripts = diag_activeScripts;

					private _clientSpawnedScripts = _clientActiveScripts select 0;
					private _clientExecVMScripts = _clientActiveScripts select 1;
					private _clientExecScripts = _clientActiveScripts select 2;
					private _clientExecFSMScripts = _clientActiveScripts select 3;

					_monitorText = "<t color='#FFFF33' align='center'>===== DIAGNOSTICS MONITOR =====</t><br/><br/>";

					_monitorText = _monitorText + "<t color='#FF0000' align='center'>======= SERVER =======</t><br/>";
					_monitorText = _monitorText + (format ["FPS: %1", _serverFps]) + "<br/>";
					_monitorText = _monitorText + (format ["Min FPS: %1", _serverMinFps]) + "<br/><br/>";
					_monitorText = _monitorText + (format ["AI units: %1", _serverAIUnitsCount]) + "<br/>";
					_monitorText = _monitorText + (format ["Objects with simulation: %1", _serverEnabledSimulationObjectsCount]) + "<br/>";
					_monitorText = _monitorText + (format ["Total objects: %1", _serverObjCount]) + "<br/><br/>";
					_monitorText = _monitorText + "Active scripts:<br/>";
					_monitorText = _monitorText + (format ["- spawn: %1", _serverSpawnedScripts]) + "<br/>";
					_monitorText = _monitorText + (format ["- exec: %1", _serverExecScripts]) + "<br/>";
					_monitorText = _monitorText + (format ["- execVM: %1", _serverExecVMScripts]) + "<br/>";
					_monitorText = _monitorText + (format ["- execFSM: %1", _serverExecFSMScripts]) + "<br/><br/>";

					_monitorText = _monitorText + "<t color='#FF0000' align='center'>======= YOU =======</t><br/>";
					_monitorText = _monitorText + (format ["FPS: %1", _clientFps]) + "<br/>";
					_monitorText = _monitorText + (format ["Min FPS: %1", _clientMinFps]) + "<br/>";
					_monitorText = _monitorText + (format ["Total objects: %1", _clientObjCount]) + "<br/><br/>";
					_monitorText = _monitorText + "Active scripts:<br/>";
					_monitorText = _monitorText + (format ["- spawn: %1", _clientSpawnedScripts]) + "<br/>";
					_monitorText = _monitorText + (format ["- exec: %1", _clientExecScripts]) + "<br/>";
					_monitorText = _monitorText + (format ["- execVM: %1", _clientExecVMScripts]) + "<br/>";
					_monitorText = _monitorText + (format ["- execFSM: %1", _clientExecFSMScripts]) + "<br/>";
					_monitorText = _monitorText + "<t color='#FFFF33' align='center'>==============================</t>";

					hint parseText _monitorText;

				}] remoteExec ["spawn", _user];

			} forEach _users;
			
		},
		_interval,
		[]
	] call CBA_fnc_addPerFrameHandler;

}] remoteExec ["spawn", 2];
