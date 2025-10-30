#define COMPONENT radio
#include "\z\tis_main\addons\main\script_mod.hpp"

// #define DEBUG_ENABLED_TIS_RADIO
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_TIS_RADIO
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_ENABLED_TIS_RADIO
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TIS_RADIO
#endif

#include "\z\tis_main\addons\main\script_macros.hpp"

// TFAR macros
#define TFAR_PREFIX tfar

#define TFAR_PATHTOF(component,path) \z\tfar\addons\component\path
#define TFAR_QPATHTOF(component,path) QUOTE(TFAR_PATHTOF(component,path))
