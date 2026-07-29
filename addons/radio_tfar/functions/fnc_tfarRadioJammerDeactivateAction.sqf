#include "script_component.hpp"

params [
    ["_actionType", 'SCROLL', ['string']], // SCROLL, HOLD, NONE
    ["_actionName", "Deactivate Jammer", ["string"]], 
    ["_actionTime", 5, [5]], // Only valid for HOLD action
    ["_shouldCreateAceAction", false, [true]], // TRUE/FALSE
    ["_requiredItem", "", ["string"]], 
    ["_hideActionOnSuccess", false, [true]], 
    ["_onDeactivationCode", {}, [{}]]
];

if(EGVAR(main,isAceInteractionMenuLoaded)) then {
    // Create ACE action
};
