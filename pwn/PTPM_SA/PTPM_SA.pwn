#define PTPM_Main_File

#define	PTPM_Pocket_Money			500
#define	PTPM_Restart_Count			20
#define	PTPM_Round_Time_Minutes		15
#define	PTPM_Round_Time_Seconds		0

#define MAX_CHATBOX_LINES			0
#define MAX_PRIVAT_CHATBOX_LINES	0

/*******************************************************************************
		Protect the Prime Minister - San Andreas
			Copyright (C) 2009  Mark "Nero_3D"

	Description:
		There are five teams Psycho, Terrorist, PrimeMinister, Bodyguard and Cop
		The Prime Minister should survive the round with the help from his loyal
		Bodyguards (spawns near him) and the Cops (spawns @ police department)
		Meanwhile the Terrorists try to assassinate the Prime Minister
		The Psychos are free to do what they want

	Licence:
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program. If not, see <http://www.gnu.org/licenses/>.

	Credits:
		- To Spark for Protect the Prime Minister
		- To all other people / scripter who improve the original mode

	Changelog:
		0.3h - 0.3i (15.12.11):
			* Easy switch between textdraw / normal chat (chatbox lines set to 0)
			* LetterDeleter, pm, query, GetIDEx and changeName fixed / updated
		0.3g - 0.3h (01.01.11):
			* Offset in anit-cheat system added since the health value
				sometimes changed to 99.99 instead of 100.0 and you got kicked
			* Textdraw changed and some useless arrays removed -> more available player
			* PTPM_Initialize added
			* PTPM_GetMap fixed
		0.3f - 0.3g (01.12.10):
			* Class / Team / Map system is now variable based (ex: enum based)
			* Directive PTPM_File_System added, to disable / enable the System
			* Vehicle healthbar updates now on state change, too
			* Steadily nitro added (like in Singelplayer)
			* PTPM_File_System not compatible with 0.3c

*******************************************************************************/

#define NUM_CLASSES	(29)
#define NUM_TEAMS	(5)
#define NUM_MAPS	(7)

#include PTPM_SA_Def // Creation part

PTPM_Create_Class(C_Psycho1);
PTPM_Create_Class(C_Psycho2);
PTPM_Create_Class(C_Psycho3);
PTPM_Create_Class(C_Psycho4);
PTPM_Create_Class(C_Terrorist1);
PTPM_Create_Class(C_Terrorist2);
PTPM_Create_Class(C_Terrorist3);
PTPM_Create_Class(C_Terrorist4);
PTPM_Create_Class(C_Terrorist5);
PTPM_Create_Class(C_Terrorist6);
PTPM_Create_Class(C_Terrorist7);
PTPM_Create_Class(C_Terrorist_Medic);
PTPM_Create_Class(C_PrimeMinister);
PTPM_Create_Class(C_Bodyguard1);
PTPM_Create_Class(C_Bodyguard2);
PTPM_Create_Class(C_Bodyguard3);
PTPM_Create_Class(C_Bodyguard4);
PTPM_Create_Class(C_Bodyguard5);
PTPM_Create_Class(C_Bodyguard_Medic);
PTPM_Create_Class(C_Cop1);
PTPM_Create_Class(C_Cop2);
PTPM_Create_Class(C_Cop3);
PTPM_Create_Class(C_Cop4);
PTPM_Create_Class(C_Cop5);
PTPM_Create_Class(C_Cop6);
PTPM_Create_Class(C_Cop7);
PTPM_Create_Class(C_Cop8);
PTPM_Create_Class(C_Cop9);
PTPM_Create_Class(C_Cop_Medic);

PTPM_Create_Team(T_Psycho);
PTPM_Create_Team(T_Terrorist);
PTPM_Create_Team(T_PrimeMinister);
PTPM_Create_Team(T_Bodyguard);
PTPM_Create_Team(T_Cop);

PTPM_Create_Map(M_Desert);
PTPM_Create_Map(M_Bayside);
PTPM_Create_Map(M_Los_Santos);
PTPM_Create_Map(M_San_Fierro);
PTPM_Create_Map(M_Countryside);
PTPM_Create_Map(M_Las_Venturas);
PTPM_Create_Map(M_Mount_Chiliad);

#include PTPM_SA_Functions // Definition part

PTPM_Initialize(
	T_Psycho,
	T_Terrorist,
	T_PrimeMinister,
	T_Bodyguard,
	T_Cop
);

PTPM_Assign_Side(T_Psycho,						S_Neutral);
PTPM_Assign_Side(T_Terrorist,					S_Bad);
PTPM_Assign_Side(T_PrimeMinister,				S_Good);
PTPM_Assign_Side(T_Bodyguard,					S_Good);
PTPM_Assign_Side(T_Cop,							S_Good);

PTPM_AddPlayerClass(230,	C_Psycho1,			T_Psycho);
PTPM_AddPlayerClass(212,	C_Psycho2,			T_Psycho);
PTPM_AddPlayerClass(200,	C_Psycho3,			T_Psycho);
PTPM_AddPlayerClass(137,	C_Psycho4,			T_Psycho);
PTPM_AddPlayerClass(181,	C_Terrorist1,		T_Terrorist);
PTPM_AddPlayerClass(183,	C_Terrorist2,		T_Terrorist);
PTPM_AddPlayerClass(179,	C_Terrorist3,		T_Terrorist);
PTPM_AddPlayerClass(191,	C_Terrorist4,		T_Terrorist);
PTPM_AddPlayerClass(111,	C_Terrorist5,		T_Terrorist);
PTPM_AddPlayerClass( 73,	C_Terrorist6,		T_Terrorist);
PTPM_AddPlayerClass(100,	C_Terrorist7,		T_Terrorist);
PTPM_AddPlayerClass(274,	C_Terrorist_Medic,	T_Terrorist);
PTPM_AddPlayerClass(147,	C_PrimeMinister,	T_PrimeMinister);
PTPM_AddPlayerClass(163,	C_Bodyguard1,		T_Bodyguard);
PTPM_AddPlayerClass(164,	C_Bodyguard2,		T_Bodyguard);
PTPM_AddPlayerClass(165,	C_Bodyguard3,		T_Bodyguard);
PTPM_AddPlayerClass(166,	C_Bodyguard4,		T_Bodyguard);
PTPM_AddPlayerClass(141,	C_Bodyguard5,		T_Bodyguard);
PTPM_AddPlayerClass(276,	C_Bodyguard_Medic,	T_Bodyguard);
PTPM_AddPlayerClass(280,	C_Cop1,				T_Cop);
PTPM_AddPlayerClass(281,	C_Cop2,				T_Cop);
PTPM_AddPlayerClass(282,	C_Cop3,				T_Cop);
PTPM_AddPlayerClass(283,	C_Cop4,				T_Cop);
PTPM_AddPlayerClass(284,	C_Cop5,				T_Cop);
PTPM_AddPlayerClass(285,	C_Cop6,				T_Cop);
PTPM_AddPlayerClass(286,	C_Cop7,				T_Cop);
PTPM_AddPlayerClass(288,	C_Cop8,				T_Cop);
PTPM_AddPlayerClass(246,	C_Cop9,				T_Cop);
PTPM_AddPlayerClass(275,	C_Cop_Medic,		T_Cop);

PTPM_Initialize(
	M_Desert,
	M_Bayside,
	M_Los_Santos,
	M_San_Fierro,
	M_Countryside,
	M_Las_Venturas,
	M_Mount_Chiliad
);
PTPM_AddSelectionForMap(M_Desert, -346.3293, 1626.5712, 136.3119, 0.00, 0);
PTPM_AddSelectionForMap(M_Bayside, -2232.0784, 2361.3523, 19.7882, 184.0, 0);
PTPM_AddSelectionForMap(M_Los_Santos, 1526.7882, -1346.4575, 330.0, 63.000, 0);
PTPM_AddSelectionForMap(M_San_Fierro, -1397.0000, 1482.0000, 11.8084, 70.000, 0);
PTPM_AddSelectionForMap(M_Countryside, -412.8500, -424.8300, 32.32000, 157.5869, 0);
PTPM_AddSelectionForMap(M_Las_Venturas, 1955.3408, 1019.0750, 992.46880, 127.6004, 10);
PTPM_AddSelectionForMap(M_Mount_Chiliad, -2229.3877, -1741.4910, 480.8772, 153.0000, 0);

PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 893.7170,-1637.5000,14.9367,180.0000, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 656.0589,-1636.7515,15.8617,102.6886, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 593.5764,-1383.7019,13.6682,117.4029, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 505.6629,-1609.1188,16.3589,330.7107, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 294.9947,-1766.2690,4.5453,182.6461, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 430.5126,-1605.1104,34.1719,302.8052, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 916.3024,-863.5972,93.4565,152.5196, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 1510.8865,-689.1223,99.1328,207.7941, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2045.5173,-1115.5264,26.3617,273.7593, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2440.6575,-1010.9585,54.3438,185.0685, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2627.8757,-1098.6428,69.3694,268.6843, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2797.5376,-1245.7338,47.2274,190.0321, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2752.6917,-1964.4032,13.5469,226.4974, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2636.4524,-2012.8119,13.8139,312.0134, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2443.4824,-1980.8752,13.5469,304.5382, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2241.5457,-1883.4490,14.2344,190.6184, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2158.2515,-1707.6194,15.0859,287.6188, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2513.3923,-1689.7417,13.5502,41.5060, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2479.1199,-1756.6984,13.5469,358.8609, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2400.1738,-1367.1586,24.4893,171.9243, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2333.3208,-1201.2969,27.9766,271.1118, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2147.8079,-1433.2224,25.5391,83.8630, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2063.9387,-1584.9390,13.4817,268.8572, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 2068.4966,-1731.4603,13.8762,286.2860, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 1970.0746,-1671.6226,18.5456,88.8550, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 1674.9097,-2121.2742,13.8333,328.9870, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_Psycho, 1855.5497,-2115.4836,15.1679,209.0140, 0);
PTPM_TeamLineSpawns(M_Los_Santos, T_Terrorist, 2768.3684,-1601.6525,10.9272,2769.9431,-1625.5819,10.9272, 1.0, 0);
PTPM_TeamSpawnPoint(M_Los_Santos, T_PrimeMinister, 1125.7273, -2036.8785, 69.8804, 270.0, 0);
PTPM_TeamLineSpawns(M_Los_Santos, T_Bodyguard, 1133,-2006.7264,69.8804, 1133,-2066.7264,69.8804, 2.0, 0);
PTPM_TeamLineSpawns(M_Los_Santos, T_Cop, 1585,-1674.1223,6.2252, 1585,-1692.6426,6.2252, 2.0, 0);
PTPM_TeamLineSpawns(M_Los_Santos, T_Cop, 1610,-1719.8339,6.2188, 1610,-1666.3889,6.2188, 2.0, 0);

PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2677.2380,803.3820,49.9766,349.3465, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2112.7102,822.7894,69.5625,178.9732, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2418.6909,970.1836,45.2969,276.4825, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2052.3616,-39.9116,35.3597,162.2615, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2358.4697,657.0453,35.1719,3.1333, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2065.8127,1160.9788,46.6484,359.3500, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2733.0017,-34.1009,4.5173,97.7374, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2734.8157,-88.5975,7.2031,89.5907, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2728.5652,-189.1116,15.1898,264.4091, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2632.1716,-191.6044,7.2031,83.6373, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2510.5493,-109.5545,25.6172,277.2796, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2621.6687,168.6664,7.1953,272.0360, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2792.0320,212.1834,10.0547,356.3686, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2868.3567,691.3984,23.4786,294.7994, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2856.7861,957.5774,44.0547,286.5513, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2927.4834,1125.0161,26.9297,342.4120, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2434.0757,1281.3103,23.7422,85.3318, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2351.7974,1263.2054,26.3264,91.3505, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2228.0762,1107.3237,80.0078,183.9644, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2341.0115,730.7960,42.9343,161.0224, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2186.9912,743.3704,57.4920,178.1954, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -2018.1326,748.3585,45.4453,242.2144, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -1514.3003,-1536.9230,38.0793,307.1506, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_Psycho, -1635.2572,-1270.7701,57.6307,67.7882, 0);
PTPM_TeamLineSpawns(M_San_Fierro, T_Terrorist, -2062,1434,7.1016, -2093,1434,7.1016, 1.0, 0);
PTPM_TeamSpawnPoint(M_San_Fierro, T_PrimeMinister, -2604.2786,-304.8785,23.2305,112.7947, 0);
PTPM_TeamLineSpawns(M_San_Fierro, T_Bodyguard, -2616.1018,-318.4776,23.1227, -2601.2432,-293.0693,23.1227, 1.0, 0);
PTPM_TeamLineSpawns(M_San_Fierro, T_Cop, -1610.3680,733.6467,-4.9063, -1590.5117,733.6737,-4.9063, 2.0, 0);
PTPM_TeamLineSpawns(M_San_Fierro, T_Cop, -1562.6666,757.6099,-4.9063, -1618.2246,757.4536,-4.9063, 2.0, 0);

PTPM_TeamLineSpawns(M_Desert, T_Psycho, -82.2612,1383.4824,10.2407, -77.5519,1347.3890,10.8599, 2.0, 0);
PTPM_TeamLineSpawns(M_Desert, T_Terrorist, -294.2874,1531.7491,75.3594, -345.4248,1530.7903,75.3570, 2.0, 0);
PTPM_TeamSpawnPoint(M_Desert, T_PrimeMinister, 214.8228,1823.0508,6.4141,90.0, 0);
PTPM_TeamLineSpawns(M_Desert, T_Bodyguard, 124.5988,1916.5383,18.9541, 165.6270,1917.3433,18.4533, 2.0, 0);
PTPM_TeamLineSpawns(M_Desert, T_Cop, -388.2652, 2253.8987, 42.0938, -376.3261, 2202.0403, 42.0938, 2.0, 0);

PTPM_TeamLineSpawns(M_Mount_Chiliad, T_Psycho, -1446.7629,-1489.0828,101.7578, -1448.0564,-1534.9163,101.7578, 2.0, 0);
PTPM_TeamSpawnPoint(M_Mount_Chiliad, T_Terrorist, -2818.0095,-1517.0559,140.8438,267.4933, 0);
PTPM_TeamSpawnPoint(M_Mount_Chiliad, T_Terrorist, -2817.9077,-1518.6733,140.8438,266.2962, 0);
PTPM_TeamSpawnPoint(M_Mount_Chiliad, T_Terrorist, -2817.9270,-1520.3000,140.8438,264.8419, 0);
PTPM_TeamSpawnPoint(M_Mount_Chiliad, T_Terrorist, -2817.8613,-1522.2753,140.8438,262.7049, 0);
PTPM_TeamSpawnPoint(M_Mount_Chiliad, T_Terrorist, -2817.8523,-1524.4056,140.8438,265.0107, 0);
PTPM_TeamSpawnPoint(M_Mount_Chiliad, T_Terrorist, -2817.9915,-1526.8164,140.8438,262.9298, 0);
PTPM_TeamSpawnPoint(M_Mount_Chiliad, T_Terrorist, -2817.9590,-1529.1571,140.8438,264.2394, 0);
PTPM_TeamSpawnPoint(M_Mount_Chiliad, T_Terrorist, -2809.3828,-1517.5955,140.8438,267.9760, 0);
PTPM_TeamSpawnPoint(M_Mount_Chiliad, T_Terrorist, -2808.8022,-1521.2811,140.8438,268.0885, 0);
PTPM_TeamSpawnPoint(M_Mount_Chiliad, T_Terrorist, -2808.7705,-1524.7393,140.8438,268.4580, 0);
PTPM_TeamSpawnPoint(M_Mount_Chiliad, T_PrimeMinister, -1985.1062,-1550.1643,88.0002,270, 0);
PTPM_TeamLineSpawns(M_Mount_Chiliad, T_Bodyguard, -2006.9596,-1518.3007,85.1718, -2007.4741,-1562.4833,88.7751, 2.0, 0);
PTPM_TeamLineSpawns(M_Mount_Chiliad, T_Cop, -2408.7991,-2180.7649,33.2891, -2406.7439,-2192.7683,33.2891, 2.0, 0);
PTPM_TeamLineSpawns(M_Mount_Chiliad, T_Cop, -2368.5933,-2161.9119,35.5307, -2398.5989,-2161.1355,35.5019, 2.0, 0);

PTPM_TeamSpawnPoint(M_Bayside, T_Psycho, -905.7904,1515.3550,26.3168,3.0383, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Psycho, -881.7125,1532.2938,25.9114,357.5102, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Psycho, -881.5452,1562.0956,25.9114,157.7955, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Psycho, -636.7081,1446.7806,13.9965,213.6897, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Psycho, -743.1528,1432.2576,16.0937,185.0740, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Terrorist, -789.0142,2748.7109,48.2556,267.7834, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Terrorist, -789.2872,2764.3579,48.2556,265.7383, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Terrorist, -775.6995,2764.7869,48.2556,175.7971, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Terrorist, -760.1064,2765.0349,48.2556,177.8541, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_PrimeMinister, -2626.1106,2287.6431,8.3026,267.9435, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Bodyguard, -2622.1106,2287.6431,8.2813,267.9435, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Bodyguard, -2626.1106,2291.6431,8.3026,267.9435, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Bodyguard, -2626.1106,2283.6431,8.3026,267.9435, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Cop, -1393.6278,2629.1965,55.9575,85.2886, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Cop, -1393.6278,2631.1965,55.9334,85.2886, 0);
PTPM_TeamSpawnPoint(M_Bayside, T_Cop, -1393.6278,2635.1965,55.9334,85.2886, 0);

PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 1567.5857,15.2243,23.9857,99.4894, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 1549.0253,33.3922,24.1406,286.8644, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 1393.9169,466.2315,20.1335,152.8359, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 1359.7794,484.9118,20.2109,190.7496, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 865.9806,-18.3443,63.1953,154.4011, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 843.2611,-19.8160,64.4680,180.4315, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 267.4687,-498.9353,20.3615,41.9176, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 271.2937,-529.1648,24.0029,223.6293, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 300.0748,49.6266,2.7073,111.4777, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, -399.1404,-421.7239,16.2109,170.3078, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, -547.5909,-183.3856,78.3984,173.4266, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, -567.5013,-175.7648,78.4063,357.8924, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 1919.2909,150.6793,37.2629,157.5848, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 1947.0986,165.3667,37.2813,337.4165, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 2868.9531,-407.1333,7.7246,57.5325, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Psycho, 2356.0249,-647.8123,128.0547,263.7268, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -39.6833,94.4979,3.1172,159.3593, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -25.8858,86.3813,3.1172,72.5651, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -27.4799,81.0665,3.1172,76.3251, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -29.5620,76.1999,3.1096,72.8784, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -30.9758,71.0960,3.1172,70.0584, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -32.1034,65.2743,3.1172,75.0718, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -34.6525,56.5984,3.1172,28.0714, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -69.9844,69.6274,3.1172,271.1970, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -58.7489,60.1032,3.1103,342.6142, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -55.6768,59.0352,3.1103,339.4808, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -57.3817,60.1656,6.5911,338.8542, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -39.3132,54.1351,6.4844,342.6142, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Terrorist, -48.5333,28.0931,3.1172,160.9025, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_PrimeMinister, 1106.8263,-306.8298,73.9922,88.5804, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Bodyguard, 1045.6045,-314.8521,77.5017,179.7847, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Bodyguard, 1045.5465,-314.7320,73.9931,180.4113, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Bodyguard, 1032.6125,-314.0947,73.9922,177.9047, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Bodyguard, 1019.4659,-314.5684,77.5039,179.1580, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Bodyguard, 1019.4614,-314.3777,73.9931,179.1580, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Bodyguard, 1107.5851,-314.5782,73.9922,2.8658, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Bodyguard, 1103.3276,-299.0390,73.9851,181.7575, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Bodyguard, 1091.2754,-329.0343,73.9922,90.3161, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Cop, 1244.1953,209.7945,23.0555,65.6535, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Cop, 1252.9529,203.4870,25.6452,154.6176, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Cop, 1232.5687,223.5099,19.5547,158.4010, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Cop, 1216.7372,193.4602,19.6857,333.2193, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Cop, 1224.8313,189.3958,19.6534,331.3393, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Cop, 1234.9532,184.7260,19.6806,336.0393, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Cop, 1247.3411,179.4906,19.6524,333.5327, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Cop, 1190.6863,148.6191,20.5144,336.9560, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Cop, 1230.2233,129.8635,20.3739,345.1028, 0);
PTPM_TeamSpawnPoint(M_Countryside, T_Cop, 1243.9302,203.2454,19.5547,153.0510, 0);

PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1958.3783,1343.1572,15.3746,270.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 2199.6531,1393.3678,10.8203,180.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 2483.5977,1222.0825,10.8203,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 2637.2712,1129.2743,11.1797,180.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 2000.0106,1521.1111,17.0625,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 2024.8190,1917.9425,12.3386,270.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 2261.9048,2035.9547,10.8203,180.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 2262.0986,2398.6572,10.8203,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 2244.2566,2523.7280,10.8203,180.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 2335.3228,2786.4478,10.8203,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 2150.0186,2734.2297,11.1763,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 2158.0811,2797.5488,10.8203,180.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1969.8301,2722.8564,10.8203,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1652.0555,2709.4072,10.8265,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1564.0052,2756.9463,10.8203,90.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1271.5452,2554.0227,10.8203,270.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1441.5894,2567.9099,10.8203,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1480.6473,2213.5718,11.0234,270.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1400.5906,2225.6960,11.0234,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1598.8419,2221.5676,11.0625,180.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1318.7759,1251.3580,10.8203,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1558.0731,1007.8292,10.8125,270.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 1705.2347,1025.6808,10.8203,90.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, -857.0551,1536.6832,22.5870,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 817.3494,856.5039,12.7891,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, 116.9315,1110.1823,13.6094,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, -18.8529,1176.0159,19.5634,0.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_Psycho, -315.0575,1774.0636,43.6406,0.0, 0);
PTPM_TeamLineSpawns(M_Las_Venturas, T_Terrorist, 2874.4514,891.5120,10.7500, 2874.8750,944.4780,10.7500, 2.0, 0);
PTPM_TeamSpawnPoint(M_Las_Venturas, T_PrimeMinister, 1665.9780,1421.6775,10.7880,261.1286, 0);
PTPM_TeamLineSpawns(M_Las_Venturas, T_Bodyguard, 1675.2441,1425.9346,10.7788, 1691.8999,1386.1178,10.7452, 2.0, 0);
PTPM_TeamLineSpawns(M_Las_Venturas, T_Cop, 2247.0796,2480.5366,3.2734, 2246.4861,2430.7244,3.2734, 2.0, 0);

PTPM_SetClassData(100.0, 0.0, C_Psycho1, WEAPON_MOLTOV, 10, WEAPON_AK47, 100, WEAPON_SAWEDOFF, 80);
PTPM_SetClassData(100.0, 0.0, C_Psycho2, WEAPON_MOLTOV, 10, WEAPON_AK47, 100, WEAPON_SAWEDOFF, 80);
PTPM_SetClassData(100.0, 0.0, C_Psycho3, WEAPON_MOLTOV, 10, WEAPON_AK47, 100, WEAPON_FLAMETHROWER, 80);
PTPM_SetClassData(100.0, 0.0, C_Psycho4, WEAPON_MOLTOV, 10, WEAPON_AK47, 100, WEAPON_FLAMETHROWER, 80);
PTPM_SetClassData(100.0, 0.0, C_Terrorist1, WEAPON_SAWEDOFF, 150, WEAPON_COLT45, 200, WEAPON_M4, 300);
PTPM_SetClassData(100.0, 0.0, C_Terrorist2, WEAPON_SAWEDOFF, 150, WEAPON_M4, 400, WEAPON_FLAMETHROWER, 300);
PTPM_SetClassData(100.0, 0.0, C_Terrorist3, WEAPON_SAWEDOFF, 150, WEAPON_COLT45, 200, WEAPON_FLAMETHROWER, 300);
PTPM_SetClassData(100.0, 0.0, C_Terrorist4, WEAPON_SAWEDOFF, 150, WEAPON_COLT45, 200, WEAPON_M4, 300);
PTPM_SetClassData(100.0, 0.0, C_Terrorist5, WEAPON_SAWEDOFF, 150, WEAPON_M4, 300, WEAPON_SILENCED, 300);
PTPM_SetClassData(100.0, 0.0, C_Terrorist6, WEAPON_SAWEDOFF, 150, WEAPON_COLT45, 200, WEAPON_SILENCED, 300);
PTPM_SetClassData(100.0, 0.0, C_Terrorist7, WEAPON_SILENCED, 150, WEAPON_M4, 400, WEAPON_FLAMETHROWER, 300);
PTPM_SetClassData(100.0, 0.0, C_Terrorist_Medic, WEAPON_PARACHUTE, -1, WEAPON_SILENCED, 100, WEAPON_SPRAYCAN, 300);
PTPM_SetClassData(100.0, 0.0, C_PrimeMinister, WEAPON_CANE, -1, WEAPON_SPRAYCAN, 1000, WEAPON_PARACHUTE, -1);
PTPM_SetClassData(100.0, 0.0, C_Bodyguard1, WEAPON_SILENCED, 100, WEAPON_UZI, 200, WEAPON_PARACHUTE, -1);
PTPM_SetClassData(100.0, 0.0, C_Bodyguard2, WEAPON_SILENCED, 100, WEAPON_UZI, 200, WEAPON_PARACHUTE, -1);
PTPM_SetClassData(100.0, 0.0, C_Bodyguard3, WEAPON_SILENCED, 100, WEAPON_UZI, 200, WEAPON_PARACHUTE, -1);
PTPM_SetClassData(100.0, 0.0, C_Bodyguard4, WEAPON_SILENCED, 100, WEAPON_UZI, 200, WEAPON_PARACHUTE, -1);
PTPM_SetClassData(100.0, 0.0, C_Bodyguard5, WEAPON_SILENCED, 100, WEAPON_UZI, 200, WEAPON_PARACHUTE, -1);
PTPM_SetClassData(100.0, 0.0, C_Bodyguard_Medic, WEAPON_PARACHUTE, -1, WEAPON_SILENCED, 100, WEAPON_SPRAYCAN, 300);
PTPM_SetClassData(100.0, 0.0, C_Cop1, WEAPON_DEAGLE, 100, WEAPON_MP5, 200, WEAPON_SPRAYCAN, 300);
PTPM_SetClassData(100.0, 0.0, C_Cop2, WEAPON_DEAGLE, 100, WEAPON_M4, 200, WEAPON_SPRAYCAN, 300);
PTPM_SetClassData(100.0, 0.0, C_Cop3, WEAPON_DEAGLE, 100, WEAPON_MP5, 200, WEAPON_SPRAYCAN, 300);
PTPM_SetClassData(100.0, 0.0, C_Cop4, WEAPON_DEAGLE, 100, WEAPON_M4, 200, WEAPON_SPRAYCAN, 300);
PTPM_SetClassData(100.0, 0.0, C_Cop5, WEAPON_DEAGLE, 100, WEAPON_MP5, 200, WEAPON_SPRAYCAN, 300);
PTPM_SetClassData(100.0, 0.0, C_Cop6, WEAPON_DEAGLE, 100, WEAPON_M4, 200, WEAPON_SPRAYCAN, 300);
PTPM_SetClassData(100.0, 0.0, C_Cop7, WEAPON_DEAGLE, 100, WEAPON_MP5, 200, WEAPON_SPRAYCAN, 300);
PTPM_SetClassData(100.0, 0.0, C_Cop8, WEAPON_DEAGLE, 100, WEAPON_M4, 200, WEAPON_SPRAYCAN, 300);
PTPM_SetClassData(100.0, 0.0, C_Cop9, WEAPON_DEAGLE, 100, WEAPON_MP5, 200, WEAPON_SPRAYCAN, 300);
PTPM_SetClassData(100.0, 0.0, C_Cop_Medic, WEAPON_PARACHUTE, -1, WEAPON_DEAGLE, 100, WEAPON_SPRAYCAN, 300);

PTPM_PM_Health_Bonus = 0.2;
PTPM_Medic_Health_Bonus = 0.5;
PTPM_Player_Health_Bonus = 0.1;

PTPM_AddPickup(PICKUP_ARMOR, 2, 1086.0, -1806.0, 17.0); // 1 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 1562.0, -1888.0, 14.0); // 8 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 1759.0, -2242.0, 1.0); // 11 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 2112.0, -1990.0, 14.0); // 16 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 2125.493, -2275.037, 20.5202); // 18 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 2230.45, -2286.004, 14.3751); // 20 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 1715.12, -1673.51, 20.22); // 10 Los Santos (Interior)
PTPM_AddPickup(PICKUP_ARMOR, 2, 2339.0, -1944.0, 13.0); // 25 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 2543.0, -1625.0, 12.0); // 34 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 2544.0, -1120.0, 62.0); // 35 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 2767.0, -1192.0, 69.0); // 41 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 943.012, -939.8284, 57.7345); // 47 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 1292.7, -769.0, 95.8); // 50 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 2146.559, -2244.46, 13.58); // 53 Los Santos
PTPM_AddPickup(PICKUP_ARMOR, 2, 2186.507, -2244.993, 15.81); // 55 Los Santos
PTPM_AddPickup(PICKUP_PARACHUTE, 2, 1528.222, -1357.985, 330.0371); // 73 Los Santos
PTPM_AddPickup(PICKUP_PARACHUTE, 2, 1797.602, -1308.881, 133.8128); // 81 Los Santos
PTPM_AddPickup(PICKUP_PARACHUTE, 2, -1753.7321, 885.4072, 295.8750);
PTPM_AddPickup(PICKUP_ARMOR, 2, -2618.1980, -306.6282, 22.6980);
PTPM_AddPickup(PICKUP_ARMOR, 2, 233.9903, 111.5600, 1003.2257); // sfpd
PTPM_AddPickup(PICKUP_ARMOR, 2, -1394.0, -373.0, 6.0); // 5 San Fierro
PTPM_AddPickup(PICKUP_ARMOR, 2, -1574.0, 1268.0, 1.27); // 9 San Fierro
PTPM_AddPickup(PICKUP_ARMOR, 2, -2285.0, -24.0, 35.0); // 22 San Fierro
PTPM_AddPickup(PICKUP_ARMOR, 2, -2425.3, 1536.4, 2.1); // 26 San Fierro
PTPM_AddPickup(PICKUP_ARMOR, 2, -2513.0, 770.0, 35.0); // 31 San Fierro
PTPM_AddPickup(PICKUP_ARMOR, 2, -2650.0, -198.0, 4.0); // 38 San Fierro
PTPM_AddPickup(PICKUP_ARMOR, 2, -2916.0, 992.0, 8.0); // 42 San Fierro
PTPM_AddPickup(PICKUP_ARMOR, 2, -2060.03, 304.18, 35.81); // 51 San Fierro
PTPM_AddPickup(PICKUP_PARACHUTE, 2, -1542.857, 698.4825, 139.2658); // 74 San Fierro
PTPM_AddPickup(PICKUP_PARACHUTE, 2, -1753.418, 885.3446, 295.5166); // 75 San Fierro
PTPM_AddPickup(PICKUP_PARACHUTE, 2, -2714.0464, 545.2523, 47.9766); // sf hosp
PTPM_AddPickup(PICKUP_ARMOR, 2, -1863.0, 112.0, 15.0); // 12 San Fierro
PTPM_AddPickup(PICKUP_ARMOR, 2, 252.0, 2616.0, 17.0); // 32 Desert (maybe)
PTPM_AddPickup(PICKUP_ARMOR, 2, 108.48, 1919.29, 18.56); // 48 Desert
PTPM_AddPickup(PICKUP_PARACHUTE, 2, -225.6758, 1394.256, 172.0143); // 77 Desert
PTPM_AddPickup(PICKUP_PARACHUTE, 2, -86.2668, 2267.6125, 124.8475); // Parachute
PTPM_AddPickup(PICKUP_ARMOR, 2, -361.4214, 1595.8302, 76.4161); // Armor
PTPM_AddPickup(PICKUP_ARMOR, 2, -504.9502, 2027.8844, 43.7017); // Armour
PTPM_AddPickup(PICKUP_PARACHUTE, 2, -352.3621, 1601.4336, 164.5686); // Parachute Maybe
PTPM_AddPickup(PICKUP_PARACHUTE, 2, -2237.1941, -1710.5507, 480.8812); // parachute
PTPM_AddPickup(PICKUP_ARMOR, 2, -2467.4795, -1218.7037, 254.1941); // armour
PTPM_AddPickup(PICKUP_ARMOR, 2, -1986.3958, -1504.4312, 85.2055); // armour
PTPM_AddPickup(PICKUP_ARMOR, 2, -2380.3877, -1637.3463, 491.8316); // armour
PTPM_AddPickup(PICKUP_ARMOR, 2, -2440.0886, -2159.2776, 35.8599); // armour
PTPM_AddPickup(PICKUP_ARMOR, 2, -2888.4492, -1519.1957, 135.3701); // armour
PTPM_AddPickup(PICKUP_ARMOR, 2, -1849.2826, -1667.7755, 27.6797); // armour
PTPM_AddPickup(PICKUP_ARMOR, 2, -1632.9254, -2248.7239, 34.6684); // armour
PTPM_AddPickup(PICKUP_JETPACK, 2, -2238.3298, -1760.9666, 415.2671); // jetpack
PTPM_AddPickup(PICKUP_JETPACK, 2, -2307.3315, -2012.2480, 240.8118); // jetpack
PTPM_AddPickup(PICKUP_ARMOR, 2, -2092.0, -2330.0, 31.0); // 13 Chilliad
PTPM_AddPickup(PICKUP_ARMOR, 2, -2303.0, -1606.0, 484.0); // 24 Chilliad
PTPM_AddPickup(PICKUP_PARACHUTE, 2, -2350.0, -1586.0, 485.0); // 78 Chilliad
PTPM_AddPickup(PICKUP_PARACHUTE, 2, -2138.1853, 2642.8479, 154.8358);
PTPM_AddPickup(PICKUP_PARACHUTE, 2, -2236.5391, 2352.3455, 4.9821);
PTPM_AddPickup(PICKUP_ARMOR, 2, -2638.5386, 2263.3713, 13.3930);
PTPM_AddPickup(PICKUP_ARMOR, 2, -1442.8461, 2652.9485, 55.8359);
PTPM_AddPickup(PICKUP_ARMOR, 2, -781.9979, 2744.9290, 48.4299);
PTPM_AddPickup(PICKUP_ARMOR, 2, -795.5693, 2026.5187, 60.3906);
PTPM_AddPickup(PICKUP_ARMOR, 2, -806.5844, 2257.2332, 70.1676);
PTPM_AddPickup(PICKUP_ARMOR, 2, -2009.9419, 2364.4385, 7.8180);
PTPM_AddPickup(PICKUP_ARMOR, 2, -47.87, 29.81, 6.48);
PTPM_AddPickup(PICKUP_ARMOR, 2, 1240.99, 233.18, 29.69);
PTPM_AddPickup(PICKUP_ARMOR, 2, 1070.62, -358.18, 76.78);
PTPM_AddPickup(PICKUP_ARMOR, 2, 1325.0, 190.0, 19.0); // 4 Countryside
PTPM_AddPickup(PICKUP_ARMOR, 2, 2487.0, 139.0, 27.0); // 29 Countryside
PTPM_AddPickup(PICKUP_ARMOR, 2, -51.0, -232.0, 7.0); // 44 Countryside
PTPM_AddPickup(PICKUP_ARMOR, 2, 761.0, 380.0, 23.0); // 45 Countryside
PTPM_AddPickup(PICKUP_PARACHUTE, 2, 1710.3359, 1614.3585, 10.1191); //para
PTPM_AddPickup(PICKUP_PARACHUTE, 2, 1964.4523, 1917.0341, 130.9375); //para
PTPM_AddPickup(PICKUP_PARACHUTE, 2, 2055.7258, 2395.8589, 150.4766); //para
PTPM_AddPickup(PICKUP_PARACHUTE, 2, 2265.0120, 1672.3837, 94.9219); //para
PTPM_AddPickup(PICKUP_PARACHUTE, 2, 2265.9739, 1623.4060, 94.9219); //para
PTPM_AddPickup(PICKUP_ARMOR, 2, 1000.0, 1068.0, 11.0); // 0 Las Venturas
PTPM_AddPickup(PICKUP_ARMOR, 2, 1269.0, 1352.0, 11.0); // 2 Las Venturas
PTPM_AddPickup(PICKUP_ARMOR, 2, 1433.0, 1852.0, 10.8); // 6 Las Venturas
PTPM_AddPickup(PICKUP_ARMOR, 2, 1531.0, 925.0, 11.0); // 7 Las Venturas
PTPM_AddPickup(PICKUP_ARMOR, 2, 2097.0, 2154.0, 14.0); // 14 Las Venturas (out of reach)
PTPM_AddPickup(PICKUP_ARMOR, 2, 2106.0, 1004.0, 11.0); // 15 Las Venturas
PTPM_AddPickup(PICKUP_ARMOR, 2, 212.0, 1807.0, 22.0); // 17 Las Venturas
PTPM_AddPickup(PICKUP_ARMOR, 2, 2294.0, 547.0, 1.0); // 23 Las Venturas
PTPM_AddPickup(PICKUP_ARMOR, 2, 2435.0, 1663.0, 16.0); // 27 Las Venturas
PTPM_AddPickup(PICKUP_ARMOR, 2, 2500.0, 925.0, 11.0); // 30 Las Venturas
PTPM_AddPickup(PICKUP_ARMOR, 2, 2265.825, 1617.069, 94.5); // 57 Las Venturas
PTPM_AddPickup(PICKUP_ARMOR, 2, 2557.337, 2817.809, 10.82); // 68 Las Venturas (factory)
PTPM_AddPickup(PICKUP_PARACHUTE, 2, 2057.0, 2434.0, 166.0); // 76 Las Venturas
PTPM_AddPickup(PICKUP_PARACHUTE, 2, 2267.989, 1699.668, 101.4); // 82 Las Venturas
PTPM_AddPickup(PICKUP_ARMOR, 2, 1720.7655, 1421.6407, 10.6406);
PTPM_AddPickup(PICKUP_JETPACK, 2, 268.4451, 1884.2373, -30.0938); // jetpack
PTPM_AddPickup(PICKUP_ARMOR, 2, 268.5153, 1891.2520, -12.8603); // armour bottom (terrorist)
PTPM_AddPickup(PICKUP_ARMOR, 2, 220.1820, 1822.7550, 7.5216); // bg armour
PTPM_AddPickup(PICKUP_ARMOR, 2, 266.2813, 1816.398, 1.594); // 39 Area 51
PTPM_AddPickup(PICKUP_ARMOR, 2, 275.169, 1859.699, 9.81); // 40 Area 51
PTPM_AddPickup(PICKUP_ARMOR, 2, 247.016, 1859.22, 14.08); // 58 Area 51
PTPM_AddPickup(PICKUP_ARMOR, 2, 255.36, 1802.007, 7.47); // 67 Area 51
PTPM_AddPickup(PICKUP_ARMOR, 2, 292.46, 1817.89, 1.015); // 71 Area 51
PTPM_AddPickup(PICKUP_ARMOR, 2, 102.0159, 1901.1531, 33.8984); // Armour Outside

