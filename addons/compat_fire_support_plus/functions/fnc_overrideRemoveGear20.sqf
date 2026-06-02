#include "script_component.hpp"

WNZ_EMP_RemoveGearFunc_20 = {
    _AOE = 20;

    {				
        private _gear = tisFspGear;
        private _nvgsw = tisFspNvgs;
        private _binos = TIS_FSP_Binos;
        private _acreRadios = TIS_FSP_AcreRadios;

        if(alive _x) then {
                 
            _itemsUnit = assignedItems _x;
            _commonItemsArray = ((_nvgsw + _binos + _gear + _acreRadios) arrayIntersect _itemsUnit);
            _nvg = _commonItemsArray select 0;
            if(!isNil '_nvg') then {
                _x unassignItem _nvg;
                _x removeItem _nvg;
                _x removeWeapon _nvg;
            };
            _unitGear = items _x;
            _radioItemsArray = (_acreRadios arrayIntersect _unitGear);
            _radioItems = _radioItemsArray select 0;
            if(!isNil '_radioItems') then {
                _x unassignItem _radioItems;
                _x removeItem _radioItems;
                _x removeWeapon _radioItems;
            };
            _unitradio = assignedItems _x select {_x call BIS_fnc_itemType select 1 == "Radio"} param [0, ""];
            _x unassignItem _unitradio;
            _x removeItem _unitradio;
            _x removeWeapon _unitradio;
            if (_unitradio isNotEqualTo "") then {
                [QGVAR(fspEmpRemoveItem), [_x, _unitradio]] call CBA_fnc_localEvent;
            };

            _unit = _x;
            private _weaponItems = tisFspWeaponItems;
            {
                _unit removePrimaryWeaponItem _x; 
            } forEach _weaponItems;
        };
    } forEach (nearestObjects [_this, [
    "Civilian",
    "SoldierGB",
    "SoldierEB",
    "SoldierWB"
    ], _AOE]); 

};
