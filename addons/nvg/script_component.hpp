#define COMPONENT nvg
#include "\z\tis_main\addons\main\script_mod.hpp"

// #define DEBUG_ENABLED_TIS_NVG
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_TIS_NVG
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_ENABLED_TIS_NVG
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TIS_NVG
#endif

#include "\z\tis_main\addons\main\script_macros.hpp"

#define NVG_BATTERY_MAX_LIFEPOINTS 10000