PTPM_AddWeaponPickup(WEAPON_AK47, 160, 1308.97, -874.4, 40.0, 30); // 2 Los Santos
PTPM_AddWeaponPickup(WEAPON_AK47, 160, 2129.4, -2280.71, 14.42, 30); // 6 Los Santos
PTPM_AddWeaponPickup(WEAPON_AK47, 160, 825.921, -1165.813, 17.8936, 30); // 8 Los Santos
PTPM_AddWeaponPickup(WEAPON_COLT45, 100, 2447.773, -1975.663, 13.0, 30); // 21 Los Santos
PTPM_AddWeaponPickup(WEAPON_COLT45, 100, 2538.0, -1630.0, 14.0, 30); // 26 Los Santos
PTPM_AddWeaponPickup(WEAPON_COLT45, 100, 2423.892, -1117.452, 41.2464, 30); // 24 Los Santos
PTPM_AddWeaponPickup(WEAPON_COLT45, 100, 338.0, -1875.0, 4.0, 30); // 29 Los Santos
PTPM_AddWeaponPickup(WEAPON_COLT45, 100, 2444.895, -1981.524, 13.933, 30); // 31 Los Santos
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, 2766.0, -2182.0, 11.0, 30); // 37 Los Santos
PTPM_AddWeaponPickup(WEAPON_UZI, 120, 2551.33, -1740.0, 6.49, 30); // 61 Los Santos
PTPM_AddWeaponPickup(WEAPON_UZI, 120, 2790.343, -1427.489, 39.6258, 30); // 62 Los Santos
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 2198.11, -1170.22, 33.5, 30); // 68 Los Santos
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 1764.0, -1930.0, 14.0, 30); // 71 Los Santos
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 2266.0, -1028.0, 59.0, 30); // 73 Los Santos
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 2175.614, -2282.959, 13.54, 30); // 76 Los Santos
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 100, 2428.0, -1214.0, 36.0, 30); // 81 Los Santos
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 100, 832.603, -1273.861, 14.4833, 30); // 83 Los Santos
PTPM_AddWeaponPickup(WEAPON_SILENCED, 100, 1214.0, -1816.0, 17.0, 30); // 90 Los Santos
PTPM_AddWeaponPickup(WEAPON_SPRAYCAN, 500, 2463.0, -1061.0, 60.0, 30); // 94 Los Santos
PTPM_AddWeaponPickup(WEAPON_SPRAYCAN, 500, 2510.0, -1723.0, 19.0, 30); // 95 Los Santos
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, 2529.724, -1678.563, 19.4225, 30); // 104 Los Santos
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, 2574.065, -1134.201, 64.6535, 30); // 105 Los Santos
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, 899.8012, -792.078, 102.0, 30); // 108 Los Santos
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, 2466.0, -1656.1, 13.3, 30); // 109 Los Santos
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, 1408.0, -2380.0, 14.0, 30); // 101 Los Santos
PTPM_AddWeaponPickup(WEAPON_GRENADE, 10, 1309.93, -1468.30, 10.04, 30);
PTPM_AddWeaponPickup(WEAPON_M4, 200, 2196.63, -1090.32, 44.30, 30);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 10, 2549.70, -1330.60, 34.42, 30);
PTPM_AddWeaponPickup(WEAPON_SNIPER, 20, 2015.54, -2132.02, 19.83, 30);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 10, 1671.96, -1673.09, 21.43, 30);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 15, 406.95, -1266.33, 50.01, 30);
PTPM_AddWeaponPickup(WEAPON_SNIPER, 20, 414.46, -1511.86, 31.57, 30);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 15, 862.23, -1377.51, 13.63, 30);
PTPM_AddWeaponPickup(WEAPON_AK47, 150, 1275.21, -1212.06, 13.67, 30);
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 2830.58, -1312.35, 17.84, 30);
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, -2665.0, 1452.0, 7.0, 30);
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, -2092.0, 1121.0, 54.0, 30);
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, -2414.9, 1538.7, 26.0, 30);
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, -2428.4, 1536.3, 2.1, 30);
PTPM_AddWeaponPickup(WEAPON_MP5, 200, -2678.0, -128.0, 4.0, 30);
PTPM_AddWeaponPickup(WEAPON_SNIPER, 20, -1825.8746, 1026.8816, 45.2326, 30);
PTPM_AddWeaponPickup(WEAPON_SNIPER, 20, -1727.9237, 182.3361, 3.5547, 30);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 10, -1853.3662, 987.3723, 35.2830, 30);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 10, -1978.7894, 444.6832, 27.3449, 30);
PTPM_AddWeaponPickup(WEAPON_M4, 200, -2302.4536, 1098.5649, 80.0016, 30);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 15, -1801.0330, 750.2778, 24.8906, 30);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 15, -2706.1077, 375.7592, 4.9687, 30);
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 200, -1496.0, 591.0, 42.0, 30);
PTPM_AddWeaponPickup(WEAPON_UZI, 120, -1679.0, 1410.0, 7.0, 30);
PTPM_AddWeaponPickup(WEAPON_UZI, 120, -2038.43, 139.6281, 28.3359, 30);
PTPM_AddWeaponPickup(WEAPON_KNIFE, -1, -1456.289, 1497.905, 6.7, 30);
PTPM_AddWeaponPickup(WEAPON_KNIFE, -1, -1595.0, 1345.0, -7.5, 30);
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 300, -1579.0, 29.45, 17.0, 30);
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 300, -2132.52, 189.2507, 35.5379, 30);
PTPM_AddWeaponPickup(WEAPON_FIREEXTINGUISHER, 300, -1700.0, 415.0, 7.0, 30);
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, -2212.0, 109.0, 35.0, 30);
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, -1542.022, -437.7364, 5.9258, 30);
PTPM_AddWeaponPickup(WEAPON_COLT45, 100, -2206.0, -23.0, 35.0, 30);
PTPM_AddWeaponPickup(WEAPON_SHOTGUN, 50, -1841.106, -74.2171, 14.7606, 30);
PTPM_AddWeaponPickup(WEAPON_SHOTGUN, 50, -2038.664, 137.4694, 28.3359, 30);
PTPM_AddWeaponPickup(WEAPON_AK47, 220, -1683.497, 716.2739, 30.6452, 30);
PTPM_AddWeaponPickup(WEAPON_SHOTGUN, 25, -1376.4923, 1493.3958, 11.2031, 30);
PTPM_AddWeaponPickup(WEAPON_SHOTGSPA, 30, 238.1103, 112.0389, 1010.2188, 60);
PTPM_AddWeaponPickup(WEAPON_FIREEXTINGUISHER, 200, 218.1052, 115.7770, 1010.2188, 60);
PTPM_AddWeaponPickup(WEAPON_SHOVEL, -1, -140.2877, 1496.0981, 21.3760, 5);
PTPM_AddWeaponPickup(WEAPON_SHOVEL, -1, -137.3183, 1500.3707, 20.3800, 5);
PTPM_AddWeaponPickup(WEAPON_CHAINSAW, -1, -102.5674, 1368.8951, 10.2734, 5);
PTPM_AddWeaponPickup(WEAPON_DILDO, -1, 540.9449, 2358.8433, 30.9870, 5);
PTPM_AddWeaponPickup(WEAPON_FLOWER, -1, 553.3507, 2274.7832, 34.4340, 5);
PTPM_AddWeaponPickup(WEAPON_POOLSTICK, -1, 23.6597, 1363.0038, 9.1719, 5);
PTPM_AddWeaponPickup(WEAPON_BAT, -1, 6.1200, 1382.3802, 9.1781, 5);
PTPM_AddWeaponPickup(WEAPON_DILDO2, -1, -21.2242, 1390.1115, 9.1719, 5);
PTPM_AddWeaponPickup(WEAPON_CHAINSAW, -1, -171.3368, 2526.1011, 26.2891, 5); // Chainsaw
PTPM_AddWeaponPickup(WEAPON_KATANA, -1, -597.6247, 2022.2175, 60.3818, 5);
PTPM_AddWeaponPickup(WEAPON_SHOVEL, -1, -168.2105, 2521.9858, 25.3978, 5); // Shovel
PTPM_AddWeaponPickup(WEAPON_CHAINSAW, -1, -88.1425, 1579.7565, 19.9543, 5); // Chainsaw
PTPM_AddWeaponPickup(WEAPON_SHOVEL, -1, -93.6178, 1586.4666, 19.5323, 5); // Shovel
PTPM_AddWeaponPickup(WEAPON_FIREEXTINGUISHER, 3000, 431.8049, 2537.3123, 16.2685, 30); // Fire Extinguisher
PTPM_AddWeaponPickup(WEAPON_SHOVEL, -1, -333.0277, 2219.3123, 42.4885, 5); // Shovel
PTPM_AddWeaponPickup(WEAPON_FLOWER, -1, -335.9626, 2225.1255, 42.4871, 5); // Flowers
PTPM_AddWeaponPickup(WEAPON_SHOVEL, -1, 304.1429, 2228.8489, 34.7733, 5);
PTPM_AddWeaponPickup(WEAPON_SPRAYCAN, -1, 314.1726, 2222.2141, 35.7107, 30);
PTPM_AddWeaponPickup(WEAPON_BAT, -1, -590.3543, 2018.4451, 60.3828, 5);
PTPM_AddWeaponPickup(WEAPON_NITESTICK, -1, -377.7772, 2243.2141, 42.6185, 5); // Nightstick (cop weapon)
PTPM_AddWeaponPickup(WEAPON_UZI, 150, 102.0130, 1900.9927, 33.8984, 30); // Uzis
PTPM_AddWeaponPickup(WEAPON_UZI, 150, 162.0741, 1934.7688, 33.8984, 30); // Uzis
PTPM_AddWeaponPickup(WEAPON_MP5, 300, -329.5251, 1860.5280, 44.5668, 30); // MP5
PTPM_AddWeaponPickup(WEAPON_TEC9, 100, -220.5080, 1801.8065, 103.7095, 30); // SMG
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 300, -98.1209, 2270.3389, 122.4016, 30); // Flamethrower (pm spawn?)
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, -83.6319, 1525.7402, 17.2205, 30); // Dessert Eagle on top of lonely shack
PTPM_AddWeaponPickup(WEAPON_MP5, 300, -127.1452, 2258.0967, 28.3973, 10); // MP5 (campfire)
PTPM_AddWeaponPickup(WEAPON_TEC9, 100, 278.0169, 2023.8375, 17.6406, 30); // SMG
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 300, 246.4423, 1411.0696, 23.3703, 30); // Flamethrower
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 300, 246.7062, 1385.9924, 23.3750, 30); // Flamethrower
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 300, 215.0238, 1468.0563, 23.7344, 30); // Flamethrower
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, 487.3661, 1535.1282, 1.0032, 30); // DesertEagle
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, -480.4825, 2180.6299, 41.8672, 30);
PTPM_AddWeaponPickup(WEAPON_SHOTGSPA, 60, 136.8696, 1875.2312, 22.4375, 30);
PTPM_AddWeaponPickup(WEAPON_AK47, 150, -336.0703, 1293.3424, 53.6643, 30);
PTPM_AddWeaponPickup(WEAPON_AK47, 150, -653.5152, 2040.8524, 60.3906, 30);
PTPM_AddWeaponPickup(WEAPON_SILENCED, 50, -127.5074, 1926.5990, 15.3981, 30);
PTPM_AddWeaponPickup(WEAPON_TEC9, 100, -35.9747, 2349.6221, 24.3026, 30); // Tec-9 (new)
PTPM_AddWeaponPickup(WEAPON_UZI, 100, -149.8675, 1596.4629, 17.4454, 30); // Micro Uzi
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, -152.0274, 1320.9338, 13.8111, 30); // Desert Eagle
PTPM_AddWeaponPickup(WEAPON_UZI, 100, -249.2702, 1314.6149, 36.9502, 30); // Micro Uzi
PTPM_AddWeaponPickup(WEAPON_SILENCED, 50, 1.5069, 1517.4351, 12.7500, 30); // Silenced Pistol
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, 161.8201, 1504.1044, 10.5859, 30); // Desert Eagle
PTPM_AddWeaponPickup(WEAPON_TEC9, 100, 392.8684, 1430.7505, 7.7917, 30); // Tec 9
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, 548.5426, 2273.8989, 34.7579, 30); // Desert Eagle
PTPM_AddWeaponPickup(WEAPON_SHOTGUN, 60, 399.8705, 2429.5833, 16.4885, 30); // Shotgun (regular)
PTPM_AddWeaponPickup(WEAPON_AK47, 150, 113.2080, 2406.0139, 17.3938, 30); // AK 47
PTPM_AddWeaponPickup(WEAPON_SHOTGSPA, 60, 414.3580, 2533.0876, 23.3131, 30); // Combat Shotgun
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 6660, -338.3566, 1985.2874, 131.4921, 200); // Flamethrower (lots of ammo)
PTPM_AddWeaponPickup(WEAPON_TEC9, 100, -258.8873, 2042.0297, 48.1047, 30); // Tec-9
PTPM_AddWeaponPickup(WEAPON_UZI, 100, -149.3102, 1989.7598, 30.4239, 30); // Micro Uzi
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 60, -285.3163, 1262.9303, 24.8750, 30); // Sawnoff
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 60, -56.4050, 1294.1333, 12.1404, 30); // Sawn-off
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 60, 541.1504, 2361.0249, 33.9793, 30); // Sawnoff
PTPM_AddWeaponPickup(WEAPON_TEC9, 100, 605.8316, 2147.7361, 41.3062, 30); // Tec-9
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, 492.0047, 1719.7748, 11.2410, 30); // Desert Eagle
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, 165.1940, 1283.6234, 20.7728, 30); // Desert Eagle
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 60, -343.2186, 1546.4620, 80.4334, 60); // SAWN OFF
PTPM_AddWeaponPickup(WEAPON_SHOTGSPA, 60, -336.2724, 1595.2528, 95.5666, 60); // Combat Shotgun
PTPM_AddWeaponPickup(WEAPON_UZI, 100, -346.5265, 1584.6504, 95.5346, 60); // Uzi
PTPM_AddWeaponPickup(WEAPON_AK47, 150, -357.0659, 1594.8313, 95.5090, 60); // AK-47
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 300, -185.0072, 1886.8285, 115.7031, 400); // Minigun
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 300, -371.6570, 2128.8850, 133.1797, 400); // Minigun (new set)
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 10000, -347.2831, 1600.8020, 165.7395, 0); // Minigun
PTPM_AddWeaponPickup(WEAPON_SHOTGUN, 50, 24.0, 969.0, 20.0, 30); // 17 Desert
PTPM_AddWeaponPickup(WEAPON_COLT45, 100, -639.0, 1181.0, 13.0, 30); // 30 Desert (maybe)
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, 36.0, 1372.0, 9.0, 30); // 38 Desert
PTPM_AddWeaponPickup(WEAPON_UZI, 120, 119.0, 2409.0, 17.0, 30); // 57 Desert (maybe)
PTPM_AddWeaponPickup(WEAPON_GRENADE, 15, -149.78, 1903.17, 43.36, 30);
PTPM_AddWeaponPickup(WEAPON_ROCKETLAUNCHER, 20, -427.36, 2505.86, 124.30, 180);
PTPM_AddWeaponPickup(WEAPON_HEATSEEKER, 20, 248.47, 1457.66, 43.09, 180);
PTPM_AddWeaponPickup(WEAPON_SNIPER, 30, 404.99, 2454.69, 29.63, 30);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 20, 639.30, 1685.29, 6.99, 30);
PTPM_AddWeaponPickup(WEAPON_M4, 200, 237.88, 1716.71, 25.53, 30);
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 300, -2625.8015, -978.2073, 0.1978, 400); // Minigun
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 300, -2692.1790, -2136.3743, 18.5538, 400); // Minigun (new set)
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 1000, -2424.1614, -1342.5021, 309.9434, 0); // Minigun
PTPM_AddWeaponPickup(WEAPON_MP5, 300, -2135.7476, -1242.1997, 29.1718, 10); // MP5 (campfire)
PTPM_AddWeaponPickup(WEAPON_MP5, 300, -1907.4188, -1500.9512, 25.4219, 10); // MP5 (campfire)
PTPM_AddWeaponPickup(WEAPON_SILENCED, 50, -2172.2546, -1843.6069, 214.8233, 30);
PTPM_AddWeaponPickup(WEAPON_CHAINSAW, 1, -2437.1436, -1616.6068, 520.9243, 0); // Chainsaw
PTPM_AddWeaponPickup(WEAPON_AK47, 160, -1968.0, -923.0, 32.0, 30); // 5 Chilliad
PTPM_AddWeaponPickup(WEAPON_COLT45, 100, -365.4774, -1422.401, 25.5, 30); // 20 Chilliad
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, -1870.0, -1625.0, 22.0, 30); // 34 Chilliad
PTPM_AddWeaponPickup(WEAPON_FIREEXTINGUISHER, 3000, -1627.0, -2692.0, 49.0, 30); // 39 Chilliad
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 300, -1358.0, -2115.0, 30.0, 30); // 47 Chilliad
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 300, -601.4012, -1068.6, 23.6667, 30); // 51 Chilliad
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 300, -366.066, -1418.683, 25.5, 30); // 52 Chilliad
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 300, -1100.3, -1640.4, 76.4, 30); // 53 Chilliad
PTPM_AddWeaponPickup(WEAPON_UZI, 120, -2038.0, -2562.0, 31.0, 30); // 60 Chilliad
PTPM_AddWeaponPickup(WEAPON_M4, 200, -2244.42, -2561.49, 31.92, 30);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 15, -2802.17, -1857.13, 132.78, 30);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 15, -1883.97, -1637.19, 21.75, 30);
PTPM_AddWeaponPickup(WEAPON_AK47, 200, -1805.63, -1668.25, 23.71, 30);
PTPM_AddWeaponPickup(WEAPON_MP5, 200, -2910.29, -1168.89, 3.69, 30); // chil
PTPM_AddWeaponPickup(WEAPON_SNIPER, 20, -1065.6610, -1157.2533, 129.2188, 40);
PTPM_AddWeaponPickup(WEAPON_SNIPER, 30, -1955.8247, -1514.1563, 42.5692, 50);
PTPM_AddWeaponPickup(WEAPON_SNIPER, 35, 34.2412, -1524.8169, -0.6653, 60);
PTPM_AddWeaponPickup(WEAPON_AK47, 100, -2362.4902, -1562.1139, 485.2821, 10);
PTPM_AddWeaponPickup(WEAPON_AK47, 150, -1637.3337, -2233.2131, 31.4766, 10);
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 500, 50.8250, -1019.4810, 18.4685, 300);
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 500, -1202.1648, -2554.7898, 23.7149, 450);
PTPM_AddWeaponPickup(WEAPON_ROCKETLAUNCHER, 5, -1199.7949, -1169.5959, 129.2188, 300);
PTPM_AddWeaponPickup(WEAPON_ROCKETLAUNCHER, 10, -1379.5378, -825.7098, 81.7927, 370);
PTPM_AddWeaponPickup(WEAPON_ROCKETLAUNCHER, 7, -466.4154, -1888.0167, 1.5635, 320);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 5, -1795.0339, -1599.4187, 21.7500, 30);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 10, -650.8707, -837.3129, 103.9770, 35);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 15, -316.9090, -1775.6058, 13.4780, 40);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 10, -1948.2723, -1195.1027, 34.8594, 40);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 5, -2058.4263, -1574.0569, 141.1011, 25);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 7, -1047.4786, -912.6324, 129.2119, 30);
PTPM_AddWeaponPickup(WEAPON_UZI, 120, -2616.2000, 2239.8098, 4.9844, 30);
PTPM_AddWeaponPickup(WEAPON_AK47, 160, -2400.3379, 2360.7544, 4.9433, 30);
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, -2282.8025, 2658.5266, 59.9032, 30);
PTPM_AddWeaponPickup(WEAPON_CHAINSAW, -1, -1820.7958, 2060.1426, 9.3511, 5);
PTPM_AddWeaponPickup(WEAPON_COLT45, 200, -1660.5110, 2551.6790, 85.3414, 30);
PTPM_AddWeaponPickup(WEAPON_FIREEXTINGUISHER, 3000, -1463.4205, 1872.6388, 32.6328, 30);
PTPM_AddWeaponPickup(WEAPON_TEC9, 150, -886.0540, 1922.6598, 135.7936, 30);
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 60, -867.2928, 1904.9644, 51.4219, 30);
PTPM_AddWeaponPickup(WEAPON_MP5, 200, -1303.5846, 2542.5120, 93.3047, 30);
PTPM_AddWeaponPickup(WEAPON_SPRAYCAN, 400, -1274.0315, 2723.8691, 50.2663, 30);
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 50, -1425.5934, 2170.9673, 50.6250, 30);
PTPM_AddWeaponPickup(WEAPON_AK47, 160, -746.1544, 1590.0294, 26.9746, 30);
PTPM_AddWeaponPickup(WEAPON_MP5, 200, -730.32, 2923.52, 34.05, 30); // bay
PTPM_AddWeaponPickup(WEAPON_AK47, 80, -41.82, 98.34, 3.10, 30);
PTPM_AddWeaponPickup(WEAPON_SHOTGSPA, 30, -92.39, 47.91, 3.11, 30);
PTPM_AddWeaponPickup(WEAPON_AK47, 160, -121.0, -232.0, 1.0, 30); // 1 Countryside
PTPM_AddWeaponPickup(WEAPON_FIREEXTINGUISHER, 3000, 0.0, 0.0, 0.0, 30); // 43 Countryside (out of reach)
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 1296.0, 392.0, 20.0, 30); // 69 Countryside
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 100, 2366.0, 23.0, 28.0, 30); // 80 Countryside
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, 262.0, 38.0, 2.0, 30); // 106 Countryside
PTPM_AddWeaponPickup(WEAPON_RIFLE, 30, -536.75, -74.25, 62.85, 30);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 15, -50.17, 2.82, 3.11, 30);
PTPM_AddWeaponPickup(WEAPON_SNIPER, 25, -155.73, -257.49, 6.18, 30);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 15, 681.68, -474.24, 16.53, 30);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 10, 1690.04, 241.67, 15.65, 30);
PTPM_AddWeaponPickup(WEAPON_RIFLE, 30, 2273.59, -74.81, 27.59, 30);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 20, 2315.65, 33.66, 27.47, 30);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 10, 1349.88, 311.44, 20.55, 30);
PTPM_AddWeaponPickup(WEAPON_M4, 200, 161.05, -160.67, 1.57, 30);
PTPM_AddWeaponPickup(WEAPON_MP5, 200, -441.28, -48.30, 58.97, 30); // cs
PTPM_AddWeaponPickup(WEAPON_AK47, 160, 1625.0, 1944.0, 11.0, 30); // 3 Las Venturas
PTPM_AddWeaponPickup(WEAPON_AK47, 160, 1923.0, 1011.0, 22.0, 30); // 4 Las Venturas
PTPM_AddWeaponPickup(WEAPON_SHOTGUN, 50, 1345.0, 2367.0, 11.0, 30); // 12 Las Venturas
PTPM_AddWeaponPickup(WEAPON_SHOTGSPA, 100, 2021.327, 1013.349, 10.3203, 30); // 85 Las Venturas
PTPM_AddWeaponPickup(WEAPON_FIREEXTINGUISHER, 3000, 2148.0, 2721.0, 11.0, 30); // 41 Las Venturas
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 300, 2649.0, 2733.0, 11.0, 30); // 50 Las Venturas
PTPM_AddWeaponPickup(WEAPON_UZI, 120, 1446.35, 1900.03, 11.0, 30); // 58 Las Venturas
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 200, 2492.051, 2398.377, 4.5293, 30); // 65 Las Venturas
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 200, 2676.0, 836.0, 22.0, 30); // 66 Las Venturas
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 2025.286, 1001.496, 10.3203, 30); // 67 Las Venturas
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 2243.0, 1132.0, 11.0, 30); // 72 Las Venturas
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 2293.686, 1982.286, 31.4335, 30); // 74 Las Venturas
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 100, 1569.0, 2150.0, 11.0, 30); // 78 Las Venturas
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 100, 1706.352, 1242.019, 34.2952, 30); // 79 Las Venturas
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 100, 924.0, 2138.0, 11.0, 30); // 82 Las Venturas
PTPM_AddWeaponPickup(WEAPON_SHOTGSPA, 100, 1407.0, 1098.0, 11.0, 30); // 87 Las Venturas
PTPM_AddWeaponPickup(WEAPON_SILENCED, 100, 1098.0, 1681.0, 7.0, 30); // 89 Las Venturas (out of reach)
PTPM_AddWeaponPickup(WEAPON_SPRAYCAN, 500, 2819.0, 1663.0, 11.0, 30); // 96 Las Venturas
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, 1761.0, 591.0, 10.0, 30); // 102 Las Venturas
PTPM_AddWeaponPickup(WEAPON_SILENCED, 200, 2216.2168, 1838.9188, 10.8203, 30); // silence 9mm
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 2215.5330, 1968.7225, 10.8203, 30); // mp5
PTPM_AddWeaponPickup(WEAPON_DEAGLE, 100, 2320.0774, 2352.7708, 10.6641, 30); // deagle
PTPM_AddWeaponPickup(WEAPON_UZI, 250, 2117.0654, 1683.1658, 13.0060, 30); // micro smg
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 100, 1924.5068, 1343.0653, 24.6168, 30); // sawn off
PTPM_AddWeaponPickup(WEAPON_TEC9, 250, 2301.7822, 1284.5436, 67.4688, 30); // tec9
PTPM_AddWeaponPickup(WEAPON_COLT45, 250, 2275.5820, 1647.6812, 107.8828, 30); // 9mm
PTPM_AddWeaponPickup(WEAPON_AK47, 300, 1974.9138, 2096.6052, 10.8203, 30); // ak47
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 2507.5391, 1283.2848, 10.8125, 30); // mp5
PTPM_AddWeaponPickup(WEAPON_SNIPER, 25, 2540.3264, 1181.2002, 18.7189, 30);
PTPM_AddWeaponPickup(WEAPON_SNIPER, 20, 1663.5302, 2371.6233, 10.8203, 30);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 10, 2121.9490, 1483.1410, 10.8203, 30);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 10, 2064.9216, 2264.2903, 9.9825, 30);
PTPM_AddWeaponPickup(WEAPON_GRENADE, 10, 1924.5129, 701.4730, 11.1328, 30);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 15, 2540.6238, 2004.4626, 10.8153, 30);
PTPM_AddWeaponPickup(WEAPON_MOLTOV, 15, 2699.7488, 864.0749, 10.1399, 30);
PTPM_AddWeaponPickup(WEAPON_M4, 200, 2000.6929, 1535.7753, 14.6172, 30);
PTPM_AddWeaponPickup(WEAPON_AK47, 150, 1740.9596, 1217.8873, 12.3648, 30);
PTPM_AddWeaponPickup(WEAPON_RIFLE, 30, 2460.4185, 2499.5024, 10.8203, 30);
PTPM_AddWeaponPickup(WEAPON_MP5, 200, 2825.86, 864.44, 23.20, 30); // lv
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 50, 263.0227, 1878.9073, -30.3906, 30); // flame thrower (right at the bottom)
PTPM_AddWeaponPickup(WEAPON_UZI, 80, 276.5279, 1886.5530, 8.4375, 15); // uzi jetpack top
PTPM_AddWeaponPickup(WEAPON_TEC9, 80, 271.6212, 1873.7330, 8.7578, 30); // uzi terrorist
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 24, 330.1199, 1848.1210, 7.7266, 20); // sawnoff
PTPM_AddWeaponPickup(WEAPON_SAWEDOFF, 24, 287.9067, 1824.1339, 7.7340, 20); // sawnoff
PTPM_AddWeaponPickup(WEAPON_UZI, 80, 275.7653, 1841.6360, 9.3473, 20); // uzi on duct (in corridor)
PTPM_AddWeaponPickup(WEAPON_UZI, 80, 293.8852, 1820.1926, 4.7109, 20); // uzi under stairs
PTPM_AddWeaponPickup(WEAPON_AK47, 80, 272.7304, 1816.0725, 1.0078, 40); // ak
PTPM_AddWeaponPickup(WEAPON_UZI, 80, 245.4331, 1818.4679, 7.5547, 7); // top room middle
PTPM_AddWeaponPickup(WEAPON_SHOTGSPA, 24, 239.1696, 1834.3403, 8.0865, 15); // shotgspa
PTPM_AddWeaponPickup(WEAPON_FLAMETHROWER, 50, 246.3053, 1830.4159, 12.2121, 25); // top flamethrower
PTPM_AddWeaponPickup(WEAPON_MP5, 80, 239.4735, 1836.7117, 10.7606, 20); // mp5
PTPM_AddWeaponPickup(WEAPON_TEC9, 80, 255.3534, 1802.6709, 7.4713, 0); // bguard uzi
PTPM_AddWeaponPickup(WEAPON_TEC9, 80, 244.8132, 1877.1115, 8.7578, 0); // cop uzi
PTPM_AddWeaponPickup(WEAPON_MINIGUN, 200, 244.98, 1859.185, 14.08, 30); // 64 Area 51
PTPM_AddWeaponPickup(WEAPON_SHOTGSPA, 40, 297.8289, 1846.622, 7.7266, 30); // 86 Area 51 (+1 z)
PTPM_AddWeaponPickup(WEAPON_SHOTGSPA, 15, 163.9067, 1849.6705, 33.8984, 30); //Combat Shotgun Outside
PTPM_AddWeaponPickup(WEAPON_UZI, 200, 162.1602, 1935.1891, 33.8984, 30); // Micro SMG Outside
PTPM_AddWeaponPickup(WEAPON_TEC9, 100, 111.4570, 1814.4930, 33.8984, 30); // Tec9 Outside
PTPM_AddWeaponPickup(WEAPON_MP5, 80, 259.9716, 1807.7046, 33.8984, 30); // MP5 Outside
PTPM_AddWeaponPickup(WEAPON_M4, 200, 264.84, 1895.21, 33.89, 30);

PTPM_AddBannedCuboidEx(-1735.49, -1737.49, -444.96, -446.96, 2.96, 0.96, "", -1733.06, -445.99, 14.23, 270.76, false, 0); // 1
PTPM_AddBannedCuboidEx(-1734.40, -1736.40, -444.94, -446.94, 15.14, 13.14, "", -1738.50, -445.69, 1.96, 96.85, false, 0); // 1
PTPM_AddBannedCuboidEx(-1617.74, -1619.74, -83.01, -85.01, 2.96, 0.96, "", -1616.31, -86.35, 14.22, 219.76, false, 0); // 2
PTPM_AddBannedCuboidEx(-1617.05, -1619.05, -83.60, -85.60, 15.14, 13.14, "", -1620.00, -82.69, 1.96, 45.33, false, 0); // 2
PTPM_AddBannedCuboidEx(-1443.42, -1445.42, 91.27, 89.27, 2.96, 0.96, "", -1442.05, 87.64, 14.25, 223.76, false, 0); // 3
PTPM_AddBannedCuboidEx(-1442.80, -1444.80, 90.47, 88.47, 15.14, 13.14, "", -1445.76, 91.56, 1.96, 43.96, false, 0); // 3
PTPM_AddBannedCuboidEx(-1163.65, -1165.65, 370.97, 368.97, 2.96, 0.96, "", -1162.28, 367.44, 14.25, 224.49, false, 0); // 4
PTPM_AddBannedCuboidEx(-1162.96, -1164.96, 370.29, 368.29, 15.14, 13.14, "", -1165.92, 371.34, 1.96, 47.77, false, 0); // 4
PTPM_AddBannedCuboidEx(-1114.84, -1116.84, 336.28, 334.28, 2.96, 0.96, "", -1118.07, 337.77, 14.25, 46.62, false, 0); // 5
PTPM_AddBannedCuboidEx(-1115.52, -1117.52, 337.06, 335.06, 15.14, 13.14, "", -1114.31, 333.79, 1.96, 224.26, false, 0); // 5
PTPM_AddBannedCuboidEx(-1181.61, -1183.61, 61.41, 59.41, 2.96, 0.96, "", -1185.90, 57.69, 14.14, 133.58, false, 0); // 6
PTPM_AddBannedCuboidEx(-1182.42, -1184.42, 60.71, 58.71, 15.14, 13.14, "", -1181.14, 61.88, 1.96, 315.94, false, 0); // 6
PTPM_AddBannedCuboidEx(-1080.90, -1082.90, -206.90, -208.90, 2.96, 0.96, "", -1084.76, -209.26, 14.14, 111.66, false, 0); // 7
PTPM_AddBannedCuboidEx(-1081.79, -1083.79, -207.30, -209.30, 15.14, 13.14, "", -1080.15, -207.23, 1.96, 296.21, false, 0); // 7
PTPM_AddBannedCuboidEx(-1153.27, -1155.27, -475.75, -477.75, 2.96, 0.96, "", -1157.45, -474.62, 14.14, 56.27, false, 0); // 8
PTPM_AddBannedCuboidEx(-1154.13, -1156.13, -475.18, -477.18, 15.14, 13.14, "", -1152.91, -477.68, 1.96, 237.40, false, 0); // 8
PTPM_AddBannedCuboidEx(-1360.10, -1362.10, -695.65, -697.65, 2.96, 0.96, "", -1361.09, -692.87, 14.14, 0.24, false, 0); // 9
PTPM_AddBannedCuboidEx(-1360.04, -1362.04, -694.68, -696.68, 15.14, 13.14, "", -1360.92, -698.58, 1.96, 179.76, false, 0); // 9
PTPM_AddBannedCuboidEx(-1602.38, -1604.38, -695.64, -697.64, 2.96, 0.96, "", -1603.31, -692.86, 14.14, 1.14, false, 0); // 10
PTPM_AddBannedCuboidEx(-1602.43, -1604.43, -694.52, -696.52, 15.14, 13.14, "", -1603.42, -698.70, 1.96, 178.46, false, 0); // 10
PTPM_AddBannedCuboidEx(-2235.5684, -2243.3987, -87.2494, -89.2179, 36.2203, 32.2203, "", 501.9458, -70.6178, 998.7578, 178.7700, false, 11); // mistys
PTPM_AddBannedCuboidEx(-2660.4895, -2661.4390, 1418.2272, 1416.4740, 924.1953, 921.1953, "", -2662.0427, 1426.2308, 23.8984, 11.6095, false, 0); // jizzys
PTPM_AddBannedCuboidEx(-1604.4769, -1607.4769, 713.8431, 707.8431, 14.8672, 12.8672, "", 246.4116, 112.0505, 1003.2188, 359.2755, false, 10); // inside sfpd
PTPM_AddBannedCuboidEx(248.4455, 244.4455, 111.5912, 106.5912, 1004.2188, 1000.2188, "", -1605.5092, 717.7777, 11.9759, 1.3457, false, 0); // outside sfpd
PTPM_AddBannedCuboidEx(-2328, -2330, 1530, 1528, 1, -1, "", -2301.4436, 1545.0177, 18.7734, 90, false, 0);
PTPM_AddBannedCuboidEx(-829.32, -831.32, 1981.88, 1979.88, 10.25, 8.25, "", -841.19, 1975.66, 22.92, 190.29, false, 0); // dam up
PTPM_AddBannedCuboidEx(-1506.8912, -1511.0693, 2616.2776, 2611.7107, 57.7089, 53.7089, "", 316.4593, -167.2180, 999.5938, 355.2000, false, 6); // ammunation
PTPM_AddBannedCuboidEx(-1050.88, -1052.88, -695.19, -697.19, 47.49, 45.49, "", -1062.78, -696.33, 56.33, 92.84, false, 0); // ontowalkway
PTPM_AddBannedCuboidEx(97, 82, 1942, 1798, 500, 17.6, "", 97.5643, 1920.4034, 18.1709, 267.3321, true, 0);
PTPM_AddBannedCuboidEx(293, 82, 1962, 1942, 500, 17.6, "", 232.8058, 1927.2909, 17.6406, 181.1084, true, 0);
PTPM_AddBannedCuboidEx(293, 286, 1942, 1798, 500, 17.6, "", 282.9717, 1820.8510, 17.6406, 89.6375, true, 0);
PTPM_AddBannedCuboidEx(286, 82, 1798, 1780, 500, 17.6, "", 210.5844, 1801.2509, 17.6406, 355.0099, true, 0);
PTPM_AddBannedCuboidEx(293, 97, 1961, 1789, 300, 75, "", 213.6958, 1874.7875, 17.6406, 174.5749, true, 0);

