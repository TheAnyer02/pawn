/*******************************************************************************
		This file is part of Protect the Prime Minister - San Andreas

	PTPM - SA is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	Foobar is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Foobar. If not, see <http://www.gnu.org/licenses/>.

*******************************************************************************/

#if !defined PTPM_Main_File
	#error "You cant compile PTPM_SA_Def.inc!"
#elseif defined _PTPM_SA_Public_included_
	#if defined _PTPM_SA_Functions_included_
		#error "PTPM_SA_Def needs to be included before PTPM_SA_Functions and PTPM_SA_Public!"
	#endif
	#error "PTPM_SA_Def needs to be included before PTPM_SA_Public!"
#else
	#if defined _PTPM_SA_Functions_included_
		#error "PTPM_SA_Def needs to be included before PTPM_SA_Functions!"
	#endif
#endif

#if !defined NUM_CLASSES
	#error You need to define NUM_CLASSES
#endif

#if !defined NUM_TEAMS
	#error You need to define NUM_TEAMS
#endif

#if !defined NUM_MAPS
	#error You need to define NUM_MAPS
#endif

#if !defined _samp_included
	#include < a_samp >
#endif

//#define	PTPM_Server_Name		"Protect the PM Server - San Andreas"
//#define	PTPM_Web_Url			"www.sparksptpm.co.uk"
#define	PTPM_File1					"PTPM_Data.inc"
#define	PTPM_File2					"PTPM_Log.inc"
#define	PTPM_File3					"PTPM_Chat.inc"
#define	PTPM_Temp					"PTPM_Temp.txt"
#define	PTPM_Filterscript			"PTPM_ERCMD"
#define	PTPM_Mode_Name				"PTPM - SA"
#define PTPM_System_Name			"System"
#define	PTPM_Debug					false
#define	PTPM_Enable_Text_Change		false
#define PTPM_File_System			true
#define PTPM_Server_Data_Change		true
#define PTPM_ShowInfo				true
#define PTPM_Version				0.3i
#define	PTPM_Pickup_Stream_Radius	0
#define	PTPM_Object_Stream_Radius	0
#define	PTPM_Vehicle_Stream_Radius	0

#define	MAX_PTPM_PWEAPON			3
#define	MAX_PTPM_BCUBOID			33
#define	MAX_PTPM_OBJECTS			152
#define	MAX_PTPM_SPOINTS			163
#define MAX_PTPM_WEAPONS			265
#define	MAX_PTPM_PICKUPS			394
#define	MAX_PTPM_VEHICLE			1696

#define PTPM_HACK_OFFSET			0.5

#if !defined MAX_PICKUPS
	#define MAX_PICKUPS			400 //sa-mp version 0.2
#endif

#if defined INVALID_PLAYER_ID
	const SAMP_INVALID_PLAYER_ID = INVALID_PLAYER_ID;
	#undef INVALID_PLAYER_ID
#else
//	const SAMP_INVALID_PLAYER_ID = 255; //version 0.2 (200 Players)
	const SAMP_INVALID_PLAYER_ID = (0xFFFF); //version 0.3 (500 Players)
#endif

#if !defined MAX_PTPM_PWEAPON
	#define MAX_PTPM_PWEAPON	0
#endif

#if !defined MAX_PTPM_BCUBOID
	#define MAX_PTPM_BCUBOID	0
#endif

#if !defined MAX_PTPM_OBJECTS
	#define MAX_PTPM_OBJECTS	0
#elseif MAX_PTPM_OBJECTS > MAX_OBJECTS
	#undef MAX_PTPM_OBJECTS
	#define MAX_PTPM_OBJECTS MAX_OBJECTS
#endif

#if !defined MAX_PTPM_SPOINTS
	#define MAX_PTPM_SPOINTS	0
#endif

#if !defined MAX_PTPM_WEAPONS
	#define MAX_PTPM_WEAPONS	0
#endif

#if !defined MAX_PTPM_PICKUPS
	#define MAX_PTPM_PICKUPS	0
#elseif MAX_PTPM_PICKUPS > MAX_PICKUPS
	#undef MAX_PTPM_PICKUPS
	#define MAX_PTPM_PICKUPS MAX_PICKUPS
#endif

#if !defined MAX_PTPM_VEHICLE
	#define MAX_PTPM_VEHICLE	0
#elseif MAX_PTPM_VEHICLE > MAX_VEHICLES
	#undef MAX_PTPM_VEHICLE
	#define MAX_PTPM_VEHICLE MAX_VEHICLES
#endif

#define NUM_TMP_LENGTH					256
#define NUM_STRING_LENGTH				128
#define NUM_NAME_LENGTH					24
#define NUM_IP_LENGTH					16

#if !defined MAX_CHATBOX_LINES
	#define MAX_CHATBOX_LINES			40
#endif
#if !defined MAX_PRIVAT_CHATBOX_LINES
	#define MAX_PRIVAT_CHATBOX_LINES	6
#endif

#define MAX_OTHER_TEXTDRAWS				5

#define PTPM_DIALOG_COMMAND				1

const MAX_SAMP_PLAYERS = MAX_PLAYERS;

