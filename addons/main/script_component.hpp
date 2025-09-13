#define COMPONENT tis_main
#include "\z\tis\addons\tis_main\script_mod.hpp"

// #define DEBUG_ENABLED_TIS_MAIN
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_TIS_MAIN
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_ENABLED_TIS_MAIN
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TIS_MAIN
#endif

#include "\z\tis\addons\tis_main\script_macros.hpp"