PTPM_AddObject(9586, -2900.9803, -2426.2065, 13.9176, 0, 0, 90);
PTPM_AddObject(9590, -2900.9670, -2417.5939, 5.6371, 0.0, 0.0, 90.0);
PTPM_AddObject(9361, -2914.7358, -2459.1796, 15.7722, 0.0, 0.0, 45.0);
PTPM_AddObject(3887, -2909.6967, -2382.7436, 21.3423, 0.0, 0.0, 0.0);
PTPM_AddObject(3887, -2892.0783, -2383.0791, 21.3173, 0.0, 0.0, 180.0);
PTPM_AddObject(14412, -2900.9633, -2486.0751, 12.2964, 0.0, 0.0, 90.0);
PTPM_AddObject(3399, -2899.9841, -2460.9858, 0.6434, 0.0, 0.0, 180.0);
PTPM_AddObject(3399, -2900.0043, -2458.8857, 0.6284, 0.0, 0.0, 180.0);
PTPM_AddObject(970, -2895.3454, -2459.8857, -2.5723, 0.0, 0.0, 270.0);
PTPM_AddObject(9585, -2900.9252, -2423.8430, 3.8262, 0.0, 0.0, 90.0);
PTPM_AddObject(9584, -2900.9494, -2499.1176, 23.0635, 0.0, 0.0, 90.0);
PTPM_AddObject(9698, -2899.7824, -2487.6130, 25.9482, 0.0, 0.0, 90.0);
PTPM_AddObject(8613, -2912.9851, -2477.0571, 16.1453, 0.0, 0.0, 270.0);
PTPM_AddObject(14407, -2893.9877, -2481.0756, 22.6998, 0.0, 0.0, 90.8);
PTPM_AddObject(14395, -2888.0891, -2482.7104, 27.7505, 0.0, 0.0, 270.0);
PTPM_AddObject(8885, -2902.9785, -2451.1940, 1.3549, 0.0, 0.0, 90.0);
PTPM_AddObject(8885, -2897.4262, -2451.1992, 4.7565, 0.0, 0.0, 90.0);
PTPM_AddObject(8885, -2891.9755, -2451.1887, 8.1902, 0.0, 0.0, 90.0);
PTPM_AddObject(8885, -2892.5776, -2451.2431, 1.3686, 0.0, 0.0, 90.0);
PTPM_AddObject(3502, -2901.7253, -2410.5185, 2.3547, 0.0, 0.0, 180.0);
PTPM_AddObject(3568, -2897.8137, -2447.1259, -1.1593, 0.0, 0.0, 0.0);
PTPM_AddObject(3524, -2889.5393, -2447.4243, 1.7848, 0.0, 0.0, 180.0);
PTPM_AddObject(18259, -2905.8662, -2384.0942, -0.3906, 0.0, 0.0, 87.4);
PTPM_AddObject(3565, -2890.4711, -2425.4560, -0.7568, 0.0, 0.0, 270.0);
PTPM_AddObject(3565, -2893.0876, -2425.4558, -0.7676, 0.0, 0.0, 270.0);
PTPM_AddObject(3565, -2890.4738, -2425.4799, 1.9404, 0.0, 0.0, 270.0);
PTPM_AddObject(3570, -2911.2954, -2425.1240, -0.7495, 0.0, 0.0, 270.0);
PTPM_AddObject(3573, -2905.0302, -2410.4350, 0.6204, 0.0, 0.0, 180.0);
PTPM_AddObject(3570, -2908.8027, -2428.0656, -0.7657, 0.0, 0.0, 270.0);
PTPM_AddObject(3575, -2899.5629, -2424.1911, 0.5867, 0.0, 0.0, 90.0);
PTPM_AddObject(3630, -2908.3447, -2412.9331, 2.1187, 0.0, 0.0, 180.0);
PTPM_AddObject(3722, -2891.5947, -2406.6811, 2.3747, 0.0, 0.0, 180.0);
PTPM_AddObject(5261, -2909.4516, -2404.8845, 0.1956, 0.0, 0.0, 180.0);
PTPM_AddObject(5262, -2909.0253, -2410.3881, 6.2265, 0.0, 0.0, 90.0);
PTPM_AddObject(5269, -2904.6472, -2407.5903, 0.9601, 0.0, 0.0, 0.0);
PTPM_AddObject(8885, -2892.0415, -2434.3051, 1.4425, 0.0, 0.0, 270.0);
PTPM_AddObject(3568, -2911.7924, -2447.0688, 0.4095, 0.0, 0.0, 180.0);
PTPM_AddObject(3570, -2911.3542, -2425.1372, 1.9316, 0.0, 0.0, 270.0);
PTPM_AddObject(3570, -2903.6337, -2427.8354, 1.9402, 0.0, 0.0, 359.3);
PTPM_AddObject(3570, -2895.6752, -2425.4870, 1.9402, 0.0, 0.0, 89.6);
PTPM_AddObject(897, -2905.3710, -2438.3134, -3.0913, 0.0, 0.0, 0.0);
PTPM_AddObject(2929, -2893.0722, -2517.4809, 8.5838, 0.0, 0.0, 0.0);
PTPM_AddObject(2930, -2890.7714, -2461.8637, -0.7598, 0.0, 0.0, 90.0);
PTPM_AddObject(2930, -2889.2441, -2456.3564, 0.7738, 0.0, 0.0, 90.0);
PTPM_AddObject(2930, -2889.1582, -2461.8896, -0.7995, 0.0, 0.0, 90.0);
PTPM_AddObject(9819, -2907.1320, -2484.4472, 29.9009, 0.0, 0.0, 90.0);
PTPM_AddObject(9818, -2900.9997, -2484.2412, 30.7412, 0.0, 0.0, 90.0);
PTPM_AddObject(8572, -2891.0507, -2494.1350, 25.9355, 0.0, 0.0, 180.0);
PTPM_AddObject(971, -2888.3474, -2356.3676, 15.4188, 0.0, 0.0, 180.9);
PTPM_AddObject(3569, -2903.2485, -2337.5927, 15.5625, 0.0, 0.0, 270.0);
PTPM_AddObject(8075, -2907.5705, -2422.1379, 17.2046, 0.0, 0.0, 270.0);
PTPM_AddObject(8885, -2888.1821, -2413.2880, 16.6343, 0.0, 0.0, 0.0);
PTPM_AddObject(10773, -2908.5126, -2447.2128, 15.9311, 0.0, 0.0, 0.0);
PTPM_AddObject(12859, -2890.6940, -2462.0175, 13.1961, 0.0, 0.0, 90.0);
PTPM_AddObject(12930, -2909.7749, -2446.9309, 13.9594, 0.0, 0.0, 0.0);
PTPM_AddObject(12930, -2907.6442, -2446.9184, 14.0041, 0.0, 0.0, 0.0);
PTPM_AddObject(18257, -2886.2675, -2446.5947, 13.2065, 0.0, 0.0, 0.0);
PTPM_AddObject(17055, -2906.7187, -2526.0881, 15.5410, 0.0, 0.0, 270.0);
PTPM_AddObject(9245, -2889.7424, -2426.8349, 24.2762, 0.0, 0.0, 90.0);
PTPM_AddObject(3578, -2912.4033, -2415.2871, 21.9095, 0.0, 0.0, 180.0);
PTPM_AddObject(3578, -2902.7348, -2415.2958, 21.9095, 0.0, 0.0, 180.0);
PTPM_AddObject(18257, -2891.9230, -2437.6352, 12.6989, 0.0, 0.0, 179.6);
PTPM_AddObject(18257, -2884.6159, -2447.7934, 13.2065, 0.0, 0.0, 91.1);
PTPM_AddObject(17055, -2895.1962, -2526.3229, 15.5410, 0.0, 0.0, 270.0);
PTPM_AddObject(3884, -2900.4274, -2486.6418, 33.4332, 0.0, 0.0, 0.0);
PTPM_AddObject(3277, -2900.4521, -2486.7172, 33.3899, 0.0, 0.0, 194.6);
PTPM_AddObject(14459, -2900.9470, -2490.7031, 9.9957, 0.0, 0.0, 90.0);
PTPM_AddObject(14407, -2907.9433, -2506.8232, 3.8953, 0.0, 0.0, 270.0);
PTPM_AddObject(8885, -2907.7990, -2497.7602, 6.3804, 0.0, 0.0, 270.0);
PTPM_AddObject(3566, -2892.6945, -2500.0246, 5.3163, 0.0, 0.0, 0.0);
PTPM_AddObject(3569, -2902.0922, -2482.9501, 5.3163, 0.0, 0.0, 90.0);
PTPM_AddObject(18257, -2895.1855, -2497.4204, 2.9277, 0.0, 0.0, 90.0);
PTPM_AddObject(18260, -2902.6691, -2497.3173, 4.5259, 0.0, 0.0, 270.0);
PTPM_AddObject(3565, -2913.6547, -2482.4135, 4.3006, 0.0, 0.0, 90.0);
PTPM_AddObject(3565, -2888.7834, -2482.5356, 4.3006, 0.0, 0.0, 90.0);
PTPM_AddObject(3565, -2898.9938, -2488.7077, 4.3006, 0.0, 0.0, 90.0);
PTPM_AddObject(18257, -2906.6872, -2491.8686, 2.7277, 0.0, 0.0, 1.4);
PTPM_AddObject(18257, -2902.6481, -2469.7172, 2.7277, 0.0, 0.0, 180.2);
PTPM_AddObject(18257, -2894.5051, -2480.4746, 2.9277, 0.0, 0.0, 359.2);
PTPM_AddObject(925, -2914.0817, -2501.4628, 8.1786, 0.0, 0.0, 90.0);
PTPM_AddObject(18257, -2904.6264, -2516.5380, 7.1167, 0.0, 0.0, 0.0);
PTPM_AddObject(3796, -2908.0632, -2476.0385, 2.9583, 0.0, 0.0, 33.7);
PTPM_AddObject(3761, -2909.2543, -2469.6079, 9.0907, 0.0, 0.0, 270.0);
PTPM_AddObject(3761, -2890.0908, -2499.6279, 9.0657, 0.0, 0.0, 0.0);
PTPM_AddObject(3761, -2888.2148, -2474.3154, 9.0648, 0.0, 0.0, 0.0);
PTPM_AddObject(929, -2896.0217, -2472.1215, 8.0528, 0.0, 0.0, 270.0);
PTPM_AddObject(929, -2902.0537, -2464.2363, 3.9137, 0.0, 0.0, 359.3);
PTPM_AddObject(929, -2898.1435, -2464.2329, 3.9137, 0.0, 0.0, 359.3);
PTPM_AddObject(16349, -2910.2739, -2465.2939, 4.9761, 0.0, 0.0, 337.5);
PTPM_AddObject(16444, -2906.5234, -2466.5610, 3.1568, 0.0, 0.0, 348.7);
PTPM_AddObject(5986, -1394.700073, -2737.722656, 94.454933, 0, 0, 270);
PTPM_AddObject(2929, -1391.538696, -2729.938232, 89.740944, 0, 0, 90.2409);
PTPM_AddObject(5822, -1395.752930, -2736.695313, 86.633812, 0, 0, 276.0934);
PTPM_AddObject(2929, -1391.557129, -2727.572998, 89.745232, 0, 0, 90.2409);
PTPM_AddObject(5822, -1377.727051, -2716.296875, 100.408150, 0, 0, 276.0934);
PTPM_AddObject(6102, -1231.572021, -1924.278564, 7.584078, 0, 0, 303.75);
PTPM_AddObject(5822, -1243.021240, -1926.279541, 3.904521, 0, 0, 128.1246);
PTPM_AddObject(3361, -1185.534180, -1963.030884, 14.909491, 0, 0, 33.75);
PTPM_AddObject(3361, -1180.844116, -1959.888794, 11.159510, 0, 0, 33.75);
PTPM_AddObject(3776, -1345.151367, -1510.978271, 30.946987, 0, 0, 0);
PTPM_AddObject(3776, -919.398193, -1088.529541, 105.813828, 0, 0, 326.25);
PTPM_AddObject(5130, -2022.970215, -1082.461914, 49.338943, 0, 0, 224.9228);
PTPM_AddObject(5822, -2044.633667, -1081.143799, 39.786896, 0, 0, 6.9528);
PTPM_AddObject(18368, -1986.675171, -1027.376465, 52.756893, 0, 0, 263.0472);
PTPM_AddObject(18259, -1961.971191, -1060.714966, 54.698631, 0, 0, 180);
PTPM_AddObject(18259, -1268.360107, -2045.176880, 21.754488, 0, 0, 63.9076);
PTPM_AddObject(3092, -2409.773193, -2183.314941, 34.226871, 0, 0, 270);
PTPM_AddObject(2909, -1198.160889, -1973.060181, 1.308082, 0, 0, 303.75);
PTPM_AddObject(3030, -1236.063721, -1991.852783, 21.247726, 0, 0, 0);
PTPM_AddObject(2909, -1192.803345, -1969.477539, 1.327233, 0, 0, 303.75);
PTPM_AddObject(6973, -1233.19, -1967.91, 24.61, 0.00, 0.00, 214.02); // helipad
PTPM_AddObject(3997, -1226.334473, -1899.111084, -4.665723, 0, 0, 303.75);
PTPM_AddObject(3865, -1217.70, -1982.42, 22.71, 270.00, 0.00, 247.32); // pipe1
PTPM_AddObject(3865, -1217.69, -1982.42, 20.70, 90.00, 0.00, 270.88); // pipe2
PTPM_AddObject(3865, -1224.97, -1972.34, 22.71, 270.00, 0.00, 9.80); // pipe3
PTPM_AddObject(3865, -1224.97, -1972.34, 20.70, 90.00, 0.00, 9.80); // pipe4
PTPM_AddObject(8661, -1219.22, -1989.07, -14.50, 90.00, 0.00, 33.24); // underblock1
PTPM_AddObject(8661, -1186.51, -1967.45, -14.50, 90.00, 0.00, 394.40); // underblock2
PTPM_AddObject(8661, -1163.62, -1951.94, -14.56, 90.00, 0.00, 33.46); // underblock3
PTPM_AddObject(8661, -1274.53, -1835.68, -14.56, -270.00, 0.00, 213.88); // underblock4
PTPM_AddObject(8661, -1304.02, -1854.80, -14.66, 90.00, 0.00, 213.43); // underblock5
PTPM_AddObject(8661, -1309.31, -1882.16, -14.64, 90.00, 0.00, 304.11); // underblock6
PTPM_AddObject(8661, -1287.13, -1915.31, -14.63, 90.00, 0.00, 303.34); // underblock7
PTPM_AddObject(8661, -1246.90, -1983.34, -14.69, 90.00, 0.00, 303.18); // underblock8
PTPM_AddObject(8661, -1269.29, -1950.22, -14.68, 90.00, 0.00, 304.46); // underblock9
PTPM_AddObject(969, -1277.28, -1932.91, -4.86, 0.00, 90.00, 211.64); // underblock10
PTPM_AddObject(969, -1274.97, -1931.27, -4.78, 0.00, 90.00, 214.90); // underblock11
PTPM_AddObject(8661, -1231.73, -1962.64, 0.46, 360.00, 0.00, 123.06); // platform
PTPM_AddObject(8661, -1223.43, -1957.17, -9.51, 90.00, 0.00, 122.88); // platformblock1
PTPM_AddObject(8661, -1242.63, -1945.99, -19.53, 0.00, -90.00, 303.64); // platformblock2
PTPM_AddObject(8661, -2146.01, 2714.04, 160.83, 0.00, 0.00, -2.40); // platform
PTPM_AddObject(8661, -2114.11, 2712.81, 161.06, -0.10, 1.00, 177.87);
PTPM_AddObject(8661, -2142.00, 2703.99, 150.84, 90.00, 0.00, -2.15);
PTPM_AddObject(8661, -2109.20, 2702.64, 151.16, 89.00, -90.19, 447.90);
PTPM_AddObject(7096, -1050.60, -692.17, 36.75, 0.00, 0.00, 359.79); // stair1
PTPM_AddObject(7096, -1053.81, -697.92, 43.64, 0.00, 0.00, 540.30); // stair2
PTPM_AddObject(6976, -1084.29, -656.56, 56.73, 0.00, 28.00, 181.09); // walkway1
PTPM_AddObject(4106, -1093.39, -695.56, 58.03, 0.00, 0.00, 269.63); // walkway2
PTPM_AddObject(8614, -1063.57, -694.73, 61.86, 0.00, 0.00, 539.88); // walkwaystair
PTPM_AddObject(984, -1050.24, -698.56, 66.02, 0.00, 270.00, 270.30); // fence1
PTPM_AddObject(983, -1040.91, -698.51, 64.83, 22.00, 90.00, 89.51); // fence2
PTPM_AddObject(987, 2132.19, 1621.70, 999.81, 0.00, 0.00, 357.76); // fenceblock
PTPM_AddObject(9093, 2044.95, 2371.71, 143.10, 0.00, 251.00, 268.96); // 1
PTPM_AddObject(9093, 2044.92, 2368.40, 144.25, 180.00, 71.00, 449.38); // 2
PTPM_AddObject(9093, 2044.91, 2365.11, 145.37, 180.00, 70.00, 89.55); // 3
PTPM_AddObject(9093, 2044.94, 2361.72, 146.00, 180.00, 90.00, 269.90); // 4
PTPM_AddObject(9093, 2044.96, 2358.15, 146.01, 180.00, 90.00, 270.19); // 5
PTPM_AddObject(9093, 2050.22, 2359.59, 146.57, 180.00, 110.00, 360.18); // 6
PTPM_AddObject(9093, 2053.53, 2359.64, 147.76, 180.00, 110.00, 360.30); // 7
PTPM_AddObject(9093, 2056.86, 2359.73, 148.91, 180.00, 107.00, 360.19); // 8
PTPM_AddObject(9093, 2060.17, 2359.69, 149.40, 180.00, 90.00, 359.49); // 9
PTPM_AddObject(9093, 2063.57, 2359.69, 149.40, 180.00, 90.00, 359.49); // 10

