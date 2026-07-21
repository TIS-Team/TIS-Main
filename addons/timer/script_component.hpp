#define COMPONENT timer
#include "\z\tis_main\addons\main\script_mod.hpp"

// #define DEBUG_ENABLED_TIS_TIMER
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_TIS_TIMER
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_ENABLED_TIS_TIMER
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TIS_TIMER
#endif

#include "\z\tis_main\addons\main\script_macros.hpp"


#define TIS_TIMER_DISPLAY_IDD 55552