#define TEXTDRAW_GLOBAL (MAX_TEXT_DRAWS - MAX_CHATBOX_LINES - MAX_OTHER_TEXTDRAWS)
#define TEXTDRAW_PLAYER (MAX_PRIVAT_CHATBOX_LINES)

#if 0 < TEXTDRAW_PLAYER
	#undef MAX_PLAYERS
	#define MAX_PLAYERS ((TEXTDRAW_GLOBAL / TEXTDRAW_PLAYER) + 1)
#endif

#define INVALID_PLAYER_ID (MAX_PLAYERS - 1)

#define INVALID_CLASS (Class:-1)
#define INVALID_MAP (Map:-1)

#if !defined INFINITY
	#define INFINITY (0x7F800000)
#endif

enum Class {};
enum Team {};
enum Map {};

enum Dates
{
	PTPM_Year,
	PTPM_Month,
	PTPM_Day,
	PTPM_Hour,
	PTPM_Minute,
	PTPM_Second
}

enum Misc
{
	S_Bad = 1,
	S_Good,
	TC_All,
	PS_Death,
	PS_Spawn,
	S_Neutral,
	TC_Driver,
	PS_Connect,
	TC_Modelid,
	TC_Vehicleid,
	TC_Passenger,
	PS_Disconnect
};

#if MAX_PTPM_PICKUPS > 0
	enum PENUM
	{
		#if PTPM_Pickup_Stream_Radius > 0
			pid,
			ptype,
			bool:pactive,
		#endif
		pmodel,
		Float:PX,
		Float:PY,
		Float:PZ,
		PBC, PWP
	};

	enum WENUM
	{
		Weapon,
		Ammo,
		Delay,
		Wait,
		ID,
		HeavyWeapon,
		slot
	}
#endif

#if MAX_PTPM_SPOINTS > 0
	enum TENUM
	{
		Float:TX,
		Float:TY,
		Float:TZ,
		Float:TAngle,
		TInt
	};
#endif

enum CENUM
{
	Skin,
	Float:SHealth,
	Float:SArmour
};

#if MAX_PTPM_BCUBOID > 0
	enum BCENUM
	{
		Float:BCX,
		Float:BCY,
		Float:BCZ,
		BText[NUM_STRING_LENGTH],
		Float:BTX,
		Float:BTY,
		Float:BTZ,
		Float:BTA,
		bool:BVehicle,
		BInterior
	};
#endif

enum SDENUM
{
	Float:SX,
	Float:SY,
	Float:SZ,
	Float:SA,
	Float:SCX,
	Float:SCY,
	Float:SCZ,
	Sint
};

#if PTPM_Object_Stream_Radius > 0
	enum OENUM
	{
		omodel,
		Float:OX,
		Float:OY,
		Float:OZ,
		Float:OrX,
		Float:OrY,
		Float:OrZ
	};

	enum POENUM
	{
		oid, bool:oactive
	};
#endif

#if MAX_PTPM_VEHICLE > 0
	enum VENUM
	{
		#if PTPM_Vehicle_Stream_Radius > 0
			vid,
			Float:VX,
			Float:VY,
			Float:VZ,
			Float:VA,
			Float:VCX,
			Float:VCY,
			Float:VCZ,
			Float:VCA,
			Float:VCH,
			bool:vactive,
			bool:vused,
		#endif
		vmodel
	};
#endif

enum PLENUM
{
	Float:phealth,
	Float:parmour
};

enum CAENUM
{
	ca_level,
	ca_name[16],
	ca_len,
	ca_fname[25],
	ca_args
}

