#define COMPONENT zeus
#include "\z\tis_main\addons\main\script_mod.hpp"

#define DEBUG_ENABLED_TIS_ZEUS
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_TIS_ZEUS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_ENABLED_TIS_ZEUS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TIS_ZEUS
#endif

#include "\z\tis_main\addons\main\script_macros.hpp"
// Include BI DIK codes
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

#define SIZEX ((safeZoneW / safeZoneH) min 1.2)
#define SIZEY (SIZEX / 1.2)
#define W_PART(num) (num * (SIZEX / 40))
#define H_PART(num) (num * (SIZEY / 25))
#define X_PART(num) (W_PART(num) + (safeZoneX + (safeZoneW - SIZEX) / 2))
#define Y_PART(num) (H_PART(num) + (safeZoneY + (safeZoneH - SIZEY) / 2))
