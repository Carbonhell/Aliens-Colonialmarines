#if !defined(MAP_FILE)

		#define TITLESCREEN "title" //Add an image in misc/fullscreen.dmi, and set this define to the icon_state, to set a custom titlescreen for your map

		#define MINETYPE "mining"

        #include "map_files\CM\sulaco.dmm"
        #include "map_files\generic\z2.dmm"
        #include "map_files\CM\unk379.dmm"

		#define MAP_PATH "map_files/CM"
        #define MAP_FILE "sulaco.dmm"
        #define MAP_NAME "Sulaco"

		#define MAP_TRANSITION_CONFIG DEFAULT_MAP_TRANSITION_CONFIG

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring /tg/station 2.

#endif