new
	PTPM_Players,
	PTPM_Round_Time,
	PTPM_Whole_Time,
	PTPM_MAX_PLAYERS,
	PTPM_PM_Timeouted,
	PTPM_Timer_Counter,
	PTPM_Kill_Spee_Time,
	PTPM_TextDraw_Count,
	PTPM_Restart_Count_Ex,
	PTPM_SA_MP_Version[15],
	PTPM_Mute[MAX_PLAYERS],
	#if MAX_PTPM_OBJECTS > 0
		PTPM_Object_Counter,
	#endif
	PTPM_Money[MAX_PLAYERS],
	PTPM_Balance_Counter = 1,
	PTPM_Logged[MAX_PLAYERS],
	PTPM_Tmp[NUM_TMP_LENGTH],
	PTPM_Name[NUM_NAME_LENGTH],
	PTPM_Offer_Time[MAX_PLAYERS],
	PTPM_PM_Name[NUM_NAME_LENGTH],
	PTPM_Team_Size[Team:NUM_TEAMS],
	#if MAX_PTPM_SPOINTS > 0
		PTPM_Point_Counter[Team:NUM_TEAMS],
		PTPM_TM_Counter[Team:NUM_TEAMS][Map:NUM_MAPS],
	#endif
	PTPM_Player_Kills[MAX_PLAYERS],
	PTPM_String[NUM_STRING_LENGTH],
	PTPM_PM_Plan[NUM_STRING_LENGTH],
	PTPM_Team_Player[Team:NUM_TEAMS],
	PTPM_F_String[NUM_STRING_LENGTH],
	PTPM_Player_Teamkills[MAX_PLAYERS],
	PTPM_Old_PM_ID = INVALID_PLAYER_ID,
	PTPM_GetPlayerInterior[MAX_PLAYERS],
	PTPM_GetPlayerVehicleID[MAX_PLAYERS],
	PTPM_Player_Data[MAX_PLAYERS][PLENUM],
	PTPM_GetPlayerVehicleModel[MAX_PLAYERS],
	PTPM_Player_Freeze_Counter[MAX_PLAYERS],
	PTPM_Class_Data[Class:NUM_CLASSES][CENUM],
	PTPM_Selection_Data[Map:NUM_MAPS][SDENUM],
	#if MAX_PTPM_VEHICLE > 0
		PTPM_Vehicle_Counter,
		PTPM_Vehicle[MAX_PTPM_VEHICLE][VENUM],
	#endif
	PTPM_PlayerIp[MAX_PLAYERS][NUM_IP_LENGTH],
	PTPM_Health_Counter[MAX_PLAYERS] = {1, ...},
	PTPM_Swapclass_Offer_ID = INVALID_PLAYER_ID,
	PTPM_PlayerName[MAX_PLAYERS][NUM_NAME_LENGTH],
	PTPM_Logged_Name[MAX_PLAYERS][NUM_NAME_LENGTH],
	PTPM_Connected[MAX_PLAYERS] = {SAMP_INVALID_PLAYER_ID, ...},
	PTPM_PlayerSpec[MAX_PLAYERS] = {SAMP_INVALID_PLAYER_ID,	...},
	#if MAX_PTPM_PICKUPS > 0
		PTPM_Pickup_Counter,
		#if MAX_PTPM_WEAPONS > 0
			PTPM_Weapon_Counter,
			PTPM_Weapon[MAX_PTPM_WEAPONS][WENUM],
		#endif
		#if MAX_PTPM_BCUBOID > 0
			PTPM_Banned_Cuboid_Counter,
			PTPM_Banned_Cuboid[MAX_PTPM_BCUBOID][BCENUM],
		#endif
		PTPM_Pickup[MAX_PTPM_PICKUPS][PENUM],
	#endif
	#if MAX_PTPM_PWEAPON > 0
		PTPM_PWeapon_Counter[Class:NUM_CLASSES],
		PTPM_Class_Weapon[Class:NUM_CLASSES][MAX_PTPM_PWEAPON][2],
	#endif
	#if 0 < MAX_CHATBOX_LINES
		PTPM_Chatbox_Line[MAX_CHATBOX_LINES][NUM_STRING_LENGTH],
	#endif
	#if 0 < MAX_PRIVAT_CHATBOX_LINES
		PTPM_Privat_Chatbox_Time[MAX_PRIVAT_CHATBOX_LINES][MAX_PLAYERS],
		PTPM_Privat_Chatbox_Line[MAX_PRIVAT_CHATBOX_LINES][MAX_PLAYERS][NUM_STRING_LENGTH],
	#endif
	#if MAX_PTPM_SPOINTS > 0
		PTPM_Team_Data[Team:NUM_TEAMS][MAX_PTPM_SPOINTS][TENUM],
		PTPM_Team_Map_Data[Team:NUM_TEAMS][Map:NUM_MAPS][MAX_PTPM_SPOINTS / 2],
	#endif
	PTPM_Playerid_Saver[MAX_PLAYERS] = {SAMP_INVALID_PLAYER_ID, ...},
	#if MAX_PTPM_PICKUPS > 0 && PTPM_Pickup_Stream_Radius > 0
		PTPM_S_Pickup_Counter,
		PTPM_GetPickupNumber[MAX_PICKUPS] = {-1, ...},
	#endif
	#if MAX_PTPM_OBJECTS > 0 && PTPM_Object_Stream_Radius > 0
		PTPM_S_Object_Counter,
		PTPM_Object[MAX_PTPM_OBJECTS][OENUM],
		PTPM_Player_Object[MAX_PLAYERS][MAX_PTPM_OBJECTS][POENUM],
	#endif
	#if MAX_PTPM_VEHICLE > 0 && PTPM_Vehicle_Stream_Radius > 0
		PTPM_S_Vehicle_Counter,
		PTPM_GetVehicleNumber[MAX_VEHICLES] = {-1, ...},
	#endif
	#if PTPM_Pickup_Stream_Radius > 0
		#if PTPM_Object_Stream_Radius > 0
			#if PTPM_Vehicle_Stream_Radius > 0
				PTPM_Timer[6][NUM_STRING_LENGTH],
			#else
				PTPM_Timer[5][NUM_STRING_LENGTH],
			#endif
		#elseif PTPM_Vehicle_Stream_Radius > 0
			PTPM_Timer[5][NUM_STRING_LENGTH],
		#endif
	#elseif PTPM_Object_Stream_Radius > 0
		#if PTPM_Vehicle_Stream_Radius > 0
			PTPM_Timer[5][NUM_STRING_LENGTH],
		#else
			PTPM_Timer[4][NUM_STRING_LENGTH],
		#endif
	#elseif PTPM_Vehicle_Stream_Radius > 0
		PTPM_Timer[4][NUM_STRING_LENGTH],
	#else
		PTPM_Timer[3][NUM_STRING_LENGTH],
	#endif
	Map:PTPM_Map,
	File:PTPM_File,
	Class:PTPM_Class[MAX_PLAYERS],
	Team:PTPM_Team[Class:NUM_CLASSES],
	Dates:PTPM_Dates[Dates],
	Misc:PTPM_Side[Team:NUM_TEAMS],
	bool:PTPM_EveryoneIsOp,
	bool:PTPM_Spawned[MAX_PLAYERS],
	bool:PTPM_Cant_Use_Weapon[Team:NUM_TEAMS][12],
	bool:PTPM_Player_Legal_HeavyWeapon[MAX_PLAYERS],
	bool:PTPM_Cant_Enter_Vehicle[Team:NUM_TEAMS][212][2],
	bool:PTPM_Player_Controllable[MAX_PLAYERS] = {true, ...},
	bool:PTPM_TextDrawActive[MAX_PLAYERS][Text:MAX_TEXT_DRAWS],
	Float:PTPM_Float[4],
	Float:PTPM_PM_Health_Bonus,
	Float:PTPM_Medic_Health_Bonus,
	Float:PTPM_Player_Health_Bonus,
	Float:PTPM_PlayerVehicleHealth[MAX_PLAYERS],
	Text:PTPM_Clock,
	Text:PTPM_ShowMap,
	Text:PTPM_Healthbar,
	Text:PTPM_Healthbar_BG,
	Text:PTPM_Max_Kills_Text,
	#if 0 < MAX_CHATBOX_LINES
		Text:PTPM_Chatbox[MAX_CHATBOX_LINES],
	#endif
	#if 0 < MAX_PRIVAT_CHATBOX_LINES
		Text:PTPM_Privat_Chatbox[MAX_PRIVAT_CHATBOX_LINES][MAX_PLAYERS],
	#endif
	i, z, l;