PTPM_AddVehicle(VEHICLE_POLMAV,		1987, -2286.9893, 15.1966, 85.8866); //
PTPM_AddVehicle(VEHICLE_POLMAV,		1987, -2314.5679, 13.6807, 86.7669); //
PTPM_AddVehicle(VEHICLE_POLMAV,		1992, -2400, 13.7241, 90.2958); //
PTPM_AddVehicle(VEHICLE_POLMAV,		1992, -2375, 13.7236, 77.8665); // police mav
PTPM_AddVehicle(VEHICLE_POLMAV,		1992, -2350, 13.7236, 94.8186); // police mav 2
PTPM_AddVehicle(VEHICLE_SHAMAL,		1596.1857, -2450, 14.4836, 0.0000); // shamal
PTPM_AddVehicle(VEHICLE_SHAMAL,		1559.7833, -2450, 14.4836, 0.0000); // shamal
PTPM_AddVehicle(VEHICLE_RUSTLER,	1516.4668, -2455, 14.2437, 359.9142); // rustler
PTPM_AddVehicle(VEHICLE_RUSTLER,	1486.6560, -2455, 14.2642, 359.9445); // rustler
PTPM_AddVehicle(VEHICLE_BEAGLE,		1457.6503, -2446.1963, 14.9146, 0.0000); // beagle
PTPM_AddVehicle(VEHICLE_BEAGLE,		1442.9895, -2493.7166, 14.9277, 270.0598); // beagle runway
PTPM_AddVehicle(VEHICLE_AT400,		1470.1775, -2593.4873, 13.4630, 269.6879); // massive fucking plane
PTPM_AddVehicle(VEHICLE_TUGSTAIR,	1489.0352, -2590, 13.2065, 180.2330); // stairs for plane
PTPM_AddVehicle(VEHICLE_BAGGAGE,	1877.1975, -2419.0972, 13.2110, 117.3680); // baggage
PTPM_AddVehicle(VEHICLE_BAGGAGE,	1807.3389, -2449.4619, 13.2110, 129.6533); // baggage
PTPM_AddVehicle(VEHICLE_BAGGAGE,	1697.7036, -2434.6035, 13.2111, 116.7797); // baggage
PTPM_AddVehicle(VEHICLE_STRETCH,	1272.0273, -2052.5105, 58.9108, 268.6577); // pm limo
PTPM_AddVehicle(VEHICLE_ENFORCER,	1248.0804, -2041.6018, 59.8980, 269.1785); // pm swat van south
PTPM_AddVehicle(VEHICLE_ENFORCER,	1248.4545, -2029.4104, 59.8854, 269.3774); // pm swat van middle
PTPM_AddVehicle(VEHICLE_ENFORCER,	1247.5862, -2016.4684, 59.9106, 270.2272); // pm swat van north
PTPM_AddVehicle(VEHICLE_COPCARLA,	1258.5917, -2052.1367, 59.2043, 267.4406); // pm police car behind limo
PTPM_AddVehicle(VEHICLE_COPCARLA,	1283.4066, -2052.5417, 58.5057, 267.8666); // pm police car infront of limo
PTPM_AddVehicle(VEHICLE_NEWSVAN,	1307.8915, -2061.7043, 58.2399, 269.3047); // pm news van
PTPM_AddVehicle(VEHICLE_NEWSVAN,	1323.5018, -2061.6367, 57.7726, 270.4650); // pm news van
PTPM_AddVehicle(VEHICLE_NEWSVAN,	1275, -2013, 59.1134, 89.3634); // pm newsvan
PTPM_AddVehicle(VEHICLE_FBIRANCH,	1275, -2023, 59.1450, 88.3334); // pm fbiranch north
PTPM_AddVehicle(VEHICLE_FBIRANCH,	1275, -2028, 59.1616, 88.3310); // pm fbiranch south
PTPM_AddVehicle(VEHICLE_STRETCH,	1330.2595, -626.7542, 108.9349, 289.3475); // safe house limo
PTPM_AddVehicle(VEHICLE_FBIRANCH,	1339.3717, -623.1824, 109.2619, 289.7454); // safe house escort before limo
PTPM_AddVehicle(VEHICLE_FBIRANCH,	1320.3932, -630.0724, 109.2656, 286.9799); // safe house escort behind limo
PTPM_AddVehicle(VEHICLE_COPCARLA,	1356.0096, -610.3824, 108.8543, 105.9892); // safe house cop car north
PTPM_AddVehicle(VEHICLE_COPCARLA,	1357.4025, -614.4976, 108.9018, 106.5213); // safe house cop car middle
PTPM_AddVehicle(VEHICLE_COPCARLA,	1358.7394, -618.5698, 108.9018, 105.6476); // safe house cop car south
PTPM_AddVehicle(VEHICLE_COPBIKE,	1360.5815, -622.1605, 108.7038, 106.0725); // safe house cop bike next to cop cars
PTPM_AddVehicle(VEHICLE_COPBIKE,	1555, -1609, 12.9486, 180); // police station bike 1 (north)
PTPM_AddVehicle(VEHICLE_COPBIKE,	1560, -1609, 12.9486, 180); // police station bike 2
PTPM_AddVehicle(VEHICLE_COPBIKE,	1565, -1609, 12.9474, 180); // police station bike 3
PTPM_AddVehicle(VEHICLE_COPBIKE,	1570, -1609, 12.9557, 180); // police station bike 4
PTPM_AddVehicle(VEHICLE_COPBIKE,	1575, -1609, 12.9540, 180); // police station bike 5 (south)
PTPM_AddVehicle(VEHICLE_ENFORCER,	1601.7515, -1623.7999, 13.6164, 91.0440); // police station swat van 2
PTPM_AddVehicle(VEHICLE_ENFORCER,	1601.8759, -1629.7356, 13.6197, 88.7999); // police station swat van 1
PTPM_AddVehicle(VEHICLE_SWATVAN,	1534.5927, -1645.1713, 5.6494, 179.6766); // police station swat tank 1 (corner)
PTPM_AddVehicle(VEHICLE_SWATVAN,	1545.3734, -1655.2261, 5.6494, 270.4727);// police station swat tank 2
PTPM_AddVehicle(VEHICLE_COPCARLA,	1544.4673, -1667.9943, 5.6599, 269.0485); // police station cop car indoors
PTPM_AddVehicle(VEHICLE_COPCARLA,	1529.6506, -1683.7926, 5.6578, 91.2372); // police station cop car indoors
PTPM_AddVehicle(VEHICLE_COPCARLA,	1544.2897, -1684.2386, 5.6589, 90.3812); // police station cop car indoors
PTPM_AddVehicle(VEHICLE_COPCARLA,	1558.9119, -1709.6991, 5.6586, 181.0041); // police station cop car indoors
PTPM_AddVehicle(VEHICLE_COPCARLA,	1591.4161, -1711.0702, 5.6598, 0.3255); // police station cop car indoors
PTPM_AddVehicle(VEHICLE_COPCARLA,	1601.5614, -1700.2463, 5.6598, 89.8913); // police station cop car indoors
PTPM_AddVehicle(VEHICLE_COPCARRU,	1585.3955, -1671.6195, 6.0846, 269.2602); // police station ranger
PTPM_AddVehicle(VEHICLE_COPCARRU,	1584.6819, -1667.6851, 6.0791, 269.2272); // police station ranger
PTPM_AddVehicle(VEHICLE_COPCARRU,	1601.9421, -1684.0054, 6.0797, 89.9971); // police station ranger
PTPM_AddVehicle(VEHICLE_COPCARRU,	1602.3267, -1691.9391, 6.1032, 91.0921); // police station ranger
PTPM_AddVehicle(VEHICLE_COPCARRU,	1603.4213, -1614.9706, 13.6899, 86.7397); // police station ranger outdoors
PTPM_AddVehicle(VEHICLE_COPCARRU,	1603.1095, -1604.8138, 13.6777, 89.8504);// police station ranger outdoors
PTPM_AddVehicle(VEHICLE_AMBULAN,	2021.3857, -1413.9185, 16.9922, 266.4618); //Ambulance
PTPM_AddVehicle(VEHICLE_AMBULAN,	2032.9591, -1433.4801, 17.2008, 181.1191); //Ambulance
PTPM_AddVehicle(VEHICLE_HUNTLEY,	2783.7915, -1602.6122, 11.0649, 268.0349); // t big
PTPM_AddVehicle(VEHICLE_HUNTLEY,	2776.3411, -1602.3579, 11.0681, 268.0318); // t big
PTPM_AddVehicle(VEHICLE_BENSON,		2793.6848, -1623.7864, 10.8578, 346.6386); // benson
PTPM_AddVehicle(VEHICLE_BURRITO,	2781.8101, -1626.0529, 10.8616, 89.2409); // burrito
PTPM_AddVehicle(VEHICLE_ELEGY,		2821.4878, -1562.6649, 10.8606, 269.0218); // elegy
PTPM_AddVehicle(VEHICLE_GLENSHIT,	2822.1040, -1557.3737, 10.8510, 270.5379); // glenshit
PTPM_AddVehicle(VEHICLE_RANCHER,	2821.5530, -1541.4941, 10.8506, 1.9334); // rancher
PTPM_AddVehicle(VEHICLE_RANCHER,	2806.9922, -1539.7356, 10.8584, 1.2723); // rancher
PTPM_AddVehicle(VEHICLE_BENSON,		2796.7432, -1541.4360, 10.8521, 13.7492); // benson
PTPM_AddVehicle(VEHICLE_WAYFARER,	2796.6592, -1579, 10.8568, 91.9738); // wayfarer
PTPM_AddVehicle(VEHICLE_WAYFARER,	2796.6592, -1577, 10.8568, 91.9738); // wayfarer
PTPM_AddVehicle(VEHICLE_WAYFARER,	2796.6592, -1575, 10.8568, 91.9738); // wayfarer
PTPM_AddVehicle(VEHICLE_WAYFARER,	2796.6592, -1573, 10.8568, 91.9738); // wayfarer
PTPM_AddVehicle(VEHICLE_WAYFARER,	2796.6592, -1571, 10.8568, 91.9738); // wayfarer
PTPM_AddVehicle(VEHICLE_PCJ600,		2796.6592, -1568, 10.8568, 91.9738);
PTPM_AddVehicle(VEHICLE_PCJ600,		2796.6592, -1566, 10.8568, 91.9738);
PTPM_AddVehicle(VEHICLE_PCJ600,		2796.6592, -1564, 10.8568, 91.9738);
PTPM_AddVehicle(VEHICLE_PCJ600,		2796.6592, -1562, 10.8568, 91.9738);
PTPM_AddVehicle(VEHICLE_STRATUM,	2822.2832, -1553.0403, 10.5804, 269.5517); // stratum
PTPM_AddVehicle(VEHICLE_ZR350,		1465.7742, -899.0321, 54.8603, 3.2162); // posh house 1
PTPM_AddVehicle(VEHICLE_CHEETAH,	1527.2067, -886.2890, 61.1146, 254.2985); // roof top
PTPM_AddVehicle(VEHICLE_BULLET,		1535.1796, -841.1790, 64.8940, 94.3109); // posh 3
PTPM_AddVehicle(VEHICLE_SUPERGT,	1528.4613, -811.7554, 71.8663, 89.1012); // posh 4
PTPM_AddVehicle(VEHICLE_CHEETAH,	1025.5624, -800.0936, 101.8734, 20.1116); // posh
PTPM_AddVehicle(VEHICLE_ZR350,		920.5785, -786.9205, 114.3464, 68.2807); // posh
PTPM_AddVehicle(VEHICLE_BULLET,		855.9669, -815.3113, 87.7593, 19.6388); // posh
PTPM_AddVehicle(VEHICLE_BULLET,		684.5640, -1074.3420, 49.5645, 60.4335); // posh
PTPM_AddVehicle(VEHICLE_CHEETAH,	404.5968, -1155.5228, 77.6275, 143.8123); // posh
PTPM_AddVehicle(VEHICLE_BULLET,		289.7317, -1167.9216, 80.9028, 220.8520); // very posh
PTPM_AddVehicle(VEHICLE_BULLET,		292.9161, -1162.0803, 80.9022, 220.1603); // very posh
PTPM_AddVehicle(VEHICLE_SUPERGT,	288.0584, -1327.9247, 53.5295, 218.3855); // posh
PTPM_AddVehicle(VEHICLE_BULLET,		1241.8268, -749.5003, 94.2435, 18.4917); //
PTPM_AddVehicle(VEHICLE_CHEETAH,	872.4854, -872.3334, 77.2855, 200.1391); // posh
PTPM_AddVehicle(VEHICLE_ZR350,		833.5978, -926.3884, 54.9567, 246.7931); // posh
PTPM_AddVehicle(VEHICLE_ZR350,		842.0680, -896.1290, 68.4778, 232.5096); // posh
PTPM_AddVehicle(VEHICLE_SUPERGT,	1086.8040, -637.7476, 112.9547, 5.5657); // posh
PTPM_AddVehicle(VEHICLE_HUNTLEY,	1528.2061, -800.0825, 73.0617, 90.4437); // posh 4b (RANCHER)
PTPM_AddVehicle(VEHICLE_NRG500,		1018.2570, -777.7994, 102.6511, 90.7938); // posh bike
PTPM_AddVehicle(VEHICLE_HUNTLEY,	848.0241, -818.4172, 87.0807, 22.0264); // posh rancher
PTPM_AddVehicle(VEHICLE_NRG500,		718.9101, -1001.8113, 52.4130, 148.8447); // posh bike
PTPM_AddVehicle(VEHICLE_NRG500,		278.7959, -1257.6844, 73.9157, 215.0338); // posh bike
PTPM_AddVehicle(VEHICLE_PCJ600,		337.6167, -1308.5352, 54.2161, 209.8673); // sanchez
PTPM_AddVehicle(VEHICLE_PCJ600,		346.4070, -1300.6411, 54.2168, 206.8296); // sanchez
PTPM_AddVehicle(VEHICLE_PATRIOT,	914.0649, -665.7319, 116.7606, 241.1865); // patriot
PTPM_AddVehicle(VEHICLE_MONSTERA,	946.1701, -705.2098, 121.9152, 29.1216); // bandito
PTPM_AddVehicle(VEHICLE_HUNTLEY,	940.8948, -695.8306, 121.1879, 29.9158); // sand king
PTPM_AddVehicle(VEHICLE_HUNTLEY,	1097.4353, -642.2601, 112.5732, 267.1823); // huntley
PTPM_AddVehicle(VEHICLE_COMET,		1659.2822, -1426.8878, 13.3985, 88.7621); // com
PTPM_AddVehicle(VEHICLE_BANSHEE,	1590.5114, -1317.7780, 17.2589, 49.2585); // com
PTPM_AddVehicle(VEHICLE_STALLION,	1809.2898, -1430.6573, 13.1695, 184.9688); // com
PTPM_AddVehicle(VEHICLE_WINDSOR,	1725.2581, -1217.3599, 19.0807, 2.3763); // com
PTPM_AddVehicle(VEHICLE_COMET,		1531.0547, -1066.9626, 24.7978, 90.4579); // com
PTPM_AddVehicle(VEHICLE_ZR350,		1451.6792, -1146.7477, 23.7968, 133.4617); // com
PTPM_AddVehicle(VEHICLE_STALLION,	1328.1886, -1188.7338, 23.3185, 176.1219); // com
PTPM_AddVehicle(VEHICLE_WINDSOR,	1252.2759, -1430.6191, 13.2775, 183.7629); // com
PTPM_AddVehicle(VEHICLE_COMET,		1357.4553, -1570.0588, 13.2831, 161.9771); // com
PTPM_AddVehicle(VEHICLE_BANSHEE,	1677.5549, -1680.1785, 13.2813, 182.6165); // com
PTPM_AddVehicle(VEHICLE_STALLION,	1462.1278, -1356.1224, 13.6903, 0.6286); // com
PTPM_AddVehicle(VEHICLE_CHEETAH,	1294.6667, -984.6381, 32.8379, 180.0905); // cheetah
PTPM_AddVehicle(VEHICLE_STRATUM,	1205.1552, -1070.0197, 29.3908, 178.9626); // res
PTPM_AddVehicle(VEHICLE_CEMENT,		1256.7892, -1261.7640, 13.3957, 272.3957); // ind
PTPM_AddVehicle(VEHICLE_STALLION,	1429.0876, -1408.5740, 13.7150, 179.6099); // com
PTPM_AddVehicle(VEHICLE_STALLION,	1479.4669, -1415.0720, 12.0265, 125.8019); // com
PTPM_AddVehicle(VEHICLE_BLADE,		1947.7089, -1055.4075, 24.3895, 261.2244); // low
PTPM_AddVehicle(VEHICLE_WASHING,	2149.6853, -1137.7899, 25.6585, 90.4148); // saloon
PTPM_AddVehicle(VEHICLE_ELEGY,		2160.4878, -1192.2114, 23.9636, 272.4233); // saloon
PTPM_AddVehicle(VEHICLE_MERIT,		2241.3850, -1317.9384, 24.1282, 269.8383); // saloon
PTPM_AddVehicle(VEHICLE_WASHING,	2347.2151, -1274.0010, 22.6479, 272.8961); // saloon
PTPM_AddVehicle(VEHICLE_SAVANNA,	2427.8301, -1241.7535, 24.4136, 273.2498); // lowrider
PTPM_AddVehicle(VEHICLE_VOODOO,		2413.4661, -1229.0675, 24.5211, 182.1959); // lowrider
PTPM_AddVehicle(VEHICLE_PCJ600,		2463.7815, -1424.0723, 23.8932, 83.3706); // slow bike
PTPM_AddVehicle(VEHICLE_WASHING,	2460.6946, -1551.0662, 24.1444, 273.1476); // saloon
PTPM_AddVehicle(VEHICLE_SAVANNA,	2479.3372, -1748.7130, 13.6900, 180.5300); // lowrider
PTPM_AddVehicle(VEHICLE_GLENSHIT,	2393.3811, -1927.7556, 13.5243, 0.1380); // saloon
PTPM_AddVehicle(VEHICLE_BLADE,		2390.0774, -1884.8796, 13.6899, 265.9858); // lowrider
PTPM_AddVehicle(VEHICLE_GLENSHIT,	2728.9060, -1970.3724, 13.6880, 269.7400); // saloon cheap
PTPM_AddVehicle(VEHICLE_REGINA,		976.4387, -1230.6876, 17.0708, 88.5852); // suv
PTPM_AddVehicle(VEHICLE_FLATBED,	834.1715, -1216.6764, 17.0872, 84.6204); // ind
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	860.5280, -1285.6953, 14.0937, 182.9245); // ind
PTPM_AddVehicle(VEHICLE_MERIT,		920.2068, -1292.6371, 13.8247, 270.7137); // saloon
PTPM_AddVehicle(VEHICLE_SOLAIR,		1012.5267, -1346.8806, 13.4797, 267.5486); // suv
PTPM_AddVehicle(VEHICLE_REGINA,		1117.3052, -1378.9901, 14.4011, 89.1945); // suv
PTPM_AddVehicle(VEHICLE_NRG500,		1132.5653, -1614.6372, 13.9194, 85.6389); // fast bike in shopping centre
PTPM_AddVehicle(VEHICLE_WINDSOR,	1160.2629, -1770.1327, 16.7116, 359.6430); // com
PTPM_AddVehicle(VEHICLE_BANSHEE,	1284.9130, -1732.6017, 13.6673, 0.8082); // com
PTPM_AddVehicle(VEHICLE_REGINA,		974.6439, -1089.6545, 24.2836, 177.6930); // suv
PTPM_AddVehicle(VEHICLE_ELEGY,		785.2358, -1064.5126, 24.9404, 49.4555); // saloon
PTPM_AddVehicle(VEHICLE_COMET,		922.8809, -996.1521, 38.3117, 97.5416); // com
PTPM_AddVehicle(VEHICLE_STRATUM,	1140.2466, -927.7980, 43.3007, 271.3280); // suv
PTPM_AddVehicle(VEHICLE_GLENSHIT,	1337.9901, -901.7728, 36.4426, 180.8606); // saloon
PTPM_AddVehicle(VEHICLE_SWEEPER,	1646.3864, -1062.6378, 24.0274, 155.3884); // sweeper
PTPM_AddVehicle(VEHICLE_BENSON,		1649.0890, -1111.7745, 24.0429, 267.8602); // van
PTPM_AddVehicle(VEHICLE_BURRITO,	1657.3999, -1134.4487, 24.0332, 180.5504); // smallvan
PTPM_AddVehicle(VEHICLE_FLATBED,	1564.0852, -1019.3521, 24.0372, 81.4864); // flatbed
PTPM_AddVehicle(VEHICLE_NRG500,		1518.3389, -1257.1481, 14.6713, 180.1029); // fastbike
PTPM_AddVehicle(VEHICLE_MERIT,		1999.5741, -1445.1320, 13.6917, 217.9478); // saloon
PTPM_AddVehicle(VEHICLE_BLADE,		2086.8411, -1327.5076, 24.1078, 0.7111); // low
PTPM_AddVehicle(VEHICLE_WASHING,	1993.6346, -1276.0702, 23.9460, 357.9409); // saloon
PTPM_AddVehicle(VEHICLE_SWEEPER,	1816.7452, -1133.7300, 24.2091, 273.6008); // sweeper
PTPM_AddVehicle(VEHICLE_COACH,		1775.9677, -1022.6566, 24.0901, 333.2864); // coach
PTPM_AddVehicle(VEHICLE_ELEGY,		2051.7642, -1121.0273, 24.7394, 176.2412); // saloon
PTPM_AddVehicle(VEHICLE_SAVANNA,	2080.0862, -1284.8212, 24.0993, 178.8542); // lowrider
PTPM_AddVehicle(VEHICLE_VOODOO,		2143.8416, -1422.6912, 25.2155, 89.4439); // low
PTPM_AddVehicle(VEHICLE_PCJ600,		2199.1309, -1497.6111, 24.1060, 275.7724); // slowbike
PTPM_AddVehicle(VEHICLE_SOLAIR,		2200.7722, -1660.7334, 15.1396, 164.7502); // sub
PTPM_AddVehicle(VEHICLE_WAYFARER,	2321.2974, -1756.2679, 13.6757, 273.8248); // Wayfarer
PTPM_AddVehicle(VEHICLE_STRETCH,	1460.0215, -1025.5533, 23.5681, 90.6347); // limo bingo
PTPM_AddVehicle(VEHICLE_STRETCH,	1439.1008, -1025.7854, 23.5682, 90.6346); // limo bingo
PTPM_AddVehicle(VEHICLE_COACH,		1567.8092, -1891.4109, 13.7520, 356.6625); // coach
PTPM_AddVehicle(VEHICLE_STRATUM,	1370.2388, -1889.9265, 13.7022, 359.3041); // suv
PTPM_AddVehicle(VEHICLE_GLENSHIT,	1206.1053, -1829.6782, 13.5963, 92.9658); // saloon
PTPM_AddVehicle(VEHICLE_BANSHEE,	1022.5290, -1832.1632, 13.8703, 62.2289); // com
PTPM_AddVehicle(VEHICLE_WINDSOR,	860.6016, -1756.1599, 13.7098, 17.1219); // com
PTPM_AddVehicle(VEHICLE_CHEETAH,	721.0599, -1809.3398, 12.5489, 71.5726); // posh
PTPM_AddVehicle(VEHICLE_SOLAIR,		479.5703, -1765.3434, 5.7271, 87.6614); // suv
PTPM_AddVehicle(VEHICLE_REGINA,		266.6155, -1746.7922, 4.5722, 91.5479); // suv
PTPM_AddVehicle(VEHICLE_COMET,		276.7425, -1594.9742, 33.2880, 348.6675); // com
PTPM_AddVehicle(VEHICLE_STALLION,	425.1006, -1440.8821, 31.4193, 36.4924); // com
PTPM_AddVehicle(VEHICLE_STRATUM,	551.6909, -1505.2357, 14.7316, 182.8906); // suv
PTPM_AddVehicle(VEHICLE_MERIT,		649.7829, -1620.6465, 15.2105, 112.6496); // saloon
PTPM_AddVehicle(VEHICLE_NRG500,		682.0504, -1259.6924, 13.7628, 106.4779); // bikefast
PTPM_AddVehicle(VEHICLE_WAYFARER,	2175.6335, -993.5605, 63.1809, 169.8002); // Wayfarer
PTPM_AddVehicle(VEHICLE_RANCHER,	2453.6128, -1016.0901, 59.8982, 177.5543); // rancher
PTPM_AddVehicle(VEHICLE_WASHING,	2536.1904, -1104.8235, 59.8875, 180.5492); // saloon
PTPM_AddVehicle(VEHICLE_BLADE,		2328.6465, -1407.3834, 24.1766, 178.8325); // low
PTPM_AddVehicle(VEHICLE_MONSTERA,	2492.1194, -1663.3529, 13.5302, 82.4906); // monster
PTPM_AddVehicle(VEHICLE_GLENSHIT,	2066.3311, -1694.5254, 13.7310, 268.5239); // GLENSHIT
PTPM_AddVehicle(VEHICLE_CEMENT,		2054.1970, -1767.7522, 13.7393, 181.0835); // cement
PTPM_AddVehicle(VEHICLE_FLATBED,	1939.3959, -1815.7340, 13.7385, 77.9876); // flatbed
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	1937.9028, -1939.7325, 13.7375, 89.1628); // towtruck
PTPM_AddVehicle(VEHICLE_PCJ600,		1941.1481, -2140.8420, 13.7440, 175.4044); // PCJ600
PTPM_AddVehicle(VEHICLE_SWEEPER,	2125.8816, -2165.4050, 13.7341, 320.7342); // sweeper
PTPM_AddVehicle(VEHICLE_PATRIOT,	2076.9661, -1994.8885, 13.7389, 41.9139); // patriot
PTPM_AddVehicle(VEHICLE_GLENSHIT,	1502.1649, -2212.7788, 13.3136, 359.6183); // saloon
PTPM_AddVehicle(VEHICLE_STRATUM,	1407.0730, -2261.8484, 13.3164, 180.3750); // suv
PTPM_AddVehicle(VEHICLE_BANSHEE,	1365.5696, -2365.7705, 13.3159, 90.6723); // com
PTPM_AddVehicle(VEHICLE_BENSON,		1789.8521, -2180.6389, 13.3187, 270.2510); // van
PTPM_AddVehicle(VEHICLE_WASHING,	1922.5924, -1605.3048, 13.1082, 269.9615); // saloon
PTPM_AddVehicle(VEHICLE_WAYFARER,	2070.1260, -1591.6121, 13.0664, 182.2131); // Wayfarer
PTPM_AddVehicle(VEHICLE_MERIT,		2705.9854, -1844.6924, 9.8701, 340.3920); // saloon
PTPM_AddVehicle(VEHICLE_SOLAIR,		2813.2185, -1671.5564, 10.3166, 2.8114); // suv
PTPM_AddVehicle(VEHICLE_SAVANNA,	2644.6707, -2023.4589, 13.9219, 1.6210); // low
PTPM_AddVehicle(VEHICLE_CEMENT,		2743.6338, -2138.0737, 11.5750, 94.0439); // cement
PTPM_AddVehicle(VEHICLE_FLATBED,	2300.8748, -2043.2729, 13.9219, 93.1316); // flatbed
PTPM_AddVehicle(VEHICLE_ELEGY,		2241.5413, -2111.0176, 13.9195, 134.0082); // saloon
PTPM_AddVehicle(VEHICLE_NRG500,		2228.4226, -1811.8547, 13.8943, 269.9799); // NRG500
PTPM_AddVehicle(VEHICLE_BLADE,		2505.4697, -1235.4440, 37.6099, 356.9889); // lowr
PTPM_AddVehicle(VEHICLE_BURRITO,	2587.6326, -1322.8219, 40.4727, 91.7934); // smallvan
PTPM_AddVehicle(VEHICLE_PCJ600,		2527.5496, -1465.3361, 24.3251, 86.3631); // slowbike
PTPM_AddVehicle(VEHICLE_MERIT,		2698.6609, -1191.8911, 69.7986, 270.9197); // saloon
PTPM_AddVehicle(VEHICLE_RANCHER,	2706.4719, -1274.8931, 58.4590, 135.3378); // rancher
PTPM_AddVehicle(VEHICLE_BANSHEE,	894.8080, -1518.4893, 12.8387, 9.3645); // com
PTPM_AddVehicle(VEHICLE_STRATUM,	883.8334, -1669.2842, 13.2677, 179.1199); // suv
PTPM_AddVehicle(VEHICLE_STRATUM,	932.0258, -846.5217, 93.5395, 204.0052); // stratum
PTPM_AddVehicle(VEHICLE_ELEGY,		1515.5645, -694.6604, 94.5642, 92.3278); // zr350
PTPM_AddVehicle(VEHICLE_STRATUM,	2799.5591, -1258.3878, 47.0600, 204.8639); // stratum
PTPM_AddVehicle(VEHICLE_ELEGY,		666.1675, -1420.3197, 14.3140, 182.4264); // stratum
PTPM_AddVehicle(VEHICLE_BURRITO,	1670.2103, -2111.6082, 13.3595, 271.8420); // burrito
PTPM_AddVehicle(VEHICLE_STRATUM,	1852.8041, -2104.9824, 13.3596, 270.4381); // stratum
PTPM_AddVehicle(VEHICLE_SOLAIR,		2257.3926, -1887.3085, 13.1181, 270.4228); // shit car
PTPM_AddVehicle(VEHICLE_STRATUM,	2257.3926, -1887.3085, 13.1181, 270.4244); // crap car
PTPM_AddVehicle(VEHICLE_ELEGY,		2795.7795, -1589.3219, 10.5862, 270.9865); // tspawn
PTPM_AddVehicle(VEHICLE_GLENSHIT,	2629.7607, -1097.9878, 69.0963, 84.7661); // crap car
PTPM_AddVehicle(VEHICLE_SOLAIR,		2452.0415, -2024.6608, 13.2054, 179.7856); // shit car
PTPM_AddVehicle(VEHICLE_STRATUM,	2272.9333, -1911.0579, 13.2040, 358.7230); // shit car
PTPM_AddVehicle(VEHICLE_GLENSHIT,	2171.2175, -1726.0149, 13.1972, 89.1969); // shit car
PTPM_AddVehicle(VEHICLE_SOLAIR,		1981.4486, -1658.5092, 15.6288, 91.2597); // shit car
PTPM_AddVehicle(VEHICLE_SOLAIR,		2408.9807, -1391.3481, 24.1352, 267.8494); // solair
PTPM_AddVehicle(VEHICLE_WAYFARER,	2327.3572, -1225.1285, 27.8549, 91.6161); // wayfarer
PTPM_AddVehicle(VEHICLE_COMET,		612.4523, -1349.6593, 13.5771, 101.3442); // comet
PTPM_AddVehicle(VEHICLE_PCJ600,		494.7574, -1359.1431, 16.8249, 117.3824); // pcj
PTPM_AddVehicle(VEHICLE_ZR350,		515.5775, -1611.4176, 16.2628, 181.5104); // zr350
PTPM_AddVehicle(VEHICLE_ELEGY,		383.7121, -1599.5427, 29.9967, 270.5061); // elegy
PTPM_AddVehicle(VEHICLE_ELEGY,		-2118.9319, 194.8274, 35.7567, 2.7513);
PTPM_AddVehicle(VEHICLE_ELEGY,		-2036.5212, 305.6321, 35.9090, 359.8144);
PTPM_AddVehicle(VEHICLE_BENSON,		-2087.8369, 255.6416, 37.0341, 357.9168);
PTPM_AddVehicle(VEHICLE_CADDY,		-2652.9031, -297.2605, 8.0617, 315.6009);
PTPM_AddVehicle(VEHICLE_CADDY,		-2659.7441, -289.6562, 8.0920, 313.6239);
PTPM_AddVehicle(VEHICLE_CADDY,		-2642.9949, -301.7552, 8.0090, 47.6567);
PTPM_AddVehicle(VEHICLE_STRATUM,	-2618.9480, 1376.7870, 7.7322, 181.1998);
PTPM_AddVehicle(VEHICLE_SUPERGT,	-2645.5964, 1376.7522, 7.8935, 267.8349);
PTPM_AddVehicle(VEHICLE_STRETCH,	-2628.6924, 1377.4845, 7.9350, 180.7913);
PTPM_AddVehicle(VEHICLE_STRETCH,	-2633.1638, 1332.7010, 7.9953, 269.6430);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-2126.2573, 650.7344, 53.2421, 88.8335);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-2125.8604, 658.0598, 53.3040, 92.1547);
PTPM_AddVehicle(VEHICLE_MERIT,		-2158.0305, 657.3961, 53.2440, 272.5298);
PTPM_AddVehicle(VEHICLE_NRG500,		-2151.1257, 629.7889, 52.8293, 180.7068);
PTPM_AddVehicle(VEHICLE_MERIT,		-2156.6838, 942.3219, 80.8784, 269.6746);
PTPM_AddVehicle(VEHICLE_COMET,		-2223.2629, 1083.2794, 82.7819, 359.6700);
PTPM_AddVehicle(VEHICLE_MONSTERA,	-2517.2996, 1229.3512, 38.7999, 209.3221);
PTPM_AddVehicle(VEHICLE_NRG500,		-1654.1005, 1211.9901, 14.2380, 315.9562);
PTPM_AddVehicle(VEHICLE_CHEETAH,	-1660.4161, 1213.3704, 8.0209, 295.4768);
PTPM_AddVehicle(VEHICLE_CHEETAH,	-1553.3494, 1089.8568, 7.9584, 89.1789);
PTPM_AddVehicle(VEHICLE_TAXI,		-1497.4607, 845.8477, 7.9671, 88.5197);
PTPM_AddVehicle(VEHICLE_WASHING,	-1699.4597, 1035.9624, 46.0932, 91.6588);
PTPM_AddVehicle(VEHICLE_ZR350,		-1786.6871, 1206.5266, 25.7813, 178.8742);
PTPM_AddVehicle(VEHICLE_ZR350,		-1703.9169, 1339.6957, 7.8358, 133.6003);
PTPM_AddVehicle(VEHICLE_WASHING,	-2438.0117, 1340.9783, 8.7316, 86.7979);
PTPM_AddVehicle(VEHICLE_SUPERGT,	-2168.5137, 1251.3845, 27.4573, 358.0133);
PTPM_AddVehicle(VEHICLE_SUPERGT,	-2636.3838, 932.3286, 72.5378, 187.1212);
PTPM_AddVehicle(VEHICLE_PCJ600,		-2566.5906, 989.6594, 78.8568, 358.1472);
PTPM_AddVehicle(VEHICLE_PCJ600,		-2464.8860, 896.7036, 63.6223, 0.6326);
PTPM_AddVehicle(VEHICLE_MERIT,		-2273.8679, 921.3689, 67.3102, 359.9958);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2459.9055, 786.4501, 36.2643, 89.8722);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2673.5830, 802.1517, 51.0693, 0.3607);
PTPM_AddVehicle(VEHICLE_MONSTERA,	-2902.7820, 342.5712, 6.3723, 138.7612);
PTPM_AddVehicle(VEHICLE_MONSTERA,	-2876.3977, 26.3173, 7.2123, 118.5961);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-1382.4279, 455.8060, 7.1838, 359.9849);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-1439.3396, 455.1034, 7.1739, 0.1531);
PTPM_AddVehicle(VEHICLE_MERIT,		-1465.0304, 455.6730, 7.9280, 358.9676);
PTPM_AddVehicle(VEHICLE_KART,		-1677.1865, 438.8195, 7.4635, 227.1910);
PTPM_AddVehicle(VEHICLE_SAVANNA,	-1872.5575, -820.7949, 32.8273, 90.7921);
PTPM_AddVehicle(VEHICLE_MONSTERA,	-1898.3019, -915.5814, 33.3947, 91.2857);
PTPM_AddVehicle(VEHICLE_ELEGY,		-2124.4800, -929.0856, 32.7397, 269.1853);
PTPM_AddVehicle(VEHICLE_ELEGY,		-2133.3015, -847.1439, 32.7396, 88.8312);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-2134.1038, -775.5048, 32.8568, 91.5838);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-2134.1428, -453.9576, 36.1699, 95.0875);
PTPM_AddVehicle(VEHICLE_BULLET,		-2035.6851, 170.2529, 29.4610, 268.9087);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2219.7209, -83.2318, 36.4367, 2.0481);
PTPM_AddVehicle(VEHICLE_BULLET,		-2018.4379, -98.9675, 35.7890, 358.5420);
PTPM_AddVehicle(VEHICLE_BULLET,		-2352.0959, -126.8848, 35.9374, 179.5324);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-2180.1277, 41.8536, 36.1953, 269.9865);
PTPM_AddVehicle(VEHICLE_NRG500,		-2269.4526, 69.5823, 35.7279, 89.6104);
PTPM_AddVehicle(VEHICLE_NRG500,		-2266.0090, 145.0206, 35.7322, 92.0045);
PTPM_AddVehicle(VEHICLE_SAVANNA,	-2129.2864, 787.6249, 70.3666, 87.1679);
PTPM_AddVehicle(VEHICLE_SAVANNA,	-2424.9958, 740.8871, 35.8205, 177.6701);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2684.7639, 636.4294, 14.5454, 179.2696);
PTPM_AddVehicle(VEHICLE_ELEGY,		-2545.7666, 627.5895, 15.1684, 89.1952);
PTPM_AddVehicle(VEHICLE_ELEGY,		-2428.7107, 514.7900, 30.6451, 207.9893);
PTPM_AddVehicle(VEHICLE_BANSHEE,	-2498.4822, 357.5526, 35.7969, 58.0823);
PTPM_AddVehicle(VEHICLE_BANSHEE,	-2664.9673, 268.9968, 5.0156, 357.6026);
PTPM_AddVehicle(VEHICLE_TAXI,		-2626.5276, -53.6779, 5.1144, 357.7703);
PTPM_AddVehicle(VEHICLE_COMET,		-2718.5354, -124.4790, 5.3071, 269.1429);
PTPM_AddVehicle(VEHICLE_COMET,		-2487.5295, -125.3075, 26.5715, 90.9363);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2486.0298, 51.5018, 27.7954, 177.2178);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2574.9736, 146.5981, 5.4279, 1.8790);
PTPM_AddVehicle(VEHICLE_ZR350,		-2800.0251, 205.2155, 7.8399, 92.2606);
PTPM_AddVehicle(VEHICLE_ELEGY,		-1741.0009, 811.0599, 25.5879, 270.6703);
PTPM_AddVehicle(VEHICLE_ELEGY,		-1920.7559, 875.2713, 36.1113, 270.0973);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2040.4465, 1107.7076, 54.4032, 89.8491);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-1968.8488, 465.6065, 36.2766, 89.3124);
PTPM_AddVehicle(VEHICLE_ELEGY,		-1938.2876, 584.4863, 35.9137, 1.1244);
PTPM_AddVehicle(VEHICLE_ELEGY,		-1825.2035, -0.4858, 15.8965, 270.0104);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-1820.0182, -175.9391, 10.3323, 87.9147);
PTPM_AddVehicle(VEHICLE_BANSHEE,	-1687.9076, 1003.5587, 18.2656, 91.3972);
PTPM_AddVehicle(VEHICLE_STALLION,	-1704.8613, 1058.0004, 18.4810, 182.3475);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-1702.2262, 1028.7677, 18.5187, 270.2923);
PTPM_AddVehicle(VEHICLE_COMET,		-1735.9534, 1016.0621, 18.3580, 268.5771);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2782.3508, 442.1533, 5.5383, 57.1401);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2836.3665, 865.6495, 44.1470, 268.7662);
PTPM_AddVehicle(VEHICLE_CHEETAH,	-2899.3823, 1112.4786, 27.3954, 268.9744);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-2654.5662, 615.2198, 15.2873, 0.1598);
PTPM_AddVehicle(VEHICLE_AMBULAN,	-2618.7363, 627.2617, 15.6024, 179.6464);
PTPM_AddVehicle(VEHICLE_ELEGY,		-1968.8031, -400.9335, 35.1227, 88.2282);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-1904.3373, -599.6174, 24.4277, 344.2378);
PTPM_AddVehicle(VEHICLE_SAVANNA,	-1639.3912, -567.4948, 13.9482, 80.1914);
PTPM_AddVehicle(VEHICLE_SAVANNA,	-1405.5500, -309.2615, 13.9504, 174.9827);
PTPM_AddVehicle(VEHICLE_SAVANNA,	-2132.1143, 160.2086, 35.1341, 270.0023);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2151.4924, 428.9210, 35.1902, 176.6156);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2304.8279, 360.0154, 35.2835, 201.6184);
PTPM_AddVehicle(VEHICLE_NRG500,		-1696.7413, 977.0867, 17.1574, 7.0263);
PTPM_AddVehicle(VEHICLE_BANSHEE,	-2641.7395, 1333.0645, 6.8700, 356.7557);
PTPM_AddVehicle(VEHICLE_CADDY,		-2650.6292, -280.5106, 7.0874, 132.0127);
PTPM_AddVehicle(VEHICLE_WASHING,	-1409.6693, 456.0711, 7.0672, 3.2988);
PTPM_AddVehicle(VEHICLE_PHOENIX,	-2617.2964, 1349.0765, 7.0217, 358.1852); //
PTPM_AddVehicle(VEHICLE_SAVANNA,	-2129.8242, 288.0418, 34.9864, 269.9582); //
PTPM_AddVehicle(VEHICLE_COPBIKE,	-1628.6875, 652.5107, 6.9568, 0.9097); //
PTPM_AddVehicle(VEHICLE_COPBIKE,	-1616.7957, 652.5980, 6.9551, 0.6199); //
PTPM_AddVehicle(VEHICLE_COPBIKE,	-1594.2644, 672.5858, 6.9564, 176.7420); //
PTPM_AddVehicle(VEHICLE_COPBIKE,	-1593.5823, 652.3891, 6.9567, 1.3142);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1611.9730, 673.5499, 6.9567, 181.6088);
PTPM_AddVehicle(VEHICLE_REGINA,		-2553.0054, 626.6677, 27.6950, 358.6974); // suv
PTPM_AddVehicle(VEHICLE_PCJ600,		-2242.9187, 765.5427, 49.3059, 1.6011); // PCJ600
PTPM_AddVehicle(VEHICLE_KART,		-1965.3051, 720.0149, 45.3278, 268.9010); // KART
PTPM_AddVehicle(VEHICLE_PCJ600,		-1787.6517, 745.9218, 36.2055, 272.1465); // PCJ600
PTPM_AddVehicle(VEHICLE_COMET,		-2391.2390, 1125.9204, 55.8569, 339.7648); // conv
PTPM_AddVehicle(VEHICLE_REGINA,		-2421.8684, 1133.9849, 55.8559, 345.8843); // suv
PTPM_AddVehicle(VEHICLE_BANSHEE,	-2485.5100, 1137.4042, 55.8537, 359.9205); // conv
PTPM_AddVehicle(VEHICLE_PCJ600,		-2561.9558, 1146.1674, 55.8537, 281.0753); // slowbike
PTPM_AddVehicle(VEHICLE_CADDY,		-2615.2432, -296.0932, 22.3635, 44.6924);
PTPM_AddVehicle(VEHICLE_CADDY,		-2622.9700, -310.6605, 22.1746, 14.7554);
PTPM_AddVehicle(VEHICLE_CADDY,		-2623.6943, -301.5168, 21.9019, 4.1876);
PTPM_AddVehicle(VEHICLE_FBIRANCH,	-2696.1272, -282.0655, 6.6658, 315.9437);
PTPM_AddVehicle(VEHICLE_WASHING,	-2688.7402, -274.1584, 6.9215, 315.4178);
PTPM_AddVehicle(VEHICLE_FBIRANCH,	-2679.0486, -264.3250, 6.8715, 315.4175);
PTPM_AddVehicle(VEHICLE_CADDY,		-2617.6021, -300.3896, 22.2979, 65.0813);
PTPM_AddVehicle(VEHICLE_NEWSVAN,	-2682.7249, -251.1302, 6.5105, 319.0648); // newsvan
PTPM_AddVehicle(VEHICLE_NEWSVAN,	-2708.5098, -277.6510, 6.7756, 316.4557); // newsvan
PTPM_AddVehicle(VEHICLE_WAYFARER,	-2709.3982, -259.5328, 6.6492, 353.2961); // Wayfarer
PTPM_AddVehicle(VEHICLE_SWATVAN,	-1639.3496, 678.0804, -5.5212, 270.5469); // swat tank1
PTPM_AddVehicle(VEHICLE_SWATVAN,	-1639.0546, 670.0349, -5.5225, 270.1779); // swat tank 2
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1612.4198, 691.3272, -5.5208, 178.9291); // cop car
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1572.7882, 726.3871, -5.5206, 89.3208); // cop car
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1588.2332, 749.4512, -5.5218, 359.9219); // cop car
PTPM_AddVehicle(VEHICLE_COPCARRU,	-1612.4628, 749.3665, -5.5211, 178.7688); // cop 4x4
PTPM_AddVehicle(VEHICLE_COPCARRU,	-1612.2714, 733.6174, -5.5221, 359.8494); // cop 4x4
PTPM_AddVehicle(VEHICLE_COPCARRU,	-1616.9042, 733.5754, -5.5214, 1.2638); // cop 4x4
PTPM_AddVehicle(VEHICLE_COPBIKE,	-1574.5774, 748.6456, -5.5200, 142.5166); // cop bike
PTPM_AddVehicle(VEHICLE_ENFORCER,	-1637.4391, 662.2834, 6.9071, 270.4799); // swat van
PTPM_AddVehicle(VEHICLE_ENFORCER,	-1637.2936, 672.0524, 6.9071, 273.6113); // swat van
PTPM_AddVehicle(VEHICLE_ENFORCER,	-1637.9066, 658.2620, 6.9066, 267.4762); // swat van
PTPM_AddVehicle(VEHICLE_COPCARRU,	-1588.5615, 673.4885, 6.9084, 178.4371); // police 4x4
PTPM_AddVehicle(VEHICLE_VORTEX,		-2952.4602, 495.9247, 1.9517, 0.4375);
PTPM_AddVehicle(VEHICLE_SQUALO,		-2970.6746, 497.2838, 1.3557, 4.0073);
PTPM_AddVehicle(VEHICLE_MARQUIS,	-1476.5386, 700.1740, 1.1248, 355.3123);
PTPM_AddVehicle(VEHICLE_MARQUIS,	-1572.3998, 1370.7104, 0.2841, 252.0055);
PTPM_AddVehicle(VEHICLE_MARQUIS,	-1503.8254, 1300.6124, 0.6895, 273.7650);
PTPM_AddVehicle(VEHICLE_SQUALO,		-1571.3143, 1263.2914, 1.2879, 269.1020);
PTPM_AddVehicle(VEHICLE_SQUALO,		-1720.0265, 1436.3821, 1.4272, 3.3108);
PTPM_AddVehicle(VEHICLE_SQUALO,		-1464.9600, 1023.3726, -0.6029, 270.2424);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2441.2109, 1414.1995, 1.4429, 86.1079);
PTPM_AddVehicle(VEHICLE_VORTEX,		-1835.1257, 1425.9342, 7.5476, 184.1130);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2587.4680, 1444.1047, 0.3254, 4.6667);
PTPM_AddVehicle(VEHICLE_VORTEX,		-1891.6384, 1396.1394, 0.7461, 271.1545);
PTPM_AddVehicle(VEHICLE_KART,		-2451.3318, 556.0181, 22.6719, 267.4335); // KART
PTPM_AddVehicle(VEHICLE_VORTEX,		-2377.0471, 649.9578, 35.3007, 359.7591); // vortex
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	-2094.1772, 1345.9810, 7.3105, 88.1415); // van
PTPM_AddVehicle(VEHICLE_BURRITO,	-2063.2434, 1398.5623, 7.2271, 178.7124); // smallvan
PTPM_AddVehicle(VEHICLE_PCJ600,		-2073.9851, 1374.2258, 7.2329, 172.5076); // PCJ600
PTPM_AddVehicle(VEHICLE_NRG500,		-2079.8274, 1371.4542, 7.2302, 180.3891); // PCJ600
PTPM_AddVehicle(VEHICLE_WAYFARER,	-2088.0586, 1371.1990, 7.2287, 179.4680); // Wayfarer
PTPM_AddVehicle(VEHICLE_WAYFARER,	-2087.9033, 1387.9725, 7.2257, 179.4678); // Wayfarer
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-2087.6611, 1413.9387, 7.2278, 179.4678); // huntley
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-2082.3779, 1414.4132, 7.2291, 180.7033); // huntley
PTPM_AddVehicle(VEHICLE_PCJ600,		-2068.6760, 1369.5734, 6.6863, 178.4523); // fast bike
PTPM_AddVehicle(VEHICLE_PCJ600,		-2068.3259, 1382.5973, 6.6855, 178.4524); // slowbike
PTPM_AddVehicle(VEHICLE_WAYFARER,	-2084.0664, 1371.8256, 6.6868, 181.7741); // bigbike
PTPM_AddVehicle(VEHICLE_WAYFARER,	-2088.7297, 1362.1067, 6.6868, 181.7492); // bigbike
PTPM_AddVehicle(VEHICLE_PCJ600,		-2073.7957, 1384.0508, 6.6907, 177.6445); //
PTPM_AddVehicle(VEHICLE_PCJ600,		-2073.4456, 1392.5313, 6.6856, 177.6445); //
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-2077.5728, 1413.7444, 7.0339, 179.4285); //
PTPM_AddVehicle(VEHICLE_WAYFARER,	-2084.2048, 1361.7908, 6.6211, 203.1954); //
PTPM_AddVehicle(VEHICLE_BURRITO,	-2063.0005, 1409.0186, 7.2237, 178.7168); // burritto
PTPM_AddVehicle(VEHICLE_ELEGY,		-2077.6667, 1404.0363, 7.0272, 179.4645); // suv
PTPM_AddVehicle(VEHICLE_MERIT,		-2082.0869, 1403.5656, 7.0361, 179.1644); // suv
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2087.1438, 1404.6234, 7.0344, 178.8210); // suv
PTPM_AddVehicle(VEHICLE_ELEGY,		-2093.3323, 1361.7595, 7.0396, 179.7579); // solair
PTPM_AddVehicle(VEHICLE_MERIT,		-2047.3087, 1332.6898, 7.0630, 270.9971); // comet
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-2119.3062, 1343.2362, 6.9395, 271.4023); // glenshit
PTPM_AddVehicle(VEHICLE_SQUALO,		-1782.7452, 1550.7842, 0.2427, 298.0088); // fastboat
PTPM_AddVehicle(VEHICLE_SQUALO,		-1617.7899, 1433.6151, 0.1265, 241.6499); // fastboat
PTPM_AddVehicle(VEHICLE_SQUALO,		-1476.5730, 1201.7140, 0.3884, 187.7503); // fastboat
PTPM_AddVehicle(VEHICLE_VORTEX,		-2571.3198, 1386.4089, 6.5449, 351.2159); // new hover
PTPM_AddVehicle(VEHICLE_VORTEX,		-2467.5503, 1388.8195, 6.5475, 271.6523); // hover
PTPM_AddVehicle(VEHICLE_VORTEX,		-2335.7229, 1397.4176, 7.0563, 249.1124); // hover
PTPM_AddVehicle(VEHICLE_VORTEX,		-2121.6143, 1351.7623, 6.7545, 88.0823);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2217.0090, 1351.9673, 6.7745, 88.6992);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2192.4121, 1351.1522, 6.7707, 284.6617);
PTPM_AddVehicle(VEHICLE_SQUALO,		-1476.0929, 786.0922, -0.6458, 182.0836);
PTPM_AddVehicle(VEHICLE_SQUALO,		-1427.3295, 1502.5604, -0.8800, 89.7601);
PTPM_AddVehicle(VEHICLE_SQUALO,		-1847.7698, 1423.7585, -0.5177, 359.4388);
PTPM_AddVehicle(VEHICLE_LAUNCH,		-1449.3230, 505.5132, -0.5058, 270);
PTPM_AddVehicle(VEHICLE_COASTG,		-1743.9081, -441.6930, -0.5253, 183.3405); // airport boat
PTPM_AddVehicle(VEHICLE_COASTG,		-1760.5818, -193.3124, -0.5872, 269.6204); // airport boat
PTPM_AddVehicle(VEHICLE_COASTG,		-1621.9231, -78.1221, -0.5000, 313.5698); // airport boat
PTPM_AddVehicle(VEHICLE_COASTG,		-1446.9172, 97.8464, -0.6803, 314.6446); // airport boat
PTPM_AddVehicle(VEHICLE_REEFER,		-1418.3523, 285.4225, -0.6217, 268.9906); // docks boat
PTPM_AddVehicle(VEHICLE_REEFER,		-1723.4645, 230.2587, -0.7048, 270.5277); // docks boat
PTPM_AddVehicle(VEHICLE_REEFER,		-1632.4884, 159.8977, -0.6968, 311.1300); // drydock
PTPM_AddVehicle(VEHICLE_COASTG,		-1167.7355, 375.8934, -0.6307, 314.5526); // airport boat
PTPM_AddVehicle(VEHICLE_COASTG,		-1112.2026, 329.8409, -0.5130, 136.9124); // airport boat
PTPM_AddVehicle(VEHICLE_COASTG,		-1177.1118, 63.8489, -0.6081, 224.9513); // airport boat
PTPM_AddVehicle(VEHICLE_COASTG,		-1075.4756, -206.9377, -0.5344, 203.3205); // airport boat
PTPM_AddVehicle(VEHICLE_COASTG,		-1150.6558, -482.9445, -0.5905, 148.9825); // airport boat
PTPM_AddVehicle(VEHICLE_COASTG,		-1607.0641, -702.9749, -0.4593, 270.0885); // airport boat
PTPM_AddVehicle(VEHICLE_COASTG,		-1364.8530, -703.1875, -0.4967, 270.1161); // airport boat
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-2814.9182, -477.1983, 7.3531, 222.6756); // beach 4x4
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-2822.3184, -468.9637, 7.4042, 222.0451); // beach 4x4
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-2876.0679, -839.9258, 7.2172, 357.1570); // fucked car
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	-2876.3040, -825.2849, 7.1785, 1.2016); // towtruck
PTPM_AddVehicle(VEHICLE_BENSON,		-2532.0105, -602.5928, 132.6927, 359.4939); // radio carpark
PTPM_AddVehicle(VEHICLE_NEWSVAN,	-2524.3274, -602.7990, 132.6927, 0.9272); // radio carpark
PTPM_AddVehicle(VEHICLE_NEWSVAN,	-2513.2004, -602.8831, 132.6864, 1.4615); // radio carpark
PTPM_AddVehicle(VEHICLE_SOLAIR,		-2502.0054, -602.0209, 132.6915, 0.9653); // radio carpark
PTPM_AddVehicle(VEHICLE_REGINA,		-2400.2839, -590.4700, 132.7790, 306.5735); // viewpoint carpark
PTPM_AddVehicle(VEHICLE_JOURNEY,	-2414.1060, -587.6380, 132.7768, 35.3057); // viewpoint carpark
PTPM_AddVehicle(VEHICLE_WAYFARER,	-2395.2109, -608.6385, 132.7716, 215.7133); // viewpoint carpark
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-2362.3987, -780.2640, 96.1125, 193.0705); // 4x4
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-2201.4636, -551.4395, 47.6846, 358.4681); // 4x4
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-2428.3564, -390.9952, 70.0237, 92.9686); // crashed car
PTPM_AddVehicle(VEHICLE_JOURNEY,	-2882.9551, -599.6321, 9.7859, 351.3701); // camper
PTPM_AddVehicle(VEHICLE_PCJ600,		-2148.5542, -808.8277, 31.9549, 89.9021); // tech park
PTPM_AddVehicle(VEHICLE_ELEGY,		-2148.7292, -885.6193, 31.9578, 89.6638); // tech park
PTPM_AddVehicle(VEHICLE_CHEETAH,	-1897.3196, -783.9266, 31.9551, 270.5961); // tech park
PTPM_AddVehicle(VEHICLE_SOLAIR,		-1872.0267, -756.9329, 31.9565, 268.8901); // tech park
PTPM_AddVehicle(VEHICLE_REGINA,		-1971.7909, -538.6796, 35.2640, 272.4551); // football
PTPM_AddVehicle(VEHICLE_BURRITO,	-1972.0245, -1015.7067, 32.1036, 129.0533); // tech park
PTPM_AddVehicle(VEHICLE_COMET,		-1948.7224, -1132.9247, 30.5945, 86.2853); // tech park
PTPM_AddVehicle(VEHICLE_JOURNEY,	-1506.8927, -1537.7859, 38.3132, 339.5128); // journey
PTPM_AddVehicle(VEHICLE_JOURNEY,	-1510.2832, -1527.9327, 38.0075, 74.6150); // journey
PTPM_AddVehicle(VEHICLE_JOURNEY,	-1524.4808, -1534.1583, 38.0160, 119.8126); // journey
PTPM_AddVehicle(VEHICLE_JOURNEY,	-1625.8491, -1275.6527, 57.8366, 31.8669); // journey
PTPM_AddVehicle(VEHICLE_JOURNEY,	-1641.4857, -1263.7281, 57.8337, 98.5026); // journey
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-1640.9807, -1276.2377, 56.5083, 149.0352); // huntley
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-1647.4043, -1275.2749, 56.0543, 141.6455); // huntley
PTPM_AddVehicle(VEHICLE_WAYFARER,	-1729.4688, -612.3710, 14.0835, 180.1983); // wayfarer
PTPM_AddVehicle(VEHICLE_COPCARRU,	-373.4946, 2229.2224, 42.6745, 103.8068); // Cop
PTPM_AddVehicle(VEHICLE_COPCARRU,	-372.0769, 2223.4812, 42.6760, 103.3467); // Cop
PTPM_AddVehicle(VEHICLE_COPCARRU,	-370.6270, 2217.8696, 42.6781, 102.8179); // Cop
PTPM_AddVehicle(VEHICLE_COPCARRU,	-369.5875, 2212.5266, 42.6767, 104.3322); // Cop
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-392.1177, 2234.2717, 42.1881, 286.7657); // Car
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-393.1129, 2239.7837, 42.2510, 286.0437); // Car
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-378.9341, 2252.8047, 42.2196, 103.4142); // Vehicle
PTPM_AddVehicle(VEHICLE_QUAD,		-333.4667, 1513.3398, 74.8400, 179.6975); // Terrorororor
PTPM_AddVehicle(VEHICLE_JOURNEY,	-315.4058, 1515.2224, 75.7326, 179.3794); // Terror RV
PTPM_AddVehicle(VEHICLE_MTBIKE,		-320.9330, 1513.6566, 74.9672, 184.2828); // Terror
PTPM_AddVehicle(VEHICLE_MTBIKE,		-324.0143, 1514.1841, 74.9702, 192.7250); // Terror Bike
PTPM_AddVehicle(VEHICLE_BANDITO,	-327.4584, 1514.8817, 75.2251, 177.9374); // Terror
PTPM_AddVehicle(VEHICLE_BANDITO,	-330.8202, 1515.2344, 75.2245, 178.2083); // Terror
PTPM_AddVehicle(VEHICLE_BANDITO,	-287.6006, 1519.2936, 75.2256, 223.3827); // Terr or
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-306.1739, 1535.9799, 75.2306, 276.8695); // Dirtyt
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-313.9410, 1538.3921, 75.2314, 182.0586); // No
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-344.7124, 1521.8835, 75.0285, 280.9128); // Molll
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-345.1044, 1519.1165, 75.0279, 288.5814); // Bike
PTPM_AddVehicle(VEHICLE_RUSTLER,	291.1415, 2541.4473, 17.5427, 179.1035); // Muster
PTPM_AddVehicle(VEHICLE_RUSTLER,	325.2618, 2538.6426, 17.5348, 175.0817); // Muster
PTPM_AddVehicle(VEHICLE_RUSTLER,	344.1243, 2541, 17.4814, 180); // rustler1
PTPM_AddVehicle(VEHICLE_RUSTLER,	358.3794, 2541, 17.3897, 180); // rustler2
PTPM_AddVehicle(VEHICLE_RUSTLER,	372.5980, 2541, 17.2544, 180); // rustler3
PTPM_AddVehicle(VEHICLE_RUSTLER,	425, 2484, 17.1988, 90); // rustler1 runway east
PTPM_AddVehicle(VEHICLE_RUSTLER,	425, 2500, 17.2057, 90); // rustler2 runway east
PTPM_AddVehicle(VEHICLE_RUSTLER,	425, 2516, 17.1910, 90); // rustler3 runway east
PTPM_AddVehicle(VEHICLE_RUSTLER,	-68, 2484, 17.1994, 270); // rustler1 runway west
PTPM_AddVehicle(VEHICLE_RUSTLER,	-68, 2500, 17.1977, 270); // rustler2 runway west
PTPM_AddVehicle(VEHICLE_RUSTLER,	-68, 2516, 17.1944, 270); // rustler3 runway west
PTPM_AddVehicle(VEHICLE_GLENSHIT,	343.1581, 2468.4836, 16.2259, 349.2015); // Glendale
PTPM_AddVehicle(VEHICLE_WALTON,		512.5175, 2375.1328, 30.2694, 142.5418); // Truck
PTPM_AddVehicle(VEHICLE_TAHOMA,		528.4246, 2364.9326, 30.2506, 147.6309); // Car
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-97.8073, 1340.7292, 10.1658, 6.0542); // Sadde
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-91.7327, 1341.2476, 10.3388, 10.7399); // Sadler
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-85.6100, 1340.5928, 10.4864, 7.9968); // Vsel
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-79.2864, 1341.6671, 10.7181, 9.1289); // Vehicle
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-7.1971, 1366.4293, 8.9140, 147.0334); // Vehicke
PTPM_AddVehicle(VEHICLE_PATRIOT,	128.4070, 1935.4491, 19.2591, 177.1867); // Patrio
PTPM_AddVehicle(VEHICLE_PATRIOT,	135.0211, 1936.2513, 19.2640, 176.6158); // Partio
PTPM_AddVehicle(VEHICLE_PATRIOT,	141.6795, 1935.5112, 19.2536, 178.8926); // Patrrr
PTPM_AddVehicle(VEHICLE_PATRIOT,	177.6861, 1934.6136, 18.0750, 181.7777); // Pattt
PTPM_AddVehicle(VEHICLE_PATRIOT,	160.9952, 1905.5656, 18.7018, 354.6314); // Patrrr
PTPM_AddVehicle(VEHICLE_CROPDUST,	226.0780, 1912.1439, 17.9237, 88.5602); // Croppy
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-306.4304, 1321.1613, 54.0393, 71.6058); // Vejoc
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-308.1725, 1313.7946, 53.7000, 56.4391); // Vee
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-302.0185, 1763.0840, 42.4293, 267.4570); // Car0r
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-290.8565, 1757.5781, 42.5049, 93.9924);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-302.7458, 1749.1565, 42.4293, 269.6189);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	265.3379, 1385.5450, 10.7759, 355.3102); // Vehicle Sadlshit
PTPM_AddVehicle(VEHICLE_SADLSHIT,	278.3898, 1394.5453, 10.7750, 3.6282); // Sadlshit
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-37.5037, 2343.7458, 23.9176, 186.5129); // Glenshit
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-29.4181, 2342.6941, 23.9203, 179.2358); // Glenshit
PTPM_AddVehicle(VEHICLE_MTBIKE,		-436.9597, 1528.6982, 35.0200, 78.4875); // Mountain Bike
PTPM_AddVehicle(VEHICLE_MTBIKE,		-437.1234, 1523.3080, 34.8416, 89.7792); // Mountain Bike
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-461.2624, 1840.4432, 79.8521, 5.2061); // Sadlshit
PTPM_AddVehicle(VEHICLE_MONSTERA,	-650.4379, 2064.0884, 60.0519, 254.1844); // Monster Truck
PTPM_AddVehicle(VEHICLE_QUAD,		-639.3491, 2044.7014, 60.0518, 306.4698); // QUAD
PTPM_AddVehicle(VEHICLE_QUAD,		-651.7520, 2049.6462, 60.0528, 318.2614); // QUAD
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-56.6189, 2071.8889, 17.3831, 272.0660); // Glenshit
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	-42.8314, 2072.4724, 17.3776, 272.8621); // Towtruck
PTPM_AddVehicle(VEHICLE_COACH,		139.1421, 2402.3652, 16.3514, 183.3682); // Bus
PTPM_AddVehicle(VEHICLE_SADLSHIT,	546.0180, 2273.2808, 34.6324, 163.6258); // Sadlshit
PTPM_AddVehicle(VEHICLE_RANCHER,	613.8723, 1695.1948, 6.7766, 126.8590); // Rancher
PTPM_AddVehicle(VEHICLE_SADLSHIT,	579.9173, 1694.9648, 6.7756, 125.5006); // Sadlshit
PTPM_AddVehicle(VEHICLE_RANCHER,	441.1465, 1452.1217, 6.6511, 180.1733); // Rancher
PTPM_AddVehicle(VEHICLE_SANCHEZ,	419.9347, 1396.7889, 7.3782, 275.6075); // Sanchez
PTPM_AddVehicle(VEHICLE_BANDITO,	158.9563, 1289.6885, 20.7672, 119.3067); // Bandito
PTPM_AddVehicle(VEHICLE_JOURNEY,	-28.1202, 1392.3749, 8.9534, 115.3400); // Camper
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-105.6378, 1657.1228, 18.7260, 1.5408); // Glenshit
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	-103.1216, 1680.6563, 19.3278, 353.2779); // Towtruck
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-307.9980, 2278.7800, 69.6654, 118.5181); // Sanchez
PTPM_AddVehicle(VEHICLE_COACH,		-511.9582, 2342.5620, 68.8873, 42.4001); // Bus
PTPM_AddVehicle(VEHICLE_TAHOMA,		-653.6816, 2453.1689, 108.5600, 235.7774); // Tahoma
PTPM_AddVehicle(VEHICLE_JOURNEY,	-520.7234, 2559.4729, 53.1944, 273.0922); // Camper
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-270.1139, 2528.6023, 33.6351, 180.0996); // Sadlshit
PTPM_AddVehicle(VEHICLE_MTBIKE,		9.6867, 2566.6843, 16.2201, 275.5639); // Mountain Bike
PTPM_AddVehicle(VEHICLE_SUPERGT,	405.6807, 2451.9543, 16.2418, 0.2241); // Super GT
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-137.3023, 1495.3257, 20.8097, 185.5890); // Glenshit
PTPM_AddVehicle(VEHICLE_SADLSHIT,	307.2332, 2224.7744, 34.5744, 279.0383); // Sadlshit
PTPM_AddVehicle(VEHICLE_PACKER,		159.0350, 1794.4323, 17.6331, 267.3149); // Packer
PTPM_AddVehicle(VEHICLE_PACKER,		217.6115, 1794.5244, 17.6330, 90.9282); // Packer
PTPM_AddVehicle(VEHICLE_TAHOMA,		185.3955, 1779.2295, 17.6334, 38.4860); // Tahoma
PTPM_AddVehicle(VEHICLE_JOURNEY,	-305.7203, 1582.0869, 75.7340, 314.6775); // Camper
PTPM_AddVehicle(VEHICLE_BANDITO,	-298.0320, 1577.2061, 75.2261, 314.9534); // Bandito
PTPM_AddVehicle(VEHICLE_BANDITO,	-294.2787, 1570.9336, 75.2273, 315.6023); // Bandito
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-289.3582, 1565.8213, 75.2249, 311.6503); // Sancher
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-283.7643, 1561.8212, 75.2252, 311.5244); // Sanchez
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-169.6647, 2530.4236, 26.4566, 172.2570); // Sadlshit
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-179.5176, 2523.3569, 26.8471, 270.6300); // Sadlshit
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-95.7158, 1578.8989, 18.4041, 316.8269); // Sadlshit
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-88.9240, 1587.0151, 19.6654, 148.3202); // Sadlshit
PTPM_AddVehicle(VEHICLE_QUAD,		159.6595, 1503.9028, 9.9643, 260.0487); // QUAD
PTPM_AddVehicle(VEHICLE_NRG500,		-329.8607, 1996.8251, 131.0137, 353.8627); // NRG-500
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-323.8958, 1994.4108, 131.0051, 267.4394); // Sanchez (new new)
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-102.9670, 1409.7643, 8.7564, 11.1346); // sanchez
PTPM_AddVehicle(VEHICLE_MTBIKE,		-95.2224, 1387.8547, 9.8821, 284.0279); // mtbike
PTPM_AddVehicle(VEHICLE_QUAD,		-336.6664, 1513.8232, 74.8424, 178.8342); // QUAD
PTPM_AddVehicle(VEHICLE_QUAD,		-339.6753, 1513.9998, 74.8419, 179.2734); // QUAD
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-345.4217, 1515.9220, 75.0287, 107.6245); // sanchez
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-346.7638, 1505.9716, 75.2014, 177.2721); // sanchez
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-287.3348, 1563.5139, 75.0287, 320.7873); // sanchez
PTPM_AddVehicle(VEHICLE_BANDITO,	-301.5450, 1579.9359, 75.2271, 316.1707); // bandito
PTPM_AddVehicle(VEHICLE_JOURNEY,	-265.3403, 1542.6632, 75.7345, 314.8934); // journey
PTPM_AddVehicle(VEHICLE_JOURNEY,	-270.2007, 1547.4906, 75.7341, 315.5843); // journey (last of the t spawns)
PTPM_AddVehicle(VEHICLE_COPCARRU,	-392.1603, 2195.9368, 42.6069, 281.4015); // copcar
PTPM_AddVehicle(VEHICLE_COPCARRU,	-388.5154, 2190.1953, 42.6066, 278.1221); // copcar
PTPM_AddVehicle(VEHICLE_COPCARRU,	-392.4467, 2221.1265, 42.6202, 285.0713); // copcar
PTPM_AddVehicle(VEHICLE_COPCARRU,	-381.2379, 2262.0291, 42.5836, 185.7649); // copcar
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-411.5871, 2261.4980, 42.0659, 284.0798); // glenshit
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-437.5620, 2245.5037, 42.1707, 178.6818); // glenshit
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-415.2881, 2221.1184, 42.0702, 272.4201); // glenshit
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-406.4722, 2227.7639, 42.1847, 335.6204); // sadlshit
PTPM_AddVehicle(VEHICLE_PATRIOT,	172.7931, 1934.1707, 18.2634, 181.9308); // patriot
PTPM_AddVehicle(VEHICLE_PATRIOT,	183.1861, 1934.7625, 17.8627, 180.3658); // patriot
PTPM_AddVehicle(VEHICLE_PATRIOT,	204.4802, 1873.1158, 13.1361, 269.8959); // patriot
PTPM_AddVehicle(VEHICLE_PATRIOT,	190.9326, 1871.0653, 17.6315, 1.4515); // patriot
PTPM_AddVehicle(VEHICLE_BARRACKS,	190.6840, 1880.8751, 17.6280, 1.4526); // army truck
PTPM_AddVehicle(VEHICLE_BARRACKS,	190.4281, 1890.9606, 17.6272, 1.4538); // armytruck
PTPM_AddVehicle(VEHICLE_PATRIOT,	190.1387, 1902.3572, 17.6368, 1.4542); // patriot
PTPM_AddVehicle(VEHICLE_CROPDUST,	222.9974, 1877.2621, 17.9276, 349.3912); // duster
PTPM_AddVehicle(VEHICLE_CROPDUST,	225.3865, 1890.0095, 17.9222, 349.4016); // duster
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-210.1860, 1910.3212, 39.0504, 148.5330); // sanchez
PTPM_AddVehicle(VEHICLE_SANCHEZ,	392.0377, 2078.8513, 17.3098, 1.7270); // sanchez
PTPM_AddVehicle(VEHICLE_SANCHEZ,	343.2761, 1800.8895, 17.9775, 318.2888); // sanchez
PTPM_AddVehicle(VEHICLE_SANCHEZ,	15.4727, 1736.3965, 21.8593, 285.8096); // sanchez
PTPM_AddVehicle(VEHICLE_PACKER,		414.7962, 955.8672, 30.4635, 241.2664); // Packer
PTPM_AddVehicle(VEHICLE_GLENSHIT,	838.2132, 2465.1345, 29.8546, 117.3449); //
PTPM_AddVehicle(VEHICLE_SADLSHIT,	795.1725, 2413.9941, 15.5269, 183.1105); //
PTPM_AddVehicle(VEHICLE_TAHOMA,		769.8999, 2340.4568, 12.2173, 180.9902); //
PTPM_AddVehicle(VEHICLE_JOURNEY,	901.7408, 2328.5530, 11.1176, 180.3398); //
PTPM_AddVehicle(VEHICLE_LANDSTAL,	902.0013, 2232.7798, 10.5237, 181.8236); //landstal
PTPM_AddVehicle(VEHICLE_BFINJECT,	900.8930, 2143.1997, 10.6032, 182.6698); //
PTPM_AddVehicle(VEHICLE_WALTON,		757.0711, 2102.5811, 8.3406, 358.1468); //
PTPM_AddVehicle(VEHICLE_QUAD,		681.3440, 1951.3121, 5.0207, 181.1861); // train
PTPM_AddVehicle(VEHICLE_SANCHEZ,	685.1196, 1951.0209, 5.2082, 180.4845); // train
PTPM_AddVehicle(VEHICLE_SANCHEZ,	688.0167, 1951.0138, 5.2077, 181.9976); // train
PTPM_AddVehicle(VEHICLE_QUAD,		690.9780, 1951.3625, 5.0213, 183.3431); // train
PTPM_AddVehicle(VEHICLE_PACKER,		729.9453, 1869.5992, 6.2312, 205.5516); // train
PTPM_AddVehicle(VEHICLE_PACKER,		728.1098, 1864.0717, 6.3122, 206.6182); // train
PTPM_AddVehicle(VEHICLE_FREEWAY,	614.8901, 1689.1740, 12.0043, 215.8332); // hidebike
PTPM_AddVehicle(VEHICLE_COPCARRU,	-652.0114, 1193.4659, 14.3920, 287.1533); // terminus
PTPM_AddVehicle(VEHICLE_COPCARRU,	-656.6796, 1198.3301, 13.8911, 292.0036); // terminus
PTPM_AddVehicle(VEHICLE_PATRIOT,	-639.3463, 1162.0695, 14.0132, 229.2976); // terminus
PTPM_AddVehicle(VEHICLE_PATRIOT,	-640.6520, 1153.1771, 13.9554, 240.7832); // terminus
PTPM_AddVehicle(VEHICLE_NEBULA,		678.9440, 2196.0518, 23.0729, 181.7497); // nebula
PTPM_AddVehicle(VEHICLE_HUNTLEY,	812.5190, 1992.6683, 8.8760, 173.1010); //huntley
PTPM_AddVehicle(VEHICLE_BANDITO,	701.6065, 1948.9017, 5.4035, 183.0978); // bandito
PTPM_AddVehicle(VEHICLE_PATRIOT,	780.0374, 1877.6465, 4.9285, 269.2345); // patriot
PTPM_AddVehicle(VEHICLE_SOLAIR,		902.0481, 1877.3051, 10.5767, 179.7795); // solair
PTPM_AddVehicle(VEHICLE_MERIT,		676.4182, 1729.2784, 6.7341, 310.8552); // merit
PTPM_AddVehicle(VEHICLE_RANCHER,	798.0359, 1695.3804, 5.4254, 265.5924); // rancher
PTPM_AddVehicle(VEHICLE_OCEANIC,	789.6333, 1678.0112, 5.1154, 89.1847); // oceanic
PTPM_AddVehicle(VEHICLE_SQUALO,		-80.0669, 487.7204, -0.5299, 98.9804); //
PTPM_AddVehicle(VEHICLE_SANCHEZ,	798.0046, 2240.2544, 9.2807, 209.5868); // sanchez
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	673.1003, 1594.6523, 5.2698, 170.4411); // towtruck
PTPM_AddVehicle(VEHICLE_GLENSHIT,	776.2334, 1557.4261, 6.2894, 303.0466); // glen
PTPM_AddVehicle(VEHICLE_SADLSHIT,	682.3124, 1412.2334, 12.9886, 13.4228); // sadlshit
PTPM_AddVehicle(VEHICLE_WALTON,		777.9928, 1397.0499, 20.2656, 181.4007); // walton
PTPM_AddVehicle(VEHICLE_TAHOMA,		825.2336, 1217.8518, 27.5150, 187.8956); // taloma
PTPM_AddVehicle(VEHICLE_RANCHER,	576.2413, 1246.0880, 11.9132, 28.5967); // rancher
PTPM_AddVehicle(VEHICLE_EMPEROR,	708.8505, 1203.0743, 13.5405, 85.1022); // emperor
PTPM_AddVehicle(VEHICLE_SOLAIR,		507.0561, 1112.0461, 14.7187, 356.1344); // solair
PTPM_AddVehicle(VEHICLE_BFINJECT,	494.6823, 1119.0626, 14.3451, 355.9106); // bfinj
PTPM_AddVehicle(VEHICLE_SUPERGT,	401.0060, 1163.4678, 7.6167, 269.3647); // supergt
PTPM_AddVehicle(VEHICLE_NEBULA,		400.3200, 1149.5994, 8.1719, 268.8035); // nebula
PTPM_AddVehicle(VEHICLE_JOURNEY,	315.0375, 1161.9280, 9.1335, 86.8744); // journey
PTPM_AddVehicle(VEHICLE_ESPERANT,	295.8253, 1147.3025, 8.3278, 269.8992); // esperanto
PTPM_AddVehicle(VEHICLE_SANCHEZ,	634.7539, 1228.6328, 11.3805, 122.3248); // sanchez
PTPM_AddVehicle(VEHICLE_PIZZABOY,	174.9599, 1173.5681, 14.3579, 142.6513); // pizzaboy
PTPM_AddVehicle(VEHICLE_BFINJECT,	178.2996, 1170.6022, 14.5333, 142.6743); // bfinj
PTPM_AddVehicle(VEHICLE_SANDKING,	531.3890, 668.0421, 3.8471, 329.5020); // sandking
PTPM_AddVehicle(VEHICLE_LANDSTAL,	521.3588, 673.8175, 3.8521, 328.8015); // landstal
PTPM_AddVehicle(VEHICLE_YOSEMITE,	343.6065, 747.8186, 6.2081, 92.6852); // yosemite
PTPM_AddVehicle(VEHICLE_HUNTLEY,	128.6116, 718.1661, 5.9189, 122.3895); // huntley
PTPM_AddVehicle(VEHICLE_MERIT,		-139.7703, 583.8871, 2.3102, 16.3734); // merit
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	782.5097, 695.8967, 11.3015, 103.7606); // towtruck
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-407.6429, 623.2076, 16.0364, 264.7849); // sadlshit
PTPM_AddVehicle(VEHICLE_TAHOMA,		-283.6242, 680.6658, 18.1536, 309.0658); // taloma
PTPM_AddVehicle(VEHICLE_JOURNEY,	-122.8863, 768.9604, 21.5292, 330.0441); // journey
PTPM_AddVehicle(VEHICLE_RANCHER,	85.2580, 807.2419, 33.9690, 301.7183); // rancher
PTPM_AddVehicle(VEHICLE_MESA,		290.9921, 802.0983, 15.0091, 23.7794); // mesa
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-385.4826, 750.0555, 24.9052, 329.7118); // glen
PTPM_AddVehicle(VEHICLE_PATRIOT,	-318.2691, 844.3259, 14.2341, 272.0210); // patriot
PTPM_AddVehicle(VEHICLE_YOSEMITE,	-312.7302, 824.4495, 14.3285, 273.0023); // yosemite
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-391.4470, 1012.1808, 10.6735, 54.3129); // sad
PTPM_AddVehicle(VEHICLE_WALTON,		138.9227, 899.3122, 20.9006, 288.5594); // walton
PTPM_AddVehicle(VEHICLE_MONSTERA,	212.1735, 974.6084, 28.8503, 333.7029); // monstera
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-19.4109, 706.7399, 20.7024, 121.5846); // sanchez
PTPM_AddVehicle(VEHICLE_MONSTERA,	761.5104, 1040.3561, 30.8594, 231.0159); // monster
PTPM_AddVehicle(VEHICLE_PIZZABOY,	181.7333, 1168.7413, 14.3575, 141.8946); // pizzaboy
PTPM_AddVehicle(VEHICLE_HOTKNIFE,	-276.6193, 985.6359, 20.1259, 270.9423); //hotknife
PTPM_AddVehicle(VEHICLE_COPCARRU,	-210.8648, 999.4500, 19.8503, 89.7964); // copcarru
PTPM_AddVehicle(VEHICLE_COPCARRU,	-210.9043, 995.1942, 19.7623, 89.5294); // copcarru
PTPM_AddVehicle(VEHICLE_COPCARRU,	-211.0630, 990.9757, 19.6799, 89.4680); // copcarru
PTPM_AddVehicle(VEHICLE_COPCARRU,	-227.4120, 992.8058, 19.7287, 269.8940); // copcarru
PTPM_AddVehicle(VEHICLE_COPCARRU,	-227.4198, 997.4986, 19.7670, 268.9711); // copcarru
PTPM_AddVehicle(VEHICLE_BFINJECT,	26.1608, 973.0208, 19.4093, 260.4325); // bfinj
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	-53.6380, 923.9610, 21.8058, 94.1115); // towtruck
PTPM_AddVehicle(VEHICLE_SANDKING,	-100.8763, 976.8270, 20.1774, 359.1267); // sandking
PTPM_AddVehicle(VEHICLE_SOLAIR,		3.6329, 1083.5742, 19.6261, 90.1482); // solair
PTPM_AddVehicle(VEHICLE_ESPERANT,	-83.8296, 1077.0717, 19.5396, 0.2300); // esperanto
PTPM_AddVehicle(VEHICLE_STALLION,	-77.4747, 1077.5347, 19.6381, 1.0599); // stallion
PTPM_AddVehicle(VEHICLE_MERIT,		-165.4307, 1085.1846, 19.5429, 2.5791); // merit
PTPM_AddVehicle(VEHICLE_EMPEROR,	-231.7890, 1084.1042, 19.3288, 1.4741); // emperor
PTPM_AddVehicle(VEHICLE_AMBULAN,	-303.8193, 1036.0305, 19.7445, 269.1934); // ambul
PTPM_AddVehicle(VEHICLE_AMBULAN,	-316.2111, 1057.2214, 19.8893, 267.8399); // ambul
PTPM_AddVehicle(VEHICLE_YOSEMITE,	-359.1689, 1128.5206, 19.7869, 268.4344); // yosemite
PTPM_AddVehicle(VEHICLE_SABRE,		-260.7447, 1158.8090, 19.5521, 89.3095); // sabre
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-172.7996, 1142.1024, 19.6702, 271.3307); // huntley
PTPM_AddVehicle(VEHICLE_BLOODRA,	-128.4020, 1135.3990, 19.5346, 1.3775); // bloodra
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-52.2261, 1167.4504, 19.7090, 179.1451); // landstal
PTPM_AddVehicle(VEHICLE_CLOVER,		-30.4338, 1166.6561, 19.1463, 359.9251); // clover
PTPM_AddVehicle(VEHICLE_OCEANIC,	66.9436, 1193.1268, 18.4392, 89.9775); // oceanic
PTPM_AddVehicle(VEHICLE_BLOODRA,	-15.2056, 1204.7896, 19.1518, 89.0830); // bloodra
PTPM_AddVehicle(VEHICLE_MESA,		-77.1586, 1222.3790, 19.8508, 181.5723); // mesa
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-84.5881, 1222.0951, 19.8345, 181.2472); // landstal
PTPM_AddVehicle(VEHICLE_BFINJECT,	-176.7979, 1217.2242, 19.5224, 269.2904); // bf inj
PTPM_AddVehicle(VEHICLE_NEBULA,		-214.6400, 1214.5306, 19.5762, 181.9335); // nebula
PTPM_AddVehicle(VEHICLE_COACH,		-290.7144, 1143.0774, 19.7981, 90.7188); // coach
PTPM_AddVehicle(VEHICLE_DUMPER,		824.6457, 832.2698, 12.7670, 18.8625); // dumper
PTPM_AddVehicle(VEHICLE_DOZER,		833.1371, 832.9565, 12.2192, 18.6695); // dozer
PTPM_AddVehicle(VEHICLE_FLATBED,	833.4152, 869.2450, 13.3654, 203.8206); // flatbed
PTPM_AddVehicle(VEHICLE_DUMPER,		745.3128, 780.1634, -5.8927, 323.2658); // dum
PTPM_AddVehicle(VEHICLE_FLATBED,	702.4598, 734.1238, -6.3510, 339.9949); // flat
PTPM_AddVehicle(VEHICLE_DOZER,		709.8955, 736.0938, -6.5562, 350.4632); // doz
PTPM_AddVehicle(VEHICLE_DOZER,		735.5754, 950.4409, -7.2237, 243.4660); // doz
PTPM_AddVehicle(VEHICLE_DUMPER,		745.3817, 934.8342, -5.9662, 37.8115); // dum
PTPM_AddVehicle(VEHICLE_DUMPER,		522.0106, 993.4375, -8.0148, 220.1714); // dum
PTPM_AddVehicle(VEHICLE_FLATBED,	530.4317, 996.5425, -7.7196, 222.0809); // flat
PTPM_AddVehicle(VEHICLE_DUMPER,		708.8864, 928.8096, -17.1406, 209.9132); // dum
PTPM_AddVehicle(VEHICLE_DOZER,		686.6681, 985.3293, -12.5585, 343.8343); // doz
PTPM_AddVehicle(VEHICLE_DUMPER,		736.5869, 805.5381, -17.1945, 350.5965); // dum
PTPM_AddVehicle(VEHICLE_FLATBED,	672.4702, 764.0448, -18.2787, 293.5681); // flat
PTPM_AddVehicle(VEHICLE_DUMPER,		516.4689, 969.8781, -22.6862, 228.3357); // dum
PTPM_AddVehicle(VEHICLE_DUMPER,		471.9847, 872.6871, -27.6200, 289.6999); // dum
PTPM_AddVehicle(VEHICLE_DOZER,		471.3339, 881.1882, -29.1899, 286.1142); // doz
PTPM_AddVehicle(VEHICLE_FLATBED,	546.6434, 822.3059, -28.8304, 136.3987); // flat
PTPM_AddVehicle(VEHICLE_FLATBED,	595.2134, 752.1271, -14.8622, 63.8993); // flat
PTPM_AddVehicle(VEHICLE_DUMPER,		695.3762, 828.2486, -28.6617, 238.9176); // dum
PTPM_AddVehicle(VEHICLE_FLATBED,	579.7333, 911.5330, -42.7799, 202.9857); // flat
PTPM_AddVehicle(VEHICLE_DOZER,		669.2810, 890.5291, -40.1415, 271.1826); // doz
PTPM_AddVehicle(VEHICLE_DUMPER,		628.9632, 832.8386, -41.4356, 35.8965); // dum
PTPM_AddVehicle(VEHICLE_DOZER,		623.9670, 879.6955, -42.7406, 297.1092); // doz
PTPM_AddVehicle(VEHICLE_FLATBED,	353.5844, 851.6229, 20.6398, 221.0450); // flat
PTPM_AddVehicle(VEHICLE_FLATBED,	334.0802, 863.1279, 20.8427, 120.3726); // flat
PTPM_AddVehicle(VEHICLE_FLATBED,	327.0934, 883.2712, 20.8392, 94.8575); // flat
PTPM_AddVehicle(VEHICLE_AT400,		-158.2105, 2269.3345, 400, 304.3342); // crashed plane
PTPM_AddVehicle(VEHICLE_SANCHEZ,	260.4699, 2890.9055, 11.0242, 215.2125);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-240.5511, 2609.4597, 62.7031, 182.6147);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-228.8781, 2595.0679, 62.7031, 359.1931);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-173.4756, 2708.0059, 62.5971, 2.5124);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-277.6752, 2726.5486, 62.4576, 266.6577);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-430.2229, 1162.9980, -0.4851, 9.7545);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-637.7228, 862.1175, -0.5644, 314.2047);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-648.9202, 866.5754, -0.5381, 229.1254);
PTPM_AddVehicle(VEHICLE_SUPERGT,	-688.8719, 952.1824, 12.1640, 272.5952);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-2373.6489, -2189.1133, 33.2589, 306.1899);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-2384.9880, -2190.4351, 33.1205, 271.7669);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-2399.0864, -2193.6462, 33.1207, 291.7810);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-2407.5723, -2203.2969, 33.1206, 354.4473);
PTPM_AddVehicle(VEHICLE_ENFORCER,	-2397.4343, -2167.4753, 33.1448, 269.6390);
PTPM_AddVehicle(VEHICLE_SWATVAN,	-2372.1985, -2168.1006, 33.1763, 266.6502);
PTPM_AddVehicle(VEHICLE_ENFORCER,	-2382.5354, -2167.6113, 33.4210, 270.1384);
PTPM_AddVehicle(VEHICLE_COPCARRU,	-2377.6465, -2228.4419, 33.1208, 353.7873);
PTPM_AddVehicle(VEHICLE_COPCARRU,	-2386.4207, -2227.5403, 33.1206, 359.7560);
PTPM_AddVehicle(VEHICLE_COPCARRU,	-2394.6575, -2226.2749, 33.1209, 354.7045); // 10
PTPM_AddVehicle(VEHICLE_COPCARRU,	-2406.1470, -2224.0122, 33.1208, 358.4010);
PTPM_AddVehicle(VEHICLE_COPBIKE,	-2378.3643, -2209.2053, 33.1208, 326.5068);
PTPM_AddVehicle(VEHICLE_COPBIKE,	-2366.6592, -2197.8884, 33.3654, 289.0352);
PTPM_AddVehicle(VEHICLE_BUFFALO,	-2815.9453, -1512.4061, 139.0715, 272.2700 );
PTPM_AddVehicle(VEHICLE_BUFFALO,	-2815.9370, -1536.1644, 139.0702, 277.8143);
PTPM_AddVehicle(VEHICLE_BUFFALO,	-2814.7424, -1505.6492, 139.0691, 262.9542 );
PTPM_AddVehicle(VEHICLE_LEVIATHN,	-2390.6204, -2204.1663, 33.3788, 117.7673 );
PTPM_AddVehicle(VEHICLE_CARGOBOB,	-1885.5658, -1533.3868, 23.4462, 173.7907);
PTPM_AddVehicle(VEHICLE_CARGOBOB,	-1827.6298, -1572.0697, 23.4160, 121.4971);
PTPM_AddVehicle(VEHICLE_MONSTER,	-1990.9425, -1454.9397, 87.2293, 141.1646); //20
PTPM_AddVehicle(VEHICLE_MONSTER,	-1983.2312, -1459.7136, 87.1853, 120.9004);
PTPM_AddVehicle(VEHICLE_MONSTER,	-1982.1433, -1469.3402, 86.5387, 100.9334);
PTPM_AddVehicle(VEHICLE_MONSTER,	-1982.9606, -1479.0107, 85.4821, 103.0794);
PTPM_AddVehicle(VEHICLE_MONSTER,	-1982.5193, -1490.3038, 85.5715, 79.3180);
PTPM_AddVehicle(VEHICLE_RUSTLER,	-1960.9373, -1597.9121, 86.9930, 179.5480);
PTPM_AddVehicle(VEHICLE_RUSTLER,	-1980.9554, -1589.0686, 87.5481, 180.3195);
PTPM_AddVehicle(VEHICLE_RUSTLER,	-2379.8350, -2286.5393, 17.1092, 123.2685);
PTPM_AddVehicle(VEHICLE_RUSTLER,	-2373.2949, -2296.2078, 19.0660, 125.2730);
PTPM_AddVehicle(VEHICLE_RUSTLER,	-2904.9067, -1389.0231, 11.1150, 21.6618);
PTPM_AddVehicle(VEHICLE_BEAGLE,		-2198.7346, -2131.2871, 48.6255, 204.3451); // 30
PTPM_AddVehicle(VEHICLE_BEAGLE,		-2910.8594, -1408.5975, 12.8633, 44.4641);
PTPM_AddVehicle(VEHICLE_DODO,		-2136.7048, -2056.8174, 63.8336, 172.2179);
PTPM_AddVehicle(VEHICLE_DODO,		-2915.7021, -1861.3938, 31.7442, 10.3758);
PTPM_AddVehicle(VEHICLE_DODO,		-2881.3860, -1508.7205, 136.5421, 90.3337);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-2815.0845, -1541.7048, 139.3728, 285.3298);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-2812.6074, -1547.8026, 139.8271, 281.6122);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-2807.2344, -1511.0553, 139.1206, 269.4672);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-2822.0288, -1498.3555, 139.1208, 264.5773);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-2818.3213, -1491.7410, 139.0995, 266.7462);
PTPM_AddVehicle(VEHICLE_ZR350,		-2771.7834, -1530.8959, 139.2209, 85.5879); // 40
PTPM_AddVehicle(VEHICLE_ZR350,		-2773.4927, -1510.8029, 138.1146, 81.8501);
PTPM_AddVehicle(VEHICLE_ZR350,		-2785.5688, -1515.0902, 138.4556, 72.2713);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2801.5635, -1513.3973, 138.8572, 268.4358);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2802.6350, -1516.0708, 138.8569, 269.2060);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2802.1323, -1518.5948, 138.8576, 268.7362);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2801.0457, -1523.2094, 138.8468, 270.6464);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2808.7576, -1530.3390, 140.4086, 181.8249);
PTPM_AddVehicle(VEHICLE_COMET,		-2014.8441, -1480.3762, 83.9815, 198.4703);
PTPM_AddVehicle(VEHICLE_COMET,		-2010.4569, -1493.0989, 84.0092, 201.6919);
PTPM_AddVehicle(VEHICLE_COMET,		-2007.6163, -1506.0615, 84.6317, 190.6711); // 50
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-1996.2604, -1451.8334, 87.1934, 145.0126);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-1982.9974, -1496.6965, 86.0771, 84.5245);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-1970.9158, -1509.7953, 88.4100, 89.5364);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-1965.3683, -1520.5060, 90.3538, 150.3880);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1999.2424, -1578.2704, 86.4753, 182.4734);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1999.4883, -1564.9413, 86.2433, 178.7807);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1991.5387, -1571.0326, 86.5412, 185.6543);
PTPM_AddVehicle(VEHICLE_STRETCH,	-1968.4734, -1599.4694, 87.4364, 144.7384);
PTPM_AddVehicle(VEHICLE_QUAD,		-2003.1709, -1599.8164, 87.5026, 271.9611);
PTPM_AddVehicle(VEHICLE_QUAD,		-2003.2914, -1606.0265, 87.7402, 267.2109); // 60
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2028.8821, -1450.5828, 91.0469, 218.0506);
PTPM_AddVehicle(VEHICLE_DUMPER,		-1902.9093, -1627.7791, 22.1280, 180.0736);
PTPM_AddVehicle(VEHICLE_DUMPER,		-1823.0953, -1651.3756, 22.1213, 88.6411);
PTPM_AddVehicle(VEHICLE_DUMPER,		-1930.1538, -1703.4938, 23.2751, 271.0763);
PTPM_AddVehicle(VEHICLE_ADMIRAL,	-1893.7970, -1693.0510, 21.6189, 271.5607);
PTPM_AddVehicle(VEHICLE_ADMIRAL,	-1857.5566, -1623.6881, 22.3006, 184.5594);
PTPM_AddVehicle(VEHICLE_TRASH,		-1890.7816, -1750.5702, 22.2951, 303.5776);
PTPM_AddVehicle(VEHICLE_BUFFALO,	-2329.0088, -1822.3352, 436.7441, 7.7643);
PTPM_AddVehicle(VEHICLE_CHEETAH,	-2390.1665, -1866.5256, 405.0624, 100.9337);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-2413.5105, -1824.7920, 415.4131, 37.8859); // 70
PTPM_AddVehicle(VEHICLE_MTBIKE,		-2433.0752, -1812.8022, 411.7278, 112.0382);
PTPM_AddVehicle(VEHICLE_CLOVER,		-2478.9880, -1798.2788, 406.3089, 47.3762);
PTPM_AddVehicle(VEHICLE_STALLION,	-2517.1333, -1726.7825, 402.0662, 11.9676);
PTPM_AddVehicle(VEHICLE_GLENDALE,	-2533.1794, -1667.5564, 401.2312, 21.7438);
PTPM_AddVehicle(VEHICLE_SANDKING,	-2379.7205, -1454.8885, 384.9155, 278.6467);
PTPM_AddVehicle(VEHICLE_FELTZER,	-2262.1548, -1485.7367, 378.8713, 232.9437);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-2222.3479, -1570.4625, 379.1562, 191.5209);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-2197.8594, -1617.2303, 364.9783, 5.3690);
PTPM_AddVehicle(VEHICLE_NRG500,		-2370.2078, -1388.3630, 358.8773, 70.8725);
PTPM_AddVehicle(VEHICLE_BUFFALO,	-2551.8943, -1484.2795, 359.9571, 54.6059); // 80
PTPM_AddVehicle(VEHICLE_MTBIKE,		-2519.6372, -1435.1702, 350.5429, 345.0096);
PTPM_AddVehicle(VEHICLE_MONSTER,	-2366.9658, -1360.9087, 300.7245, 277.0966);
PTPM_AddVehicle(VEHICLE_CHEETAH,	-2345.7637, -1302.6483, 310.0883, 7.7477);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-2507.0757, -1277.4647, 273.3358, 126.0685);
PTPM_AddVehicle(VEHICLE_COACH,		-2605.8606, -1273.6674, 218.4306, 3.9074);
PTPM_AddVehicle(VEHICLE_CLOVER,		-2553.5691, -1105.9164, 175.4155, 179.9735);
PTPM_AddVehicle(VEHICLE_STALLION,	-2703.5315, -1289.5621, 152.2599, 137.3071);
PTPM_AddVehicle(VEHICLE_POLMAV,		-2774.0544, -1286.4609, 124.0907, 39.2780);
PTPM_AddVehicle(VEHICLE_POLMAV,		-2474.6621, -1096.1312, 137.5849, 313.2358);
PTPM_AddVehicle(VEHICLE_GLENDALE,	-2362.5823, -1154.0608, 173.7676, 306.7439); // 90
PTPM_AddVehicle(VEHICLE_MAVERICK,	-2816.5295, -1521.2769, 146.7012, 180.0988);
PTPM_AddVehicle(VEHICLE_SANDKING,	-2711.8933, -1614.2540, 239.5914, 349.7456);
PTPM_AddVehicle(VEHICLE_POLMAV,		-2411.9590, -2219.1670, 33.4658, 326.0417);
PTPM_AddVehicle(VEHICLE_POLMAV,		-2363.5859, -2177.6099, 33.8124, 264.7794);
PTPM_AddVehicle(VEHICLE_FELTZER,	-2768.3931, -1698.3556, 141.3474, 157.8846);
PTPM_AddVehicle(VEHICLE_DUMPER,		-2783.2690, -1774.1362, 141.2821, 167.9984);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-2665.6899, -1998.3688, 90.4798, 184.0617);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-2659.1877, -2100.5525, 74.1952, 210.1969);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2625.7700, -2152.8767, 70.0404, 255.7048);
PTPM_AddVehicle(VEHICLE_TAXI,		-2564.8586, -2147.1194, 63.9549, 280.0340); // 100
PTPM_AddVehicle(VEHICLE_BUFFALO,	-2701.6343, -1871.1652, 138.0206, 266.7029);
PTPM_AddVehicle(VEHICLE_CHEETAH,	-2628.1370, -1994.1829, 126.1259, 202.6443);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-2499.8386, -2080.8879, 124.0225, 274.9414);
PTPM_AddVehicle(VEHICLE_CLOVER,		-2662.8860, -1772.7054, 242.7201, 106.4483);
PTPM_AddVehicle(VEHICLE_GLENDALE,	-2654.4348, -1725.3420, 257.6967, 245.6479);
PTPM_AddVehicle(VEHICLE_SANDKING,	-2502.3315, -1896.5430, 298.0989, 20.4675);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2372.2952, -1926.5311, 304.5104, 84.8233);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-2419.5854, -1956.3926, 303.5986, 34.7233);
PTPM_AddVehicle(VEHICLE_MONSTER,	-2593.5637, -1607.4014, 343.5501, 204.6164);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-2528.1829, -1808.8088, 376.8376, 6.1249); // 110
PTPM_AddVehicle(VEHICLE_FELTZER,	-2067.1248, -1958.8745, 56.3981, 324.2487);
PTPM_AddVehicle(VEHICLE_COPCARRU,	-2400.6294, -2226.0034, 33.4785, 358.1456);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-2763.0491, -2043.7616, 38.4786, 57.7693);
PTPM_AddVehicle(VEHICLE_BUFFALO,	-2863.9075, -1935.4927, 37.4305, 41.7784);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2916.9001, -1460.2668, 11.1050, 0.0485);
PTPM_AddVehicle(VEHICLE_CHEETAH,	-2893.2280, -1244.9945, 9.6844, 43.7233);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2796.9351, -1127.3652, 15.8574, 314.0134);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-2547.3735, -959.8969, 21.8003, 293.5425);
PTPM_AddVehicle(VEHICLE_BANDITO,	-2349.0300, -1022.7355, 15.8620, 222.8083);
PTPM_AddVehicle(VEHICLE_CLOVER,		-2194.1802, -1167.0858, 15.8614, 205.4655); // 120
PTPM_AddVehicle(VEHICLE_STALLION,	-2006.0137, -1394.5394, 26.7512, 227.4891);
PTPM_AddVehicle(VEHICLE_SANDKING,	-1929.0791, -1590.6270, 28.4324, 168.2822);
PTPM_AddVehicle(VEHICLE_PREDATOR,	1655.4677, -1690.5326, -0.5193, 288.1472);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-1618.3999, -1705.3264, -0.4953, 304.4674);
PTPM_AddVehicle(VEHICLE_MONSTER,	-1651.4672, -2235.2122, 29.8256, 170.8282);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1642.0264, -2251.7205, 31.2759, 91.8318);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-1635.9498, -2228.0967, 29.7359, 281.9251);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-1824.5349, -1531.9379, -0.2122, 38.1299);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-2047.3981, -1299.1976, -0.0769, 15.8887);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-2278.2468, -1021.8701, -0.2242, 56.1533); // 130
PTPM_AddVehicle(VEHICLE_PREDATOR,	-2694.3008, -1011.9853, -0.2535, 96.8734);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-2969.2698, -1305.8879, 0.2027, 143.6526);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-2975.7288, -1695.6388, 0.1748, 183.8137);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-2801.0063, -2279.6108, 0.1118, 140.5747);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-2727.3528, -2759.5715, -0.4926, 210.7893);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-1885.7413, -2792.8152, 0.0144, 211.0767);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-1383.3831, -1746.7831, -0.2763, 234.0696);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-1338.1444, -1919.2219, -0.2657, 195.1976);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-1432.0155, -2068.5459, -0.2944, 139.2095);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-1540.0782, -2301.7292, -0.2051, 14.4143); // 140
PTPM_AddVehicle(VEHICLE_PREDATOR,	-1499.2396, -2304.6470, -0.2479, 12.6757);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-1198.3932, -2230.8638, -0.2033, 168.3618);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-1176.7382, -2738.7830, -0.2185, 228.2159);
PTPM_AddVehicle(VEHICLE_PREDATOR,	-998.3292, -2891.7649, -0.0513, 79.0745);
PTPM_AddVehicle(VEHICLE_REEFER,		-1483.0880, -1675.0219, -0.1841, 247.2354);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2795.4956, -1572.9344, 140.9896, 257.0880);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2797.3137, -1418.2864, 136.1386, 268.6466);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2849.8018, -1465.7086, 135.5788, 151.1253);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2827.2029, -1525.6514, 138.8663, 7.3278);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-2831.3967, -1523.8119, 138.6470, 184.6001); // 150
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1640.2782, -2223.4880, 30.6599, 99.1813);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1646.9988, -2241.8115, 30.2725, 184.2397);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1646.5533, -2209.4268, 33.3577, 96.6930);
PTPM_AddVehicle(VEHICLE_COPCARSF,	-1635.1289, -2257.8247, 31.8573, 90.1367);
PTPM_AddVehicle(VEHICLE_SULTAN,		-2204.5273, -2254.1033, 30.4259, 232.4917);
PTPM_AddVehicle(VEHICLE_MESA,		-2189.9773, -2265.2559, 30.3717, 232.6713);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-2121.7600, -2290.9282, 30.3741, 141.5620);
PTPM_AddVehicle(VEHICLE_BFINJECT,	-2144.5657, -2379.9058, 30.3726, 231.4693);
PTPM_AddVehicle(VEHICLE_QUAD,		-2149.0315, -2543.7908, 30.3638, 320.5326);
PTPM_AddVehicle(VEHICLE_SULTAN,		-2099.9846, -2477.3682, 30.3714, 231.1153); // 160
PTPM_AddVehicle(VEHICLE_MESA,		-2048.8872, -2508.7813, 30.9794, 318.1779);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-2018.4684, -2404.5127, 30.3699, 136.3184);
PTPM_AddVehicle(VEHICLE_BFINJECT,	-2033.7391, -2322.8545, 30.3713, 356.7208);
PTPM_AddVehicle(VEHICLE_QUAD,		-2096.1592, -2250.7637, 30.3716, 143.9510);
PTPM_AddVehicle(VEHICLE_REGINA,		-2674.1904, -2620.5491, 7.4223, 205.3137);
PTPM_AddVehicle(VEHICLE_SULTAN,		-2307.9810, -2770.9529, 14.0852, 245.7099);
PTPM_AddVehicle(VEHICLE_MESA,		-2031.8894, -2757.1421, 49.9026, 286.0391);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-1836.8688, -2744.2781, 3.5002, 107.3600);
PTPM_AddVehicle(VEHICLE_BFINJECT,	-1627.7050, -2688.4871, 48.2865, 145.8459);
PTPM_AddVehicle(VEHICLE_QUAD,		-1606.4072, -2713.3533, 48.2824, 52.6981); // 170
PTPM_AddVehicle(VEHICLE_REGINA,		-1576.3538, -2728.9341, 48.2893, 144.6998);
PTPM_AddVehicle(VEHICLE_SULTAN,		-1560.0487, -2739.5662, 48.2902, 147.1556);
PTPM_AddVehicle(VEHICLE_MESA,		-1471.2964, -2638.4380, 42.8979, 299.8403);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-847.3705, -2645.2136, 96.2679, 10.5579);
PTPM_AddVehicle(VEHICLE_BFINJECT,	-761.9213, -2456.6157, 71.4594, 230.9397);
PTPM_AddVehicle(VEHICLE_QUAD,		-263.0020, -2164.4561, 28.6835, 152.4455);
PTPM_AddVehicle(VEHICLE_REGINA,		-253.1976, -2217.2649, 28.5173, 102.5834);
PTPM_AddVehicle(VEHICLE_SULTAN,		-293.3706, -2149.0083, 28.3181, 154.9319);
PTPM_AddVehicle(VEHICLE_MESA,		-36.4589, -2497.4497, 36.3981, 214.0104);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-13.3326, -2509.6992, 36.3999, 121.1489); // 180
PTPM_AddVehicle(VEHICLE_BFINJECT,	32.5219, -2636.9539, 40.1604, 89.5907);
PTPM_AddVehicle(VEHICLE_QUAD,		-1132.4354, -2278.6941, 35.9363, 4.4214);
PTPM_AddVehicle(VEHICLE_HERMES,		-981.4417, -1898.2072, 80.0326, 85.0039);
PTPM_AddVehicle(VEHICLE_SULTAN,		-1018.8212, -1697.3284, 77.7648, 25.6266);
PTPM_AddVehicle(VEHICLE_MESA,		-1102.6112, -1667.8447, 76.1169, 341.0943);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-1114.4368, -1621.1880, 76.1201, 269.9464);
PTPM_AddVehicle(VEHICLE_BFINJECT,	-755.2144, -1486.5358, 89.7013, 2.1376);
PTPM_AddVehicle(VEHICLE_QUAD,		-378.2744, -1448.5403, 25.4723, 3.6920);
PTPM_AddVehicle(VEHICLE_HERMES,		-363.6711, -1410.2705, 25.4731, 90.3855);
PTPM_AddVehicle(VEHICLE_SULTAN,		-86.9996, -1196.3778, 1.9998, 345.4369); // 190
PTPM_AddVehicle(VEHICLE_MESA,		-45.2626, -1145.8362, 1.2547, 56.4938);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-575.5760, -1057.1096, 23.8280, 239.3235);
PTPM_AddVehicle(VEHICLE_BFINJECT,	-408.2732, -1762.3256, 5.8487, 17.4627);
PTPM_AddVehicle(VEHICLE_QUAD,		-1546.3046, -1211.7633, 102.0483, 227.3843);
PTPM_AddVehicle(VEHICLE_HERMES,		-1437.0760, -1531.9768, 101.5028, 42.2880);
PTPM_AddVehicle(VEHICLE_SULTAN,		-1062.2693, -1178.4099, 128.9646, 268.4395);
PTPM_AddVehicle(VEHICLE_MESA,		-1431.7803, -948.0321, 200.8141, 273.4803);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-1720.3026, -1919.9163, 98.9915, 99.5456);
PTPM_AddVehicle(VEHICLE_BFINJECT,	-1487.8038, -2176.7732, 1.5749, 170.4320);
PTPM_AddVehicle(VEHICLE_MESA,		-1453.5548, -1457.5885, 101.7578, 176.9124); // 200
PTPM_AddVehicle(VEHICLE_SULTAN,		-1461.7065, -1456.9829, 101.7578, 175.3457);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-1428.4753, -1460.8495, 101.6658, 174.4058);
PTPM_AddVehicle(VEHICLE_STALLION,	-1405.5460, -1484.6023, 101.7958, 358.9608);
PTPM_AddVehicle(VEHICLE_CLOVER,		-1398.9863, -1484.8054, 101.8056, 353.3770);
PTPM_AddVehicle(VEHICLE_GLENDALE,	-1390.3693, -1485.4039, 101.8643, 355.6828);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-1413.0469, -1513.3745, 101.6957, 99.3971);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-1465.9579, -1571.2004, 101.7578, 0.4943);
PTPM_AddVehicle(VEHICLE_BUFFALO,	-1435.3333, -1593.9545, 101.7578, 318.7972);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-1477.2480, -1525.7599, 101.8335, 180.9761);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-1459.9669, -1487.8149, 101.7578, 269.6600); // 210
PTPM_AddVehicle(VEHICLE_MTBIKE,		-1448.8809, -1555.6829, 101.7578, 180.9526);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-1443.8392, -1556.0314, 101.7578, 178.4458);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-1436.8032, -1556.2594, 101.7578, 176.8792);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-1429.6576, -1556.5096, 101.7578, 174.0358);
PTPM_AddVehicle(VEHICLE_MESA,		-678.8894, -1404.6050, 65.1612, 45.3209);
PTPM_AddVehicle(VEHICLE_STALLION,	-568.7520, -1477.2885, 10.0868, 34.6048);
PTPM_AddVehicle(VEHICLE_GLENDALE,	-345.4261, -1054.1815, 59.2788, 91.2869);
PTPM_AddVehicle(VEHICLE_HERMES,		-378.8757, -1033.3198, 59.0666, 274.2752);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-1054.1095, -1031.9008, 129.2119, 88.9138);
PTPM_AddVehicle(VEHICLE_CLOVER,		-1643.3260, -917.8596, 99.7757, 351.0459); // 220
PTPM_AddVehicle(VEHICLE_GLENDALE,	-1713.4292, -1022.9664, 74.3830, 139.1931);
PTPM_AddVehicle(VEHICLE_RHINO,		-2346.1594, -1611.3301, 483.6664, 220.7568);
PTPM_AddVehicle(VEHICLE_RUSTLER,	-2909.7632, -1280.1711, 11.8780, 170.9222);
PTPM_AddVehicle(VEHICLE_RUSTLER,	-2858.0154, -1979.7379, 38.7121, 210.8610);
PTPM_AddVehicle(VEHICLE_BUFFALO,	-2245.3557, -1737.0740, 479.7292, 14.1842); // buffalo
PTPM_AddVehicle(VEHICLE_MONSTER,	-1795.8589, -2344.1697, 35.8757, 156.9109); // monster
PTPM_AddVehicle(VEHICLE_MONSTER,	-1865.8369, -2650.0090, 55.6515, 258.8762); // monster
PTPM_AddVehicle(VEHICLE_SULTAN,		-215.2989, -2815.4988, 45.2884, 325.1967); // sultan
PTPM_AddVehicle(VEHICLE_SULTAN,		-382.8942, -2820.9539, 45.0236, 81.8549); // sultan
PTPM_AddVehicle(VEHICLE_SULTAN,		-634.6548, -2795.6040, 49.6211, 93.4775); // sultan
PTPM_AddVehicle(VEHICLE_SULTAN,		-1388.8885, -2917.0947, 47.1867, 15.3225); // sultan
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-2844.6697, -892.7352, 9.2927, 114.0765); // landstalker
PTPM_AddVehicle(VEHICLE_BUFFALO,	-128.4595, -972.0978, 26.1023, 81.9887); // buffalo
PTPM_AddVehicle(VEHICLE_BUFFALO,	-334.1578, -848.3418, 47.0545, 62.6623); // buffalo
PTPM_AddVehicle(VEHICLE_PATRIOT,	-1139.3645, -1414.8688, 126.1385, 291.0272); // patriot
PTPM_AddVehicle(VEHICLE_PATRIOT,	-1034.6451, -1174.2344, 129.2108, 90.0000); // patriot
PTPM_AddVehicle(VEHICLE_PATRIOT,	-1033.2537, -1167.2495, 129.2133, 90.0190); // patriot
PTPM_AddVehicle(VEHICLE_PATRIOT,	-879.5825, -1243.6193, 111.6640, 307.1497); // patriot
PTPM_AddVehicle(VEHICLE_PATRIOT,	-549.8234, -936.0164, 58.7215, 317.1906); // patriot
PTPM_AddVehicle(VEHICLE_PATRIOT,	-568.9822, -1048.6821, 23.8613, 237.0704); // patriot
PTPM_AddVehicle(VEHICLE_PATRIOT,	-567.1197, -1045.0377, 23.9362, 237.0529); // patriot
PTPM_AddVehicle(VEHICLE_HERMES,		-74.5151, -1589.3416, 2.3799, 248.3364); // hermes
PTPM_AddVehicle(VEHICLE_HERMES,		-254.6894, -1698.9756, 2.6274, 171.3307); // hermes
PTPM_AddVehicle(VEHICLE_HERMES,		-280.0861, -1802.5422, 13.7244, 300.3557); // hermes
PTPM_AddVehicle(VEHICLE_HERMES,		-387.6492, -1984.9158, 27.1313, 339.0298); // hermes
PTPM_AddVehicle(VEHICLE_HERMES,		-196.9525, -2402.9727, 34.5856, 219.0458); // hermes
PTPM_AddVehicle(VEHICLE_STALLION,	-179.2676, -2692.4382, 35.1404, 170.1560); // stallion
PTPM_AddVehicle(VEHICLE_STALLION,	-503.0177, -2618.2209, 162.4671, 326.4368); // stallion
PTPM_AddVehicle(VEHICLE_MESA,		-578.3273, -2357.9270, 27.3549, 323.7466); // mesa
PTPM_AddVehicle(VEHICLE_MESA,		-657.2610, -2201.4683, 11.1079, 317.4389); // mesa
PTPM_AddVehicle(VEHICLE_MESA,		22.1420, -1296.6606, 13.1033, 130.3329); // mesa
PTPM_AddVehicle(VEHICLE_QUAD,		-2234.0500, -2056.3655, 119.5490, 121.3874); // quadbike
PTPM_AddVehicle(VEHICLE_QUAD,		-2351.0264, -2105.7593, 112.1116, 97.6164); // quadbike
PTPM_AddVehicle(VEHICLE_BFINJECT,	-2445.3860, -2564.5083, 51.4009, 21.0933); // bfinjection
PTPM_AddVehicle(VEHICLE_BFINJECT,	-2247.6382, -2671.7041, 58.5060, 240.7580); // bfinjection
PTPM_AddVehicle(VEHICLE_BFINJECT,	-2012.4364, -2637.6135, 58.0434, 279.4527); // bfinjection
PTPM_AddVehicle(VEHICLE_STRETCH,	-2617.3972, 2287.9070, 8.1646, 181.7545);
PTPM_AddVehicle(VEHICLE_COPCARVG,	-2627.4165, 2269.2188, 8.1532, 266.7369);
PTPM_AddVehicle(VEHICLE_COPCARVG,	-2627.4165, 2265.2188, 8.1624, 266.7369);
PTPM_AddVehicle(VEHICLE_NEWSVAN,	-2627.4165, 2261.2188, 8.1704, 266.7369);
PTPM_AddVehicle(VEHICLE_NEWSVAN,	-2627.4165, 2257.2188, 8.1753, 266.7369);
PTPM_AddVehicle(VEHICLE_WAYFARER,	-2627.4165, 2252.2188, 8.1753, 266.7369);
PTPM_AddVehicle(VEHICLE_WAYFARER,	-2600.4570, 2267.1765, 8.2090, 85.1927);
PTPM_AddVehicle(VEHICLE_FBIRANCH,	-2619.1616, 2249.1038, 8.1686, 1.1621);
PTPM_AddVehicle(VEHICLE_FBIRANCH,	-2615.1616, 2249.1038, 8.1882, 1.1621);
PTPM_AddVehicle(VEHICLE_FBIRANCH,	-2611.1616, 2249.1038, 8.2109, 1.1621);
PTPM_AddVehicle(VEHICLE_COPCARRU,	-2600.5369, 2256.9053, 8.2109, 83.2484);
PTPM_AddVehicle(VEHICLE_COPCARRU,	-2600.5369, 2261.9053, 8.2109, 83.2484);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-2611.6189, 2361.2979, 8.6640, 180.8666);
PTPM_AddVehicle(VEHICLE_VCNMAV,		-2227.4778, 2326.5503, 7.5469, 0.4726);
PTPM_AddVehicle(VEHICLE_NEWSVAN,	-2250.9104, 2335.9739, 4.8125, 90.1419);
PTPM_AddVehicle(VEHICLE_NEWSVAN,	-2250.9104, 2314.9739, 4.8125, 90.1419);
PTPM_AddVehicle(VEHICLE_NEWSVAN,	-2250.9104, 2290.9739, 4.8125, 90.1419);
PTPM_AddVehicle(VEHICLE_NEWSVAN,	-2272.2651, 2291.2888, 4.8202, 271.2742);
PTPM_AddVehicle(VEHICLE_NEWSVAN,	-2271.7922, 2321.3477, 4.8202, 265.9456);
PTPM_AddVehicle(VEHICLE_RUMPO,		-2485.4751, 2243.5522, 4.8438, 178.7853);
PTPM_AddVehicle(VEHICLE_RUMPO,		-2476.5581, 2224.1558, 4.8438, 0.3891);
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	-2461.5581, 2224.1558, 4.8438, 0.3891);
PTPM_AddVehicle(VEHICLE_RUMPO,		-2446.5581, 2224.1558, 4.8438, 0.3891);
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	-2449.7415, 2243.2593, 4.7753, 183.5897);
PTPM_AddVehicle(VEHICLE_FELTZER,	-2528.3918, 2250.5315, 4.9779, 335.9398);
PTPM_AddVehicle(VEHICLE_BLISTAC,	-2554.8977, 2269.8213, 5.0614, 333.4261);
PTPM_AddVehicle(VEHICLE_BOXVILLE,	-2507.0620, 2348.8652, 4.9811, 184.4940);
PTPM_AddVehicle(VEHICLE_BENSON,		-2531.9714, 2361.4868, 4.9857, 274.1389);
PTPM_AddVehicle(VEHICLE_STRATUM,	-2435.3760, 2451.1841, 13.7859, 183.5816);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	-2380.8408, 2420.1570, 8.7173, 241.5786);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-2225.3005, 2400.3054, -0.3447, 41.6679);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-2232.1982, 2393.7532, -0.5344, 47.5582);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-2252.7122, 2427.8486, -0.7253, 229.7280);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-2259.4866, 2421.2808, -0.6638, 223.3056);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-2240.6646, 2440.2910, -0.5497, 222.8505);
PTPM_AddVehicle(VEHICLE_TROPIC,		-2214.5432, 2412.0632, -0.5518, 48.2394);
PTPM_AddVehicle(VEHICLE_TROPIC,		-2203.7996, 2421.5181, -0.5467, 44.1886);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-2232.6819, 2448.0068, -0.6695, 222.3092);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-2031.9108, 2330.5266, -0.4385, 37.6013);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-2047.2583, 2348.0486, -0.5216, 51.0061);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-2066.1631, 2364.6716, -0.3981, 48.5662);
PTPM_AddVehicle(VEHICLE_TROPIC,		-2324.1824, 2324.3616, -0.4747, 182.4293);
PTPM_AddVehicle(VEHICLE_TROPIC,		-2323.7444, 2304.4971, -0.4288, 181.1959);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2430.7156, 2294.8411, 4.9844, 273.4607);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2430.7156, 2291.8411, 4.9844, 273.4607);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2337.6462, 2511.9531, 1.0492, 311.2805);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2344.0730, 2533.0090, 5.8212, 201.1397);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2342.6721, 2478.5313, 4.9822, 356.0774);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2267.1240, 2538.7295, 0.7645, 310.3779);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2226.0745, 2562.2002, 0.5910, 189.0600);
PTPM_AddVehicle(VEHICLE_JOURNEY,	-844.6991, 2755.0879, 45.8516, 274.1916);
PTPM_AddVehicle(VEHICLE_PCJ600,		-787.0850, 2751.0583, 45.6474, 263.6394);
PTPM_AddVehicle(VEHICLE_PCJ600,		-787.0850, 2753.0583, 45.6474, 263.6394);
PTPM_AddVehicle(VEHICLE_PCJ600,		-787.0850, 2755.0583, 45.6474, 263.6394);
PTPM_AddVehicle(VEHICLE_WAYFARER,	-787.0850, 2757.0583, 45.6474, 263.6394);
PTPM_AddVehicle(VEHICLE_WAYFARER,	-787.0850, 2759.0583, 45.6474, 263.6394);
PTPM_AddVehicle(VEHICLE_WAYFARER,	-787.0850, 2761.0583, 45.6474, 263.6394);
PTPM_AddVehicle(VEHICLE_WAYFARER,	-778.4286, 2762.8728, 45.6899, 175.6553);
PTPM_AddVehicle(VEHICLE_BENSON,		-794.7983, 2771.9434, 45.7171, 270.9103);
PTPM_AddVehicle(VEHICLE_RANCHER,	-782.6301, 2770.2417, 45.6591, 178.5571);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-766.3795, 2773.9460, 45.7734, 88.7864);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-735.8654, 2746.4185, 47.2266, 88.9473);
PTPM_AddVehicle(VEHICLE_TAHOMA,		-771.6777, 2760.0645, 45.7394, 181.9467);
PTPM_AddVehicle(VEHICLE_TAHOMA,		-767.6777, 2760.0645, 45.7734, 181.9467);
PTPM_AddVehicle(VEHICLE_TAHOMA,		-763.6777, 2760.0645, 45.7734, 181.9467);
PTPM_AddVehicle(VEHICLE_PREMIER,	-753.4502, 2769.4856, 45.7734, 179.2740);
PTPM_AddVehicle(VEHICLE_BLISTAC,	-753.6475, 2753.9097, 45.7734, 179.2740);
PTPM_AddVehicle(VEHICLE_COPBIKE,	-1399.0782, 2628.5483, 55.7943, 86.2291);
PTPM_AddVehicle(VEHICLE_COPBIKE,	-1399.0782, 2631.5483, 55.7694, 86.2291);
PTPM_AddVehicle(VEHICLE_COPBIKE,	-1398.7524, 2634.5989, 55.7180, 87.3965);
PTPM_AddVehicle(VEHICLE_COPBIKE,	-1399.0782, 2637.5483, 55.6875, 86.2291);
PTPM_AddVehicle(VEHICLE_COPCARRU,	-1399.0782, 2640.5483, 55.6875, 86.2291);
PTPM_AddVehicle(VEHICLE_COPCARRU,	-1399.0782, 2643.5483, 55.6875, 86.2291);
PTPM_AddVehicle(VEHICLE_COPCARRU,	-1399.0782, 2646.5483, 55.6875, 86.2291);
PTPM_AddVehicle(VEHICLE_COPCARVG,	-1399.0782, 2649.5483, 55.6875, 86.2291);
PTPM_AddVehicle(VEHICLE_COPCARVG,	-1399.1132, 2653.4050, 55.6875, 83.0631);
PTPM_AddVehicle(VEHICLE_ENFORCER,	-1399.2128, 2656.6624, 55.6875, 88.5238);
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	-1411.6146, 2584.0862, 55.8359, 358.1504);
PTPM_AddVehicle(VEHICLE_BOXVILLE,	-1509.9419, 2635.4370, 55.8359, 271.1308);
PTPM_AddVehicle(VEHICLE_AMBULAN,	-1506.8044, 2524.6804, 55.6875, 358.2826);
PTPM_AddVehicle(VEHICLE_AMBULAN,	-1522.4713, 2524.7461, 55.7200, 355.4178);
PTPM_AddVehicle(VEHICLE_QUAD,		-1473.4115, 2558.0718, 55.8359, 93.1419);
PTPM_AddVehicle(VEHICLE_HOTKNIFE,	-1513.5479, 2611.4187, 55.7739, 181.0480);
PTPM_AddVehicle(VEHICLE_RDTRAIN,	-1311.1251, 2699.8555, 50.0625, 186.9698);
PTPM_AddVehicle(VEHICLE_PACKER,		-1303.5898, 2704.8848, 50.0625, 185.7010);
PTPM_AddVehicle(VEHICLE_COACH,		-1295.6909, 2709.3806, 50.0625, 188.2468);
PTPM_AddVehicle(VEHICLE_COACH,		-1288.0488, 2712.9082, 50.0625, 186.0612);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-1328.7637, 2683.2371, 50.0625, 264.8892);
PTPM_AddVehicle(VEHICLE_REGINA,		-1328.4180, 2672.1318, 50.0625, 83.9784);
PTPM_AddVehicle(VEHICLE_SADLER,		-1482.9033, 2697.1472, 55.8359, 268.8695);
PTPM_AddVehicle(VEHICLE_GLENDALE,	-1568.8752, 2640.8408, 55.8359, 275.4359);
PTPM_AddVehicle(VEHICLE_TAHOMA,		-1526.9126, 2643.0352, 55.8359, 88.7390);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-908.2130, 1524.3607, 25.9141, 242.8985);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-881.1156, 1535.4993, 25.9141, 100.3809);
PTPM_AddVehicle(VEHICLE_QUAD,		-882.5681, 1558.0959, 25.9141, 96.5677);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-905.7840, 1549.5992, 25.8606, 269.1096);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-905.7840, 1547.5992, 25.8918, 269.1096);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-747.6981, 1434.8790, 16.0919, 5.6460);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-683.8286, 1446.4352, 17.3008, 357.7681);
PTPM_AddVehicle(VEHICLE_QUAD,		-643.7973, 1441.5533, 13.6172, 0.9903);
PTPM_AddVehicle(VEHICLE_QUAD,		-639.7973, 1441.5533, 13.6172, 0.9903);
PTPM_AddVehicle(VEHICLE_JOURNEY,	-773.5403, 1442.8201, 13.7931, 77.0221);
PTPM_AddVehicle(VEHICLE_JOURNEY,	-786.1239, 1430.2653, 13.7891, 105.6719);
PTPM_AddVehicle(VEHICLE_JOURNEY,	-816.4190, 1430.5875, 13.7891, 119.7935);
PTPM_AddVehicle(VEHICLE_GLENDALE,	-866.8246, 1566.4552, 24.7867, 271.0321);
PTPM_AddVehicle(VEHICLE_SADLER,		-865.8282, 1557.5233, 24.0844, 271.0321);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-865.4333, 1550.9083, 23.5231, 268.1673);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-865.1005, 1541.8978, 22.7413, 268.1673);
PTPM_AddVehicle(VEHICLE_SECURICA,	-828.8172, 1497.1335, 19.0733, 272.9663);
PTPM_AddVehicle(VEHICLE_STRETCH,	-803.7704, 1554.8369, 26.9609, 2.5376);
PTPM_AddVehicle(VEHICLE_HOTKNIFE,	-748.9681, 1585.2646, 26.9609, 44.2883);
PTPM_AddVehicle(VEHICLE_DINGHY,		-933.3691, 2643.8079, 40.0288, 141.0726);
PTPM_AddVehicle(VEHICLE_DINGHY,		-938.7160, 2648.6973, 40.0746, 134.3031);
PTPM_AddVehicle(VEHICLE_DINGHY,		-944.1625, 2638.5710, 39.9727, 132.1796);
PTPM_AddVehicle(VEHICLE_DINGHY,		-924.9813, 2650.8701, 40.0334, 138.4392);
PTPM_AddVehicle(VEHICLE_DINGHY,		-931.2401, 2656.1851, 40.0428, 133.2486);
PTPM_AddVehicle(VEHICLE_DINGHY,		-803.4713, 2236.1760, 40.0641, 93.4047);
PTPM_AddVehicle(VEHICLE_DINGHY,		-800.4301, 2236.7170, 40.0040, 93.0059);
PTPM_AddVehicle(VEHICLE_DINGHY,		-1379.4419, 2120.5103, 40.1117, 238.4604);
PTPM_AddVehicle(VEHICLE_DINGHY,		-1371.8397, 2114.2266, 40.0630, 231.1762);
PTPM_AddVehicle(VEHICLE_TROPIC,		-1130.1346, 2786.9600, 40.1087, 7.4695);
PTPM_AddVehicle(VEHICLE_TROPIC,		-1127.1704, 2773.0112, 40.0188, 194.7168);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-795.8073, 1812.3379, -0.4974, 357.6738);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-795.4636, 1820.7888, -0.5477, 357.6738);
PTPM_AddVehicle(VEHICLE_SPEEDER,	-618.6606, 1806.2239, -0.4975, 83.7713);
PTPM_AddVehicle(VEHICLE_QUAD,		-2485.4055, 2888.6919, 47.5802, 261.5725);
PTPM_AddVehicle(VEHICLE_QUAD,		-2485.0776, 2885.6428, 46.7917, 261.5725);
PTPM_AddVehicle(VEHICLE_QUAD,		-2651.7783, 2873.4866, 63.8004, 267.7982);
PTPM_AddVehicle(VEHICLE_BFINJECT,	-1770.8105, 2911.8425, 59.0516, 270.6161);
PTPM_AddVehicle(VEHICLE_BFINJECT,	-1645.0304, 2911.5215, 51.8268, 274.3626);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-661.7008, 2302.8728, 136.0220, 91.8807);
PTPM_AddVehicle(VEHICLE_QUAD,		-661.7008, 2305.8728, 136.0220, 91.8807);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-626.7514, 2696.4114, 72.3750, 89.6808);
PTPM_AddVehicle(VEHICLE_BLISTAC,	-1191.8359, 1824.9924, 41.7188, 45.6773);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-1197.1248, 1820.7190, 41.7188, 44.2226);
PTPM_AddVehicle(VEHICLE_PREMIER,	-1201.9095, 1815.8517, 41.7188, 43.86416);
PTPM_AddVehicle(VEHICLE_BRAVURA,	-1206.9628, 1811.3123, 41.7188, 43.3755);
PTPM_AddVehicle(VEHICLE_ADMIRAL,	-1464.9824, 1864.5886, 32.6328, 99.2528);
PTPM_AddVehicle(VEHICLE_SOLAIR,		-1421.8660, 2176.8833, 50.5370, 222.4018);
PTPM_AddVehicle(VEHICLE_PATRIOT,	-1507.0482, 1974.3456, 48.4171, 358.2240);
PTPM_AddVehicle(VEHICLE_PREMIER,	-1359.8230, 2065.3262, 52.5033, 270.2028);
PTPM_AddVehicle(VEHICLE_HUSTLER,	-1939.6053, 2389.6772, 49.4922, 293.4300);
PTPM_AddVehicle(VEHICLE_BRAVURA,	-1935.9838, 2380.2446, 49.5000, 287.7526);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-1420.0134, 2304.6655, 54.7503, 202.6274);
PTPM_AddVehicle(VEHICLE_QUAD,		-1692.0798, 2395.5251, 58.2454, 28.5383);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-1670.0098, 2495.3765, 87.1244, 278.4872);
PTPM_AddVehicle(VEHICLE_PREMIER,	-1667.1249, 2562.6013, 85.1420, 275.4769);
PTPM_AddVehicle(VEHICLE_SADLER,		-1669.7704, 2601.0649, 81.2742, 273.3861);
PTPM_AddVehicle(VEHICLE_QUAD,		-1722.4993, 2671.5313, 62.2328, 230.9962);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-1535.6538, 2357.8516, 46.3156, 76.3486);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-1528.4764, 2253.9707, 48.0340, 183.2276);
PTPM_AddVehicle(VEHICLE_BLISTAC,	-1479.8020, 1879.2155, 32.6328, 185.8006);
PTPM_AddVehicle(VEHICLE_FELTZER,	-1489.3298, 1879.0116, 32.6328, 179.0183);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-1709.7765, 2175.7703, 19.5837, 222.0239);
PTPM_AddVehicle(VEHICLE_QUAD,		-1777.2389, 2211.7627, 4.0456, 230.4211);
PTPM_AddVehicle(VEHICLE_PREMIER,	-1930.1531, 2578.0037, 42.9319, 260.3332);
PTPM_AddVehicle(VEHICLE_QUAD,		-1284.8065, 2041.9019, 77.9436, 299.9343);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-1137.7235, 2108.7932, 86.0468, 277.3154);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-1106.4080, 2375.2395, 85.0791, 143.1450);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-1211.2548, 2216.7107, 105.9712, 120.6889);
PTPM_AddVehicle(VEHICLE_QUAD,		-1296.9563, 2514.8306, 87.0922, 183.5114);
PTPM_AddVehicle(VEHICLE_QUAD,		-1300.9563, 2514.8306, 87.0922, 183.5114);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-1221.8347, 2364.8291, 111.3259, 49.4197);
PTPM_AddVehicle(VEHICLE_QUAD,		-1172.3024, 2602.6140, 63.4289, 234.0768);
PTPM_AddVehicle(VEHICLE_BOXVILLE,	-1522.1962, 2584.5894, 55.8359, 0.6587);
PTPM_AddVehicle(VEHICLE_PREMIER,	-1529.5010, 2570.2429, 55.8359, 89.1162);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-2427.0713, 2499.3130, 13.4566, 272.2987);
PTPM_AddVehicle(VEHICLE_SADLER,		-2473.4404, 2503.6873, 17.2573, 87.2478);
PTPM_AddVehicle(VEHICLE_GLENDALE,	-2448.5178, 2523.3794, 15.7671, 270.6486);
PTPM_AddVehicle(VEHICLE_GLENDALE,	-942.5275, 1416.3855, 30.0920, 273.5908);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-1038.9624, 1719.8768, 31.4906, 91.9638);
PTPM_AddVehicle(VEHICLE_SADLER,		-1046.7194, 1542.3870, 33.0923, 312.1984);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-1806.3491, 2041.3049, 9.0475, 299.2224);
PTPM_AddVehicle(VEHICLE_SADLER,		-1820.4222, 2044.4138, 8.7284, 213.1046);
PTPM_AddVehicle(VEHICLE_ADMIRAL,	-1931.0247, 2367.3440, 49.4366, 294.8861);
PTPM_AddVehicle(VEHICLE_RUMPO,		-1955.5100, 2376.6702, 49.5000, 202.6092);
PTPM_AddVehicle(VEHICLE_FELTZER,	-1925.8556, 2354.7529, 49.0446, 291.8231);
PTPM_AddVehicle(VEHICLE_GLENDALE,	-2416.7332, 2656.5654, 61.5014, 271.0320);
PTPM_AddVehicle(VEHICLE_ADMIRAL,	-2675.8909, 2625.4021, 85.8863, 302.8339);
PTPM_AddVehicle(VEHICLE_MAVERICK,	-2090.8303, 2312.5078, 25.9141, 39.9778);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2150.3479, 2719.5217, 161.8320, 184.9692);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2143.9875, 2720.3745, 161.8320, 192.8026);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2136.8755, 2719.7070, 161.8320, 166.7957);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2130.1208, 2718.2578, 161.8320, 175.2558);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2122.9150, 2716.3694, 161.9137, 164.2890);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2114.5193, 2714.4080, 162.0586, 149.2488);
PTPM_AddVehicle(VEHICLE_VORTEX,		-2107.4326, 2709.9800, 162.1778, 178.3891);
PTPM_AddVehicle(VEHICLE_COPBIKE,	1077.2920, -293.6223, 73.9851, 180.1672);
PTPM_AddVehicle(VEHICLE_COPBIKE,	1074.1095, -293.0952, 73.9851, 175.1304);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	1070.6034, -293.3836, 73.9851, 181.7105);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	1067.0552, -293.1773, 73.9851, 179.5171);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	1043.4656, -350.5110, 73.9922, 357.9622);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	1070.8251, -333.8942, 73.9922, 85.3830);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	1095.0157, -350.6517, 73.9922, 359.7132);
PTPM_AddVehicle(VEHICLE_STAFFORD,	1049.8756, -332.7212, 73.9851, 88.2031);
PTPM_AddVehicle(VEHICLE_STAFFORD,	1032.2849, -310.6409, 73.9922, 181.2406);
PTPM_AddVehicle(VEHICLE_FBIRANCH,	1056.9507, -290.1041, 73.9922, 180.3006);
PTPM_AddVehicle(VEHICLE_FBIRANCH,	1034.7358, -350.2424, 73.9922, 359.8423);
PTPM_AddVehicle(VEHICLE_CAMPER,		1098.8771, -333.7421, 73.9922, 89.6406);
PTPM_AddVehicle(VEHICLE_SADLER,		1087.6224, -291.3130, 73.9922, 174.5548);
PTPM_AddVehicle(VEHICLE_GLENDALE,	1087.6272, -319.6665, 73.9922, 86.5073);
PTPM_AddVehicle(VEHICLE_COPBIKE,	1222.3462, 132.3872, 20.5306, 335.0469);
PTPM_AddVehicle(VEHICLE_COPBIKE,	1219.9082, 133.2267, 20.5325, 338.1802);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	1214.7997, 135.0764, 20.5359, 334.4202);
PTPM_AddVehicle(VEHICLE_COPBIKE,	1210.0226, 137.2502, 20.5356, 334.7335);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	1205.4465, 139.3327, 20.5389, 338.4935);
PTPM_AddVehicle(VEHICLE_COPBIKE,	1203.2094, 140.7464, 20.5368, 336.3002);
PTPM_AddVehicle(VEHICLE_COPBIKE,	1226.9937, 267.6609, 19.5547, 248.4589);
PTPM_AddVehicle(VEHICLE_COPBIKE,	1242.8092, 231.8245, 28.0728, 154.4814);
PTPM_AddVehicle(VEHICLE_COPCARRU,	1226.6038, 197.0231, 19.4063, 246.2657);
PTPM_AddVehicle(VEHICLE_COPCARRU,	1240.4711, 190.6190, 19.4089, 245.3257);
PTPM_AddVehicle(VEHICLE_COPCARLA,	1238.1025, 157.9060, 20.0185, 332.4097);
PTPM_AddVehicle(VEHICLE_COPCARRU,	1251.1154, 168.8403, 19.4419, 334.2898);
PTPM_AddVehicle(VEHICLE_COPCARRU,	1202.6848, 217.1002, 19.5744, 242.1689);
PTPM_AddVehicle(VEHICLE_COPCARLA,	1201.0869, 165.4715, 20.4842, 336.5065);
PTPM_AddVehicle(VEHICLE_COPCARLA,	1236.5651, 212.8782, 19.5547, 64.8440);
PTPM_AddVehicle(VEHICLE_COPCARRU,	1252.5729, 248.7793, 19.5547, 64.5305);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-48.9898, 55.3985, 3.1172, 158.2757);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-21.6399, 106.7221, 3.1172, 94.6683);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-59.7243, 111.9405, 3.1172, 159.5292);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-28.2362, 49.1996, 3.1172, 243.8164);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-38.7090, 97.2444, 3.1172, 160.4692);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-95.2285, 49.5385, 3.1172, 156.7091);
PTPM_AddVehicle(VEHICLE_RANCHER,	-53.1905, 85.5096, 3.1172, 253.5064);
PTPM_AddVehicle(VEHICLE_RANCHER,	-63.1777, 100.3868, 3.1172, 246.9263);
PTPM_AddVehicle(VEHICLE_RANCHER,	-46.8791, 8.2719, 3.1094, 61.7446);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-38.2340, 86.0321, 3.1172, 165.7957);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-74.7349, 53.2728, 3.1172, 159.8188);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-42.2917, 69.2559, 3.1172, 347.5307);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-57.7837, 76.6060, 3.1172, 245.6730);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-55.0658, -19.2246, 3.1172, 70.2047);
PTPM_AddVehicle(VEHICLE_CAMPER,		-5.6712, 59.6118, 3.1172, 338.0839);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	1549.0485, -27.1533, 21.3231, 269.2609);
PTPM_AddVehicle(VEHICLE_FREEWAY,	1542.4755, 34.4275, 24.1406, 283.0477);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	1544.1379, 16.3594, 24.1406, 280.5176);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	1529.3138, 0.0843, 23.5144, 217.2471);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	1380.8835, 455.2117, 19.8750, 64.5481);
PTPM_AddVehicle(VEHICLE_FREEWAY,	1391.2903, 475.4510, 20.0657, 240.6898);
PTPM_AddVehicle(VEHICLE_RANCHER,	1406.5636, 459.6162, 20.2192, 151.3657);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	1367.8904, 477.6172, 20.1227, 145.3889);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	877.3873, -27.3611, 63.1953, 157.0382);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	860.7090, -11.4543, 63.3731, 162.6782);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	888.6854, -25.3872, 63.2252, 154.5315);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	859.1102, 19.6543, 88.0454, 69.5939);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	277.7894, 67.5603, 2.7683, 111.5739);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	320.9435, 37.0995, 3.3579, 118.4673);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	263.4151, -508.7036, 20.1848, 23.5722);
PTPM_AddVehicle(VEHICLE_MTBIKE,		270.6086, -487.3895, 20.5772, 28.8989);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	284.0866, -509.1511, 20.5839, 96.2662);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-523.7220, -207.9775, 78.4063, 90.0057);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-558.5643, -179.9586, 78.4047, 174.9432);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-565.4307, -200.5089, 78.6330, 353.8582);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-431.1826, -391.1899, 16.2031, 179.1232);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-389.9446, -409.6938, 16.2109, 85.7724);
PTPM_AddVehicle(VEHICLE_OCEANIC,	2853.1252, -329.5313, 7.7272, 358.1427);
PTPM_AddVehicle(VEHICLE_OCEANIC,	2857.9192, -398.1039, 7.7797, 6.6261);
PTPM_AddVehicle(VEHICLE_DINGHY,		1440.1895, -278.6923, -0.5503, 334.5085);
PTPM_AddVehicle(VEHICLE_DINGHY,		386.5117, -273.3345, -0.3953, 215.3484);
PTPM_AddVehicle(VEHICLE_DINGHY,		370.3372, -283.7169, -0.5441, 212.2151);
PTPM_AddVehicle(VEHICLE_DINGHY,		-46.0665, -574.7012, -0.5214, 200.3237);
PTPM_AddVehicle(VEHICLE_DINGHY,		-322.54, -385.65, -0.23, 173.6901);
PTPM_AddVehicle(VEHICLE_REEFER,		153.7179, -400.7188, -0.5715, 109.9431);
PTPM_AddVehicle(VEHICLE_MARQUIS,	1411.7775, -272.1193, -0.5727, 357.6953);
PTPM_AddVehicle(VEHICLE_MARQUIS,	406.6983, -264.2725, -0.5581, 119.7808);
PTPM_AddVehicle(VEHICLE_REEFER,		918.1069, -132.4381, -0.4980, 91.9967);
PTPM_AddVehicle(VEHICLE_REEFER,		-331.9320, -467.9369, -0.5246, 221.0039);
PTPM_AddVehicle(VEHICLE_REEFER,		296.2721, -335.1281, -0.5057, 143.5944);
PTPM_AddVehicle(VEHICLE_LAUNCH,		1348.3632, -305.1563, -0.5834, 68.8226);
PTPM_AddVehicle(VEHICLE_COASTG,		-109.3459, -537.3738, -0.5010, 16.3953);
PTPM_AddVehicle(VEHICLE_DFT30,		-529.8365, -501.5349, 24.9251, 0.1753);
PTPM_AddVehicle(VEHICLE_BOXVILLE,	-557.8523, -543.1022, 25.5234, 178.7770);
PTPM_AddVehicle(VEHICLE_BOXVILLE,	-520.2065, -501.9279, 24.8923, 1.4286);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-529.6581, -543.4426, 25.5234, 180.0303);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-589.5807, -488.0215, 25.5234, 357.9819);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-748.3201, -525.4376, 31.4775, 37.6873);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-392.3272, -582.2102, 12.9059, 307.9153);
PTPM_AddVehicle(VEHICLE_WALTON,		-569.6976, -471.7984, 25.5234, 180.6335);
PTPM_AddVehicle(VEHICLE_TRACTOR,	-579.6794, -471.8521, 25.5234, 180.6335);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-500.5159, -436.9765, 41.6709, 355.0416);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-539.4112, -471.2142, 25.5178, 177.1869);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-910.8447, -522.1077, 25.9536, 21.3708);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-944.9158, -514.7542, 25.9536, 344.7337);
PTPM_AddVehicle(VEHICLE_COMBINE,	882.0760, -403.5292, 42.5682, 79.7770);
PTPM_AddVehicle(VEHICLE_COMBINE,	808.9666, -248.1864, 18.3284, 263.1118);
PTPM_AddVehicle(VEHICLE_TRACTOR,	842.1653, -359.4602, 31.2461, 241.4352);
PTPM_AddVehicle(VEHICLE_COPCARLA,	617.0349, -543.0638, 16.4819, 269.5513);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	685.7832, -253.3718, 11.3972, 87.0167);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	668.4614, -546.2032, 16.3359, 91.8897);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	1162.0258, -147.4833, 41.1003, 153.7867);
PTPM_AddVehicle(VEHICLE_RANCHER,	347.2374, -565.3052, 40.7283, 258.7503);
PTPM_AddVehicle(VEHICLE_BOBCAT,		498.9526, -456.6445, 35.1021, 326.7024);
PTPM_AddVehicle(VEHICLE_MOWER,		481.5742, -326.6151, 37.7213, 346.0919);
PTPM_AddVehicle(VEHICLE_WALTON,		1267.8484, -371.8989, 2.6513, 324.5013);
PTPM_AddVehicle(VEHICLE_MTBIKE,		282.7301, -390.8212, 7.4187, 254.9739);
PTPM_AddVehicle(VEHICLE_MTBIKE,		500.5329, -291.1873, 19.9459, 77.5626);
PTPM_AddVehicle(VEHICLE_MTBIKE,		759.9531, -221.3224, 12.3572, 275.3318);
PTPM_AddVehicle(VEHICLE_MTBIKE,		1486.4916, -359.9856, 33.0196, 71.8162);
PTPM_AddVehicle(VEHICLE_FREEWAY,	668.9131, -458.1094, 16.3359, 93.1195);
PTPM_AddVehicle(VEHICLE_FREEWAY,	668.7012, -467.8288, 16.3359, 90.2995);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	797.1016, -481.3441, 16.1223, 89.8943);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	669.0840, -464.6925, 16.3359, 86.8528);
PTPM_AddVehicle(VEHICLE_COMBINE,	-790.7696, -126.3084, 64.4024, 13.2143);
PTPM_AddVehicle(VEHICLE_WALTON,		-506.4307, 303.1030, 2.4297, 243.6405);
PTPM_AddVehicle(VEHICLE_HOTDOG,		-494.2812, 293.7330, 2.4297, 267.7440);
PTPM_AddVehicle(VEHICLE_RANCHER,	-369.7501, -179.5537, 58.6014, 306.6848);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	-777.6917, 196.4418, 2.7259, 318.0724);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-472.8308, -174.4121, 78.2109, 177.9639);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	-480.0195, 302.3040, 2.4297, 98.2525);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-765.0281, 206.5010, 2.6293, 39.8298);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-762.0589, 208.7578, 2.6755, 39.8298);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-940.8128, -254.3603, 37.5872, 349.5188);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-255.1431, 244.0980, 9.7679, 163.1406);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-593.6478, 176.7797, 22.5838, 251.5891);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-320.8463, -26.8586, 44.6366, 12.7482);
PTPM_AddVehicle(VEHICLE_COMBINE,	-171.1430, 146.5319, 5.1631, 161.2562);
PTPM_AddVehicle(VEHICLE_COMBINE,	-159.5853, 34.0942, 3.1172, 339.2584);
PTPM_AddVehicle(VEHICLE_TRACTOR,	-215.8971, -41.6792, 3.1172, 339.6080);
PTPM_AddVehicle(VEHICLE_HOTDOG,		431.6315, 213.9114, 10.5732, 223.1384);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	436.4639, 3.5628, 8.2983, 120.5780);
PTPM_AddVehicle(VEHICLE_RANCHER,	-31.0274, -193.6508, 1.7264, 267.9630);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	317.9629, -127.2772, 2.3510, 267.4955);
PTPM_AddVehicle(VEHICLE_YANKEE,		164.8912, -55.0111, 1.5781, 274.0884);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	159.8339, -178.0943, 1.5781, 90.7960);
PTPM_AddVehicle(VEHICLE_FREEWAY,	93.1486, -189.5616, 1.4844, 179.6324);
PTPM_AddVehicle(VEHICLE_FREEWAY,	183.0301, -5.6745, 1.5781, 182.5943);
PTPM_AddVehicle(VEHICLE_FREEWAY,	310.0764, -192.6511, 1.5781, 269.1597);
PTPM_AddVehicle(VEHICLE_MTBIKE,		-260.1927, -198.1862, 4.0310, 238.4069);
PTPM_AddVehicle(VEHICLE_MTBIKE,		483.3108, -169.5756, 35.2616, 136.0019);
PTPM_AddVehicle(VEHICLE_PACKER,		-98.5349, -383.8969, 1.4297, 77.0747);
PTPM_AddVehicle(VEHICLE_UTILITY,	137.5135, -246.2383, 1.5781, 90.4637);
PTPM_AddVehicle(VEHICLE_RDTRAIN,	-206.9385, -267.0805, 1.4297, 86.4516);
PTPM_AddVehicle(VEHICLE_RDTRAIN,	52.7043, -284.0299, 1.6847, 358.9695);
PTPM_AddVehicle(VEHICLE_LINERUN,	-182.9712, -278.6667, 1.4297, 89.2716);
PTPM_AddVehicle(VEHICLE_LINERUN,	90.2497, -292.4178, 1.5781, 357.7162);
PTPM_AddVehicle(VEHICLE_TOWTRUCK,	-2.8379, -378.1422, 5.4297, 359.5031);
PTPM_AddVehicle(VEHICLE_SWEEPER,	-52.7745, -281.9406, 5.4297, 178.8132);
PTPM_AddVehicle(VEHICLE_COACH,		82.4944, -336.8213, 1.5781, 268.8118);
PTPM_AddVehicle(VEHICLE_DFT30,		-131.3013, -220.2940, 1.4219, 88.6683);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-157.8681, -302.2006, 1.4297, 92.7182);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-158.1462, -306.3193, 1.4297, 89.8982);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	547.6807, -181.8441, 35.5300, 33.8501);
PTPM_AddVehicle(VEHICLE_WALTON,		1288.8221, 190.0710, 20.2351, 211.9887);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	1090.0494, 477.3053, 27.3024, 224.6663);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	1535.4517, 216.4464, 22.3501, 65.1540);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	753.0432, 276.4599, 27.3697, 193.0746);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	1434.6874, -195.1977, 31.3965, 37.3303);
PTPM_AddVehicle(VEHICLE_RANCHER,	1443.1438, 369.3864, 18.9901, 237.2415);
PTPM_AddVehicle(VEHICLE_BOXVILLE,	1425.4063, 274.6239, 19.5547, 66.4176);
PTPM_AddVehicle(VEHICLE_MTBIKE,		959.0034, -71.3558, 22.7560, 273.5887);
PTPM_AddVehicle(VEHICLE_MTBIKE,		550.9790, 277.9433, 16.9325, 217.4915);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	1382.5344, 267.4018, 19.5669, 338.2929);
PTPM_AddVehicle(VEHICLE_FREEWAY,	772.5741, 347.7164, 20.1527, 186.8465);
PTPM_AddVehicle(VEHICLE_FREEWAY,	1309.9063, 163.7072, 20.4609, 159.9749);
PTPM_AddVehicle(VEHICLE_FREEWAY,	1499.1349, 359.9464, 19.2491, 26.3895);
PTPM_AddVehicle(VEHICLE_NRG500,		920.2519, -575.8494, 114.3125, 192.3737);
PTPM_AddVehicle(VEHICLE_NRG500,		1031.8105, -66.0252, 88.0367, 95.0100);
PTPM_AddVehicle(VEHICLE_CHEETAH,	-70.9536, -211.5095, 5.4297, 266.3916); // 1
PTPM_AddVehicle(VEHICLE_CHEETAH,	166.4726, -238.2138, 13.4838, 89.3652); // 2
PTPM_AddVehicle(VEHICLE_TRACTOR,	1974.1060, 225.5116, 28.1741, 171.9749);
PTPM_AddVehicle(VEHICLE_WALTON,		1901.1582, 136.4913, 36.1577, 64.5240);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	2047.9657, 312.8364, 27.7757, 43.7642);
PTPM_AddVehicle(VEHICLE_MESA,		1934.7406, 168.8163, 37.2752, 69.8507);
PTPM_AddVehicle(VEHICLE_COASTG,		2059.2075, -235.1499, -0.5488, 91.8036);
PTPM_AddVehicle(VEHICLE_TROPIC,		2042.1426, -129.6595, -0.5391, 302.9844);
PTPM_AddVehicle(VEHICLE_TROPIC,		2040.9349, -141.4028, -0.5132, 216.5036);
PTPM_AddVehicle(VEHICLE_TROPIC,		2025.6659, -132.0978, -0.5605, 75.8156);
PTPM_AddVehicle(VEHICLE_DINGHY,		1913.8684, -237.2200, -0.2573, 300.4621);
PTPM_AddVehicle(VEHICLE_DINGHY,		1939.9235, -254.3883, -0.5218, 334.6158);
PTPM_AddVehicle(VEHICLE_DINGHY,		1959.6722, -254.6385, -0.5441, 359.9961);
PTPM_AddVehicle(VEHICLE_DINGHY,		1985.6084, -46.7282, -0.5498, 149.4575);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	1901.8351, 174.0943, 37.1434, 36.9504);
PTPM_AddVehicle(VEHICLE_MTBIKE,		1884.4840, -12.5735, 35.0930, 255.9918);
PTPM_AddVehicle(VEHICLE_FREEWAY,	1646.6997, 245.8785, 19.2938, 256.8500);
PTPM_AddVehicle(VEHICLE_DUMPER,		2397.7869, 363.5640, 28.9323, 126.3227);
PTPM_AddVehicle(VEHICLE_WALTON,		2358.5151, 170.5490, 27.2183, 87.9205);
PTPM_AddVehicle(VEHICLE_TAMPA,		2209.1809, 110.4762, 27.2400, 271.5754);
PTPM_AddVehicle(VEHICLE_SUNRISE,	2209.8020, -88.0954, 27.0613, 267.0333);
PTPM_AddVehicle(VEHICLE_SABRE,		2280.5549, -83.1752, 26.5242, 175.6755);
PTPM_AddVehicle(VEHICLE_RUMPO,		2431.4666, -83.9197, 26.8410, 271.1351);
PTPM_AddVehicle(VEHICLE_TAMPA,		2501.5710, 6.3421, 27.2282, 179.4910);
PTPM_AddVehicle(VEHICLE_WINDSOR,	2207.2769, -380.5099, 51.8874, 267.7411);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	2524.1360, -375.1299, 79.1788, 267.9537);
PTPM_AddVehicle(VEHICLE_FREEWAY,	2324.5603, 74.9540, 26.4922, 178.1036);
PTPM_AddVehicle(VEHICLE_MTBIKE,		2315.1145, 3.3423, 26.4844, 357.9587);
PTPM_AddVehicle(VEHICLE_FREEWAY,	2268.3779, 66.0873, 26.4844, 92.7261);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	2254.8618, -84.3024, 26.5165, 178.1822);
PTPM_AddVehicle(VEHICLE_COASTG,		2101.7981, -99.2673, -0.5476, 121.5565);
PTPM_AddVehicle(VEHICLE_DINGHY,		2170.8008, -138.8979, -0.5468, 170.7504);
PTPM_AddVehicle(VEHICLE_AMBULAN,	212.0961, -160.0490, 1.5781, 269.2923);
PTPM_AddVehicle(VEHICLE_AMBULAN,	708.2214, -441.6792, 16.3359, 181.1105);
PTPM_AddVehicle(VEHICLE_AMBULAN,	1228.3380, 299.6837, 19.5547, 67.1483);
PTPM_AddVehicle(VEHICLE_DINGHY,		1607.8746, 449.6531, -0.4664, 9.9744);
PTPM_AddVehicle(VEHICLE_DINGHY,		1596.2928, 446.4237, -0.3875, 356.5009);
PTPM_AddVehicle(VEHICLE_DINGHY,		1581.0421, 446.4198, -0.3297, 31.9079);
PTPM_AddVehicle(VEHICLE_DINGHY,		-325.5027, -463.1857, -0.6308, 231.4495);
PTPM_AddVehicle(VEHICLE_DINGHY,		-96.5986, -722.4144, -0.4989, 56.9211);
PTPM_AddVehicle(VEHICLE_DINGHY,		-113.8363, -761.4823, -0.5145, 81.0481);
PTPM_AddVehicle(VEHICLE_DINGHY,		-246.7013, -767.2890, -0.5047, 345.5651);
PTPM_AddVehicle(VEHICLE_DINGHY,		-222.5454, -776.9276, -0.5189, 311.4115);
PTPM_AddVehicle(VEHICLE_WALTON,		2725.4353, -496.8919, 51.2178, 16.6129);
PTPM_AddVehicle(VEHICLE_GLENSHIT,	2555.3928, -924.3685, 83.6929, 100.5222);
PTPM_AddVehicle(VEHICLE_SADLSHIT,	1994.1129, -785.4816, 132.7321, 64.7267);
PTPM_AddVehicle(VEHICLE_SADLER,		1774.1910, -793.0194, 62.6663, 254.0783);
PTPM_AddVehicle(VEHICLE_RANCHER,	1824.4529, -554.8333, 74.1567, 1.1631);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	1769.1486, -179.8652, 80.1774, 41.9575);
PTPM_AddVehicle(VEHICLE_HUNTLEY,	185.0528, -858.0983, 16.6695, 38.9225);
PTPM_AddVehicle(VEHICLE_MTBIKE,		2657.2278, -916.5535, 73.5108, 101.2705);
PTPM_AddVehicle(VEHICLE_MTBIKE,		22.9914, -699.3735, 5.0758, 67.7777);
PTPM_AddVehicle(VEHICLE_MARQUIS,	-206.0261, -625.9319, -0.2043, 220.0836);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	2351.0137, -662.6081, 128.3589, 267.1501);
PTPM_AddVehicle(VEHICLE_WALTON,		2361.6641, -646.9599, 128.1019, 180.3793);
PTPM_AddVehicle(VEHICLE_TURISMO,	2040.0520, 1319.2799, 10.3779, 183.2439);
PTPM_AddVehicle(VEHICLE_BANSHEE,	2040.5247, 1359.2783, 10.3516, 177.1306);
PTPM_AddVehicle(VEHICLE_WASHING,	2110.4102, 1398.3672, 10.7552, 359.5964);
PTPM_AddVehicle(VEHICLE_INFERNUS,	2074.9624, 1479.2120, 10.3990, 359.6861);
PTPM_AddVehicle(VEHICLE_ZR350,		2075.6038, 1666.9750, 10.4252, 359.7507);
PTPM_AddVehicle(VEHICLE_BULLET,		2119.5845, 1938.5969, 10.2967, 181.9064);
PTPM_AddVehicle(VEHICLE_BULLET,		1843.7881, 1216.0122, 10.4556, 270.8793);
PTPM_AddVehicle(VEHICLE_BUFFALO,	1944.1003, 1344.7717, 8.9411, 0.8168);
PTPM_AddVehicle(VEHICLE_BUFFALO,	1679.2278, 1316.6287, 10.6520, 180.4150);
PTPM_AddVehicle(VEHICLE_CHEETAH,	1685.4872, 1751.9667, 10.5990, 268.1183);
PTPM_AddVehicle(VEHICLE_INFERNUS,	2034.5016, 1912.5874, 11.9048, 0.2909);
PTPM_AddVehicle(VEHICLE_INFERNUS,	2172.1682, 1988.8643, 10.5474, 89.9151);
PTPM_AddVehicle(VEHICLE_BANSHEE,	2245.5759, 2042.4166, 10.5000, 270.7350);
PTPM_AddVehicle(VEHICLE_ZR350,		2361.1538, 1993.9761, 10.4260, 178.3929);
PTPM_AddVehicle(VEHICLE_SUNRISE,	2221.9946, 1998.7787, 9.6815, 92.6188);
PTPM_AddVehicle(VEHICLE_URANUS,		2243.3833, 1952.4221, 14.9761, 359.4796);
PTPM_AddVehicle(VEHICLE_EUROS,		2276.7085, 1938.7263, 31.5046, 359.2321);
PTPM_AddVehicle(VEHICLE_EUROS,		2602.7769, 1853.0667, 10.5468, 91.4813);
PTPM_AddVehicle(VEHICLE_PHOENIX,	2610.7600, 1694.2588, 10.6585, 89.3303);
PTPM_AddVehicle(VEHICLE_EUROS,		2635.2419, 1075.7726, 10.5472, 89.9571);
PTPM_AddVehicle(VEHICLE_ELEGY,		2577.2354, 1038.8063, 10.4777, 181.7069);
PTPM_AddVehicle(VEHICLE_ELEGY,		2394.1021, 989.4888, 10.4806, 89.5080);
PTPM_AddVehicle(VEHICLE_ELEGY,		1881.0510, 957.2120, 10.4789, 270.4388);
PTPM_AddVehicle(VEHICLE_SLAMVAN,	2039.1257, 1545.0879, 10.3481, 359.6690);
PTPM_AddVehicle(VEHICLE_SLAMVAN,	2009.8782, 2411.7524, 10.5828, 178.9618);
PTPM_AddVehicle(VEHICLE_BANSHEE,	2010.0841, 2489.5510, 10.5003, 268.7720);
PTPM_AddVehicle(VEHICLE_CHEETAH,	2076.4033, 2468.7947, 10.5923, 359.9186);
PTPM_AddVehicle(VEHICLE_MAVERICK,	2093.2754, 2414.9421, 74.7556, 89.0247);
PTPM_AddVehicle(VEHICLE_SUPERGT,	2352.9026, 2577.9768, 10.5201, 0.4091);
PTPM_AddVehicle(VEHICLE_SUPERGT,	2166.6963, 2741.0413, 10.5245, 89.7816);
PTPM_AddVehicle(VEHICLE_INFERNUS,	1960.9989, 2754.9072, 10.5473, 200.4316);
PTPM_AddVehicle(VEHICLE_BANSHEE,	1919.5863, 2760.7595, 10.5079, 100.0753);
PTPM_AddVehicle(VEHICLE_CHEETAH,	1673.8038, 2693.8044, 10.5912, 359.7903);
PTPM_AddVehicle(VEHICLE_BUFFALO,	1591.0482, 2746.3982, 10.6519, 172.5125);
PTPM_AddVehicle(VEHICLE_PHOENIX,	1580.4537, 2838.2886, 10.6614, 181.4573);
PTPM_AddVehicle(VEHICLE_SUNRISE,	1555.2734, 2750.5261, 10.6388, 91.7773);
PTPM_AddVehicle(VEHICLE_SLAMVAN,	1455.9305, 2878.5288, 10.5837, 181.0987);
PTPM_AddVehicle(VEHICLE_ZR350,		1537.8425, 2578.0525, 10.5662, 0.0650);
PTPM_AddVehicle(VEHICLE_TURISMO,	1433.1594, 2607.3762, 10.3781, 88.0013);
PTPM_AddVehicle(VEHICLE_PHOENIX,	2223.5898, 1288.1464, 10.5104, 182.0297);
PTPM_AddVehicle(VEHICLE_URANUS,		2451.6707, 1207.1179, 10.4510, 179.8960);
PTPM_AddVehicle(VEHICLE_SUNRISE,	2461.7253, 1357.9705, 10.6389, 180.2927);
PTPM_AddVehicle(VEHICLE_URANUS,		2461.8162, 1629.2268, 10.4496, 181.4625);
PTPM_AddVehicle(VEHICLE_ZR350,		2395.7554, 1658.9591, 10.5740, 359.7374);
PTPM_AddVehicle(VEHICLE_PEREN,		1553.3696, 1020.2884, 10.5532, 270.6825);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	1380.8304, 1159.1782, 10.9128, 355.7117);
PTPM_AddVehicle(VEHICLE_MOONBEAM,	1383.4630, 1035.0420, 10.9131, 91.2515);
PTPM_AddVehicle(VEHICLE_PEREN,		1445.4526, 974.2831, 10.5534, 1.6213);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	1704.2365, 940.1490, 10.9127, 91.9048);
PTPM_AddVehicle(VEHICLE_PEREN,		1658.5463, 1028.5432, 10.5533, 359.8419);
PTPM_AddVehicle(VEHICLE_FCR900,		1677.6628, 1040.1930, 10.4136, 178.7038);
PTPM_AddVehicle(VEHICLE_FCR900,		1383.6959, 1042.2114, 10.4121, 85.7269);
PTPM_AddVehicle(VEHICLE_FCR900,		1064.2332, 1215.4158, 10.4157, 177.2942);
PTPM_AddVehicle(VEHICLE_FCR900,		1111.4536, 1788.3893, 10.4158, 92.4627);
PTPM_AddVehicle(VEHICLE_NRG500,		953.2818, 1806.1392, 8.2188, 235.0706);
PTPM_AddVehicle(VEHICLE_NRG500,		995.5328, 1886.6055, 10.5359, 90.1048);
PTPM_AddVehicle(VEHICLE_FCR900,		993.7083, 2267.4133, 11.0315, 1.5610);
PTPM_AddVehicle(VEHICLE_SLAMVAN,	1439.5662, 1999.9822, 10.5843, 0.4194);
PTPM_AddVehicle(VEHICLE_NRG500,		1430.2354, 1999.0144, 10.3896, 352.0951);
PTPM_AddVehicle(VEHICLE_NRG500,		2156.3540, 2188.6572, 10.2414, 22.6504);
PTPM_AddVehicle(VEHICLE_COPCARVG,	2277.6846, 2477.1096, 10.5652, 180.1090);
PTPM_AddVehicle(VEHICLE_COPCARVG,	2268.9888, 2443.1697, 10.5662, 181.8062);
PTPM_AddVehicle(VEHICLE_COPCARVG,	2256.2891, 2458.5110, 10.5680, 358.7335);
PTPM_AddVehicle(VEHICLE_COPCARVG,	2251.6921, 2477.0205, 10.5671, 179.5244);
PTPM_AddVehicle(VEHICLE_COPBIKE,	2294.7305, 2441.2651, 10.3860, 9.3764);
PTPM_AddVehicle(VEHICLE_COPBIKE,	2290.7268, 2441.3323, 10.3944, 16.4594);
PTPM_AddVehicle(VEHICLE_NRG500,		2476.7900, 2532.2222, 21.4416, 0.5081);
PTPM_AddVehicle(VEHICLE_NRG500,		2580.5320, 2267.9595, 10.3917, 271.2372);
PTPM_AddVehicle(VEHICLE_NRG500,		2814.4331, 2364.6641, 10.3907, 89.6752);
PTPM_AddVehicle(VEHICLE_SLAMVAN,	2827.4143, 2345.6953, 10.5768, 270.0668);
PTPM_AddVehicle(VEHICLE_FCR900,		1670.1089, 1297.8322, 10.3864, 359.4936);
PTPM_AddVehicle(VEHICLE_MAVERICK,	1614.7153, 1548.7513, 11.2749, 347.1516);
PTPM_AddVehicle(VEHICLE_MAVERICK,	1647.7902, 1538.9934, 11.2433, 51.8071);
PTPM_AddVehicle(VEHICLE_MAVERICK,	1608.3851, 1630.7268, 11.2840, 174.5517);
PTPM_AddVehicle(VEHICLE_RUSTLER,	1283.0006, 1324.8849, 9.5332, 275.0468);
PTPM_AddVehicle(VEHICLE_RUSTLER,	1283.5107, 1361.3171, 9.5382, 271.1684);
PTPM_AddVehicle(VEHICLE_RUSTLER,	1283.6847, 1386.5137, 11.5300, 272.1003);
PTPM_AddVehicle(VEHICLE_RUSTLER,	1288.0499, 1403.6605, 11.5295, 243.5028);
PTPM_AddVehicle(VEHICLE_CHEETAH,	1319.1038, 1279.1791, 10.5931, 0.9661);
PTPM_AddVehicle(VEHICLE_FCR900,		1710.5763, 1805.9275, 10.3911, 176.5028);
PTPM_AddVehicle(VEHICLE_FCR900,		2805.1650, 2027.0028, 10.3920, 357.5978);
PTPM_AddVehicle(VEHICLE_SLAMVAN,	2822.3628, 2240.3594, 10.5812, 89.7540);
PTPM_AddVehicle(VEHICLE_FCR900,		2876.8013, 2326.8418, 10.3914, 267.8946);
PTPM_AddVehicle(VEHICLE_BANSHEE,	2842.0554, 2637.0105, 10.5000, 182.2949);
PTPM_AddVehicle(VEHICLE_TAMPA,		2494.4214, 2813.9348, 10.5172, 316.9462);
PTPM_AddVehicle(VEHICLE_TAMPA,		2327.6484, 2787.7327, 10.5174, 179.5639);
PTPM_AddVehicle(VEHICLE_TAMPA,		2142.6970, 2806.6758, 10.5176, 89.8970);
PTPM_AddVehicle(VEHICLE_FCR900,		2139.7012, 2799.2114, 10.3917, 229.6327);
PTPM_AddVehicle(VEHICLE_FCR900,		2104.9446, 2658.1331, 10.3834, 82.2700);
PTPM_AddVehicle(VEHICLE_FCR900,		1914.2322, 2148.2590, 10.3906, 267.7297);
PTPM_AddVehicle(VEHICLE_TAMPA,		1904.7527, 2157.4312, 10.5175, 183.7728);
PTPM_AddVehicle(VEHICLE_TAMPA,		1532.6139, 2258.0173, 10.5176, 359.1516);
PTPM_AddVehicle(VEHICLE_FCR900,		1534.3204, 2202.8970, 10.3644, 4.9108);
PTPM_AddVehicle(VEHICLE_TAMPA,		1613.1553, 2200.2664, 10.5176, 89.6204);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	1552.1292, 2341.7854, 10.9126, 274.0815);
PTPM_AddVehicle(VEHICLE_PEREN,		1637.6285, 2329.8774, 10.5538, 89.6408);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	1357.4165, 2259.7158, 10.9126, 269.5567);
PTPM_AddVehicle(VEHICLE_INFERNUS,	1281.7458, 2571.6719, 10.5472, 270.6128);
PTPM_AddVehicle(VEHICLE_NRG500,		1305.5295, 2528.3076, 10.3955, 88.7249);
PTPM_AddVehicle(VEHICLE_FCR900,		993.9020, 2159.4194, 10.3905, 88.8805);
PTPM_AddVehicle(VEHICLE_CHEETAH,	1512.7134, 787.6931, 10.5921, 359.5796);
PTPM_AddVehicle(VEHICLE_NRG500,		2299.5872, 1469.7910, 10.3815, 258.4984);
PTPM_AddVehicle(VEHICLE_NRG500,		2133.6428, 1012.8537, 10.3789, 87.1290);
PTPM_AddVehicle(VEHICLE_CHEETAH,	2266.7336, 648.4756, 11.0053, 177.8517);
PTPM_AddVehicle(VEHICLE_FCR900,		2404.6636, 647.9255, 10.7919, 183.7688);
PTPM_AddVehicle(VEHICLE_SUPERGT,	2628.1047, 746.8704, 10.5246, 352.7574);
PTPM_AddVehicle(VEHICLE_TAMPA,		2808.7822, 900.1909, 10.4548, 182.4576);
PTPM_AddVehicle(VEHICLE_ELEGY,		1919.8829, 947.1886, 10.4715, 359.4453);
PTPM_AddVehicle(VEHICLE_ELEGY,		1881.6346, 1006.7653, 10.4783, 86.9967);
PTPM_AddVehicle(VEHICLE_ELEGY,		2038.1044, 1006.4022, 10.4040, 179.2641);
PTPM_AddVehicle(VEHICLE_ELEGY,		2038.1614, 1014.8566, 10.4057, 179.8665);
PTPM_AddVehicle(VEHICLE_ELEGY,		2038.0966, 1026.7987, 10.4040, 180.6107);
PTPM_AddVehicle(VEHICLE_BOBCAT,		9.1065, 1165.5066, 19.5855, 2.1281);
PTPM_AddVehicle(VEHICLE_FREEWAY,	19.8059, 1163.7103, 19.1504, 346.3326);
PTPM_AddVehicle(VEHICLE_FREEWAY,	12.5740, 1232.2848, 18.8822, 121.8670);
PTPM_AddVehicle(VEHICLE_WAYFARER,	69.4633, 1217.0189, 18.3304, 158.9345);
PTPM_AddVehicle(VEHICLE_WAYFARER,	-199.4185, 1223.0405, 19.2624, 176.7001);
PTPM_AddVehicle(VEHICLE_RUSTLER,	325.4121, 2538.5999, 17.5184, 181.2964);
PTPM_AddVehicle(VEHICLE_RUSTLER,	291.0975, 2540.0410, 17.5276, 182.7206);
PTPM_AddVehicle(VEHICLE_TORNADO,	384.2365, 2602.1763, 16.0926, 192.4858);
PTPM_AddVehicle(VEHICLE_WAYFARER,	423.8012, 2541.6870, 15.9708, 338.2426);
PTPM_AddVehicle(VEHICLE_WAYFARER,	-244.0047, 2724.5439, 62.2077, 51.5825);
PTPM_AddVehicle(VEHICLE_WAYFARER,	-311.1414, 2659.4329, 62.4513, 310.9601);
PTPM_AddVehicle(VEHICLE_SADLER,		596.8064, 866.2578, -43.2617, 186.8359);
PTPM_AddVehicle(VEHICLE_SADLER,		835.0838, 836.8370, 11.8739, 14.8920);
PTPM_AddVehicle(VEHICLE_TAMPA,		843.1893, 838.8093, 12.5177, 18.2348);
PTPM_AddVehicle(VEHICLE_LANDSTAL,	-235.9767, 1045.8623, 19.8158, 180.0806);
PTPM_AddVehicle(VEHICLE_COPCARRU,	-211.5940, 998.9857, 19.8437, 265.4935);
PTPM_AddVehicle(VEHICLE_BOBCAT,		-304.0620, 1024.1111, 19.5714, 94.1812);
PTPM_AddVehicle(VEHICLE_HOTDOG,		-290.2229, 1317.0276, 54.1871, 81.7529);
PTPM_AddVehicle(VEHICLE_TURISMO,	-290.3145, 1567.1534, 75.0654, 133.1694);
PTPM_AddVehicle(VEHICLE_PATRIOT,	280.4914, 1945.6143, 17.6317, 310.3278);
PTPM_AddVehicle(VEHICLE_PATRIOT,	272.2862, 1949.4713, 17.6367, 285.9714);
PTPM_AddVehicle(VEHICLE_PATRIOT,	271.6122, 1961.2386, 17.6373, 251.9081);
PTPM_AddVehicle(VEHICLE_PATRIOT,	279.8705, 1966.2362, 17.6436, 228.4709);
PTPM_AddVehicle(VEHICLE_BARRACKS,	277.6437, 1985.7559, 18.0772, 270.4079);
PTPM_AddVehicle(VEHICLE_BARRACKS,	277.4477, 1994.8329, 18.0773, 267.7378);
PTPM_AddVehicle(VEHICLE_BANDITO,	-441.3438, 2215.7026, 42.2489, 191.7953);
PTPM_AddVehicle(VEHICLE_BANDITO,	-422.2956, 2225.2612, 42.2465, 0.0616);
PTPM_AddVehicle(VEHICLE_BANDITO,	-371.7973, 2234.5527, 42.3497, 285.9481);
PTPM_AddVehicle(VEHICLE_BANDITO,	-360.1159, 2203.4272, 42.3039, 113.6446);
PTPM_AddVehicle(VEHICLE_SANCHEZ,	-660.7385, 2315.2642, 138.3866, 358.7643);
PTPM_AddVehicle(VEHICLE_SKIMMER,	-1029.2648, 2237.2217, 42.2679, 260.5732);
PTPM_AddVehicle(VEHICLE_ESPERANT,	95.0568, 1056.5530, 13.4068, 192.1461);
PTPM_AddVehicle(VEHICLE_BANSHEE,	114.7416, 1048.3517, 13.2890, 174.9752);
PTPM_AddVehicle(VEHICLE_INFERNUS,	-290.0065, 1759.4958, 42.4154, 89.7571);
PTPM_AddVehicle(VEHICLE_NRG500,		-302.5649, 1777.7349, 42.2514, 238.5039);
PTPM_AddVehicle(VEHICLE_NRG500,		-302.9650, 1776.1152, 42.2588, 239.9874);
PTPM_AddVehicle(VEHICLE_FELTZER,	-301.0404, 1750.8517, 42.3966, 268.7585);
PTPM_AddVehicle(VEHICLE_SLAMVAN,	-866.1774, 1557.2700, 23.8319, 269.3263);
PTPM_AddVehicle(VEHICLE_SUNRISE,	-799.3062, 1518.1556, 26.7488, 88.5295);
PTPM_AddVehicle(VEHICLE_FCR900,		-749.9730, 1589.8435, 26.5311, 125.6508);
PTPM_AddVehicle(VEHICLE_NRG500,		-867.8612, 1544.5282, 22.5419, 296.0923);
PTPM_AddVehicle(VEHICLE_YOSEMITE,	-904.2978, 1553.8269, 25.9229, 266.6985);
PTPM_AddVehicle(VEHICLE_FCR900,		-944.2642, 1424.1603, 29.6783, 148.5582);
PTPM_AddVehicle(VEHICLE_BANSHEE,	-237.7157, 2594.8804, 62.3828, 178.6802);
PTPM_AddVehicle(VEHICLE_FREEWAY,	-196.3012, 2774.4395, 61.4775, 303.8402);
PTPM_AddVehicle(VEHICLE_SHAMAL,		-1341.1079, -254.3787, 15.0701, 321.6338);
PTPM_AddVehicle(VEHICLE_SHAMAL,		-1371.1775, -232.3967, 15.0676, 315.6091);
PTPM_AddVehicle(VEHICLE_SHAMAL,		1642.9850, -2425.2063, 14.4744, 159.8745);
PTPM_AddVehicle(VEHICLE_SHAMAL,		1734.1311, -2426.7563, 14.4734, 172.2036);
PTPM_AddVehicle(VEHICLE_CHEETAH,	-680.9882, 955.4495, 11.9032, 84.2754);
PTPM_AddVehicle(VEHICLE_SKIMMER,	-816.3951, 2222.7375, 43.0045, 268.1861);
PTPM_AddVehicle(VEHICLE_SKIMMER,	-94.6885, 455.4018, 1.5719, 250.5473);
PTPM_AddVehicle(VEHICLE_SKIMMER,	1624.5901, 565.8568, 1.7817, 200.5292);
PTPM_AddVehicle(VEHICLE_SKIMMER,	1639.3567, 572.2720, 1.5311, 206.6160);
PTPM_AddVehicle(VEHICLE_SKIMMER,	2293.4219, 517.5514, 1.7537, 270.7889);
PTPM_AddVehicle(VEHICLE_SKIMMER,	2354.4690, 518.5284, 1.7450, 270.2214);
PTPM_AddVehicle(VEHICLE_SKIMMER,	772.4293, 2912.5579, 1.0753, 69.6706);
PTPM_AddVehicle(VEHICLE_SULTAN,		2133.0769, 1019.2366, 10.5259, 90.5265);
PTPM_AddVehicle(VEHICLE_SULTAN,		2142.4023, 1408.5675, 10.5258, 0.3660);
PTPM_AddVehicle(VEHICLE_SULTAN,		2196.3340, 1856.8469, 10.5257, 179.8070);
PTPM_AddVehicle(VEHICLE_SULTAN,		2103.4146, 2069.1514, 10.5249, 270.1451);
PTPM_AddVehicle(VEHICLE_SULTAN,		2361.8042, 2210.9951, 10.3848, 178.7366);
PTPM_AddVehicle(VEHICLE_SULTAN,		-1993.2465, 241.5329, 34.8774, 310.0117);
PTPM_AddVehicle(VEHICLE_JESTER,		-1989.3235, 270.1447, 34.8321, 88.6822);
PTPM_AddVehicle(VEHICLE_JESTER,		-1946.2416, 273.2482, 35.1302, 126.4200);
PTPM_AddVehicle(VEHICLE_URANUS,		-1956.8257, 271.4941, 35.0984, 71.7499);
PTPM_AddVehicle(VEHICLE_ELEGY,		-1952.8894, 258.8604, 40.7082, 51.7172);
PTPM_AddVehicle(VEHICLE_INFERNUS,	-1949.8689, 266.5759, 40.7776, 216.4882);
PTPM_AddVehicle(VEHICLE_BANSHEE,	-1988.0347, 305.4242, 34.8553, 87.0725);
PTPM_AddVehicle(VEHICLE_JESTER,		-1657.6660, 1213.6195, 6.9062, 282.6953);
PTPM_AddVehicle(VEHICLE_SULTAN,		-1658.3722, 1213.2236, 13.3806, 37.9052);
PTPM_AddVehicle(VEHICLE_URANUS,		-1660.8994, 1210.7589, 20.7875, 317.6098);
PTPM_AddVehicle(VEHICLE_SUNRISE,	-1645.2401, 1303.9883, 6.8482, 133.6013);
PTPM_AddVehicle(VEHICLE_SKIMMER,	-1333.1960, 903.7660, 1.5568, 0.5095);
PTPM_AddVehicle(VEHICLE_INFERNUS,	113.8611, 1068.6182, 13.3395, 177.1330);
PTPM_AddVehicle(VEHICLE_BANSHEE,	159.5199, 1185.1160, 14.7324, 85.5769);
PTPM_AddVehicle(VEHICLE_INFERNUS,	612.4678, 1694.4126, 6.7192, 302.5539);
PTPM_AddVehicle(VEHICLE_NRG500,		661.7609, 1720.9894, 6.5641, 19.1231);
PTPM_AddVehicle(VEHICLE_NRG500,		660.0554, 1719.1187, 6.5642, 12.7699);
PTPM_AddVehicle(VEHICLE_SAVANNA,	711.4207, 1947.5208, 5.4056, 179.3810);
PTPM_AddVehicle(VEHICLE_SAVANNA,	1031.8435, 1920.3726, 11.3369, 89.4978);
PTPM_AddVehicle(VEHICLE_SAVANNA,	1112.3754, 1747.8737, 10.6923, 270.9278);
PTPM_AddVehicle(VEHICLE_SAVANNA,	1641.6802, 1299.2113, 10.6869, 271.4891);
PTPM_AddVehicle(VEHICLE_SAVANNA,	2135.8757, 1408.4512, 10.6867, 180.4562);
PTPM_AddVehicle(VEHICLE_SAVANNA,	2262.2639, 1469.2202, 14.9177, 91.1919);
PTPM_AddVehicle(VEHICLE_SAVANNA,	2461.7380, 1345.5385, 10.6975, 0.9317);
PTPM_AddVehicle(VEHICLE_SAVANNA,	2804.4365, 1332.5348, 10.6283, 271.7682);
PTPM_AddVehicle(VEHICLE_SULTAN,		2805.1685, 1361.4004, 10.4548, 270.2340);
PTPM_AddVehicle(VEHICLE_SUPERGT,	2853.5378, 1361.4677, 10.5149, 269.6648);
PTPM_AddVehicle(VEHICLE_SAVANNA,	2633.9832, 2205.7061, 10.6868, 180.0076);
PTPM_AddVehicle(VEHICLE_SAVANNA,	2119.9751, 2049.3127, 10.5423, 180.1963);
PTPM_AddVehicle(VEHICLE_SAVANNA,	2785.0261, -1835.0374, 9.6874, 226.9852);
PTPM_AddVehicle(VEHICLE_SAVANNA,	2787.8975, -1876.2583, 9.6966, 0.5804);
PTPM_AddVehicle(VEHICLE_INFERNUS,	2771.2993, -1841.5620, 9.4870, 20.7678);
PTPM_AddVehicle(VEHICLE_TAXI,		1713.9319, 1467.8354, 10.5219, 342.8006);
PTPM_AddVehicle(VEHICLE_TAMPA,		2513.8765, 2368.1816, 3.9390, 85.5409); // tampa
PTPM_AddVehicle(VEHICLE_SAVANNA,	2510.8699, 2397.8613, 3.9283, 7.0816); // savanna
PTPM_AddVehicle(VEHICLE_SLAMVAN,	2537.6511, 2397.4429, 3.9339, 358.6610); // slamvan
PTPM_AddVehicle(VEHICLE_LANDSTAL,	2540.1926, 2363.2505, 3.9329, 88.0596); // landstal
PTPM_AddVehicle(VEHICLE_FBIRANCH,	1716.6511, 1387.6346, 10.1719, 195.3732); // fbiranch
PTPM_AddVehicle(VEHICLE_FBIRANCH,	1713.9792, 1397.3528, 10.1771, 195.5063); // fbiranch
PTPM_AddVehicle(VEHICLE_STRETCH,	1711.7006, 1405.5538, 10.1757, 195.4851); // limo
PTPM_AddVehicle(VEHICLE_FBIRANCH,	1708.9426, 1416.8193, 10.1718, 192.9204); // fbiranch
PTPM_AddVehicle(VEHICLE_NEWSVAN,	1717.1743, 1433.9290, 10.2928, 177.0596); // newsvan
PTPM_AddVehicle(VEHICLE_COPBIKE,	1718.0765, 1380.7115, 10.6894, 195.7436); // cop bike
PTPM_AddVehicle(VEHICLE_COPBIKE,	1719.1389, 1381.5099, 10.0587, 196.9333); // copbike
PTPM_AddVehicle(VEHICLE_NRG500,		2848.1685, 915.0026, 10.5222, 99.9024); // nrg
PTPM_AddVehicle(VEHICLE_FCR900,		2853.1367, 923.1398, 10.5225, 92.1160); // fcr
PTPM_AddVehicle(VEHICLE_FCR900,		2855.5422, 929.4323, 10.5203, 86.2880); // fcr
PTPM_AddVehicle(VEHICLE_BURRITO,	2840.2390, 960.1940, 10.5213, 173.6817); // huntley
PTPM_AddVehicle(VEHICLE_BURRITO,	2830.1165, 963.1138, 10.5229, 5.9503); // huntley
PTPM_AddVehicle(VEHICLE_SLAMVAN,	2812.8147, 965.9282, 10.5222, 92.2067); // van or something
PTPM_AddVehicle(VEHICLE_BENSON,		2826.4226, 911.6951, 10.5260, 93.4742); // minivan
PTPM_AddVehicle(VEHICLE_TAMPA,		2802.0010, 899.7051, 10.5257, 182.4596); // glenshit
PTPM_AddVehicle(VEHICLE_TAMPA,		2804.8748, 899.9962, 10.5228, 187.1934); // glenshit
PTPM_AddVehicle(VEHICLE_WAYFARER,	2850.9485, 936.1880, 10.5229, 359.2170); // wayfarer
PTPM_AddVehicle(VEHICLE_WAYFARER,	2850.9075, 933.1924, 10.5203, 359.2168); // wayfarer
PTPM_AddVehicle(VEHICLE_WAYFARER,	2850.8469, 928.7164, 10.5197, 359.2164); // wayfarer
PTPM_AddVehicle(VEHICLE_SWATVAN,	2223.5107, 2453.2517, -7.8801, 268.2045); // swat tank
PTPM_AddVehicle(VEHICLE_SWATVAN,	2227.1729, 2462.8828, -7.8858, 268.8480); // swat tank
PTPM_AddVehicle(VEHICLE_COPCARVG,	2314.9893, 2460.0833, 3.0197, 268.9429); // cop car
PTPM_AddVehicle(VEHICLE_COPCARVG,	2314.5588, 2470.2651, 3.0193, 271.6169); //
PTPM_AddVehicle(VEHICLE_COPCARRU,	2311.8721, 2431.6428, 3.0219, 180.7283); // copcarru
PTPM_AddVehicle(VEHICLE_COPCARRU,	2303.3135, 2431.7693, 3.0199, 180.1414); //
PTPM_AddVehicle(VEHICLE_COPCARRU,	2294.3782, 2431.3086, 3.0165, 178.5332); //
PTPM_AddVehicle(VEHICLE_COPCARVG,	2277.0938, 2430.8738, 3.0175, 358.4374); // copcar
PTPM_AddVehicle(VEHICLE_COPCARVG,	2255.1445, 2431.7939, 3.0171, 358.1542); // copcar
PTPM_AddVehicle(VEHICLE_COPCARVG,	2314.0994, 2484.8403, 3.0163, 271.4961); // copcar
PTPM_AddVehicle(VEHICLE_ENFORCER,	2286.2075, 2474.7297, 3.0213, 357.8531); // cop van
PTPM_AddVehicle(VEHICLE_ENFORCER,	2277.2646, 2474.8477, 3.0187, 357.6639); //
PTPM_AddVehicle(VEHICLE_ENFORCER,	2263.4182, 2475.9897, 3.4054, 359.4711); // enforcer
PTPM_AddVehicle(VEHICLE_COPBIKE,	295.5503, 2455.9656, 2.8444, 272.6913);
PTPM_AddVehicle(VEHICLE_COPBIKE,	2297.9265, 2448.2090, 2.8325, 256.5524);
PTPM_AddVehicle(VEHICLE_COPBIKE,	2297.2913, 2464.0583, 2.8477, 311.1149);
PTPM_AddVehicle(VEHICLE_FCR900,		2856.2258, 933.8096, 10.7500, 94.0911); // fcr
PTPM_AddVehicle(VEHICLE_FCR900,		2855.9255, 938.6560, 10.7500, 85.3177); // fcr
PTPM_AddVehicle(VEHICLE_WAYFARER,	2846.3101, 928.1447, 10.7500, 357.3498); // slow bike
PTPM_AddVehicle(VEHICLE_WAYFARER,	2846.3413, 932.7408, 10.7500, 1.4232); // slow bike
PTPM_AddVehicle(VEHICLE_WAYFARER,	2845.9744, 936.4430, 10.7500, 0.9252); // slow bike
PTPM_AddVehicle(VEHICLE_NRG500,		2545.5967, 742.9938, 10.3889, 182.0201); // nrg
PTPM_AddVehicle(VEHICLE_FCR900,		1997.4865, 2298.8430, 10.8203, 266.6409); // fcr
PTPM_AddVehicle(VEHICLE_WAYFARER,	1979.0238, 2255.0264, 27.1953, 272.0834); // slow bike
PTPM_AddVehicle(VEHICLE_FCR900,		2541.8589, 2020.6932, 10.8150, 180.6666); // fcr
PTPM_AddVehicle(VEHICLE_FCR900,		2613.6719, 1389.7543, 10.8203, 88.4533); // fcr
PTPM_AddVehicle(VEHICLE_CEMENT,		2710.9368, 823.6846, 10.7319, 356.2392); // cement
PTPM_AddVehicle(VEHICLE_BENSON,		2707.2192, 877.3322, 9.8438, 178.7618); // truck
PTPM_AddVehicle(VEHICLE_DFT30,		1702.8733, 752.7228, 10.8203, 176.4471); // flatbed
PTPM_AddVehicle(VEHICLE_BENSON,		1045.3615, 2153.3630, 10.8203, 178.4094); // truck
PTPM_AddVehicle(VEHICLE_AMBULAN,	1614.5382, 1839.8813, 10.8203, 358.3155); // ambulance
PTPM_AddVehicle(VEHICLE_AMBULAN,	1596.0594, 1851.6489, 10.8203, 171.9366); // ambulance
PTPM_AddVehicle(VEHICLE_BENSON,		1745.9331, 2235.1458, 10.8203, 87.1925); // truck
PTPM_AddVehicle(VEHICLE_FIRETRUK,	1754.3046, 2073.4290, 10.8203, 175.6263); // firetruck
PTPM_AddVehicle(VEHICLE_FIRETRUK,	1766.3475, 2073.1533, 10.8203, 180.3264); // firetruck
PTPM_AddVehicle(VEHICLE_DFT30,		1985.7671, 2066.5872, 10.8203, 268.0074); // flatbed
PTPM_AddVehicle(VEHICLE_CEMENT,		2455.1008, 1914.7067, 10.8647, 359.9929); // cement
PTPM_AddVehicle(VEHICLE_BOXVILLE,	2399.2078, 1518.9467, 10.8203, 89.8420); // lorry
PTPM_AddVehicle(VEHICLE_BENSON,		2241.9043, 2235.4993, 10.7834, 269.4017); // truck
PTPM_AddVehicle(VEHICLE_SUNRISE,	2834.3618, 897.7526, 10.7578, 358.9492); // medium car
PTPM_AddVehicle(VEHICLE_URANUS,		2841.6228, 896.5438, 10.7578, 355.5916); // medium car
PTPM_AddVehicle(VEHICLE_EUROS,		2847.9221, 896.6416, 10.7500, 354.0812); // medium car
PTPM_AddVehicle(VEHICLE_BUFFALO,	2163.2354, 778.4031, 11.3520, 88.6995); // medium car
PTPM_AddVehicle(VEHICLE_WASHING,	1852.8623, 698.4745, 11.1820, 270.7062); // medium car
PTPM_AddVehicle(VEHICLE_TAMPA,		1905.1713, 2575.4136, 10.8203, 353.6099); // car slow
PTPM_AddVehicle(VEHICLE_SLAMVAN,	1473.4617, 1901.7454, 11.1509, 268.1785); // car medium
PTPM_AddVehicle(VEHICLE_SULTAN,		1568.5438, 1904.8778, 10.8203, 357.6760); // car medium
PTPM_AddVehicle(VEHICLE_SADLER,		1647.6797, 1943.2810, 10.8203, 265.9184); // car slow
PTPM_AddVehicle(VEHICLE_SUNRISE,	1603.6918, 2087.9055, 11.1319, 269.9370); // medium car
PTPM_AddVehicle(VEHICLE_URANUS,		1848.1832, 2245.0029, 10.8203, 353.1832); // car medium
PTPM_AddVehicle(VEHICLE_WASHING,	1895.4502, 2245.7375, 10.8203, 358.1965); // car medium
PTPM_AddVehicle(VEHICLE_SULTAN,		1923.3781, 2407.2771, 10.8203, 1.3979); // car medium
PTPM_AddVehicle(VEHICLE_PEREN,		1955.9355, 2263.9260, 22.7849, 183.1015); // slow car
PTPM_AddVehicle(VEHICLE_SULTAN,		2339.5979, 2109.5945, 10.6793, 180.9847); // sultan
PTPM_AddVehicle(VEHICLE_BULLET,		2360.4705, 2101.3645, 10.6719, 179.1046); // fast car
PTPM_AddVehicle(VEHICLE_PHOENIX,	2340.3718, 2173.3989, 10.7202, 0.5030); // fast car
PTPM_AddVehicle(VEHICLE_EUROS,		2467.1799, 2337.0210, 10.8203, 89.1238); // medium car
PTPM_AddVehicle(VEHICLE_TURISMO,	2604.8398, 2087.4294, 10.8193, 357.9221); // fast car
PTPM_AddVehicle(VEHICLE_TAMPA,		2578.9456, 1967.3489, 10.8203, 1.0713); // slow car
PTPM_AddVehicle(VEHICLE_BANSHEE,	2562.8914, 1754.9176, 10.8203, 355.3429); // fast car
PTPM_AddVehicle(VEHICLE_TAMPA,		2310.3855, 1795.8695, 10.8203, 177.0800); // car slow
PTPM_AddVehicle(VEHICLE_SLAMVAN,	2520.5940, 1449.7646, 10.8203, 359.6602); // car slow
PTPM_AddVehicle(VEHICLE_CHEETAH,	2609.4919, 1430.0392, 10.8203, 180.8888); // car fast
PTPM_AddVehicle(VEHICLE_PEREN,		2538.7830, 1222.1353, 10.9586, 177.4772); // car slow
PTPM_AddVehicle(VEHICLE_INFERNUS,	2461.8325, 921.9180, 10.8203, 271.6954); // car fast
PTPM_AddVehicle(VEHICLE_ZR350,		2532.9211, 923.4487, 10.8280, 89.4167); // car fast
PTPM_AddVehicle(VEHICLE_CHEETAH,	2075.0493, 1160.3806, 10.6719, 179.5119); // car fast
PTPM_AddVehicle(VEHICLE_TURISMO,	2039.6614, 1214.8975, 10.6719, 359.9566); // car fast
PTPM_AddVehicle(VEHICLE_URANUS,		2362.7856, 728.6328, 11.3205, 180.5584); // car medium
PTPM_AddVehicle(VEHICLE_TAMPA,		2006.5060, 657.9883, 11.2493, 1.0433); // car slow
PTPM_AddVehicle(VEHICLE_BUFFALO,	2104.6033, 942.1170, 10.8203, 267.1487); // car medium
PTPM_AddVehicle(VEHICLE_SLAMVAN,	2231.0376, 952.5665, 10.8203, 356.3398); // car slow
PTPM_AddVehicle(VEHICLE_TAMPA,		2446.0754, 1123.5997, 10.8203, 89.2985); // car slow
PTPM_AddVehicle(VEHICLE_SULTAN,		2468.2139, 1566.8163, 10.8092, 267.5183); // car medium
PTPM_AddVehicle(VEHICLE_PEREN,		2440.1716, 1752.4663, 10.8203, 359.2478); // car slow
PTPM_AddVehicle(VEHICLE_INFERNUS,	2187.3416, 1809.9685, 10.8203, 356.7759); // car fast
PTPM_AddVehicle(VEHICLE_PHOENIX,	2147.9761, 1788.3610, 10.8203, 359.2826); // car fast
PTPM_AddVehicle(VEHICLE_PHOENIX,	2080.1755, 1783.2009, 10.6719, 333.1432); // car fast
PTPM_AddVehicle(VEHICLE_BULLET,		2040.1539, 1643.3982, 10.6719, 179.1316); // car fast
PTPM_AddVehicle(VEHICLE_SULTAN,		1509.3618, 2101.7888, 10.8203, 93.4111); // car medium
PTPM_AddVehicle(VEHICLE_STUNT,		-2340.4287, -1633.2748, 483.6993, 0.0); // psycho lev
PTPM_AddVehicle(VEHICLE_STUNT,		1560.0, -1250.0, 278.0, 270.0); // pm's vehicle stunt
PTPM_AddVehicle(VEHICLE_TUG,		303.1669, 1856.8157, 7.5121, 269.8915); // tug
PTPM_AddVehicle(VEHICLE_TUG,		288.5635, 1838.0925, 7.4930, 90.0084); // forklift
PTPM_AddVehicle(VEHICLE_MESA,		250.0213, 1851.8928, 8.5318, 0.7202); // mesa
PTPM_AddVehicle(VEHICLE_FORKLIFT,	258.2811, 1858.4617, 8.5234, 359.2342); // forklift
PTPM_AddVehicle(VEHICLE_TUG,		221.8046, 1854.5204, 12.4292, 357.9152); // tug inside
PTPM_AddVehicle(VEHICLE_TUG,		213.6140, 1853.8013, 12.3871, 1.4956); // tug inside
PTPM_AddVehicle(VEHICLE_TUG,		222.0894, 1870.0920, 12.6810, 89.4719); // tug inside
PTPM_AddVehicle(VEHICLE_AT400,		1586.941, 1190.642, 10.863, 180); // shamal

PTPM_TeamCantEnterVehicle(TC_Modelid, VEHICLE_HYDRA,	TC_All,		T_Psycho,		T_PrimeMinister);
PTPM_TeamCantEnterVehicle(TC_Modelid, VEHICLE_HUNTER,	TC_All,		T_Psycho,		T_PrimeMinister);

PTPM_TeamCantEnterVehicle(TC_Modelid, VEHICLE_NRG500,	TC_Driver,	T_PrimeMinister);

PTPM_TeamCantEnterVehicle(TC_Modelid, VEHICLE_STRETCH,	TC_Driver,	T_Terrorist,	T_Bodyguard,	T_Cop);
PTPM_TeamCantEnterVehicle(TC_Modelid, VEHICLE_STUNT,	TC_Driver,	T_Terrorist,	T_Bodyguard,	T_Cop);

PTPM_TeamCantUseWeapons(S_HEAVY_WEAPONS, T_PrimeMinister);

#include PTPM_SA_Public // END OF FILE
