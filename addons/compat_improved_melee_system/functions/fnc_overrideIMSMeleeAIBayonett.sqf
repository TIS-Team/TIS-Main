IMS_AI_MeleeAIBayonet = {
    _unit = _this;
    if ((captive _unit) or !(isNil {_unit getVariable "IMS_IsUnitInvicibleScripted"}) or !(isNil {_unit getVariable "WBK_AI_ISZombie"})) exitWith {};

	if (!isNull (_unit getVariable ["BIS_fnc_moduleRemoteControl_owner", objNull])) exitWith {};

    if (!(alive _unit) or !(IMS_BayonetOnAI) or (handgunWeapon _unit in IMS_Melee_Weapons) or (primaryWeapon _unit == "") or (isPlayer _unit)) exitWith {};

    waitUntil {!(captive _unit) and (behaviour _unit == "COMBAT") and (((_unit findNearestEnemy _unit) distance _unit) <= IMS_BayoneteDistanceWork) and ((_unit findNearestEnemy _unit) isKindOf "MAN")};

    if ((isPlayer _unit) or (currentWeapon _unit == "") or !(isNil {_unit getVariable "WBK_AI_ISZombie"})) exitWith {};

    _unit spawn IMS_AI_MakeAiGoBayonetScript;
    sleep 1;
    
	if ((captive _unit) or (isPlayer _unit) or (currentWeapon _unit == "") or !(isNil {_unit getVariable "WBK_AI_ISZombie"})) exitWith {};
    
	waitUntil {(isNil {_unit getVariable "WBK_AI_BIC"})};
    
	if ((isPlayer _unit) or (currentWeapon _unit == "") or !(isNil {_unit getVariable "WBK_AI_ISZombie"})) exitWith {};
    
	_unit enableAI "MOVE";
    _unit enableAI "PATH";
    _unit doMove (getPos _unit);
    sleep 3;
    
	if ((isPlayer _unit) or (currentWeapon _unit == "") or !(isNil {_unit getVariable "WBK_AI_ISZombie"})) exitWith {};
	
    _unit spawn IMS_AI_MeleeAIBayonet;
};