new const
	PTPM_MapNameA[Map:NUM_MAPS][] =
{
	"Desert",
	"Bayside",
	"Los Santos",
	"San Fierro",
	"Countryside",
	"Las Venturas",
	"Mount Chiliad"
},
	PTPM_TeamData[Team:NUM_TEAMS][] =
{
	{"~r~", 0xFF7F00FF, "a Psycho"},
	{"~p~", 0xFF00AFFF, "a Terrorist"},
	{"~y~", 0xFFFF40FF, "the Prime Minister"},
	{"~g~", 0x008000FF, "a Bodyguard"},
	{"~b~", 0x5050CFFF, "a Cop"}
},
	PTPM_Commands_Array[][CAENUM] =
{	//	***	User Commands ***
	{0, "n", 1, "PTPM_No", 1},
	{0, "y", 1, "PTPM_Yes", 1},
	{0, "me", 2, "PTPM_Me", 2},
	{0, "rc", 2, "PTPM_Reclass", 2},
	{0, "pm", 2, "PTPM_PrivatMessage", 2},
	{0, "cn", 2, "PTPM_ChangeName", 2},
	{0, "ops", 3, "PTPM_Ops", 1},
	{0, "cls", 3, "PTPM_ClearWindow", 1},
	{0, "help", 4, "PTPM_Help", 1},
	{0, "weps", 4, "PTPM_Weapons", 1},
	{0, "kill", 4, "PTPM_KillCom", 1},
	{0, "duty", 4, "PTPM_ExplainRole", 1},
	{0, "plan", 4, "PTPM_PM_Plan_Com", 2},
	{0, "clear", 5, "PTPM_ClearWindow", 1},
	{0, "query", 5, "PTPM_Query", 3},
	{0, "pinfo", 5, "PTPM_PInfo", 3},
	{0, "login", 5, "PTPM_OnPlayerLogIn", 2},
	{0, "weapons", 7, "PTPM_Weapons", 1},
	{0, "players", 7, "PTPM_PlayersCom", 1},
	{0, "reclass", 7, "PTPM_Reclass", 2},
	{0, "swapclass", 9, "PTPM_Swapclass", 2},
	{0, "changename", 10, "PTPM_ChangeName", 2},
	{0, "disablelogin", 12, "PTPM_DisableLogin", 2},
	// *** Moderator Commands ***
	{1, "cp", 2, "PTPM_ChangePassword", 2},
	{1, "say", 3, "PTPM_SayCom", 2},
	{1, "tell", 4, "PTPM_TellCom", 2},
	{1, "mute", 4, "PTPM_MuteCom", 3},
	{1, "tele", 4, "PTPM_Tele", 2},
	{1, "velo", 4, "PTPM_Velo", 2},
	{1, "watch", 5, "PTPM_Watch", 3},
	{1, "teleto", 6, "PTPM_TeleTo", 3},
	{1, "unmute", 6, "PTPM_Unmute", 3},
	{1, "freeze", 6, "PTPM_Freeze", 3},
	{1, "logout", 6, "PTPM_OnPlayerLogOut", 2},
	{1, "clearpc", 7, "PTPM_Free_Chat", 0},
	{1, "unfreeze", 8, "PTPM_Unfreeze", 3},
	{1, "changepw", 8, "PTPM_ChangePassword", 2},
	{1, "gethealth", 9, "PTPM_GetHealth", 3},
	{1, "sethealth", 9, "PTPM_SetHealth", 2},
	{1, "disablelogin", 12, "PTPM_DisableLogin", 2},
	{1, "changepassword", 14, "PTPM_ChangePassword", 2},
	// *** Operator	Commands ***
	{2, "ban", 3, "PTPM_BanCom", 3},
	{2, "kick", 4, "PTPM_KickCom", 3},
	{2, "force", 5, "PTPM_Force", 2},
	{2, "ipban", 5, "PTPM_IpBanCom", 3},
	{2, "loadnpc", 7, "PTPM_LoadNpc", 2},
	{2, "restart", 7, "PTPM_RestartCom", 2},
	// *** Rcon	Commands ***
	{3, "sao", 3, "PTPM_ShowAllOps", 1},
	{3, "sam", 3, "PTPM_ShowAllMods", 1},
	{3, "saa", 3, "PTPM_ShowAllAdmins", 1},
	{3, "cop", 3, "PTPM_ChangeOtherPassword", 2},
	{3, "addop", 5, "PTPM_AddOp", 2},
	{3, "delop", 5, "PTPM_DelOp", 2},
	{3, "addmod", 6, "PTPM_AddMod", 2},
	{3, "delmod", 6, "PTPM_DelMod", 2},
	{3, "showallops", 10, "PTPM_ShowAllOps", 1},
	{3, "showallmods", 11, "PTPM_ShowAllMods", 1},
	{3, "enablelogin", 11, "PTPM_EnableLogin", 2},
	{3, "showalladmins", 13, "PTPM_ShowAllAdmins", 1},
	{3, "changeotherpass", 15, "PTPM_ChangeOtherPassword", 2}
};

