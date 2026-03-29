#include "\a3\ui_f\hpp\defineCommonGrids.inc"

class RscPicture{}; //part of the background
class RscStandardDisplay{};
class RscActiveText{};
class RscActivePicture: RscActiveText{};
class RscText{}; 

#define LOADING_IMAGE(_NUMBER_) class Loading_Image##_NUMBER_ : LoadingOne { \
    class controls: controls { \
        class LoadingPic : LoadingPic { \
			text = QPATHTOF(img\##_NUMBER_##.jpg); \
        }; \
    }; \
};

class RscDisplayLoading {
	class Variants {
		class LoadingOne {
			idd = 250;
			class controls {
				class LoadingPic : RscPicture {
					idc=1;
					x = "SafeZoneX";
					y = "SafeZoneY";
					h = "SafeZoneH";
					w = "SafeZoneW";
					text = QPATHTOF(img\1.jpg);
				};
			};
		};

		LOADING_IMAGE(2)
		LOADING_IMAGE(3)
		LOADING_IMAGE(4)
		LOADING_IMAGE(5)
		LOADING_IMAGE(6)
		LOADING_IMAGE(7)
		LOADING_IMAGE(8)
		LOADING_IMAGE(9)
		LOADING_IMAGE(10)
		LOADING_IMAGE(11)
		LOADING_IMAGE(12)
		LOADING_IMAGE(13)
		LOADING_IMAGE(14)
		LOADING_IMAGE(15)
		LOADING_IMAGE(16)
		LOADING_IMAGE(17)
		LOADING_IMAGE(18)
		LOADING_IMAGE(19)
		LOADING_IMAGE(20)
		LOADING_IMAGE(21)
		LOADING_IMAGE(22)
		LOADING_IMAGE(23)
		LOADING_IMAGE(24)
		LOADING_IMAGE(25)
		LOADING_IMAGE(26)
		LOADING_IMAGE(27)
		LOADING_IMAGE(28)
		LOADING_IMAGE(29)
		LOADING_IMAGE(30)
		LOADING_IMAGE(31)
		LOADING_IMAGE(32)
		LOADING_IMAGE(33)
		LOADING_IMAGE(34)
		LOADING_IMAGE(35)
	};
};

class RscDisplayMPPlayers;
class RscDisplayClientWait : RscDisplayMPPlayers 
{
	class LoadingPic : RscPicture 
	{
		text = QPATHTOF(img\4.jpg);
	};
};
