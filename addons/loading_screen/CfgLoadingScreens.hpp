#include "\a3\ui_f\hpp\defineCommonGrids.inc"

class RscPicture{}; //part of the background
class RscStandardDisplay{};
class RscActiveText{};
class RscActivePicture: RscActiveText{};
class RscText{}; 

//_randomImage = selectRandom [QPATHTOF(img\1.jpg),QPATHTOF(img\2.jpg),QPATHTOF(img\3.jpg),QPATHTOF(img\4.jpg),QPATHTOF(img\5.jpg),QPATHTOF(img\6.jpg),QPATHTOF(img\7.jpg),QPATHTOF(img\8.jpg),QPATHTOF(img\9.jpg),QPATHTOF(img\10.jpg),QPATHTOF(img\11.jpg),QPATHTOF(img\12.jpg),QPATHTOF(img\13.jpg),QPATHTOF(img\14.jpg),QPATHTOF(img\15.jpg),QPATHTOF(img\16.jpg),QPATHTOF(img\17.jpg),QPATHTOF(img\18.jpg),QPATHTOF(img\19.jpg),QPATHTOF(img\20.jpg),QPATHTOF(img\21.jpg),QPATHTOF(img\22.jpg),QPATHTOF(img\23.jpg),QPATHTOF(img\24.jpg),QPATHTOF(img\25.jpg),QPATHTOF(img\26.jpg),QPATHTOF(img\27.jpg),QPATHTOF(img\28.jpg),QPATHTOF(img\29.jpg),QPATHTOF(img\30.jpg),QPATHTOF(img\31.jpg),QPATHTOF(img\32.jpg),QPATHTOF(img\33.jpg),QPATHTOF(img\34.jpg),QPATHTOF(img\35.jpg)];

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

		class Loading_West1 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\2.jpg);
				};
			};
		};
		class Loading_West2 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\3.jpg);
				};
			};
		};
		class Loading_West3 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\7.jpg);
				};
			};
		};
		class Loading_West4 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\8.jpg);
				};
			};
		};
		class Loading_West5 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\9.jpg);
				};
			};
		};
		class Loading_West6 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\10.jpg);
				};
			};
		};
		class Loading_West7 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\11.jpg);
				};
			};
		};
		class Loading_West8 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\12.jpg);
				};
			};
		};
		class Loading_West9 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\13.jpg);
				};
			};
		};
		class Loading_West10 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\20.jpg);
				};
			};
		};
		class Loading_West11 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\21.jpg);
				};
			};
		};
		class Loading_West12 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\22.jpg);
				};
			};
		};
		class Loading_West13 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\23.jpg);
				};
			};
		};
		class Loading_West14 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\24.jpg);
				};
			};
		};
		class Loading_West15 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\25.jpg);
				};
			};
		};
		class Loading_West16 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\26.jpg);
				};
			};
		};
		class Loading_West17 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\27.jpg);
				};
			};
		};
		class Loading_East1 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\4.jpg);
				};
			};
		};
		class Loading_East2 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\5.jpg);
				};
			};
		};
		class Loading_East3 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\6.jpg);
				};
			};
		};
		class Loading_East4 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\14.jpg);
				};
			};
		};
		class Loading_East5 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\15.jpg);
				};
			};
		};
		class Loading_East6 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\16.jpg);
				};
			};
		};
		class Loading_East7 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\17.jpg);
				};
			};
		};
		class Loading_East8 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\18.jpg);
				};
			};
		};
		class Loading_East9 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\19.jpg);
				};
			};
		};
		class Loading_East10 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\28.jpg);
				};
			};
		};
		class Loading_East11 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\29.jpg);
				};
			};
		};
		class Loading_East12 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\30.jpg);
				};
			};
		};
		class Loading_East13 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\31.jpg);
				};
			};
		};
		class Loading_East14 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\32.jpg);
				};
			};
		};
		class Loading_East15 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\33.jpg);
				};
			};
		};
		class Loading_East16 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\34.jpg);
				};
			};
		};
		class Loading_East17 : LoadingOne 
		{
			class controls : controls 
			{
				class LoadingPic : LoadingPic 
				{
					text = QPATHTOF(img\35.jpg);
				};
			};
		};
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