// * Native
// ** PTPM Macros
native PTPM_Create_Class(classname);
native PTPM_Create_Team(teamname);
native PTPM_Create_Map(mapname);
native PTPM_Assign_Side(teamname, side);
native PTPM_GetIDEx(playerid, source[], &id);
native PTPM_MapName();
native PTPM_IsMedic(playerid);
native PTPM_TeamNames(teamname);
native PTPM_TeamColor(playerid);
native PTPM_TeamColorHex(playerid);
native PTPM_PlayerHealPlayer(playerid);
native PTPM_DistanceBetweenPointsSq(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z3);
native PTPM_IsPlayerInAmbulance(playerid);
native PTPM_PointToPoint(floatar[], Float:radius, Float:x, Float:y, Float:z);
native PTPM_IsPlayerOp(playerid);
native PTPM_IsPlayerMod(playerid);
native PTPM_SAMP_VERSION(version[]);
native PTPM_IsEmpty(text[]);
native PTPM_IsInt(cell);
native PTPM_ValidNumber(cell);
native PTPM_ValidLetter(cell);
native PTPM_ValidNameCell(cell);
// ** Changed SA-MP functions
native PTPM_TextDrawCreate(Float:x, Float:y, text[]);
native PTPM_TextDrawDestroy(Text:text);
native PTPM_TextDrawShowForPlayer(playerid, Text:text);
native PTPM_TextDrawHideForPlayer(playerid, Text:text);
native PTPM_TextDrawHideForAll(Text:text);
native PTPM_TextDrawShowForAll(Text:text);
native PTPM_TogglePlayerControllable(playerid, bool:toggle);
native PTPM_SetPlayerControllable(playerid, bool:toggle, time);
native PTPM_RemovePlayerFromVehicle(playerid);
native PTPM_GivePlayerMoney(playerid, money);
native PTPM_ResetPlayerMoney(playerid);
native PTPM_SetPlayerArmour(playerid, Float:armour);
native PTPM_SetPlayerHealth(playerid, Float:health);
native PTPM_IsPlayerInAnyVehicle(playerid);

#define PTPM_Create_Class(%1)					new Class:%1
#define PTPM_Create_Team(%1)					new Team:%1
#define PTPM_Create_Map(%1)						new Map:%1
#define PTPM_Assign_Side(%1,%2)					PTPM_Side[(%1)] = (%2)
#define function%1(%2)							%1(%2); public%1(%2)
#define PTPM_GetIDEx(%1,%2,%3)					if(PTPM_GetID(%1, %2, %3) == SAMP_INVALID_PLAYER_ID) return true
#define PTPM_MapName()							PTPM_MapNameA[PTPM_Map]
#define PTPM_TeamNames(%1)						(PTPM_TeamData[%1][5])
#define PTPM_IsMedic(%1)						(PTPM_Class[%1] == C_Bodyguard_Medic || PTPM_Class[%1] == C_Cop_Medic || PTPM_Class[%1] == C_Terrorist_Medic)
#define PTPM_TeamColor(%1)						PTPM_TeamData[PTPM_Team[PTPM_Class[%1]]], (PTPM_IsMedic(%1)) ? ("~h~") : ("")
#define PTPM_TeamColorHex(%1)					PTPM_TeamData[PTPM_Team[PTPM_Class[%1]]][4]
#define PTPM_TextDrawCreate(%1,%2,%3)			TextDrawCreate(%1, %2, %3),			PTPM_TextDraw_Count += 1
#define PTPM_TextDrawDestroy(%1)				TextDrawDestroy(%1),				PTPM_TextDraw_Count -= 1
#define PTPM_TextDrawShowForPlayer(%1,%2)		TextDrawShowForPlayer(%1, %2),		PTPM_TextDrawActive[%1][%2] = true
#define PTPM_TextDrawHideForPlayer(%1,%2)		TextDrawHideForPlayer(%1, %2),		PTPM_TextDrawActive[%1][%2] = false
#define PTPM_PlayerHealPlayer(%1)				PTPM_PlayerHealPlayerFunc(%1, PTPM_GetClosestPlayer(%1))
#define PTPM_TextDrawHideForAll(%1);\
{\
	 if(PTPM_Players) TextDrawHideForAll(%1);\
	 PTPM_TextDrawActive[INVALID_PLAYER_ID][%1] = false;\
}
#define PTPM_TextDrawShowForAll(%1);\
{\
	 if(PTPM_Players) TextDrawShowForAll(%1);\
	 PTPM_TextDrawActive[INVALID_PLAYER_ID][%1] = true;\
}
#define PTPM_RemovePlayerFromVehicle(%1)		RemovePlayerFromVehicle(%1), PTPM_GetPlayerVehicleID[%1] = INVALID_VEHICLE_ID
#define PTPM_IsPlayerInAnyVehicle[%0]			(PTPM_GetPlayerVehicleID[%0] != INVALID_VEHICLE_ID)
#define PTPM_DistanceBetweenPointsSq(%1,%2,%3,%4,%5,%6) ((%1 - %4) * (%1 - %4) + (%2 - %5) * (%2 - %5) + (%3 - %6) * (%3 - %6))
#define PTPM_GivePlayerMoney(%1,%2)				GivePlayerMoney(%1, %2), PTPM_Money[%1] += %2
#define PTPM_ResetPlayerMoney(%1)				ResetPlayerMoney(%1), PTPM_Money[%1] = 0
#define PTPM_SetPlayerArmour(%1,%2)				(SetPlayerArmour(%1, %2), PTPM_Player_Data[%1][parmour] = ((%2) + PTPM_HACK_OFFSET))
#define PTPM_SetPlayerHealth(%1,%2)				(SetPlayerHealth(%1, %2), PTPM_Player_Data[%1][phealth] = ((%2) + PTPM_HACK_OFFSET))
#define PTPM_IsPlayerInAmbulance(%1)			(PTPM_GetPlayerVehicleModel[%1] == VEHICLE_AMBULAN)
#define PTPM_PointToPoint(%1,%4,%5,%6,%7) ((\
		(%4) > (%1[0] - (%5)) && (%1[0] - (%5)) > -(%4)) && ((%4) > (%1[1] - (%6)) && \
		(%1[1] - (%6)) > -(%4)) && ((%4) > (%1[2] - (%7)) && (%1[2] - (%7)) > -(%4)))
#define PTPM_IsPlayerOp(%1)						(PTPM_EveryoneIsOp || PTPM_Logged[%1] > 1)
#define PTPM_IsPlayerMod(%1)					(PTPM_EveryoneIsOp || PTPM_Logged[%1] > 0)
#define PTPM_SAMP_VERSION(%1)					(strfind(PTPM_SA_MP_Version, %1, false, 0) != -1)
#define PTPM_IsEmpty(%1)						((%1[0] == '\0') || (%1[0] == '/' && %1[1] == '?'))
#define PTPM_IsInt(%1)							('0' <= (%1) <= '9')
#define PTPM_ValidNumber(%1)					(PTPM_IsInt(%1) || %1 == '-' || %1 == '+')
#define PTPM_ValidLetter(%1)					(('a' <= (%1) <= 'z') || ('A' <= (%1) <= 'Z'))
#define PTPM_ValidNameCell(%1)					(PTPM_IsInt(%1) || PTPM_ValidLetter(%1) || (%1) == '_' || (%1) == '[' || (%1) == ']')
#define PTPM_TogglePlayerControllable(%1,%2)	(PTPM_Player_Controllable[%1] = %2, TogglePlayerControllable(%1, %2))
#define PTPM_SetPlayerControllable(%1,%2,%3)	(PTPM_TogglePlayerControllable(%1, %2), PTPM_Player_Freeze_Counter[%1] = %3)

#define _PTPM_SA_Def_included_

#define	PICKUP_JETPACK 370
#define	PICKUP_PARACHUTE 371
#define	PICKUP_HEART 1240
#define	PICKUP_PPILL 1241
#define	PICKUP_ARMOR 1242

#define	VEHICLE_ADMIRAL	445
#define	VEHICLE_ALPHA 602
#define	VEHICLE_AMBULAN	416
#define	VEHICLE_ANDROM 592				// air
#define	VEHICLE_ARTICT1	435
#define	VEHICLE_ARTICT2	450
#define	VEHICLE_ARTICT3	591
#define	VEHICLE_AT400 577			 	// air
#define	VEHICLE_BAGBOXA	606
#define	VEHICLE_BAGBOXB	607
#define	VEHICLE_BAGGAGE	485
#define	VEHICLE_BANDITO	568
#define	VEHICLE_BANSHEE	429
#define	VEHICLE_BARRACKS 433
#define	VEHICLE_BEAGLE 511				// air
#define	VEHICLE_BENSON 499
#define	VEHICLE_BF400 581				// bike
#define	VEHICLE_BFINJECT 424
#define	VEHICLE_BIKE 509				// bike
#define	VEHICLE_BLADE 536
#define	VEHICLE_BLISTAC	496
#define	VEHICLE_BLOODRA	504
#define	VEHICLE_BMX	481					// bike
#define	VEHICLE_BOBCAT 422
#define	VEHICLE_BOXBURG	609
#define	VEHICLE_BOXVILLE 498
#define	VEHICLE_BRAVURA	401
#define	VEHICLE_BROADWAY 575
#define	VEHICLE_BUCCANEE 518
#define	VEHICLE_BUFFALO	402
#define	VEHICLE_BULLET 541
#define	VEHICLE_BURRITO	482
#define	VEHICLE_BUS	431
#define	VEHICLE_CABBIE 438
#define	VEHICLE_CADDY 457
#define	VEHICLE_CADRONA	527
#define	VEHICLE_CAMPER 483
#define	VEHICLE_CARGOBOB 548			// air
#define	VEHICLE_CEMENT 524
#define	VEHICLE_CHEETAH	415
#define	VEHICLE_CLOVER 542
#define	VEHICLE_CLUB 589
#define	VEHICLE_COACH 437
#define	VEHICLE_COASTG 472				// water
#define	VEHICLE_COMBINE	532
#define	VEHICLE_COMET 480
#define	VEHICLE_COPBIKE	523				// bike
#define	VEHICLE_COPCARLA 596
#define	VEHICLE_COPCARRU 599
#define	VEHICLE_COPCARSF 597
#define	VEHICLE_COPCARVG 598
#define	VEHICLE_CROPDUST 512			// air
#define	VEHICLE_DFT30 578
#define	VEHICLE_DINGHY 473				// water
#define	VEHICLE_DODO 593				// air
#define	VEHICLE_DOZER 486
#define	VEHICLE_DUMPER 406
#define	VEHICLE_DUNERIDE 573
#define	VEHICLE_ELEGANT	507
#define	VEHICLE_ELEGY 562
#define	VEHICLE_EMPEROR	585
#define	VEHICLE_ENFORCER 427
#define	VEHICLE_ESPERANT 419
#define	VEHICLE_EUROS 587
#define	VEHICLE_FAGGIO 462
#define	VEHICLE_FARMTR1	610
#define	VEHICLE_FBIRANCH 490
#define	VEHICLE_FBITRUCK 528
#define	VEHICLE_FCR900 521				// bike
#define	VEHICLE_FELTZER	533
#define	VEHICLE_FIRELA 544
#define	VEHICLE_FIRETRUK 407
#define	VEHICLE_FLASH 565
#define	VEHICLE_FLATBED	455
#define	VEHICLE_FORKLIFT 530
#define	VEHICLE_FORTUNE	526
#define	VEHICLE_FREEWAY	463				// bike
#define	VEHICLE_FREIBOX	590
#define	VEHICLE_FREIFLAT 569
#define	VEHICLE_FREIGHT	537
#define	VEHICLE_GLENDALE 466
#define	VEHICLE_GLENSHIT 604
#define	VEHICLE_GREENWOO 492
#define	VEHICLE_HERMES 474
#define	VEHICLE_HOTDOG 588
#define	VEHICLE_HOTKNIFE 434
#define	VEHICLE_HOTRINA	502
#define	VEHICLE_HOTRINB	503
#define	VEHICLE_HOTRING	494
#define	VEHICLE_HUNTER 425				// air
#define	VEHICLE_HUNTLEY	579
#define	VEHICLE_HUSTLER	545
#define	VEHICLE_HYDRA 520				// air
#define	VEHICLE_INFERNUS 411
#define	VEHICLE_INTRUDER 546
#define	VEHICLE_JESTER 559
#define	VEHICLE_JETMAX 493				// water
#define	VEHICLE_JOURNEY	508
#define	VEHICLE_KART 571
#define	VEHICLE_LANDSTAL 400
#define	VEHICLE_LAUNCH 595				// water
#define	VEHICLE_LEVIATHN 417			// air
#define	VEHICLE_LINERUN	403
#define	VEHICLE_MAJESTIC 517
#define	VEHICLE_MANANA 410
#define	VEHICLE_MARQUIS	484				// water
#define	VEHICLE_MAVERICK 487			// air
#define	VEHICLE_MERIT 551
#define	VEHICLE_MESA 500
#define	VEHICLE_MONSTER	444
#define	VEHICLE_MONSTERA 556
#define	VEHICLE_MONSTERB 557
#define	VEHICLE_MOONBEAM 418
#define	VEHICLE_MOWER 572
#define	VEHICLE_MRWHOOP	423
#define	VEHICLE_MTBIKE 510				// bike
#define	VEHICLE_MULE 414
#define	VEHICLE_NEBULA 516
#define	VEHICLE_NEVADA 553				// air
#define	VEHICLE_NEWSVAN	582
#define	VEHICLE_NRG500 522				// bike
#define	VEHICLE_OCEANIC	467
#define	VEHICLE_PACKER 443
#define	VEHICLE_PATRIOT	470
#define	VEHICLE_PCJ600 461				// bike
#define	VEHICLE_PEREN 404
#define	VEHICLE_PETRO 514
#define	VEHICLE_PETROTR	584
#define	VEHICLE_PHOENIX	603
#define	VEHICLE_PICADOR	600
#define	VEHICLE_PIZZABOY 448
#define	VEHICLE_POLMAV 497				// air
#define	VEHICLE_PONY 413
#define	VEHICLE_PREDATOR 430			// water
#define	VEHICLE_PREMIER	426
#define	VEHICLE_PREVION	436
#define	VEHICLE_PRIMO 547
#define	VEHICLE_QUAD 471				// bike
#define	VEHICLE_RAINDANC 563			// air
#define	VEHICLE_RANCHER	489
#define	VEHICLE_RCBANDIT 441
#define	VEHICLE_RCBARON	464				// air
#define	VEHICLE_RCCAM 594
#define	VEHICLE_RCGOBLIN 501			// air
#define	VEHICLE_RCRAIDER 465			// air
#define	VEHICLE_RCTIGER	564
#define	VEHICLE_RDTRAIN	515
#define	VEHICLE_REEFER 453				// water
#define	VEHICLE_REGINA 479
#define	VEHICLE_REMINGTN 534
#define	VEHICLE_RHINO 432
#define	VEHICLE_RNCHLURE 505
#define	VEHICLE_ROMERO 442
#define	VEHICLE_RUMPO 440
#define	VEHICLE_RUSTLER	476				// air
#define	VEHICLE_SABRE 475
#define	VEHICLE_SADLER 543
#define	VEHICLE_SADLSHIT 605
#define	VEHICLE_SANCHEZ	468				// bike
#define	VEHICLE_SANDKING 495
#define	VEHICLE_SAVANNA	567
#define	VEHICLE_SEASPAR	447				// air
#define	VEHICLE_SECURICA 428
#define	VEHICLE_SENTINEL 405
#define	VEHICLE_SHAMAL 519				// air
#define	VEHICLE_SKIMMER	460				// air
#define	VEHICLE_SLAMVAN	535
#define	VEHICLE_SOLAIR 458
#define	VEHICLE_SPARROW	469				// air
#define	VEHICLE_SPEEDER	452				// water
#define	VEHICLE_SQUALO 446				// water
#define	VEHICLE_STAFFORD 580
#define	VEHICLE_STALLION 439
#define	VEHICLE_STRATUM	561
#define	VEHICLE_STREAK 538
#define	VEHICLE_STREAKC	570
#define	VEHICLE_STRETCH	409
#define	VEHICLE_STUNT 513				 // air
#define	VEHICLE_SULTAN 560
#define	VEHICLE_SUNRISE	550
#define	VEHICLE_SUPERGT	506
#define	VEHICLE_SWATVAN	601
#define	VEHICLE_SWEEPER	574
#define	VEHICLE_TAHOMA 566
#define	VEHICLE_TAMPA 549
#define	VEHICLE_TAXI 420
#define	VEHICLE_TOPFUN 459
#define	VEHICLE_TORNADO	576
#define	VEHICLE_TOWTRUCK 525
#define	VEHICLE_TRACTOR	531
#define	VEHICLE_TRAM 449
#define	VEHICLE_TRASH 408
#define	VEHICLE_TROPIC 454
#define	VEHICLE_TUG	583
#define	VEHICLE_TUGSTAIR 608
#define	VEHICLE_TURISMO	451
#define	VEHICLE_URANUS 558
#define	VEHICLE_UTILITY	552
#define	VEHICLE_UTILTR1	611
#define	VEHICLE_VCNMAV 488				// air
#define	VEHICLE_VINCENT	540
#define	VEHICLE_VIRGO 491
#define	VEHICLE_VOODOO 412
#define	VEHICLE_VORTEX 539				// hovercraft
#define	VEHICLE_WALTON 478
#define	VEHICLE_WASHING	421
#define	VEHICLE_WAYFARER 586			// bike
#define	VEHICLE_WILLARD	529
#define	VEHICLE_WINDSOR	555
#define	VEHICLE_YANKEE 456
#define	VEHICLE_YOSEMITE 554
#define	VEHICLE_ZR350 477

#define S_FIST (0)
#define S_MELEE_1 (1)
#define S_PISTOLS (2)
#define S_SHOTGUNS (3)
#define S_UZIS (4)
#define S_ASSAULT_RIFES (5)
#define S_RIFLES (6)
#define S_HEAVY_WEAPONS (7)
#define S_MISSILES (8)
#define S_MISC_1 (9)
#define S_MELEE_2 (10)
#define S_MISC_2 (11)
#define S_BOMB (12)
