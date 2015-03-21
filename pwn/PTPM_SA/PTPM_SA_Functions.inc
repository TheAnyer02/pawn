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

#if defined _PTPM_SA_Functions_included_
	#endinput
#endif

#if !defined PTPM_Main_File
	#error "You cant compile PTPM_SA_Functions.inc!"
#elseif !defined _PTPM_SA_Def_included_
	#if defined _PTPM_SA_Public_included_
		#error "PTPM_SA_Functions needs to be included after PTPM_SA_Def and before PTPM_SA_Public!"
	#endif
	#error "PTPM_SA_Functions needs to be included after PTPM_SA_Def!"
#else
	#if defined _PTPM_SA_Public_included_
		#error "PTPM_SA_Functions needs to be included before PTPM_SA_Public!"
	#endif
#endif

function PTPM_AddPlayerClass(skin, &Class:classvariable, Team:teamid) <Gamemode:passive>
{
	classvariable = Class:AddPlayerClass(skin, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
	PTPM_Class_Data[classvariable][Skin] = skin;
	PTPM_Team[classvariable] = teamid;
	PTPM_Team_Size[teamid]++;
}
public PTPM_AddPlayerClass(skin, &Class:classvariable, Team:teamid) <> return;

function PTPM_SetClassData(Float:CHealth, Float:CArmour, Class:classid, ...) <Gamemode:passive>
{
	#if MAX_PTPM_PWEAPON > 0
		PTPM_Name[0] = numargs(), l = 3;
		do
		{
			i = getarg(l++), z = getarg(l++);
			if(PTPM_PWeapon_Counter[classid] >= MAX_PTPM_PWEAPON)
			{
				#if PTPM_Debug == true
					printf("Error - To much weapons: PTPM_ClassStuff(%d, %f, %f, %d, %d)", _:classid, CHealth, CArmour, i, z);
				#endif
				PTPM_PWeapon_Counter[classid]++;
				continue;
			}
			PTPM_Class_Weapon[classid][PTPM_PWeapon_Counter[classid]][0] = i;
			PTPM_Class_Weapon[classid][PTPM_PWeapon_Counter[classid]][1] = z;
			PTPM_PWeapon_Counter[classid]++;
		}
		while(l < PTPM_Name[0]);
	#endif
	PTPM_Class_Data[classid][SHealth] = CHealth;
	PTPM_Class_Data[classid][SArmour] = CArmour;
}
public PTPM_SetClassData(Float:CHealth, Float:CArmour, Class:classid, ...) <> return;

function PTPM_TeamSpawnPoint(Map:mapid, Team:teamid, Float:X, Float:Y, Float:Z, Float:Angle, Interior) <Gamemode:passive>
{
	#if MAX_PTPM_SPOINTS > 0
		if(PTPM_Point_Counter[teamid] >= MAX_PTPM_SPOINTS)
		{
			#if PTPM_Debug == true
				printf("PTPM_TeamSpawnPoint - PTPM_Point_Counter[%d] - %f, %f, %f, %f, %d", _:teamid, X, Y, Z, Angle, Interior);
			#endif
			PTPM_Point_Counter[teamid]++;
			return;
		}
		if(PTPM_TM_Counter[teamid][mapid] >= MAX_PTPM_SPOINTS / 2)
		{
			#if PTPM_Debug == true
				printf("PTPM_TeamSpawnPoint - PTPM_TM_Counter[%d][%d] - %f, %f, %f, %f, %d", _:teamid, _:mapid, X, Y, Z, Angle, Interior);
			#endif
			PTPM_TM_Counter[teamid][mapid]++;
			return;
		}
		PTPM_Team_Data[teamid][PTPM_Point_Counter[teamid]][TX] = X;
		PTPM_Team_Data[teamid][PTPM_Point_Counter[teamid]][TY] = Y;
		PTPM_Team_Data[teamid][PTPM_Point_Counter[teamid]][TZ] = Z;
		PTPM_Team_Data[teamid][PTPM_Point_Counter[teamid]][TAngle] = Angle;
		PTPM_Team_Data[teamid][PTPM_Point_Counter[teamid]][TInt] = Interior;
		PTPM_Team_Map_Data[teamid][mapid][PTPM_TM_Counter[teamid][mapid]] = PTPM_Point_Counter[teamid];
		PTPM_TM_Counter[teamid][mapid]++;
		PTPM_Point_Counter[teamid]++;
	#endif
}
public PTPM_TeamSpawnPoint(Map:mapid, Team:teamid, Float:X, Float:Y, Float:Z, Float:Angle, Interior) <> return;

function PTPM_TeamLineSpawns(Map:mapid, Team:teamid, Float:X1, Float:Y1, Float:Z1, Float:X2, Float:Y2, Float:Z2, Float:separation, Interior) <Gamemode:passive>
{
	PTPM_Float[0] = floatpower(PTPM_DistanceBetweenPointsSq(X1, Y1, Z1, X2, Y2, Z2), 0.5);
	if(PTPM_Float[0] < separation)
	{
		printf("AddTeamLineSpawn: This line is too short (%f,%f,%f) -> (%f,%f,%f)", X1, Y1, Z1, X2, Y2, Z2);
		return;
	}
	X2 = floatdiv(floatsub(X2, X1), PTPM_Float[0]);	/* |\ */
	Y2 = floatdiv(floatsub(Y2, Y1), PTPM_Float[0]);	/* | \ */
	Z2 = floatdiv(floatsub(Z2, Z1), PTPM_Float[0]); /* |__\ */
	PTPM_Float[1] = floatabs(floatdiv(Y2, X2));
	if(X2 >= 0 && Y2 >= 0)		PTPM_Float[2] = 90 - atan(PTPM_Float[1]);
	else if (X2 >= 0 && Y2 < 0)	PTPM_Float[2] = 90 + atan(PTPM_Float[1]);
	else if (X2 < 0 && Y2 < 0)	PTPM_Float[2] = 270 - atan(PTPM_Float[1]);
	else if (X2 < 0 && Y2 >= 0)	PTPM_Float[2] = 270 + atan(PTPM_Float[1]);
	PTPM_Float[2] = floatsub(PTPM_Float[2], 90.0);
	if(PTPM_Float[2] >= 360.0) PTPM_Float[2] -= 360.0;
	for(PTPM_Float[3] = 0.0; PTPM_Float[3] <= PTPM_Float[0]; PTPM_Float[3] += separation)
		PTPM_TeamSpawnPoint(mapid, teamid,	floatadd(X1, floatmul(PTPM_Float[3], X2)),
											floatadd(Y1, floatmul(PTPM_Float[3], Y2)),
											floatadd(Z1, floatmul(PTPM_Float[3], Z2)),
											floatsub(360, PTPM_Float[2]), Interior);
}
public PTPM_TeamLineSpawns(Map:mapid, Team:teamid, Float:X1, Float:Y1, Float:Z1, Float:X2, Float:Y2, Float:Z2, Float:separation, Interior) <> return;

function PTPM_AddSelectionForMap(Map:mapid, Float:X, Float:Y, Float:Z, Float:Angle, interiorid) <Gamemode:passive>
{
	PTPM_Selection_Data[mapid][SX] = X;
	PTPM_Selection_Data[mapid][SY] = Y;
	PTPM_Selection_Data[mapid][SZ] = Z;
	PTPM_Selection_Data[mapid][SA] = Angle;
	PTPM_Selection_Data[mapid][SCX] = X + 5.0 * floatcos((Angle + 90), degrees);
	PTPM_Selection_Data[mapid][SCY] = Y + 5.0 * floatsin((Angle + 90), degrees);
	PTPM_Selection_Data[mapid][SCZ] = Z + 1.0;
	PTPM_Selection_Data[mapid][Sint] = interiorid;
}
public PTPM_AddSelectionForMap(Map:mapid, Float:X, Float:Y, Float:Z, Float:Angle, interiorid) <> return;

function PTPM_AddVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle) <Gamemode:passive>
{
	#if MAX_PTPM_VEHICLE > 0
		if(PTPM_Vehicle_Counter >= MAX_PTPM_VEHICLE || PTPM_Vehicle_Counter >= MAX_VEHICLES)
		{
			#if PTPM_Debug == true
				printf("To much Vehicle: PTPM_AddVehicle(%d, %f, %f, %f, %f)", modelid, spawn_x, spawn_y, spawn_z, z_angle);
			#endif
			PTPM_Vehicle_Counter++;
			return;
		}
		PTPM_Vehicle[PTPM_Vehicle_Counter][vmodel] = modelid;
		#if PTPM_Vehicle_Stream_Radius > 0
			PTPM_Vehicle[PTPM_Vehicle_Counter][VX] = spawn_x;
			PTPM_Vehicle[PTPM_Vehicle_Counter][VCX] = spawn_x;
			PTPM_Vehicle[PTPM_Vehicle_Counter][VY] = spawn_y;
			PTPM_Vehicle[PTPM_Vehicle_Counter][VCY] = spawn_y;
			PTPM_Vehicle[PTPM_Vehicle_Counter][VZ] = spawn_z;
			PTPM_Vehicle[PTPM_Vehicle_Counter][VCZ] = spawn_z;
			PTPM_Vehicle[PTPM_Vehicle_Counter][VA] = z_angle;
			PTPM_Vehicle[PTPM_Vehicle_Counter][VCA] = z_angle;
			PTPM_Vehicle[PTPM_Vehicle_Counter][VCH] = 1000.0;
			PTPM_Vehicle[PTPM_Vehicle_Counter][vid] = -1;
		#else
			CreateVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, -1, -1, -1);
		#endif
		PTPM_Vehicle_Counter++;
	#endif
}
public PTPM_AddVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle) <> return;

function PTPM_AddWeaponPickup(weapon, ammo, Float:X, Float:Y, Float:Z, delay) <Gamemode:passive>
{
	#if MAX_PTPM_PICKUPS > 0 && MAX_PTPM_WEAPONS > 0
		if(PTPM_Weapon_Counter >= MAX_PTPM_WEAPONS)
		{
			#if PTPM_Debug == true
				printf("To much Weapons: PTPM_AddWeaponPickup(%d, %d, %f, %f, %f, %d)", weapon, ammo, X, Y, Z, delay);
			#endif
			PTPM_Weapon_Counter++;
			return;
		}
		switch(weapon)
		{
			case 1:				i = 331;
			case 2..8:			i = 331 + weapon;
			case 9:				i = 341;
			case 10..15:		i = 311 + weapon;
			case 16..18:		i = 326 + weapon;
			case 22..29:		i = 324 + weapon;
			case 30, 31:		i = 325 + weapon;
			case 32:			i = 372;
			case 33..43:		i = 324 + weapon;
			case 53, 54:		i = 325 + weapon;
			default:			return;
		}
		PTPM_AddPickup(i, 23, X, Y, Z);
		switch(weapon)
		{
			case 0, 1:			PTPM_Weapon[PTPM_Weapon_Counter][slot] = 0;
			case 2..9:			PTPM_Weapon[PTPM_Weapon_Counter][slot] = 1;
			case 22..24:		PTPM_Weapon[PTPM_Weapon_Counter][slot] = 2;
			case 25..27:		PTPM_Weapon[PTPM_Weapon_Counter][slot] = 3;
			case 28, 29, 32:	PTPM_Weapon[PTPM_Weapon_Counter][slot] = 4;
			case 30, 31:		PTPM_Weapon[PTPM_Weapon_Counter][slot] = 5;
			case 33, 34:		PTPM_Weapon[PTPM_Weapon_Counter][slot] = 6;
			case 35..38:		PTPM_Weapon[PTPM_Weapon_Counter][slot] = 7;
			case 16..18, 39:	PTPM_Weapon[PTPM_Weapon_Counter][slot] = 8;
			case 41..43:		PTPM_Weapon[PTPM_Weapon_Counter][slot] = 9;
			case 10..15:		PTPM_Weapon[PTPM_Weapon_Counter][slot] = 10;
			case 44..46:		PTPM_Weapon[PTPM_Weapon_Counter][slot] = 11;
			default:			return;
		}
		if(PTPM_Weapon[PTPM_Weapon_Counter][slot] == 7)
				PTPM_Weapon[PTPM_Weapon_Counter][HeavyWeapon] = true;
		else	PTPM_Weapon[PTPM_Weapon_Counter][HeavyWeapon] = false;
		PTPM_Weapon[PTPM_Weapon_Counter][Weapon] = weapon;
		PTPM_Weapon[PTPM_Weapon_Counter][Ammo] = (ammo < 0) ? (1) : (ammo);
		PTPM_Weapon[PTPM_Weapon_Counter][Delay] = delay;
		PTPM_Weapon[PTPM_Weapon_Counter][Wait] = false;
		PTPM_Weapon[PTPM_Weapon_Counter][ID] = INVALID_PLAYER_ID;
		PTPM_Pickup[(PTPM_Pickup_Counter - 1)][PWP] = PTPM_Weapon_Counter++;
	#endif
}
public PTPM_AddWeaponPickup(weapon, ammo, Float:X, Float:Y, Float:Z, delay) <> return;

function PTPM_AddPickup(model, type, Float:X, Float:Y, Float:Z) <Gamemode:passive>
{
	#if MAX_PTPM_PICKUPS > 0
		if(PTPM_Pickup_Counter >= MAX_PTPM_PICKUPS || PTPM_Pickup_Counter >= MAX_PICKUPS)
		{
			#if PTPM_Debug == true
				printf("To much Pickups: PTPM_AddPickup(%d, %d, %f, %f, %f)", model, type, X, Y, Z);
			#endif
			PTPM_Pickup_Counter++;
			return;
		}
		#if PTPM_Pickup_Stream_Radius > 0
			PTPM_Pickup[PTPM_Pickup_Counter][ptype] = type;
			PTPM_Pickup[PTPM_Pickup_Counter][pid] = -1;
		#else
			CreatePickup(model, type, X, Y, Z);
		#endif
		PTPM_Pickup[PTPM_Pickup_Counter][pmodel] = model;
		PTPM_Pickup[PTPM_Pickup_Counter][PBC] = -1;
		PTPM_Pickup[PTPM_Pickup_Counter][PWP] = -1;
		PTPM_Pickup[PTPM_Pickup_Counter][PX] = X;
		PTPM_Pickup[PTPM_Pickup_Counter][PY] = Y;
		PTPM_Pickup[PTPM_Pickup_Counter][PZ] = Z;
		PTPM_Pickup_Counter++;
	#endif
}
public PTPM_AddPickup(model, type, Float:X, Float:Y, Float:Z) <> return;

function PTPM_AddBannedCuboid(Float:X, Float:Y, Float:Z, text[], Float:TEX, Float:TEY, Float:TEZ, Float:TEA, bool:vehicles, interior) <Gamemode:passive>
{
	#if MAX_PTPM_PICKUPS > 0 && MAX_PTPM_BCUBOID > 0
		if(PTPM_Banned_Cuboid_Counter >= MAX_PTPM_BCUBOID)
		{
			#if PTPM_Debug == true
				printf("To much Banned Cuboids: PTPM_AddBannedCuboid(%f, %f, %f, %s, %f, %f, %f, %f, %b, %d)", X, Y, Z, text, TEX, TEY, TEZ, TEA, vehicles, interior);
			#endif
			PTPM_Banned_Cuboid_Counter++;
			return;
		}
		PTPM_AddPickup(1318, 1, X, Y, Z);
		PTPM_Banned_Cuboid[PTPM_Banned_Cuboid_Counter][BCX] = X;
		PTPM_Banned_Cuboid[PTPM_Banned_Cuboid_Counter][BCY] = Y;
		PTPM_Banned_Cuboid[PTPM_Banned_Cuboid_Counter][BCZ] = Z;
		format(PTPM_Banned_Cuboid[PTPM_Banned_Cuboid_Counter][BText], NUM_STRING_LENGTH, "%s", (text[0]) ? (text) : (" "));
		PTPM_Banned_Cuboid[PTPM_Banned_Cuboid_Counter][BTX] = TEX;
		PTPM_Banned_Cuboid[PTPM_Banned_Cuboid_Counter][BTY] = TEY;
		PTPM_Banned_Cuboid[PTPM_Banned_Cuboid_Counter][BTZ] = TEZ;
		PTPM_Banned_Cuboid[PTPM_Banned_Cuboid_Counter][BTA] = TEA;
		PTPM_Banned_Cuboid[PTPM_Banned_Cuboid_Counter][BVehicle] = vehicles;
		PTPM_Banned_Cuboid[PTPM_Banned_Cuboid_Counter][BInterior] = interior;
		PTPM_Pickup[(PTPM_Pickup_Counter - 1)][PBC] = PTPM_Banned_Cuboid_Counter++;
	#endif
}
public PTPM_AddBannedCuboid(Float:X, Float:Y, Float:Z, text[], Float:TEX, Float:TEY, Float:TEZ, Float:TEA, bool:vehicles, interior) <> return;

function PTPM_AddBannedCuboidEx(Float:MX, Float:IX, Float:MY, Float:IY, Float:MZ, Float:IZ, text[], Float:TEX, Float:TEY, Float:TEZ, Float:TEA, bool:vehicles, interior) <Gamemode:passive>
{
	#if MAX_PTPM_PICKUPS > 0 && MAX_PTPM_BCUBOID > 0
		PTPM_AddBannedCuboid(	floatadd(IX, floatdiv(floatsub(MX, IX), 2.0)),
								floatadd(IY, floatdiv(floatsub(MY, IY), 2.0)),
								floatsub(MZ, 1.0),
								text, TEX, TEY, TEZ, TEA, vehicles, interior);
	#endif
}
public PTPM_AddBannedCuboidEx(Float:MX, Float:IX, Float:MY, Float:IY, Float:MZ, Float:IZ, text[], Float:TEX, Float:TEY, Float:TEZ, Float:TEA, bool:vehicles, interior) <> return;

function PTPM_AddObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ) <Gamemode:passive>
{
	#if MAX_PTPM_OBJECTS > 0
		if(PTPM_Object_Counter >= MAX_PTPM_OBJECTS || PTPM_Object_Counter >= MAX_OBJECTS)
		{
			#if PTPM_Debug == true
				printf("To much Objects: PTPM_AddObject(%d, %d, %f, %f, %f, %f, %f, %f)", modelid, X, Y, Z, rX, rY, rZ);
			#endif
			PTPM_Object_Counter++;
			return;
		}
		#if PTPM_Object_Stream_Radius > 0
			PTPM_Object[PTPM_Object_Counter][omodel] = modelid;
			PTPM_Object[PTPM_Object_Counter][OX] = X;
			PTPM_Object[PTPM_Object_Counter][OY] = Y;
			PTPM_Object[PTPM_Object_Counter][OZ] = Z;
			PTPM_Object[PTPM_Object_Counter][OrX] = rX;
			PTPM_Object[PTPM_Object_Counter][OrY] = rY;
			PTPM_Object[PTPM_Object_Counter][OrZ] = rZ;
			for(i = 0; i < PTPM_Players; i++)
				PTPM_Player_Object[PTPM_Connected[i]][PTPM_Object_Counter][oid] = -1;
		#else
			CreateObject(modelid, X, Y, Z, rX, rY, rZ);
		#endif
		PTPM_Object_Counter++;
	#endif
}
public PTPM_AddObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ) <> return;

function PTPM_Reset(Restart_Time, bool:overwrite) <Gamemode:active>
{
	if(!PTPM_Restart_Count_Ex || overwrite)
	{
		state Gamemode:restart;
		PTPM_Restart_Count_Ex = Restart_Time + 1;
		if(!GetPlayerPos(PTPM_Old_PM_ID, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]))
		{
			PTPM_Float[0] = float(random(3000) * ((random(2)) ? (1) : (-1)));
			PTPM_Float[1] = float(random(3000) * ((random(2)) ? (1) : (-1)));
			PTPM_Float[2] = 500.0;
		}
		for(i = 0; i < PTPM_Players; i++)
		{
			PTPM_TogglePlayerControllable(PTPM_Connected[i], false);
			SetPlayerPos(PTPM_Connected[i], PTPM_Float[0], (PTPM_Float[1] - 30.0), (PTPM_Float[2] + 25.0)),
			SetPlayerCameraPos(PTPM_Connected[i], PTPM_Float[0], (PTPM_Float[1] - 25.0), (PTPM_Float[2] + 25.0));
			SetPlayerCameraLookAt(PTPM_Connected[i], PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
		}
	}
}
public PTPM_Reset(Restart_Time, bool:overwrite) <>
{
	PTPM_PM_Name[0] = EOS;
	PTPM_PM_Plan[0] = EOS;
	PTPM_Round_Time = false;
	PTPM_Old_PM_ID = INVALID_PLAYER_ID;

	for(i = 0; Team:i < Team:NUM_TEAMS; i++)
		PTPM_Team_Player[Team:i] = false;
	#if MAX_PTPM_PICKUPS > 0 && MAX_PTPM_WEAPONS > 0
		for(i = 0; i < PTPM_Weapon_Counter; i++)
			PTPM_Weapon[i][Wait] = false;
	#endif

	#if MAX_PTPM_VEHICLE > 0 && PTPM_Vehicle_Stream_Radius > 0
		for(i = 0; i < PTPM_Vehicle_Counter; i++)
			if(PTPM_Vehicle[i][vactive])
				PTPM_ResetVehicle(i);
	#endif
	#if MAX_PTPM_PICKUPS > 0 && PTPM_Pickup_Stream_Radius > 0
		for(i = 0; i < PTPM_Pickup_Counter; i++)
			if(PTPM_Pickup[i][pactive])
				PTPM_DestroyPickup(i);
	#endif

	format(PTPM_String, NUM_STRING_LENGTH, "%02d:%02d",
			PTPM_Round_Time_Minutes, PTPM_Round_Time_Seconds);
	TextDrawSetString(PTPM_Clock, PTPM_String);

	#if PTPM_Server_Data_Change
		PTPM_ChangeServerData(false);
	#endif

	for(i = 0; i < PTPM_Players; i++)
	{
		PTPM_SetPlayerArmour(PTPM_Connected[i], 0.0);
		PTPM_PlayerStats(PTPM_Connected[i], PS_Death);
		PTPM_SetPlayerControllable(PTPM_Connected[i], false, 0);

		#if PTPM_Object_Stream_Radius > 0 && MAX_PTPM_OBJECTS > 0
			for(z = 0; z < PTPM_Object_Counter; z++)
				if(PTPM_Player_Object[PTPM_Connected[i]][z][oactive])
					PTPM_DestroyPlayerObject(PTPM_Connected[i], z);
		#endif

		PTPM_Class[PTPM_Connected[i]] =	Class:((random(2)) ?
						(random(PTPM_Team_Size[T_Psycho] + PTPM_Team_Size[T_Terrorist])) :
						(PTPM_Team_Size[T_Bodyguard] + random(PTPM_Team_Size[T_Bodyguard] + PTPM_Team_Size[T_Cop])));
		PTPM_SpawnPlayer(PTPM_Connected[i]);
	}
	state Gamemode:active;
}

function PTPM_RestartCom(playerid, rest[]) <Gamemode:active>
{
	if(!PTPM_IsInt(rest[0]))
		return PTPM_SendClientMessage(playerid, "Right Usage: /restart [time]");
	PTPM_Reset(((i = PTPM_strval(rest)) ? (i) : (1)), true);
	return true;
}
public PTPM_RestartCom(playerid, rest[]) <> return PTPM_SendClientMessage(playerid, "Only avaible during running mode!");

#if 0 < MAX_CHATBOX_LINES
	function PTPM_SendClientMessageToAll(text[NUM_STRING_LENGTH])
	{
		for(l = 0; l < MAX_CHATBOX_LINES - 1; l++)
		{
			format(PTPM_Chatbox_Line[l], NUM_STRING_LENGTH, PTPM_Chatbox_Line[l + 1]);
			TextDrawSetString(PTPM_Chatbox[l], PTPM_Chatbox_Line[l]);
		}
		if(strlen(text) > (NUM_STRING_LENGTH / 2))
		{
			format(PTPM_Chatbox_Line[MAX_CHATBOX_LINES - 1], NUM_STRING_LENGTH / 2, text);
			PTPM_SendClientMessageToAll(PTPM_Chatbox_Line[MAX_CHATBOX_LINES - 1]);
			format(PTPM_Chatbox_Line[MAX_CHATBOX_LINES - 1], NUM_STRING_LENGTH, text[NUM_STRING_LENGTH / 2]);
		}
		else
		{
			if(PTPM_IsEmpty(text)) format(PTPM_Chatbox_Line[MAX_CHATBOX_LINES - 1], NUM_STRING_LENGTH, " ");
			else format(PTPM_Chatbox_Line[MAX_CHATBOX_LINES - 1], NUM_STRING_LENGTH, text);
		}
		TextDrawSetString(PTPM_Chatbox[MAX_CHATBOX_LINES - 1], PTPM_Chatbox_Line[MAX_CHATBOX_LINES - 1]);
		#if PTPM_File_System == true
			PTPM_WriteToLog(text, MAX_PLAYERS);
		#endif

		PTPM_SendClientMessage(INVALID_PLAYER_ID, text);
		return true;
	}
#else
	function PTPM_SendClientMessageToAll(text[NUM_STRING_LENGTH])
	{
		for(i = 1, z = 0xFFFFFFFF; ; i += 2)
		{
			if((text[i - 1] == '~') && (text[i + 1] == '~'))
			{
				switch(text[i])
				{
					case 'r': z = 0xFF0000FF;
					case 'g': z = 0x00AA00FF;
					case 'b': z = 0x0000CCFF;
					case 'y': z = 0xFFFF00FF;
					case 'p': z = 0x9932CCFF;
					case 'l': z = 0;
					default: continue;
				}
			}
			break;
		}
		LetterDeleter(text, '~');
		SendClientMessageToAll(z, text);
		#if PTPM_File_System == true
			PTPM_WriteToLog(text, MAX_PLAYERS);
		#endif

		PTPM_SendClientMessage(INVALID_PLAYER_ID, text);
		return true;
	}
#endif

#if 0 < MAX_PRIVAT_CHATBOX_LINES
	function PTPM_SendClientMessage(playerid, text[NUM_STRING_LENGTH])
	{
		if(playerid == INVALID_PLAYER_ID)
		{
			LetterDeleter(text, '~');
			return print(text);
		}
		for(l = 0; l < MAX_PRIVAT_CHATBOX_LINES - 1; l++)
		{
			PTPM_Privat_Chatbox_Time[l][playerid] = PTPM_Privat_Chatbox_Time[l + 1][playerid];
			format(PTPM_Privat_Chatbox_Line[l][playerid], NUM_STRING_LENGTH, PTPM_Privat_Chatbox_Line[l + 1][playerid]);
			TextDrawSetString(PTPM_Privat_Chatbox[l][playerid], PTPM_Privat_Chatbox_Line[l][playerid]);
		}
		PTPM_Privat_Chatbox_Time[MAX_PRIVAT_CHATBOX_LINES - 1][playerid] = 15;
		if(PTPM_IsEmpty(text)) format(PTPM_Privat_Chatbox_Line[MAX_PRIVAT_CHATBOX_LINES - 1][playerid], NUM_STRING_LENGTH, " ");
		else format(PTPM_Privat_Chatbox_Line[MAX_PRIVAT_CHATBOX_LINES - 1][playerid], NUM_STRING_LENGTH, text);
		TextDrawSetString(PTPM_Privat_Chatbox[MAX_PRIVAT_CHATBOX_LINES - 1][playerid], PTPM_Privat_Chatbox_Line[MAX_PRIVAT_CHATBOX_LINES - 1][playerid]);
		#if PTPM_File_System == true
			PTPM_WriteToLog(text, playerid);
		#endif
		return true;
	}
#else
	function PTPM_SendClientMessage(playerid, text[NUM_STRING_LENGTH])
	{	
		LetterDeleter(text, '~');
		if(playerid == INVALID_PLAYER_ID)
		{
			return print(text);
		}
		SendClientMessage(playerid, GetPlayerColor(playerid), text);
		#if PTPM_File_System == true
			PTPM_WriteToLog(text, playerid);
		#endif
		return true;
	}
#endif

function PTPM_SendClientMessageToAdmin(text[NUM_STRING_LENGTH])
{
	for(z = 0; z < PTPM_Players; z++)
		if(PTPM_IsPlayerMod(PTPM_Connected[z]))
			PTPM_SendClientMessage(PTPM_Connected[z], text);

	PTPM_SendClientMessage(INVALID_PLAYER_ID, text);
	return true;
}

#if defined PTPM_File_System
	function PTPM_WriteToLog(text[], id)
	{
		if(PTPM_IsEmpty(text)) return false;
		PTPM_File = fopen(PTPM_File3, io_append);
		format(PTPM_F_String, NUM_STRING_LENGTH, "%02d.%02d.%04d -",
				_:PTPM_Dates[PTPM_Day], _:PTPM_Dates[PTPM_Month], _:PTPM_Dates[PTPM_Year]);
		format(PTPM_F_String, NUM_STRING_LENGTH, "%s %02d:%02d:%02d -", PTPM_F_String,
				_:PTPM_Dates[PTPM_Hour], _:PTPM_Dates[PTPM_Minute], _:PTPM_Dates[PTPM_Second]);
		switch(id)
		{
			case MAX_PLAYERS:
				format(PTPM_F_String, NUM_STRING_LENGTH, "%s %s\r\n", PTPM_F_String, text);
			case INVALID_PLAYER_ID:
				format(PTPM_F_String, NUM_STRING_LENGTH, "%s Console[%s]: %s\r\n",
						PTPM_F_String, PTPM_PlayerName[id], text);
			default:
				format(PTPM_F_String, NUM_STRING_LENGTH, "%s Privat[%s(%d)]: %s\r\n",
					PTPM_F_String, PTPM_PlayerName[id], id, text);
		}
		fwrite(PTPM_File, PTPM_F_String);
		fclose(PTPM_File);
		return true;
	}
#endif

function PTPM_GameTextForAll(text[], time, style)
{
	GameTextForAll(text, time, style);
	PTPM_GameTextForPlayer(INVALID_PLAYER_ID, text, time, style);
	return true;
}

function PTPM_GameTextForPlayer(playerid, text[], time, style)
{
	if(playerid == INVALID_PLAYER_ID)
	{
		LetterDeleter(text, '~');
		return printf("GameText: %s", text);
	}
	GameTextForPlayer(playerid, text, time, style);
	return true;
}

function PTPM_Help(playerid)
{
	if(playerid == INVALID_PLAYER_ID)
	{
		print(	"-------------------\r\n\
				 **** Rcon Help ****\r\n\
				 -------------------");
		for(i = 0, PTPM_String[0] = EOS, PTPM_String[60] = EOS; i < sizeof PTPM_Commands_Array; i++)
		{
			if(PTPM_String[60] != EOS)
			{
				print(PTPM_String);
				PTPM_String[0] = EOS;
				PTPM_String[60] = EOS;
			}
			if(PTPM_String[0] != EOS)
					format(PTPM_String, NUM_STRING_LENGTH, "%s /%s", PTPM_String, PTPM_Commands_Array[i][ca_name]);
			else	format(PTPM_String, NUM_STRING_LENGTH, "%s/%s", PTPM_String, PTPM_Commands_Array[i][ca_name]);
		}
		printf("%s" "\r\n" "Messages starting with : are admin messages\r\n\
							Messages starting with ! are gametext-messages.\r\n\
							Messages starting with . are admin-only messages.\r", PTPM_String);
	}
	else
	{
		PTPM_SendClientMessage(playerid, "~y~Help / Commands");
		i = 0, PTPM_String[0] = EOS, PTPM_String[99] = 'A';
		if(PTPM_EveryoneIsOp)
		{
			for(; i < sizeof PTPM_Commands_Array; i++)
			{
				if(PTPM_String[99] != EOS)
				{
					if(PTPM_String[0] != EOS)
						PTPM_SendClientMessage(playerid, PTPM_String);
					PTPM_String[99] = EOS;
					switch(PTPM_Commands_Array[i][ca_level])
					{
						case 0: PTPM_String[0] = '~', PTPM_String[1] = 'w', PTPM_String[2] = '~', PTPM_String[3] = EOS;
						case 1: PTPM_String[0] = '~', PTPM_String[1] = 'g', PTPM_String[2] = '~', PTPM_String[3] = EOS;
						case 2: PTPM_String[0] = '~', PTPM_String[1] = 'b', PTPM_String[2] = '~', PTPM_String[3] = EOS;
					}
				}
				if(PTPM_String[3] != EOS)
						format(PTPM_String, NUM_STRING_LENGTH, "%s /%s", PTPM_String, PTPM_Commands_Array[i][ca_name]);
				else	format(PTPM_String, NUM_STRING_LENGTH, "%s/%s", PTPM_String, PTPM_Commands_Array[i][ca_name]);
			}
		}
		else
		{
			for(z = 1; i < sizeof PTPM_Commands_Array; i++)
			{
				if(PTPM_String[99] != EOS || z != PTPM_Commands_Array[i][ca_level])
				{
					if(PTPM_Commands_Array[i][ca_level] > PTPM_Logged[playerid]) break;
					else if(PTPM_String[0] != EOS)
						PTPM_SendClientMessage(playerid, PTPM_String);
					PTPM_String[99] = EOS;
					switch((z = PTPM_Commands_Array[i][ca_level]))
					{
						case 0: PTPM_String[0] = '~', PTPM_String[1] = 'w', PTPM_String[2] = '~', PTPM_String[3] = EOS;
						case 1: PTPM_String[0] = '~', PTPM_String[1] = 'g', PTPM_String[2] = '~', PTPM_String[3] = EOS;
						case 2: PTPM_String[0] = '~', PTPM_String[1] = 'b', PTPM_String[2] = '~', PTPM_String[3] = EOS;
					}
				}
				if(PTPM_String[3] != EOS)
						format(PTPM_String, NUM_STRING_LENGTH, "%s /%s", PTPM_String, PTPM_Commands_Array[i][ca_name]);
				else	format(PTPM_String, NUM_STRING_LENGTH, "%s/%s", PTPM_String, PTPM_Commands_Array[i][ca_name]);
			}
		}
		PTPM_SendClientMessage(playerid, PTPM_String);
	}
	return true;
}

function PTPM_Reclass(playerid, classname[])
{
	if(PTPM_Class[playerid] == C_PrimeMinister)
		return PTPM_SendClientMessage(playerid, "The Prime Minister must use /swapclass");
	else if(PTPM_Class[playerid] == INVALID_CLASS)
		return PTPM_SendClientMessage(playerid, "You cannot reclass cuz you arent a player!");
	else if(!PTPM_Player_Controllable[playerid])
		return PTPM_SendClientMessage(playerid, "You cannot reclass while frozen!");
	else if(PTPM_IsEmpty(classname))
		return PTPM_SendClientMessage(playerid, "Usage: /reclass pm|terrorist|cop|bodyguard|psycho|tmedic|bmedic|cmedic");
	else if(PTPM_IsInt(classname[0]))
	{
		if((i = PTPM_strval(classname)) >= NUM_CLASSES || i < 0)
			PTPM_SendClientMessage(playerid, "Invalid Classid - Picking random Class"),
			i = random(NUM_CLASSES);
	}
	else if(!strcmp("cop", classname, true) || !strcmp("c", classname, true))		i = _:C_Cop1 + random(PTPM_Team_Size[T_Cop]);
	else if(!strcmp("terrorist", classname, true) || !strcmp("t", classname, true))	i = _:C_Terrorist1 + random(PTPM_Team_Size[T_Terrorist]);
	else if(!strcmp("bodyguard", classname, true) || !strcmp("b", classname, true)) i = _:C_Bodyguard1 + random(PTPM_Team_Size[T_Bodyguard]);
	else if(!strcmp("psycho", classname, true) || !strcmp("p", classname, true))	i = _:C_Psycho1 + random(PTPM_Team_Size[T_Psycho]);
	else if(!strcmp("pm", classname, true))											i = _:C_PrimeMinister;
	else if(!strcmp("tmedic", classname, true) || !strcmp("tm", classname, true))	i = _:C_Terrorist_Medic;
	else if(!strcmp("cmedic", classname, true) || !strcmp("cm", classname, true))	i = _:C_Cop_Medic;
	else if(!strcmp("bmedic", classname, true) || !strcmp("bm", classname, true))	i = _:C_Bodyguard_Medic;
	else
	{
		PTPM_SendClientMessage(playerid, "No such class.");
		PTPM_SendClientMessage(playerid, "Usage: /reclass pm|terrorist|cop|bodyguard|psycho|tmedic|bmedic|cmedic");
		return true;
	}
	PTPM_Team_Player[PTPM_Team[PTPM_Class[playerid]]]--;
	PTPM_Class[playerid] = Class:i;
	PTPM_SpawnPlayer(playerid);
	return true;
}

function PTPM_Swapclass(playerid, rest[])
{
	if(PTPM_Class[playerid] == INVALID_CLASS)
		return PTPM_SendClientMessage(playerid, "You cannot reclass cuz you arent a player!");
	else if(PTPM_Class[playerid] != C_PrimeMinister)
		return PTPM_SendClientMessage(playerid, "All none Prime Minister need to use /reclass");
	else if(PTPM_IsEmpty(rest))
		return PTPM_SendClientMessage(playerid, "Usage: /swapclass <person>");
	PTPM_GetIDEx(playerid, rest, i);
	if(i == playerid)
		return PTPM_SendClientMessage(playerid, "You are the Prime Minister.");
	else if(PTPM_Class[i] == INVALID_CLASS)
		return PTPM_SendClientMessage(playerid, "That person has not yet selected a class.");
	else if(PTPM_Swapclass_Offer_ID != INVALID_PLAYER_ID)
		return PTPM_SendClientMessage(playerid, "You may not swapclass with two people at once.");
	PTPM_SendClientMessage(i, "~y~The Prime Minister wants to swapclass with you.");
	PTPM_SendClientMessage(i, "~y~Type /y to accept or /n to decline.");
	format(PTPM_String, NUM_STRING_LENGTH, "Swapclass offer sent to %s", PTPM_PlayerName[i]);
	PTPM_SendClientMessage(playerid, PTPM_String);
	PTPM_Swapclass_Offer_ID = i;
	PTPM_Offer_Time[i] = 15;
	return true;
}

function Float:PTPM_DistanceFromP2PSquare(id1, id2)
{
	new Float:Pos[6];
	GetPlayerPos(id1, Pos[0], Pos[1], Pos[2]);
	GetPlayerPos(id2, Pos[3], Pos[4], Pos[5]);
	Pos[0] -= Pos[3], Pos[1] -= Pos[4], Pos[2] -= Pos[5];
	return (Pos[0] * Pos[0]) + (Pos[1] * Pos[1]) + (Pos[2] * Pos[2]);
}

function PTPM_PlayerHealPlayerFunc(medic, patient)
{
	if(!PTPM_IsMedic(medic)) return PTPM_SendClientMessage(medic, "Special Action: You need to be a medic");
	if(patient == INVALID_PLAYER_ID) return PTPM_SendClientMessage(medic, "Special Action: You are the only player on this server");
	if((PTPM_DistanceFromP2PSquare(medic, patient) > 25.0) && (PTPM_GetPlayerVehicleID[medic] != PTPM_GetPlayerVehicleID[patient]))
	{
		format(PTPM_String, NUM_STRING_LENGTH, "You are too far from \"%s\" (%.0f).", PTPM_PlayerName[patient], PTPM_Float[3]);
		return PTPM_SendClientMessage(medic, PTPM_String);
	}
	GetPlayerHealth(patient, PTPM_Float[1]);
	GetPlayerHealth(medic, PTPM_Float[2]);
	#if MAX_PTPM_VEHICLE > 0
		if(PTPM_IsPlayerInAmbulance(medic))
				PTPM_Float[3] = floatround( ((100.0 - PTPM_Float[1]) / 4.0) , floatround_floor);
		else
	#endif
	PTPM_Float[3] = floatround( ((100.0 - PTPM_Float[1]) / 2.0) , floatround_floor);
	if(PTPM_Float[3] > (PTPM_Float[2] - 1.0)) PTPM_Float[3] = (PTPM_Float[2] - 1.0);
	else if(PTPM_Float[3] <= 0.0) return PTPM_SendClientMessage(medic, "There is nothing you can do.");
	format(PTPM_String, NUM_STRING_LENGTH, "initial health -- medic:%.0f patient:%.0f medicine:%.0f", PTPM_Float[2], PTPM_Float[1], PTPM_Float[3]);
	PTPM_SendClientMessage(medic, PTPM_String);
	PTPM_SendClientMessage(patient, PTPM_String);
	PTPM_SetPlayerHealth(medic, (PTPM_Float[2] - PTPM_Float[3]));
	#if MAX_PTPM_VEHICLE > 0
		if(PTPM_IsPlayerInAmbulance(medic))
				PTPM_SetPlayerHealth(patient, (PTPM_Float[1] + (PTPM_Float[3] * 4.0)));
		else
	#endif
	PTPM_SetPlayerHealth(patient, (PTPM_Float[1] + (PTPM_Float[3] * 2.0)));
	format(PTPM_String, NUM_STRING_LENGTH, "Special Action: Gave %.0f health to patient.", PTPM_Float[3]);
	PTPM_SendClientMessage(medic, PTPM_String);
	format(PTPM_String, NUM_STRING_LENGTH, "Special Action: You were healed by %.0f health.", PTPM_Float[3]);
	PTPM_SendClientMessage(patient, PTPM_String);
	return true;
}

function PTPM_Yes(playerid)
{
	if(PTPM_Swapclass_Offer_ID == INVALID_PLAYER_ID)
		return PTPM_SendClientMessage(playerid, "Syste: No effect!");
	else if(PTPM_Swapclass_Offer_ID == playerid)
	{
		for(i = 0; Team:i < Team:NUM_TEAMS; i++) PTPM_Team_Player[Team:i] = 0;
		PTPM_Class[PTPM_Old_PM_ID] = PTPM_Class[playerid];
		PTPM_Swapclass_Offer_ID = INVALID_PLAYER_ID;
		PTPM_Class[playerid] = C_PrimeMinister;
		PTPM_Offer_Time[playerid] = 0;
		for(i = 0; i < PTPM_Players; i++)
		{
			PTPM_SpawnPlayer(PTPM_Connected[i]);
		}
		return true;
	}
	return PTPM_SendClientMessage(playerid, "Nothing to accept.");
}

function PTPM_No(playerid)
{
	if(PTPM_Swapclass_Offer_ID == INVALID_PLAYER_ID)
		return PTPM_SendClientMessage(playerid, "Syste: No effect!");
	else if(PTPM_Swapclass_Offer_ID == playerid)
	{
		PTPM_Offer_Time[playerid] = 0;
		PTPM_Swapclass_Offer_ID = INVALID_PLAYER_ID;
		return PTPM_SendClientMessage(PTPM_Old_PM_ID, "Your offer was declined.");
	}
	return PTPM_SendClientMessage(playerid, "Nothing to negate.");
}

function PTPM_SetServerData(data[], string[], bool:show)
{
	static Data[][] =
	{
		{"gamemodetext"},
		{"hostname"},
		{"mapname"},
		{"password"},
		{"rcon_password"},
		{"worldtime"},
		{"weburl"}
	};
	for(i = 0; i < sizeof Data; i++)
		if(!strcmp(data, Data[i], false)) break;
	if(i == sizeof Data)
		printf("Error - Undefined data: PTPM_SetServerData(%s, %s)", data, string);
	else if(!string[0])
		printf("Error - Empty string: PTPM_SetServerData(%s, %s)", data, string);
	else
	{
		format(PTPM_F_String, NUM_STRING_LENGTH, "%s %s", data, string);
		if(show) printf("%s - %s", data, string);
		SendRconCommand(PTPM_F_String);
	}
}

function File:PTPM_OpenOpFile(filemode:mode)
{
	if(!fexist(PTPM_File1))
	{
		#if PTPM_File_System == true
			PTPM_File = fopen(PTPM_File1, io_write);
			fwrite(PTPM_File, "Everyone_Is_Op: false\r\n");
			fwrite(PTPM_File, "Operators\r\n{\r\n}\r\n");
			fwrite(PTPM_File, "Moderators\r\n{\r\n}\r\n");
			fwrite(PTPM_File, "Banned\r\n{\r\n}\r\n");
			fclose(PTPM_File);
		#else
			print("Cant create " PTPM_File1 " while the PTPM_File_System is deactivaed!");
		#endif
	}
	return (PTPM_File = fopen(PTPM_File1, mode));
}

function PTPM_CheckOpFile(playerid, name[], password[], op, bool:show)
{
	if(PTPM_IsEmpty(name))						return false;
	if(PTPM_IsEmpty(password))					return false;
	if(name[NUM_NAME_LENGTH - 2] != EOS)		return false;
	if(password[NUM_NAME_LENGTH - 2] != EOS)	return false;
	switch(op)
	{
		case 0: z = 0;
		case 1: z = 3;
		case 2: z = 0;
		case 3: z = 3;
	}
	PTPM_OpenOpFile(io_read), i = 0;
	format(name, NUM_NAME_LENGTH,		"-%s|", name);
	format(password, NUM_NAME_LENGTH,	"|%s|", password);
	while(fread(PTPM_File, PTPM_Tmp) && !i)
	{
		switch(z)
		{
			case 0: if(strfind(PTPM_Tmp, "Operators", true) != -1) z = 1;
			case 1: if(PTPM_Tmp[0] == '{') z = 2;
			case 2:
				if(strfind(PTPM_Tmp, name, true) != -1)
					if(strfind(PTPM_Tmp, password, true) != -1)
						if(strfind(PTPM_Tmp, "|true-", true) != -1) i = 2;
						else i = 10;
					else i = 11;
				else if(PTPM_Tmp[0] == '}')
					if(!op) i = 30;
					else z = 3;
			case 3: if(strfind(PTPM_Tmp, "Moderators", true) != -1) z = 4;
			case 4: if(PTPM_Tmp[0] == '{') z = 5;
			case 5:
				if(strfind(PTPM_Tmp, name, true) != -1)
					if(strfind(PTPM_Tmp, password, true) != -1)
						if(strfind(PTPM_Tmp, "|true-", true) != -1) i = 1;
						else i = 20;
					else i = 21;
				else if(PTPM_Tmp[0] == '}') i = 30;
		}
	}
	fclose(PTPM_File);
	format(password, NUM_NAME_LENGTH,	"%s", password[1]);
	format(name, NUM_NAME_LENGTH,		"%s", name[1]);
	password[strlen(password) - 1] = EOS;
	name[strlen(name) - 1] = EOS;
	if(i == 30 && op == 3)
		return PTPM_CheckOpFile(playerid, name, password, 0, show);
	if(show)
	{
		switch(i)
		{
			case 10, 20:	PTPM_SendClientMessage(playerid, "~r~Account disabled.");
			case 11, 21:	PTPM_SendClientMessage(playerid, "~r~Access denied.");
			case 30:		PTPM_SendClientMessage(playerid, "~r~Account doesnt exist.");
		}
	}
	return i;
}

function PTPM_OnPlayerLogIn(playerid, rest[])
{
	if(PTPM_Logged[playerid] != 0) return PTPM_SendClientMessage(playerid, "You are already logged in!");
	new name[NUM_NAME_LENGTH], password[NUM_NAME_LENGTH];
	PTPM_Parse_Command(rest, name, password, " ");
	switch(PTPM_CheckOpFile(playerid, name, password, 2, true))
	{
		case 0: return PTPM_SendClientMessage(playerid, "Right Usage: /login [name][password]");
		case 1: PTPM_Logged[playerid] = 1, PTPM_Name = "(an moderator)";
		case 2: PTPM_Logged[playerid] = 2, PTPM_Name = "(an operator)";
		default: return false;
	}
	PTPM_Logged_Name[playerid] = name;
	format(PTPM_String, NUM_STRING_LENGTH, "~r~%s (%d) ~w~logged in as ~r~%s ~b~%s", PTPM_PlayerName[playerid], playerid, name, PTPM_Name);
	PTPM_SendClientMessageToAll(PTPM_String);
	format(PTPM_String, NUM_STRING_LENGTH, "You successful logged in as ~r~\"%s\"", name);
	PTPM_SendClientMessage(playerid, PTPM_String);
	return true;
}

function PTPM_OnPlayerLogOut(playerid, rest[])
{
	new name[NUM_NAME_LENGTH], password[NUM_NAME_LENGTH];
	PTPM_Parse_Command(rest, name, password, " ");
	if(strcmp(PTPM_Logged_Name[playerid], name, false) != 0)
		return PTPM_SendClientMessage(playerid, "You cant log out with a different account!");
	switch(PTPM_CheckOpFile(playerid, name, password, 2, true))
	{
		case 0: return PTPM_SendClientMessage(playerid, "Right Usage: /logout [name][password]");
		case 1: PTPM_Logged[playerid] = 0, PTPM_Name = "(an moderator)";
		case 2: PTPM_Logged[playerid] = 0, PTPM_Name = "(an operator)";
		default: return false;
	}
	PTPM_Logged_Name[playerid][0] = EOS;
	format(PTPM_String, NUM_STRING_LENGTH, "~r~%s (%d) ~w~logged out as ~r~%s ~b~%s", PTPM_PlayerName[playerid], playerid, name, PTPM_Name);
	PTPM_SendClientMessageToAll(PTPM_String);
	format(PTPM_String, NUM_STRING_LENGTH, "You successful logged out as ~r~\"%s\"", name);
	PTPM_SendClientMessage(playerid, PTPM_String);
	return true;
}

function PTPM_DisableLogin(playerid, rest[])
{
	new name[NUM_NAME_LENGTH], password[NUM_NAME_LENGTH];
	PTPM_Parse_Command(rest, name, password, " ");
	switch(PTPM_CheckOpFile(playerid, name, password, 2, true))
	{
		case 0: return PTPM_SendClientMessage(playerid, "Right Usage: /disablelogin [name][password]");
		case 1: PTPM_Name = "moderator";
		case 2: PTPM_Name = "operator";
		default: return false;
	}
	for(i = 0; i < PTPM_Players; i++)
		if(!strcmp(PTPM_Logged_Name[PTPM_Connected[i]], name, true))
		{
			PTPM_OnPlayerLogOut(PTPM_Connected[i], rest);
			break;
		}
	#if PTPM_File_System == true
		format(PTPM_String, NUM_STRING_LENGTH, "~r~%s disabled %s account %s.", PTPM_PlayerName[playerid], PTPM_Name, name);
		PTPM_SendClientMessageToAll(PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH, "You disabled the user ~r~\"%s\"", name);
		PTPM_SendClientMessage(playerid, PTPM_String);
		format(PTPM_Tmp, NUM_STRING_LENGTH,		"-%s|%s|true-", name, password);
		format(PTPM_String, NUM_STRING_LENGTH,	"\t-%s|%s|false-\r\n", name, password);
		PTPM_freplace(0, PTPM_Tmp, PTPM_String);
	#else
		PTPM_SendClientMessage(playerid, PTPM_System_Name ": You cant disable this account because the PTPM_FILE_SYSTEM is deactivaed!");
	#endif
	return true;
}

function PTPM_EnableLogin(playerid, rest[])
{
	format(PTPM_Name, NUM_STRING_LENGTH, rest);
	PTPM_String[0] = '1', PTPM_String[22] = EOS;
	switch(PTPM_CheckOpFile(playerid, PTPM_Name, PTPM_String, 2, false))
	{
		case 0: return PTPM_SendClientMessage(playerid, "Right Usage: /enablelogin [name]");
		case 20, 21, 1: PTPM_Name = "moderator";
		case 10, 11, 2: PTPM_Name = "operator";
		case 30: return PTPM_SendClientMessage(playerid, "~r~Account doesnt exist.");
	}
	#if PTPM_File_System == true
		format(PTPM_String, NUM_STRING_LENGTH, "~r~%s enabled %s account %s.", PTPM_PlayerName[playerid], PTPM_Name, rest);
		PTPM_SendClientMessageToAll(PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH, "You enabled the user ~r~\"%s\"", rest);
		PTPM_SendClientMessage(playerid, PTPM_String);
		format(PTPM_Tmp, NUM_STRING_LENGTH,		"-%s|", rest);
		for(i = 0, PTPM_Name[0] = EOS; i < 10; i++)
			format(PTPM_Name, NUM_STRING_LENGTH, "%s%c", PTPM_Name, (random(2)) ? (random(10) + '0') : (random(26) + 'A'));
		format(PTPM_String, NUM_STRING_LENGTH,	"\t-%s|%s|true-\r\n", rest, PTPM_Name);
		PTPM_freplace(0, PTPM_Tmp, PTPM_String);
	#else
		PTPM_SendClientMessage(playerid, PTPM_System_Name ": You cant enable this account because the PTPM_FILE_SYSTEM is deactivaed!");
	#endif
	return true;
}

function PTPM_KickCom(playerid, rest[])
{
	PTPM_Parse_Command(rest, PTPM_String, rest, " ");
	if(PTPM_IsEmpty(PTPM_String))
		return PTPM_SendClientMessage(playerid, "Right Usage: /kick [playerid]");
	PTPM_GetIDEx(playerid, PTPM_String, i);
	return PTPM_Kick(i, PTPM_PlayerName[playerid], (PTPM_IsEmpty(rest)) ? ("No reason") : (rest), 0);
}

function PTPM_Kick(playerid, kickername[], reason[], rid)
{
	format(PTPM_String, NUM_STRING_LENGTH, "%s was kicked from the server by %s (%s)", PTPM_PlayerName[playerid], kickername, reason);
	PTPM_SendClientMessageToAll(PTPM_String);
	#if PTPM_File_System == true
		if(!fexist(PTPM_File2))		PTPM_File = fopen(PTPM_File2, io_write);
		else						PTPM_File = fopen(PTPM_File2, io_append);
		format(PTPM_String, NUM_STRING_LENGTH, "%s\r\n", PTPM_String);
		fwrite(PTPM_File, PTPM_String), fclose(PTPM_File);
	#endif
	return PTPM_Kick_Ex(playerid, rid);
}

function PTPM_Kick_Ex(playerid, reason)
{
	for(i = 0; i < 10; i++)
		SendClientMessage(playerid, 0xFF7F00FF, "Server closed the connection!");
	PTPM_SendClientMessage(playerid, "~r~~h~~h~~h~~h~Server closed the connection!");
	switch(reason)
	{
		case 1: PTPM_SendClientMessage(playerid,		"~r~You are banlisted!"),
				SendClientMessage(playerid, 0xFFFF00FF,	"~r~You are banlisted!");
		case 2: PTPM_SendClientMessage(playerid,		"~r~Teamkill your self!"),
				SendClientMessage(playerid, 0xFFFF00FF,	"~r~Teamkill your self!");
		case 3: PTPM_SendClientMessage(playerid,		"~r~Gamemode cant support more players!"),
				SendClientMessage(playerid, 0xFFFF00FF,	"~r~Gamemode cant support more players!");
		case 4: PTPM_SendClientMessage(playerid,		"~r~Healhack!"),
				SendClientMessage(playerid, 0xFFFF00FF,	"~r~Healhack!");
		case 5: PTPM_SendClientMessage(playerid,		"~r~Armourhack!"),
				SendClientMessage(playerid, 0xFFFF00FF,	"~r~Armourhack!");
	}
	return Kick(playerid);
}

function PTPM_IpBanCom(playerid, rest[])
{
	PTPM_Parse_Command(rest, PTPM_String, rest, " ");
	if(PTPM_IsEmpty(PTPM_String))
		return PTPM_SendClientMessage(playerid, "Right Usage: /ipban [playerid][reason]");
	PTPM_GetIDEx(playerid, PTPM_String, i);
	format(PTPM_String, NUM_STRING_LENGTH, "%s got ip banned (%s)", PTPM_PlayerName[i], (PTPM_IsEmpty(rest)) ? ("No Reason") : (rest));
	PTPM_SendClientMessage(playerid, PTPM_String);
	return PTPM_RangeBan(i, 4);
}

function PTPM_BanCom(playerid, rest[])
{
	PTPM_Parse_Command(rest, PTPM_String, rest, " ");
	if(PTPM_IsEmpty(PTPM_String)) return PTPM_SendClientMessage(playerid, "Right Usage: /ban [playerid]");
	PTPM_GetIDEx(playerid, PTPM_String, i);
	if(PTPM_IsInt(rest[0]))
	{
		z = strfind(rest, " ", true, 0);
		if(z != -1) rest[z] = EOS;
		z = strval(rest);
	}
	else z = -1;
	return PTPM_Ban(i, playerid, rest, (z != -1) ? (z) : (0));
}
function PTPM_Ban(playerid, bannerid, reason[], time)
{
	#if PTPM_File_System == true
		format(PTPM_String, NUM_STRING_LENGTH, "%s got banlisted by %s (%s)", PTPM_PlayerName[playerid], PTPM_PlayerName[bannerid], reason);
		PTPM_SendClientMessageToAll(PTPM_String);
		if(!fexist(PTPM_File2))		PTPM_File = fopen(PTPM_File2, io_write);
		else						PTPM_File = fopen(PTPM_File2, io_append);
		format(PTPM_String, NUM_STRING_LENGTH, "%s\r\n", PTPM_String);
		fwrite(PTPM_File, PTPM_String);
		fclose(PTPM_File);
		format(PTPM_String, NUM_STRING_LENGTH, "\t-%s|%s|%d-\r\n}\r\n", PTPM_PlayerIp[playerid], PTPM_PlayerName[playerid], time);
		PTPM_freplace(2, "}", PTPM_String);
		PTPM_Kick_Ex(playerid, 1);
	#else
		format(PTPM_String, NUM_STRING_LENGTH, "%s got ban by %s (%s)", PTPM_PlayerName[playerid], PTPM_PlayerName[bannerid], reason);
		PTPM_SendClientMessageToAll(PTPM_String);
		Ban(playerid);
	#endif
	return true;
}

function PTPM_RangeBan(playerid, range)
{
	GetPlayerIp(playerid, PTPM_Name, NUM_IP_LENGTH);
	if(4 < range || range < 1)
	{
		format(PTPM_Name, 32, "banip %s", PTPM_Name);
		return SendRconCommand(PTPM_Name);
	}
	for(i = 0, z = range; PTPM_Name[i] != EOS; i++)
	{
		if(PTPM_Name[i] == '.')
		{
			if(--range)
			{
				while(z < 5)
					PTPM_Name[i] = '.',
					PTPM_Name[i + 1] = '*',
					i += 2, z++;
				format(PTPM_Name, 32, "banip %s", PTPM_Name);
				SendRconCommand(PTPM_Name);
				break;
			}
		}
	}
	return true;
}

function PTPM_GetID(playerid, tmp[], &id)
{
	if(PTPM_IsInt(tmp[0]))
	{
		if((id = PTPM_strval(tmp)) < 0 || id >= INVALID_PLAYER_ID || !IsPlayerConnected(id))
			PTPM_SendClientMessage(playerid, "~r~SYSTEM: Invalid Playerid!"),
			id = SAMP_INVALID_PLAYER_ID;
	}
	else
	{
		if((id = PTPM_GetIDByName(tmp)) == -2)
			PTPM_SendClientMessage(playerid, "SYSTEM: To much matches for this part of name!"),
			id = SAMP_INVALID_PLAYER_ID;
		else if(id == -1)
			PTPM_SendClientMessage(playerid, "SYSTEM: Invalid Playername!"),
			id = SAMP_INVALID_PLAYER_ID;
	}
	return id;
}

function PTPM_KillCom(playerid)
{
	if(PTPM_Class[playerid] == C_PrimeMinister)
		return PTPM_SendClientMessage(playerid, "You cant kill yourself as PM");
	PTPM_SetPlayerHealth(playerid, 0.0);
	return true;
}

#if PTPM_File_System == true
	function PTPM_freplace(count, oldline[], newline[])
	{
		new string[2][NUM_STRING_LENGTH];
		format(string[0], NUM_STRING_LENGTH, oldline);
		format(string[1], NUM_STRING_LENGTH, newline);

		if(!fexist(PTPM_File1)) return false;
		new File:afile = fopen(PTPM_File1, io_read);
		new File:sfile = fopen(PTPM_Temp, io_write);
		while(fread(afile, PTPM_Tmp)) fwrite(sfile, PTPM_Tmp);
		fclose(sfile), fclose(afile);
		fremove(PTPM_File1);

		afile = fopen(PTPM_File1, io_write);
		sfile = fopen(PTPM_Temp, io_read);
		while(fread(sfile, PTPM_Tmp))
		{
			if(strfind(PTPM_Tmp, string[0], true) != -1 && !count--)
				format(PTPM_Tmp, NUM_TMP_LENGTH, "%s", string[1]);
			if(PTPM_Tmp[0] != EOS) fwrite(afile, PTPM_Tmp);
		}
		fclose(afile), fclose(sfile);
		fremove(PTPM_Temp);
		return true;
	}
#endif

function PTPM_PM_Plan_Com(playerid, rest[])
{
	if(PTPM_Side[PTPM_Team[PTPM_Class[playerid]]] != S_Good)
		return PTPM_SendClientMessage(playerid, "You are not allowed to see the plan.");
	if(PTPM_Team[PTPM_Class[playerid]] == T_PrimeMinister)
	{
		if(PTPM_IsEmpty(rest)) return PTPM_SendClientMessage(playerid, "Right Usage: /plan [text]");
		format(PTPM_PM_Plan, NUM_STRING_LENGTH, "~y~Plan: %s!", rest);
		for(i = 0; i < PTPM_Players; i++)
			if(PTPM_Side[PTPM_Team[PTPM_Class[PTPM_Connected[i]]]] == S_Good)
				PTPM_SendClientMessage(PTPM_Connected[i], PTPM_PM_Plan);
	}
	else
	{
		if(PTPM_IsEmpty(PTPM_PM_Plan))
			return PTPM_SendClientMessage(playerid, "You are not allowed to choose the plan.");
		PTPM_SendClientMessage(playerid, PTPM_PM_Plan);
	}
	return true;
}

function PTPM_Me(playerid, rest[])
{
	if(PTPM_Mute[playerid]) return PTPM_SendClientMessage(playerid, "You are muted.");

	format(PTPM_String, NUM_STRING_LENGTH, "*%s*", rest);
	SetPlayerChatBubble(playerid, PTPM_String, PTPM_TeamColorHex(playerid), 100.0, 10_000);
	format(PTPM_String, NUM_STRING_LENGTH, "%s%s%s %s", PTPM_TeamColor(playerid), PTPM_PlayerName[playerid], rest);
	return PTPM_SendClientMessageToAll(PTPM_String);
}

function PTPM_Parse_Command(text[], out[], rest[], const separator[])
{
	if((i = strfind(text, separator)) == -1)
	{
		strmid(out, text, 0, NUM_STRING_LENGTH, NUM_STRING_LENGTH);
		rest[0] = EOS;
		return;
	}
	strmid(out, text, 0, i, NUM_STRING_LENGTH);
	strmid(rest, text, i + 1, NUM_STRING_LENGTH, NUM_STRING_LENGTH);
	return;
}

function PTPM_MuteCom(playerid, rest[])
{
	PTPM_Parse_Command(rest, PTPM_String, rest, " ");
	if(PTPM_IsEmpty(PTPM_String)) return PTPM_SendClientMessage(playerid, "Right Usage: /mute [playerid]");
	PTPM_GetIDEx(playerid, PTPM_String, i);
	if(PTPM_Mute[i])
	{
		format(PTPM_String, NUM_STRING_LENGTH, "%s is already muted.", PTPM_PlayerName[i]);
		return PTPM_SendClientMessage(playerid, PTPM_String);
	}
	if((PTPM_Mute[i] = PTPM_strval(rest)) <= 0) PTPM_Mute[i] = PTPM_Whole_Time - PTPM_Round_Time;
	format(PTPM_String, NUM_STRING_LENGTH, "%s successfully muted for %d seconds.", PTPM_PlayerName[i], PTPM_Mute[i]);
	PTPM_SendClientMessage(playerid, PTPM_String);
	format(PTPM_String, NUM_STRING_LENGTH, "~g~You have been muted by an admin for %d seconds.", PTPM_Mute[i]);
	PTPM_GameTextForPlayer(i, PTPM_String, 6000, 4);
	return true;
}

function PTPM_Unmute(playerid, rest[])
{
	if(PTPM_IsEmpty(rest)) return PTPM_SendClientMessage(playerid, "Right Usage: /unmute [playerid]");
	PTPM_GetIDEx(playerid, rest, i);
	if(!PTPM_Mute[i])
	{
		format(PTPM_String, NUM_STRING_LENGTH, "%s isnt muted.", PTPM_PlayerName[i]);
		return PTPM_SendClientMessage(playerid, PTPM_String);
	}
	PTPM_Mute[i] = false;
	format(PTPM_String, NUM_STRING_LENGTH, "%s successfully unmuted.", PTPM_PlayerName[i]);
	PTPM_SendClientMessage(playerid, PTPM_String);
	format(PTPM_String, NUM_STRING_LENGTH, "~g~You have been unmuted by an admin.");
	PTPM_GameTextForPlayer(i, PTPM_String, 6000, 4);
	return true;
}

function PTPM_Freeze(playerid, rest[])
{
	PTPM_Parse_Command(rest, PTPM_String, rest, " ");
	if(PTPM_IsEmpty(PTPM_String)) return PTPM_SendClientMessage(playerid, "Right Usage: /freeze [playerid]");
	PTPM_GetIDEx(playerid, PTPM_String, i);
	if(!PTPM_Player_Controllable[i])
	{
		format(PTPM_String, NUM_STRING_LENGTH, "%s is already frozen.", PTPM_PlayerName[i]);
		return PTPM_SendClientMessage(playerid, PTPM_String);
	}
	if((PTPM_Player_Freeze_Counter[i] = PTPM_strval(rest)) <= 0) PTPM_Player_Freeze_Counter[i] = PTPM_Whole_Time - PTPM_Round_Time;
	PTPM_TogglePlayerControllable(i, false);
	format(PTPM_String, NUM_STRING_LENGTH, "%s successfully frozen for %d seconds.", PTPM_PlayerName[i], PTPM_Player_Freeze_Counter[i]);
	PTPM_SendClientMessage(playerid, PTPM_String);
	format(PTPM_String, NUM_STRING_LENGTH, "~g~You have been frozen by an admin for %d seconds.", PTPM_Player_Freeze_Counter[i]);
	PTPM_GameTextForPlayer(i, PTPM_String, 6000, 4);
	return true;
}

function PTPM_Unfreeze(playerid, rest[])
{
	if(PTPM_IsEmpty(rest)) return PTPM_SendClientMessage(playerid, "Right Usage: /unfreeze [playerid]");
	PTPM_GetIDEx(playerid, rest, i);
	if(PTPM_Player_Controllable[i])
	{
		format(PTPM_String, NUM_STRING_LENGTH, "%s isnt frozen.", PTPM_PlayerName[i]);
		return PTPM_SendClientMessage(playerid, PTPM_String);
	}
	PTPM_SetPlayerControllable(i, true, 0);
	format(PTPM_String, NUM_STRING_LENGTH, "%s successfully unfrozen.", PTPM_PlayerName[i]);
	PTPM_SendClientMessage(playerid, PTPM_String);
	format(PTPM_String, NUM_STRING_LENGTH, "~g~You have been unfrozen by an admin.");
	PTPM_GameTextForPlayer(i, PTPM_String, 6000, 4);
	return true;
}

function PTPM_TellCom(playerid, rest[])
{
	if(!PTPM_IsPlayerMod(playerid)) return false;
	if(PTPM_IsEmpty(rest))
		return PTPM_SendClientMessage(playerid, "Right Usage: /tell [text]");
	return PTPM_GameTextForAll(rest, 5000, 4);
}

function PTPM_SayCom(playerid, rest[])
{
	if(!PTPM_IsPlayerMod(playerid)) return false;
	if(PTPM_IsEmpty(rest))
		return PTPM_SendClientMessage(playerid, "Right Usage: /say [text]");
	format(PTPM_String, NUM_STRING_LENGTH, "~b~Admin:~r~ %s", rest);
	return PTPM_SendClientMessageToAll(PTPM_String);
}

function PTPM_SpawnPlayer(playerid)
{
	if(PTPM_IsPlayerInAnyVehicle[playerid])
		PTPM_GetPlayerVehicleID[playerid] = INVALID_VEHICLE_ID;
	if(!PTPM_Player_Controllable[playerid])
		PTPM_SetPlayerControllable(i, true, 0);
	SetCameraBehindPlayer(playerid);
	OnPlayerRequestSpawn(playerid);
	SpawnPlayer(playerid);
	return true;
}

function PTPM_TeamCantEnterVehicle(Misc:mod, id, Misc:pas, {Team}:...)
{
	switch(mod)
	{
		case TC_Modelid: {}
		case TC_Vehicleid:
			if(0 > id || id > MAX_PTPM_VEHICLE)
				return printf("PTPM_TeamCantEnterVehicle(%d, %d, %d, ...) - Invalid vehicleid!", _:mod, id, _:pas);
			#if MAX_PTPM_VEHICLE > 0
				else id = PTPM_Vehicle[id][vmodel];
			#else
				else return false;
			#endif
		default: return printf("PTPM_TeamCantEnterVehicle(%d, %d, %d, ...) - Arg 1 must be TC_Modelid or TC_Vehicleid!", _:mod, id, _:pas);
	}
	if(611 < id && id < 400) return printf("PTPM_TeamCantEnterVehicle(%d, %d, %d, ...) - Invalid modelid!", _:mod, id, _:pas);
	switch(pas)
	{
		case TC_Driver:
		{
			for(id -= 400, l = numargs(), i = 3; i < l; i++)
				PTPM_Cant_Enter_Vehicle[Team:getarg(i)][id][0] = true;
		}
		case TC_Passenger:
		{
			for(id -= 400, l = numargs(), i = 3; i < l; i++)
				PTPM_Cant_Enter_Vehicle[Team:getarg(i)][id][1] = true;
		}
		case TC_All:
		{
			for(id -= 400, l = numargs(), i = 3; i < l; i++)
				PTPM_Cant_Enter_Vehicle[Team:getarg(i)][id][0] = true,
				PTPM_Cant_Enter_Vehicle[Team:getarg(i)][id][1] = true;
		}
		default: return false;
	}
	return true;
}

function PTPM_TeamCantUseWeapons(slotid, {Team}:...)
{
	if(11 < slotid && slotid < 0) return printf("PTPM_TeamCantUseWeapons(%d, ...) - Invalid slotid!", slotid);
	for(l = numargs(), i = 1; i < l; i++)
		PTPM_Cant_Use_Weapon[Team:getarg(i)][slotid] = true;
	return true;
}

function PTPM_PlayersCom(playerid)
{
	for(PTPM_String[0] = EOS, i = 0; i <= PTPM_Players; i++)
	{
		if(i == PTPM_Players)
				format(PTPM_String, NUM_STRING_LENGTH, "%s, ~w~%s[%d]", PTPM_String, PTPM_PlayerName[INVALID_PLAYER_ID], INVALID_PLAYER_ID);
		else	format(PTPM_String, NUM_STRING_LENGTH, "%s, %s%s%s[%d]", PTPM_String, PTPM_TeamColor(PTPM_Connected[i]), PTPM_PlayerName[PTPM_Connected[i]], PTPM_Connected[i]);
		if(strlen(PTPM_String) > (NUM_STRING_LENGTH * 0.75))
		{
			format(PTPM_String, NUM_STRING_LENGTH, "Players: %s", PTPM_String[2]);
			PTPM_SendClientMessage(playerid, PTPM_String);
			PTPM_String[0] = EOS;
		}
	}
	if(PTPM_IsEmpty(PTPM_String)) format(PTPM_String, NUM_STRING_LENGTH, ", No one");
	format(PTPM_String, NUM_STRING_LENGTH, "Players: %s", PTPM_String[2]);
	return PTPM_SendClientMessage(playerid, PTPM_String);
}

function PTPM_Ops(playerid)
{
	for(PTPM_String[0] = EOS, i = 0; i <= PTPM_Players; i++)
	{
		if(i == PTPM_Players)
				format(PTPM_String, NUM_STRING_LENGTH, "%s, ~r~%s[%d] ~h~(%s)",
						PTPM_String, PTPM_PlayerName[INVALID_PLAYER_ID], INVALID_PLAYER_ID, PTPM_Logged_Name[INVALID_PLAYER_ID]);
		else if(!PTPM_IsPlayerMod(PTPM_Connected[i])) continue;
		else	format(PTPM_String, NUM_STRING_LENGTH, "%s, %s%s[%d] ~h~(%s)",
						PTPM_String, ((PTPM_IsPlayerOp(PTPM_Connected[i])) ? ("~b~") : ("~g~")),
						PTPM_PlayerName[PTPM_Connected[i]], PTPM_Connected[i], PTPM_Logged_Name[PTPM_Connected[i]]);
		if(strlen(PTPM_String) > (NUM_STRING_LENGTH * 0.75))
		{
			format(PTPM_String, NUM_STRING_LENGTH, "Ops: %s", PTPM_String[2]);
			PTPM_SendClientMessage(playerid, PTPM_String);
			PTPM_String[0] = EOS;
		}
	}
	if(PTPM_IsEmpty(PTPM_String)) format(PTPM_String, NUM_STRING_LENGTH, ", No one");
	format(PTPM_String, NUM_STRING_LENGTH, "Ops: %s", PTPM_String[2]);
	return PTPM_SendClientMessage(playerid, PTPM_String);
}

function PTPM_Weapons(playerid)
{
	for(PTPM_String[0] = EOS, i = 0; i < PTPM_Players; i++)
	{
		if(!PTPM_Spawned[i] || !PTPM_Player_Legal_HeavyWeapon[i]) continue;
		GetPlayerWeaponData(PTPM_Connected[i], 7, z, l);
		if(z == WEAPON_FLAMETHROWER || !l) continue;
		GetWeaponName(z, PTPM_Tmp, NUM_NAME_LENGTH);
		format(PTPM_String, NUM_STRING_LENGTH, "%s, %s%s%s[%d] ~r~%s (%d)", PTPM_String,
			PTPM_TeamColor(PTPM_Connected[i]), PTPM_PlayerName[PTPM_Connected[i]], PTPM_Connected[i] , PTPM_Tmp, l);
		if(strlen(PTPM_String) > (NUM_STRING_LENGTH * 0.75))
		{
			format(PTPM_String, NUM_STRING_LENGTH, "Weps: %s", PTPM_String[2]);
			PTPM_SendClientMessage(playerid, PTPM_String);
			PTPM_String[0] = EOS;
		}
	}
	if(PTPM_IsEmpty(PTPM_String)) format(PTPM_String, NUM_STRING_LENGTH, ", No one");
	format(PTPM_String, NUM_STRING_LENGTH, "Weps: %s", PTPM_String[2]);
	return PTPM_SendClientMessage(playerid, PTPM_String);
}

function PTPM_PInfo(playerid, rest[])
{
	if(PTPM_IsEmpty(rest)) i = playerid;
	else PTPM_GetIDEx(playerid, rest, i);
	GetPlayerPos(i, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
	format(PTPM_String, NUM_STRING_LENGTH,	"Name: %s [%d] cl:%d %s (%.2f,%.2f,%.2f) d:%.2f %s tk:%d %s",
											PTPM_PlayerName[i], i, _:PTPM_Class[i], PTPM_TeamNames(PTPM_Team[PTPM_Class[i]]),
											PTPM_Float[0], PTPM_Float[1], PTPM_Float[2], PTPM_DirectionFromP2P(playerid, i),
											floatpower(PTPM_DistanceFromP2PSquare(playerid, i), 0.5), PTPM_Player_Teamkills[i],
											((PTPM_Player_Legal_HeavyWeapon[i]) ? ("Heavy Weapon") : ("No Heavy Weapon")));
	return PTPM_SendClientMessage(playerid, PTPM_String);
}

stock PTPM_DirectionFromP2P(playerid, toplayer)
{
	if(playerid == toplayer)										 format(PTPM_Name, NUM_NAME_LENGTH, "\"Youself\"");
	else
	{
		new Float:Pos[5];
		PTPM_Name[0] = EOS;
		if(!GetPlayerPos(playerid, Pos[0], Pos[1], Pos[4]))			 return PTPM_Name;
		if(!GetPlayerPos(toplayer, Pos[2], Pos[3], Pos[4]))			 return PTPM_Name;
		Pos[4] = floatpower(((Pos[0] - Pos[2]) * (Pos[0] - Pos[2])) + ((Pos[1] - Pos[3]) * (Pos[1] - Pos[3])), 0.5);
		Pos[4] = Pos[4] * floatsin(22.5, degrees);
		if(((Pos[2] - Pos[0]) * (Pos[2] - Pos[0])) < Pos[4])
			if(Pos[3] > Pos[1])										format(PTPM_Name, NUM_NAME_LENGTH, "North");
			else													format(PTPM_Name, NUM_NAME_LENGTH, "South");
		else if(((Pos[3] - Pos[1]) * (Pos[3] - Pos[1])) < Pos[4])
			if(Pos[2] > Pos[0])										format(PTPM_Name, NUM_NAME_LENGTH, "East");
			else													format(PTPM_Name, NUM_NAME_LENGTH, "West");
		else
		{
			if(Pos[2] > Pos[0])
				if(Pos[3] > Pos[1])									format(PTPM_Name, NUM_NAME_LENGTH, "Northeast");
				else												format(PTPM_Name, NUM_NAME_LENGTH, "Southeast");
			else
				if(Pos[3] > Pos[1])									format(PTPM_Name, NUM_NAME_LENGTH, "Northwest");
				else												format(PTPM_Name, NUM_NAME_LENGTH, "Southwest");
		}
	}
	return PTPM_Name;
}

function PTPM_GetHealth(playerid, rest[])
{
	if(PTPM_IsEmpty(rest)) return PTPM_SendClientMessage(playerid, "Right Usage: /gethealth [playerid]");
	PTPM_GetIDEx(playerid, rest, i);
	GetPlayerHealth(i, PTPM_Float[0]);
	format(PTPM_String, NUM_STRING_LENGTH, "%s's Health: %.2f", PTPM_PlayerName[i], PTPM_Float[0]);
	return PTPM_SendClientMessage(playerid, PTPM_String);
}

function PTPM_SetHealth(playerid, rest[])
{
	PTPM_Parse_Command(rest, PTPM_String, rest, " ");
	if(PTPM_IsEmpty(rest) || PTPM_IsEmpty(PTPM_String)) return PTPM_SendClientMessage(playerid, "Right Usage: /sethealth [playerid][health]");
	PTPM_GetIDEx(playerid, PTPM_String, i);
	PTPM_Float[0] = floatstr(rest);
	if(PTPM_Float[0] > 100.0) PTPM_Float[0] = 100.0;
	PTPM_SetPlayerHealth(i, PTPM_Float[0]);
	format(PTPM_String, NUM_STRING_LENGTH, "%s's Health setted down to %.2f", PTPM_PlayerName[i], PTPM_Float[0]);
	return PTPM_SendClientMessage(playerid, PTPM_String);
}

function PTPM_Force(playerid, rest[])
{
	PTPM_Parse_Command(rest, PTPM_String, rest, " ");
	if(PTPM_IsEmpty(rest) || PTPM_IsEmpty(PTPM_String)) return PTPM_SendClientMessage(playerid, "Right Usage: /force [playerid][text]");
	PTPM_GetIDEx(playerid, PTPM_String, i);
	if(rest[0] == '/')	OnPlayerCommandText(i, rest);
	else				OnPlayerText(i, rest);
	return true;
}

function PTPM_Initialize({Team, Map, _}:...)
{
	for(i = (numargs() - 1); i != -1; i--)
	{
		setarg(i, 0, i);
	}
}

function PTPM_GetMap()
{
	#if MAX_PTPM_SPOINTS > 0
		(Map:z) = PTPM_Map;
		if(GetPlayerPos(PTPM_Old_PM_ID, PTPM_Float[0],PTPM_Float[1], PTPM_Float[2]))
		{
			new Float:Pos[3], posid;
			for(Float:l = INFINITY, i = 0; i != NUM_MAPS; i++)
			{
				posid = PTPM_Team_Map_Data[T_PrimeMinister][Map:i][0];
				Pos[0] = PTPM_Float[0] - PTPM_Team_Data[T_PrimeMinister][posid][TX];
				Pos[1] = PTPM_Float[1] - PTPM_Team_Data[T_PrimeMinister][posid][TY];
				Pos[2] = PTPM_Float[2] - PTPM_Team_Data[T_PrimeMinister][posid][TZ];
				PTPM_Float[3] =	(Pos[0] * Pos[0]) + (Pos[1] * Pos[1]) + (Pos[2] * Pos[2]);
				if(PTPM_Float[3] < Float:l) (Float:l) = PTPM_Float[3], PTPM_Map = Map:i;
			}
		}
		else	while(PTPM_Map == Map:z) PTPM_Map = Map:random(NUM_MAPS);

		if(PTPM_Map != Map:z)
		{
			if(PTPM_Team_Player[T_PrimeMinister] == 0)
					format(PTPM_String, NUM_STRING_LENGTH, "~y~~h~No PM~n~~r~~h~%s", PTPM_MapName());
			else
			{
				switch(PTPM_Map) //Desert - Bayside - Los Santos - San Fierro - Countryside - Las Venturas - Mount Chiliad
				{
					case 0, 4:
						format(PTPM_String, NUM_STRING_LENGTH, "~y~~h~%s ~r~was sighted in the~n~~y~%s~r~!",
									PTPM_PlayerName[PTPM_Old_PM_ID], PTPM_MapName());
					case 1, 6:
						format(PTPM_String, NUM_STRING_LENGTH, "~y~~h~%s ~r~was sighted near~n~~g~%s~r~!",
									PTPM_PlayerName[PTPM_Old_PM_ID], PTPM_MapName());
					case 2, 3, 5:
						format(PTPM_String, NUM_STRING_LENGTH, "~y~~h~%s ~r~was sighted in~n~~b~%s~r~!",
									PTPM_PlayerName[PTPM_Old_PM_ID], PTPM_MapName());
				}
				PTPM_GameTextForAll(PTPM_String, 7500, 4);
				format(PTPM_String, NUM_STRING_LENGTH, "~y~~h~%s(%d)~n~~r~~h~%s",
					PTPM_PlayerName[PTPM_Old_PM_ID], PTPM_Old_PM_ID, PTPM_MapName());
			}
			TextDrawSetString(PTPM_ShowMap, PTPM_String);
		}
	#else
		if(PTPM_Team_Player[T_PrimeMinister] == 0)
				format(PTPM_String, NUM_STRING_LENGTH, "~y~~h~No PM", PTPM_MapName());
		else	format(PTPM_String, NUM_STRING_LENGTH, "~y~~h~%s(%d)", PTPM_PlayerName[PTPM_Old_PM_ID]);
		TextDrawSetString(PTPM_ShowMap, PTPM_String);
	#endif

	SetWorldTime(floatround(floatdiv(PTPM_Round_Time, floatdiv(PTPM_Whole_Time, 24.0))));
	getdate(_:PTPM_Dates[PTPM_Year], _:PTPM_Dates[PTPM_Month], _:PTPM_Dates[PTPM_Day]);

	#if PTPM_Server_Data_Change
		PTPM_ChangeServerData(false);
	#endif
}

function PTPM_AddTimers(time, funcname[]) <Gamemode:passive>
{
	format(PTPM_Timer[PTPM_Timer_Counter], NUM_STRING_LENGTH - 3, funcname);
	PTPM_Timer[PTPM_Timer_Counter][NUM_STRING_LENGTH - 1] = time;
	return (PTPM_Timer_Counter++);
}
public PTPM_AddTimers(time, funcname[]) <> return -1;

function PTPM_ActivateTimers() <Gamemode:passive>
	for(z = 0, l = 1; z != PTPM_Timer_Counter; z++, l++)
		if(PTPM_Timer[z][NUM_STRING_LENGTH - 1] > 0)
#if PTPM_ShowInfo == true
			SetTimerEx("PTPM_StartTimer", (1000 / PTPM_Timer_Counter) * l, false, "ddd", z, PTPM_Timer[z][NUM_STRING_LENGTH - 1], l);
#else
			SetTimerEx("PTPM_StartTimer", (1000 / PTPM_Timer_Counter) * l, false, "ddd", z, PTPM_Timer[z][NUM_STRING_LENGTH - 1]);
#endif
public PTPM_ActivateTimers() <> return;

#if PTPM_ShowInfo == true
	function PTPM_StartTimer(timerid, time, tcount)
		SetTimer(PTPM_Timer[timerid], time, true),
		printf(	"%sPTPM_StartTimer - %s started%s(each %2d sec)%s",
				((tcount == 1) ? ("\r\n") : ("")), PTPM_Timer[timerid],
				(strlen(PTPM_Timer[timerid]) < 14) ? ("\t\t") : ("\t"), time / 1000,
				((tcount == PTPM_Timer_Counter) ? ("\r\n") : ("")));
#else
	function PTPM_StartTimer(timerid, time) SetTimer(PTPM_Timer[timerid], time, true);
#endif

#if PTPM_Server_Data_Change
	function PTPM_ChangeServerData(bool:show)
	{
		i = PTPM_Whole_Time - PTPM_Round_Time;
		z = floatround(floatdiv(i, 60.0), floatround_floor);
		format(PTPM_Tmp, NUM_STRING_LENGTH, "%02d:%02d (No PM)", z, (i - z * 60));

		for(i = 0, PTPM_String[0] = EOS; i < NUM_STRING_LENGTH - 1; i++)
			format(PTPM_String, NUM_STRING_LENGTH, "%s%c", PTPM_String,
				random(2) ? ('0' + random(10)) : ('a' + random(52)));

		if(show) print("\r\n");
		#if defined PTPM_Web_Url
			PTPM_SetServerData("weburl", PTPM_Web_Url, show);
		#endif
		PTPM_SetServerData("mapname", PTPM_MapName(), show);
		#if defined PTPM_Server_Name
			PTPM_SetServerData("hostname", PTPM_Server_Name, show);
		#else
		
		#endif
		PTPM_SetServerData("worldtime", PTPM_Tmp, show);
		PTPM_SetServerData("gamemodetext", PTPM_Mode_Name, show);
		PTPM_SetServerData("rcon_password", PTPM_String, show);
		if(show) print("\r\n");
	}
#endif

function PTPM_GetIDByName(name[])
{
	if(name[0] == EOS || name[1] == EOS || name[2] == EOS) return -1;
	for(z = -1, i = 0; i < PTPM_Players; i++)
	{
		if(PTPM_IsEmpty(PTPM_PlayerName[PTPM_Connected[i]])) continue;
		else if(strfind(PTPM_PlayerName[PTPM_Connected[i]], name, true) != -1)
			if(z != -1) return -2;
			else z = PTPM_Connected[i];
	}
	return z;
}

function PTPM_GetClosestPlayer(playerid)
{
	z = INVALID_PLAYER_ID;
	for(i = 0, PTPM_Float[1] = INFINITY; i < PTPM_Players; i++)
	{
		if(PTPM_Connected[i] == playerid) continue;
		PTPM_Float[0] = PTPM_DistanceFromP2PSquare(playerid, PTPM_Connected[i]);
		if(PTPM_Float[0] < PTPM_Float[1])
		{
			PTPM_Float[1] = PTPM_Float[0];
			z = PTPM_Connected[i];
		}
	}
	return z;
}

function PTPM_ClearWindow(playerid, chat[])
{
	switch(chat[0])
	{
		case 1: for(i = 0; i < 1000; i++) print("");
		#if 0 < MAX_CHATBOX_LINES
			case 2: for(i = 0; i < MAX_CHATBOX_LINES; i++) PTPM_SendClientMessageToAll(" ");
		#endif
		case 3: for(i = 0; i < 100; i++) SendClientMessage(playerid, 0, " ");
		#if 0 < MAX_PRIVAT_CHATBOX_LINES
			case 4: for(i = 0; i < MAX_PRIVAT_CHATBOX_LINES; i++) PTPM_SendClientMessage(playerid, " ");
		#endif
		default: return false;
	}
	return true;
}

function PTPM_RoundTick() <> return;
public PTPM_RoundTick() <Gamemode:restart>
{
	format(PTPM_String, NUM_STRING_LENGTH, "~w~Restart in ~r~%2d~w~ seconds!", --PTPM_Restart_Count_Ex);
	for(i = 0; i < PTPM_Players; i++)
		PTPM_SendClientMessage(PTPM_Connected[i], PTPM_String);
	PTPM_SendClientMessage(INVALID_PLAYER_ID, PTPM_String);
	if(!PTPM_Restart_Count_Ex)
	{
		PTPM_SendClientMessageToAll(" ");
		PTPM_SendClientMessageToAll("~b~~h~~h~~h~Game mode restarting..");
		PTPM_Reset(0, false);
	}
}
public PTPM_RoundTick() <Gamemode:active>
{
	gettime(_:PTPM_Dates[PTPM_Hour], _:PTPM_Dates[PTPM_Minute], _:PTPM_Dates[PTPM_Second]);
	if(PTPM_Round_Time == PTPM_Whole_Time || (PTPM_Old_PM_ID == INVALID_PLAYER_ID && PTPM_Team_Player[T_PrimeMinister] > 0))
	{
		if(PTPM_Old_PM_ID == INVALID_PLAYER_ID)
				PTPM_GameTextForAll("No one took the Prime Minister :(", 5000, 4);
		else	PTPM_GameTextForAll("The Prime Minister survived!", 5000, 4);
		PTPM_Team_Player[T_PrimeMinister] = 0;
		PTPM_Reset(PTPM_Restart_Count, true);
		PTPM_Round_Time = false;
		return;
	}

	if(PTPM_Team_Player[T_PrimeMinister] > 0)
	{
		PTPM_Round_Time++;
		i = PTPM_Whole_Time - PTPM_Round_Time;
		z = floatround(i / 60, floatround_floor);
		format(PTPM_String, NUM_STRING_LENGTH, "%02d:%02d", z, (i - z * 60));
		TextDrawSetString(PTPM_Clock, PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH, "%s (%s)",
				PTPM_String, PTPM_PlayerName[PTPM_Old_PM_ID]);
		PTPM_SetServerData("worldtime", PTPM_String, false);
		PTPM_String[0] = EOS;
	}

	if(PTPM_PM_Timeouted > 0)
	{
		if(PTPM_IsEmpty(PTPM_PM_Name)) PTPM_PM_Timeouted = 0;
		else
		{
			format(PTPM_String, NUM_STRING_LENGTH,	"~r~PrimeMinister %s timeouted, waiting for rejoin - %3d seconds left",
													PTPM_PM_Name, PTPM_PM_Timeouted--);
			for(i = 0; i < PTPM_Players; i++)
				PTPM_SendClientMessage(PTPM_Connected[i], PTPM_String);
			PTPM_SendClientMessage(INVALID_PLAYER_ID, PTPM_String);
			if(!PTPM_PM_Timeouted)
			{
				format(PTPM_String, NUM_STRING_LENGTH, "~r~PrimeMinister %s couldnt come back in time", PTPM_PM_Name);
				for(i = 0; i < PTPM_Players; i++)
					PTPM_SendClientMessage(PTPM_Connected[i], PTPM_String);
				PTPM_SendClientMessage(INVALID_PLAYER_ID, PTPM_String);
				PTPM_PM_Name[0] = EOS;
			}
		}
	}

	if(PTPM_Kill_Spee_Time > 0)
		if(!--PTPM_Kill_Spee_Time)
			format(PTPM_Tmp, NUM_TMP_LENGTH, "~y~%s", PTPM_Mode_Name),
			TextDrawSetString(PTPM_Max_Kills_Text, PTPM_Tmp);
}

function PTPM_Loop() <> return;
public PTPM_Loop() <Gamemode:active>
{
	for(i = 0, z = 0; i < PTPM_Players; i++)
	{
		if(!PTPM_Spawned[PTPM_Connected[i]]) continue;
		else if(!GetPlayerHealth(PTPM_Connected[i], PTPM_Float[0]))
		{
			OnPlayerDisconnect(PTPM_Connected[i], 3);
			continue;
		}

		if(PTPM_Team_Player[T_PrimeMinister] > 0)
		{
			if(PTPM_Player_Freeze_Counter[PTPM_Connected[i]] > 0)
				PTPM_Player_Freeze_Counter[PTPM_Connected[i]]--;
			else if(!PTPM_Player_Freeze_Counter[PTPM_Connected[i]] && !PTPM_Player_Controllable[PTPM_Connected[i]])
				PTPM_SetPlayerControllable(PTPM_Connected[i], true, 0);

			if(PTPM_Mute[PTPM_Connected[i]] > 0) PTPM_Mute[PTPM_Connected[i]]--;
		}
		#if 0 < MAX_PRIVAT_CHATBOX_LINES
			for(l = 0; l < MAX_PRIVAT_CHATBOX_LINES; l++)
				if(PTPM_Privat_Chatbox_Time[l][PTPM_Connected[i]] > 0)
					if(!--PTPM_Privat_Chatbox_Time[l][PTPM_Connected[i]])
						TextDrawSetString(PTPM_Privat_Chatbox[l][PTPM_Connected[i]], " "),
						format(PTPM_Privat_Chatbox_Line[l][PTPM_Connected[i]], NUM_STRING_LENGTH, " ");
		#endif

		if(PTPM_Float[0] > PTPM_Player_Data[PTPM_Connected[i]][phealth])
			if(PTPM_Money[PTPM_Connected[i]] > (z = GetPlayerMoney(PTPM_Connected[i]))) PTPM_Money[PTPM_Connected[i]] = z;
			else
			{
				#if PTPM_Debug == true
					format(PTPM_String, NUM_STRING_LENGTH, "Healhack: %s(%d) SH: %f RH: %f",
							PTPM_PlayerName[PTPM_Connected[i]], PTPM_Connected[i], PTPM_Player_Data[PTPM_Connected[i]][phealth], PTPM_Float[0]);
					PTPM_SendClientMessageToAdmin(PTPM_String);
				#endif
				PTPM_Kick(PTPM_Connected[i], PTPM_System_Name, "Healhack", 4);
				continue;
			}

		if(PTPM_Float[0] < 100.0)
		{
			#if MAX_PTPM_VEHICLE > 0
				if(PTPM_IsPlayerInAmbulance(PTPM_Connected[i]))
						PTPM_SetPlayerHealth(PTPM_Connected[i], PTPM_Float[0] + 1.0);
			#endif
			if(!--PTPM_Health_Counter[PTPM_Connected[i]])
				if(PTPM_Class[PTPM_Connected[i]] == C_PrimeMinister)
						PTPM_Health_Counter[PTPM_Connected[i]] = floatround(floatdiv(1.0, PTPM_PM_Health_Bonus)),
						PTPM_SetPlayerHealth(PTPM_Connected[i], PTPM_Float[0] + 1.0);
				else if(PTPM_IsMedic(PTPM_Connected[i]))
						PTPM_Health_Counter[PTPM_Connected[i]] = floatround(floatdiv(1.0, PTPM_Medic_Health_Bonus)),
						PTPM_SetPlayerHealth(PTPM_Connected[i], PTPM_Float[0] + 1.0);
				else	PTPM_Health_Counter[PTPM_Connected[i]] = floatround(floatdiv(1.0, PTPM_Player_Health_Bonus)),
						PTPM_SetPlayerHealth(PTPM_Connected[i], PTPM_Float[0] + 1.0);
		}

		if(GetPlayerArmour(PTPM_Connected[i], PTPM_Float[0]) && PTPM_Float[0] > PTPM_Player_Data[PTPM_Connected[i]][parmour])
			if(PTPM_Money[PTPM_Connected[i]] > (z = GetPlayerMoney(PTPM_Connected[i]))) PTPM_Money[PTPM_Connected[i]] = z;
			else
			{
				#if PTPM_Debug == true
					format(PTPM_String, NUM_STRING_LENGTH, "Armourhack: %s(%d) SA: %f RA: %f",
							PTPM_PlayerName[PTPM_Connected[i]], PTPM_Connected[i], PTPM_Player_Data[PTPM_Connected[i]][parmour], PTPM_Float[0]);
					PTPM_SendClientMessageToAdmin(PTPM_String);
				#endif
				PTPM_Kick(PTPM_Connected[i], PTPM_System_Name, "Armourhack", 5);
				continue;
			}

		if(GetVehicleHealth(PTPM_GetPlayerVehicleID[PTPM_Connected[i]], PTPM_Float[0]))
		{
			if(PTPM_TextDrawActive[PTPM_Connected[i]][PTPM_Healthbar])
			{
				PTPM_Float[1] = PTPM_Float[0] - 250;
				if(PTPM_Float[1] <= 0.0) TextDrawHideForPlayer(PTPM_Connected[i], PTPM_Healthbar);
				else
				{
					TextDrawTextSize(PTPM_Healthbar, (551.2 + (PTPM_Float[1] * 0.0702666667)), 1.0); // x * 52.7 / 750.0
					TextDrawShowForPlayer(PTPM_Connected[i], PTPM_Healthbar);
				}
			}
			if(PTPM_Float[0] < PTPM_PlayerVehicleHealth[PTPM_Connected[i]])
			{
				PTPM_Float[1] = floatround(((PTPM_PlayerVehicleHealth[PTPM_Connected[i]] - PTPM_Float[0]) / 200), floatround_floor);
				if(PTPM_Float[1] > 0.0)
				{
					GetPlayerHealth(PTPM_Connected[i], PTPM_Float[2]);
					PTPM_SetPlayerHealth(PTPM_Connected[i], PTPM_Float[2] - PTPM_Float[1]);
				}
			}
			PTPM_PlayerVehicleHealth[PTPM_Connected[i]] = PTPM_Float[0];
		}

		#if MAX_PTPM_PICKUPS > 0 && MAX_PTPM_WEAPONS > 0
			for(z = 0; z < PTPM_Pickup_Counter; z++)
			{
				#if PTPM_Pickup_Stream_Radius > 0
					if(PTPM_Pickup[z][PWP] == -1 || !PTPM_Pickup[z][pactive]) continue;
				#else
					if(PTPM_Pickup[z][PWP] == -1) continue;
				#endif
				if(PTPM_Weapon[PTPM_Pickup[z][PWP]][Wait] > 0) PTPM_Weapon[PTPM_Pickup[z][PWP]][Wait]--;
				#if defined IsPlayerInRangeOfPoint //0.3
					if(IsPlayerInRangeOfPoint(PTPM_Connected[i], 1.5, PTPM_Pickup[z][PX], PTPM_Pickup[z][PY], PTPM_Pickup[z][PZ]))
				#else
					GetPlayerPos(PTPM_Connected[i], PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
					if(PTPM_PointToPoint(PTPM_Float, 1.5, PTPM_Pickup[z][PX], PTPM_Pickup[z][PY], PTPM_Pickup[z][PZ]))
				#endif
				{
					PTPM_OnPlayerPickUpWeaponPickup(PTPM_Connected[i], PTPM_Pickup[z][PWP], z);
					break;
				}
			}
		#endif

		if(PTPM_Swapclass_Offer_ID == PTPM_Connected[i])
			if(PTPM_Offer_Time[PTPM_Connected[i]] > 0)
			{
				if(--PTPM_Offer_Time[PTPM_Connected[i]] <= 10)
					format(PTPM_String, NUM_STRING_LENGTH, "Time left to choice: ~r~%d", PTPM_Offer_Time[PTPM_Connected[i]]),
					PTPM_SendClientMessage(PTPM_Connected[i], PTPM_String);
			}
			else if(PTPM_Offer_Time[PTPM_Connected[i]] == 0)
				PTPM_Swapclass_Offer_ID = INVALID_PLAYER_ID,
				PTPM_SendClientMessage(PTPM_Connected[i], "Your offer was declined.");

		#if MAX_PTPM_PICKUPS > 0 && MAX_PTPM_BCUBOID > 0
			for(z = 0; z < PTPM_Banned_Cuboid_Counter; z++)
			{
				if(!PTPM_Banned_Cuboid[z][BVehicle] && PTPM_IsPlayerInAnyVehicle[PTPM_Connected[i]]) continue;
				#if defined IsPlayerInRangeOfPoint //0.3
					if(IsPlayerInRangeOfPoint(PTPM_Connected[i], 1.5, PTPM_Banned_Cuboid[z][BCX], PTPM_Banned_Cuboid[z][BCY], PTPM_Banned_Cuboid[z][BCZ]))
				#else
					GetPlayerPos(PTPM_Connected[i], PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
					if(PTPM_PointToPoint(PTPM_Float, 1.5, PTPM_Banned_Cuboid[z][BCX], PTPM_Banned_Cuboid[z][BCY], PTPM_Banned_Cuboid[z][BCZ]))
				#endif
				{
					PTPM_Activate_Banned_Cuboid(PTPM_Connected[i], z);
					break;
				}
			}
		#endif

		if(		GetPlayerWeaponData(PTPM_Connected[i], 7, z, l) && l > 0 && z != 37
				&& !PTPM_Player_Legal_HeavyWeapon[PTPM_Connected[i]])
		{
			GetWeaponName(z, PTPM_String, NUM_NAME_LENGTH),
			format(PTPM_String, NUM_STRING_LENGTH, "Weaponhack: %s", PTPM_String),
			PTPM_Kick(PTPM_Connected[i], PTPM_System_Name, PTPM_String, 0);
			continue;
		}

	}
}

#if PTPM_Pickup_Stream_Radius > 0 && MAX_PTPM_PICKUPS > 0
	function PTPM_Pickup_S() <> return;
	public PTPM_Pickup_S() <Gamemode:active>
	{
		if(PTPM_Players == 0) return;
		for(i = 0, z = 0, l = false; z < PTPM_Pickup_Counter; z++, l = false)
		{
			if(PTPM_S_Pickup_Counter < MAX_PICKUPS)
			{
				for(i = 0; i < PTPM_Players; i++)
				{
					if(!PTPM_Spawned[i]) continue;
					#if defined IsPlayerInRangeOfPoint //0.3
						if(IsPlayerInRangeOfPoint(PTPM_Connected[i], PTPM_Pickup_Stream_Radius, PTPM_Pickup[z][PX], PTPM_Pickup[z][PY], PTPM_Pickup[z][PZ]))
					#else
						GetPlayerPos(PTPM_Connected[i], PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
						if(PTPM_PointToPoint(PTPM_Float, PTPM_Pickup_Stream_Radius, PTPM_Pickup[z][PX], PTPM_Pickup[z][PY], PTPM_Pickup[z][PZ]))
					#endif
					{
						l = true;
						break;
					}
				}
			}
			switch(l)
			{
				case true:
				{
					if(!PTPM_Pickup[z][pactive] && PTPM_S_Pickup_Counter < MAX_PICKUPS - 1)
					{
						PTPM_Pickup[z][pid] = CreatePickup(	PTPM_Pickup[z][pmodel],
															PTPM_Pickup[z][ptype],
															PTPM_Pickup[z][PX],
															PTPM_Pickup[z][PY],
															PTPM_Pickup[z][PZ]);
						PTPM_GetPickupNumber[PTPM_Pickup[z][pid]] = z;
						PTPM_Pickup[z][pactive] = true;
						PTPM_S_Pickup_Counter++;
						#if PTPM_Debug == true
							format(PTPM_String, NUM_STRING_LENGTH, "%d/%d ~g~Create ~r~Pickup %d",
									PTPM_S_Pickup_Counter, PTPM_Pickup_Counter - 1, z);
							PTPM_SendClientMessageToAdmin(PTPM_String);
						#endif
					}
				}
				case false:
				{
					if(PTPM_DestroyPickup(z))
					{
						#if PTPM_Debug == true
							format(PTPM_String, NUM_STRING_LENGTH, "%d/%d ~r~Destroy ~r~Pickup %d",
									PTPM_S_Pickup_Counter, PTPM_Pickup_Counter - 1, z);
							PTPM_SendClientMessageToAdmin(PTPM_String);
						#endif
					}
				}
			}
		}
	}
#endif

#if PTPM_Object_Stream_Radius > 0 && MAX_PTPM_OBJECTS > 0
	function PTPM_Object_S() <> return;
	public PTPM_Object_S() <Gamemode:active>
	{
		if(PTPM_Players == 0) return;
		for(i = 0; i < PTPM_Players; i++)
		{
			if(!PTPM_Spawned[i]) continue;
			#if !defined IsPlayerInRangeOfPoint //0.3
				GetPlayerPos(PTPM_Connected[i], PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
			#endif
			for(z = 0; z < PTPM_Object_Counter; z++)
			{
				#if defined IsPlayerInRangeOfPoint //0.3
					if(IsPlayerInRangeOfPoint(PTPM_Connected[i], PTPM_Object_Stream_Radius, PTPM_Object[z][OX], PTPM_Object[z][OY], PTPM_Object[z][OZ]))
				#else
					if(PTPM_PointToPoint(PTPM_Float, PTPM_Object_Stream_Radius, PTPM_Object[z][OX], PTPM_Object[z][OY], PTPM_Object[z][OZ]))
				#endif
				{
					if(PTPM_S_Object_Counter < MAX_OBJECTS && !PTPM_Player_Object[PTPM_Connected[i]][z][oactive])
					{
						PTPM_Player_Object[PTPM_Connected[i]][z][oid] = CreatePlayerObject(PTPM_Connected[i],
																					PTPM_Object[z][omodel],
																					PTPM_Object[z][OX],
																					PTPM_Object[z][OY],
																					PTPM_Object[z][OZ],
																					PTPM_Object[z][OrX],
																					PTPM_Object[z][OrY],
																					PTPM_Object[z][OrZ]);
						PTPM_Player_Object[PTPM_Connected[i]][z][oactive] = true;
						PTPM_S_Object_Counter++;

						#if PTPM_Debug == true
							format(PTPM_String, NUM_STRING_LENGTH, "%d/%d ~g~Create Player(%d) ~p~Object %d",
									PTPM_S_Object_Counter, PTPM_Object_Counter - 1, PTPM_Connected[i], z);
							PTPM_SendClientMessageToAdmin(PTPM_String);
						#endif
					}
				}
					else
				{
					if(PTPM_DestroyPlayerObject(PTPM_Connected[i], z))
					{
						#if PTPM_Debug == true
							format(PTPM_String, NUM_STRING_LENGTH, "%d/%d ~r~Destroy Player(%d) ~p~Object %d",
									PTPM_S_Object_Counter, PTPM_Object_Counter - 1, PTPM_Connected[i], z);
							PTPM_SendClientMessageToAdmin(PTPM_String);
						#endif
					}
				}
			}
		}
	}
#endif

#if PTPM_Vehicle_Stream_Radius > 0 && MAX_PTPM_VEHICLE > 0
	function PTPM_Vehicle_S() <> return;
	public PTPM_Vehicle_S() <Gamemode:active>
	{
		if(PTPM_Players == 0) return;
		for(i = 0, z = 0, l = false; z < PTPM_Vehicle_Counter; z++, l = false)
		{
			if(PTPM_Vehicle[z][vused]) continue;
			if(PTPM_S_Vehicle_Counter < MAX_VEHICLES)
			{
				for(i = 0; i < PTPM_Players; i++)
				{
					if(!PTPM_Spawned[i]) continue;
					#if defined IsPlayerInRangeOfPoint //0.3
						if(IsPlayerInRangeOfPoint(PTPM_Connected[i], PTPM_Vehicle_Stream_Radius, PTPM_Vehicle[z][VCX], PTPM_Vehicle[z][VCY], PTPM_Vehicle[z][VCZ]))
					#else
						GetPlayerPos(PTPM_Connected[i], PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
						if(PTPM_PointToPoint(PTPM_Float, PTPM_Vehicle_Stream_Radius, PTPM_Vehicle[z][VCX], PTPM_Vehicle[z][VCY], PTPM_Vehicle[z][VCZ]))
					#endif
					{
						l = true;
						break;
					}
				}
			}
			switch(l)
			{
				case true:
				{
					if(!PTPM_Vehicle[z][vactive] && PTPM_S_Vehicle_Counter < MAX_VEHICLES - 1)
					{
						PTPM_Vehicle[z][vid] = CreateVehicle(	PTPM_Vehicle[z][vmodel],
																PTPM_Vehicle[z][VCX],
																PTPM_Vehicle[z][VCY],
																PTPM_Vehicle[z][VCZ],
																PTPM_Vehicle[z][VCA],
																-1, -1, -1);
						SetVehicleHealth(PTPM_Vehicle[z][vid], PTPM_Vehicle[z][VCH]);
						PTPM_GetVehicleNumber[PTPM_Vehicle[z][vid]] = z;
						PTPM_Vehicle[z][vactive] = true;
						PTPM_S_Vehicle_Counter++;
						#if PTPM_Debug == true
							format(PTPM_String, NUM_STRING_LENGTH, "%d/%d ~g~Create ~b~Vehicle %d",
									PTPM_S_Vehicle_Counter, PTPM_Vehicle_Counter - 1, z);
							PTPM_SendClientMessageToAdmin(PTPM_String);
						#endif
					}
				}
				case false:
				{
					if(PTPM_DestroyVehicle(z))
					{
						#if PTPM_Debug == true
							format(PTPM_String, NUM_STRING_LENGTH, "%d/%d ~r~Destroy ~b~Vehicle %d",
									PTPM_S_Vehicle_Counter, PTPM_Vehicle_Counter - 1, z);
							PTPM_SendClientMessageToAdmin(PTPM_String);
						#endif
					}
				}
			}
		}
	}
#endif

function PTPM_ArmourForHealth(playerid)
{
	if(PTPM_Team[PTPM_Class[playerid]] != T_Bodyguard) return PTPM_SendClientMessage(playerid, "Special Action: You need to be a bodyguard");
	GetPlayerArmour(playerid, PTPM_Float[3]);
	if(PTPM_Float[3] >= 100.0) return PTPM_SendClientMessage(playerid, "Special Action: You already have full armour");
	PTPM_Float[2] = 100.0 - PTPM_Float[3];
	PTPM_SetPlayerArmour(playerid, PTPM_Float[3] + PTPM_Float[2]);
	PTPM_Float[0] = PTPM_Float[2] / 2;
	GetPlayerHealth(playerid, PTPM_Float[3]);
	PTPM_SetPlayerHealth(playerid, PTPM_Float[3] - PTPM_Float[0]);
	format(PTPM_String, NUM_STRING_LENGTH,	"~r~Special Action: %s immolated %.1f health for %.1f armour.",
											PTPM_PlayerName[playerid], PTPM_Float[0], PTPM_Float[2]);
	for(i = 0; i < PTPM_Players; i++) if(PTPM_Side[PTPM_Team[PTPM_Class[PTPM_Connected[i]]]] == S_Good) PTPM_SendClientMessage(PTPM_Connected[i], PTPM_String);
	return true;
}

function PTPM_Sacrifice(playerid)
{
	if(PTPM_Team[PTPM_Class[playerid]] != T_Terrorist) return PTPM_SendClientMessage(playerid, "Special Action: You need to be a terrorist");
	GetPlayerHealth(playerid, PTPM_Float[3]);
	if(PTPM_Float[3] < 50.0) return PTPM_SendClientMessage(playerid, "Special Action: Your health must be over 50%");
	GetPlayerPos(playerid, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
	CreateExplosion(PTPM_Float[0], PTPM_Float[1], PTPM_Float[2], 4, 15.0 + float(random(50)));
	format(PTPM_String, NUM_STRING_LENGTH, "~r~Special Action: %s sacrifice hisself for a greater doing", PTPM_PlayerName[playerid]);
	for(i = 0; i < PTPM_Players; i++) if(PTPM_Side[PTPM_Team[PTPM_Class[PTPM_Connected[i]]]] == S_Bad) PTPM_SendClientMessage(PTPM_Connected[i], PTPM_String);
	return true;
}

function PTPM_ImmediateSupport(playerid)
{
	if(PTPM_Team[PTPM_Class[playerid]] != T_Cop) return PTPM_SendClientMessage(playerid, "Special Action: You need to be a cop");
	z = INVALID_PLAYER_ID;
	for(i = 0, PTPM_Float[1] = INFINITY; i < PTPM_Players; i++)
		if(PTPM_Team[PTPM_Class[PTPM_Connected[i]]] != T_Cop) continue;
		else if((PTPM_Float[0] = PTPM_DistanceFromP2PSquare(playerid, PTPM_Connected[i])) < PTPM_Float[1])
			PTPM_Float[1] = PTPM_Float[0], z = PTPM_Connected[i];
	if(z == playerid) return PTPM_SendClientMessage(playerid, "Special Action: You are the closest cop, abort");
	GetPlayerPos(z, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
	SetPlayerPos(playerid, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
	GetPlayerHealth(playerid, PTPM_Float[3]);
	PTPM_SetPlayerHealth(playerid, PTPM_Float[3] / 2);
	format(PTPM_String, NUM_STRING_LENGTH, "~r~Special Action: %s immolated %.1f health to move through room and time", PTPM_PlayerName[playerid]);
	for(i = 0; i < PTPM_Players; i++) if(PTPM_Side[PTPM_Team[PTPM_Class[PTPM_Connected[i]]]] == S_Good) PTPM_SendClientMessage(PTPM_Connected[i], PTPM_String);
	return true;
}


#if MAX_PTPM_PICKUPS > 0 && MAX_PTPM_WEAPONS > 0
	function PTPM_OnPlayerPickUpWeaponPickup(playerid, weaponid, pickupid)
	{
		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "PTPM_OnPlayerPickUpWeaponPickup(%d, %d, %d)", playerid, weaponid, pickupid);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		if(PTPM_Cant_Use_Weapon[PTPM_Team[PTPM_Class[playerid]]][PTPM_Weapon[weaponid][slot]])
		{
			GameTextForPlayer(playerid, "~w~You are ~r~not qualified~w~~n~to use this weapon!", 900, 4);
			return;
		}
		else if(PTPM_Weapon[weaponid][Wait] > 0)
		{
			format(PTPM_String, NUM_STRING_LENGTH,	"~w~RESPAWNS IN ~r~%d SECONDS ~n~ \
													~w~LAST USED BY ~y~%s",
													PTPM_Weapon[weaponid][Wait],
													PTPM_PlayerName[PTPM_Weapon[weaponid][ID]]
													);
			PTPM_GameTextForPlayer(playerid, PTPM_String, 900, 3);
		}
		else if(PTPM_Weapon[weaponid][Wait] == -1)
		{
			format(PTPM_String, NUM_STRING_LENGTH,	"~w~ALREADY TAKEN~n~ \
													~w~LAST USED BY ~y~%s",
													PTPM_PlayerName[PTPM_Weapon[weaponid][ID]]
													);
			PTPM_GameTextForPlayer(playerid, PTPM_String, 900, 3);
		}
		else
		{
			PlayerPlaySound(playerid, 1150,	PTPM_Pickup[pickupid][PX], PTPM_Pickup[pickupid][PY], PTPM_Pickup[pickupid][PZ] + 2);
			if(PTPM_Weapon[weaponid][HeavyWeapon])
			{
				switch(PTPM_Pickup[pickupid][pmodel])
				{
					case 362: format(PTPM_String, NUM_STRING_LENGTH, "~w~%s has the ~y~minigun!", PTPM_PlayerName[playerid]);
					case 360: format(PTPM_String, NUM_STRING_LENGTH, "~w~%s has the ~y~heat seeker!", PTPM_PlayerName[playerid]);
					case 359: format(PTPM_String, NUM_STRING_LENGTH, "~w~%s has the ~y~rocket launcher!", PTPM_PlayerName[playerid]);
					default: return;
				}
				PTPM_Player_Legal_HeavyWeapon[playerid] = true;
				GameTextForAll(PTPM_String, 3000, 4);
			}
			GivePlayerWeapon(playerid, PTPM_Weapon[weaponid][Weapon], PTPM_Weapon[weaponid][Ammo]);
			if(PTPM_Weapon[weaponid][Delay] < 1) PTPM_Weapon[weaponid][Wait] = -1;
			else PTPM_Weapon[weaponid][Wait] = PTPM_Weapon[weaponid][Delay];
			PTPM_Weapon[weaponid][ID] = playerid;
		}
	}
#endif

function PTPM_OnPlayerPickUpKit(playerid, pickupid, pickupmodel)
{
	#if PTPM_Debug == true
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerPickupKit(%d, %d, %d)", playerid, pickupid, pickupmodel);
		PTPM_SendClientMessageToAdmin(PTPM_String);
	#endif

	switch(pickupmodel)
	{
		case PICKUP_ARMOR:	PTPM_Player_Data[playerid][parmour] = 100.0;
		case PICKUP_HEART:	PTPM_Player_Data[playerid][phealth] = 100.0;
		default:			return false;
	}
	return true;
}

function PTPM_ExplainRole(playerid)
{
	if(PTPM_Class[playerid] == INVALID_CLASS) return printf("Player %s(%d) have no class!!!", PTPM_PlayerName[playerid], playerid);
	(Team:z) = PTPM_Team[PTPM_Class[playerid]];
	if(Team:z == T_Psycho)
	{
		PTPM_SendClientMessage(playerid, "~r~~h~Nobody wants to be your friend. So trust no one. Kill them all.");
		return true;
	}
	if(Team:z == T_Terrorist)
	{
		PTPM_SendClientMessage(playerid, "~p~Your role is to try and kill the ~y~Prime Minister(yellow)");
		PTPM_SendClientMessage(playerid, "~p~before the timer runs out.");
		PTPM_SendClientMessage(playerid, "~p~You must work with the other terrorists(pink) as a team.");
		PTPM_SendClientMessage(playerid, "~p~You must avoid the ~b~cops(blue) ~p~as they will hunt you.");
		PTPM_SendClientMessage(playerid, "~p~Beware of ~r~~h~psychopaths(orange)~p~, they will kill anyone.");
		if(PTPM_Class[playerid] == C_Terrorist_Medic)
			PTPM_SendClientMessage(playerid, "~g~~h~You are a medic, you can heal people with your spezial action~g~~h~!");
		return true;
	}
	if(Team:z == T_PrimeMinister)
	{
		PTPM_SendClientMessage(playerid, "~y~Your role is to avoid being killed by ~p~terrorists(pink)");
		PTPM_SendClientMessage(playerid, "~y~or ~r~~h~psychopaths(orange) ~y~until the timer runs out.");
		PTPM_SendClientMessage(playerid, "~y~Look right up to find out how long there is left.");
		PTPM_SendClientMessage(playerid, "~y~You must work with your loyal ~g~bodyguards(green)~y~,");
		PTPM_SendClientMessage(playerid, "~y~they will protect you. You are to co-operate with the local");
		PTPM_SendClientMessage(playerid, "~b~police(blue)~y~, who will hunt the terrorists.");
		return true;
	}
	if(Team:z == T_Bodyguard)
	{
		PTPM_SendClientMessage(playerid, "~g~Your duty is to stay with the ~y~Prime Minister(yellow)");
		PTPM_SendClientMessage(playerid, "~g~and protect him from harm. ~p~Terrorists(pink) ~g~will soon try");
		PTPM_SendClientMessage(playerid, "~g~and murder him. Also beware of ~r~~h~psychopaths(orange)~g~.");
		PTPM_SendClientMessage(playerid, "~g~You are to co-operate with the local ~b~police(blue)~g~,");
		PTPM_SendClientMessage(playerid, "~g~who will hunt the terrorists.");
		if(PTPM_Class[playerid] == C_Bodyguard_Medic)
			PTPM_SendClientMessage(playerid, "~g~~h~You are a medic, you can heal people with your spezial action~g~~h~!");
		return true;
	}
	if(Team:z == T_Cop)
	{
		PTPM_SendClientMessage(playerid, "~b~Your orders are to kill the ~p~terrorists(pink)");
		PTPM_SendClientMessage(playerid, "~b~without harming the ~g~bodyguards(green) ~b~or");
		PTPM_SendClientMessage(playerid, "~b~the ~y~Prime Minister(yellow)~b~.");
		PTPM_SendClientMessage(playerid, "~b~Also beware of ~r~~h~psychopaths(orange)~b~.");
		PTPM_SendClientMessage(playerid, "~b~Protect the Prime Minister!");
		if(PTPM_Class[playerid] == C_Cop_Medic)
			PTPM_SendClientMessage(playerid, "~g~~h~You are a medic, you can heal people with your spezial action~g~~h~!");
		return true;
	}
	return true;
}


#if PTPM_Vehicle_Stream_Radius > 0 && MAX_PTPM_VEHICLE > 0
	function PTPM_ResetVehicle(vehicleid)
	{
		if(!PTPM_DestroyVehicle(vehicleid)) return false;

		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "%d/%d ~r~Destroy ~b~Vehicle %d (Respawn)",
					PTPM_S_Vehicle_Counter, PTPM_Vehicle_Counter - 1, vehicleid);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		PTPM_Vehicle[vehicleid][VCX] = PTPM_Vehicle[vehicleid][VX];
		PTPM_Vehicle[vehicleid][VCY] = PTPM_Vehicle[vehicleid][VY];
		PTPM_Vehicle[vehicleid][VCZ] = PTPM_Vehicle[vehicleid][VZ];
		PTPM_Vehicle[vehicleid][VCA] = PTPM_Vehicle[vehicleid][VA];
		PTPM_Vehicle[vehicleid][VCH] = 1000.0;
		return true;
	}
#endif

function PTPM_strval(text[])
{
	if((i = strlen(text)) <= 30)
	{
/*
		for(l = 0, z = 0; z < i; z++)
			if(!PTPM_IsInt(text[z])) return -1;
			else l = (l * 10) + (text[z] - '0');
		return l;
*/
		return strval(text);
	}
	return 0;
}

#if PTPM_Vehicle_Stream_Radius > 0 && MAX_PTPM_VEHICLE > 0
	function PTPM_DestroyVehicle(id)
	{
		if(	id < 0 || id >= MAX_PTPM_VEHICLE ||
			!PTPM_Vehicle[id][vactive]) return false;
		PTPM_GetVehicleNumber[PTPM_Vehicle[id][vid]] = -1;
		DestroyVehicle(PTPM_Vehicle[id][vid]);
		PTPM_Vehicle[id][vactive] = false;
		PTPM_Vehicle[id][vused] = false;
		PTPM_Vehicle[id][vid] = -1;
		PTPM_S_Vehicle_Counter--;
		return true;
	}
#endif

#if PTPM_Object_Stream_Radius > 0 && MAX_PTPM_OBJECTS > 0
	function PTPM_DestroyPlayerObject(playerid, objectid)
	{
		if(!PTPM_Player_Object[playerid][objectid][oactive]) return false;
		DestroyPlayerObject(playerid, PTPM_Player_Object[playerid][objectid][oid]);
		PTPM_Player_Object[playerid][objectid][oactive] = false;
		PTPM_Player_Object[playerid][objectid][oid] = -1;
		PTPM_S_Object_Counter--;
		return true;
	}
#endif

#if PTPM_Pickup_Stream_Radius > 0 && MAX_PTPM_PICKUPS > 0
	function PTPM_DestroyPickup(pickupid)
	{
		if(!PTPM_Pickup[pickupid][pactive]) return false;
		PTPM_GetPickupNumber[PTPM_Pickup[pickupid][pid]] = -1;
		DestroyPickup(PTPM_Pickup[pickupid][pid]);
		PTPM_Pickup[pickupid][pactive] = false;
		PTPM_Pickup[pickupid][pid] = -1;
		PTPM_S_Pickup_Counter--;
		return true;
	}
#endif

#if MAX_PTPM_PICKUPS > 0 && MAX_PTPM_BCUBOID > 0
	function PTPM_Activate_Banned_Cuboid(playerid, bcubid)
	{
		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "PTPM_Activate_Banned_Cuboid(%d, %d)", playerid, bcubid);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		PTPM_GameTextForPlayer(playerid,	PTPM_Banned_Cuboid[bcubid][BText], 2500, 4);
		SetPlayerPos(playerid,				PTPM_Banned_Cuboid[bcubid][BTX],
											PTPM_Banned_Cuboid[bcubid][BTY],
											PTPM_Banned_Cuboid[bcubid][BTZ]);
		SetPlayerFacingAngle(playerid,		PTPM_Banned_Cuboid[bcubid][BTA]);
		SetPlayerInterior(playerid,			PTPM_Banned_Cuboid[bcubid][BInterior]);
	}
#endif

function LetterDeleter(text[], symbol)
{
	for(new _i; text[_i] != EOS; ++_i)
		if(text[_i] == symbol)
		{
			for(new _z = (_i + 1); text[_z] != EOS; ++_z)
				if(text[_z] == symbol)
				{
					for( ; text[++_z] != EOS; ++_i)
						text[_i] = text[_z];
					text[_i] = EOS;
					return LetterDeleter(text, symbol);
				}
			while(text[++_i] != EOS)
				text[_i - 1] = text[_i];
			text[_i - 1] = EOS;
		}
	return true;
}

function PTPM_AddOp(playerid, rest[])
{
	#if PTPM_File_System == true
		new name[NUM_NAME_LENGTH], password[NUM_NAME_LENGTH];
		PTPM_Parse_Command(rest, name, password, " ");
		switch(PTPM_CheckOpFile(playerid, name, password, 2, false))
		{
			case 0: return PTPM_SendClientMessage(playerid, "Right Usage: /addop [name][password]");
			case 1, 20, 21: return PTPM_SendClientMessage(playerid, "~r~Moderator already exist!");
			case 2, 10, 11: return PTPM_SendClientMessage(playerid, "~r~Operator already exist!");
		}
		format(PTPM_String, NUM_STRING_LENGTH, "~r~%s (%d) ~w~added the ~r~operator ~b~%s", PTPM_PlayerName[INVALID_PLAYER_ID], INVALID_PLAYER_ID, name);
		PTPM_SendClientMessageToAll(PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH, "You successful added the ~r~operator ~b~\"%s\"", name);
		PTPM_SendClientMessage(playerid, PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH,	"\t-%s|%s|true-\r\n}\r\n", name, password);
		PTPM_freplace(0, "}", PTPM_String);
	#else
		PTPM_SendClientMessage(playerid, PTPM_System_Name ": You cant add Admins while the PTPM_FILE_SYSTEM is deactivaed!");
	#endif
	return true;
}

function PTPM_AddMod(playerid, rest[])
{
	#if PTPM_File_System == true
		new name[NUM_NAME_LENGTH], password[NUM_NAME_LENGTH];
		PTPM_Parse_Command(rest, name, password, " ");
		switch(PTPM_CheckOpFile(playerid, name, password, 2, false))
		{
			case 0: return PTPM_SendClientMessage(playerid, "Right Usage: /addmod [name][password]");
			case 1, 20, 21: return PTPM_SendClientMessage(playerid, "~r~Moderator already exist!");
			case 2, 10, 11: return PTPM_SendClientMessage(playerid, "~r~Operator already exist!");
		}
		format(PTPM_String, NUM_STRING_LENGTH, "~r~%s (%d) ~w~added the ~r~moderator ~b~%s", PTPM_PlayerName[INVALID_PLAYER_ID], INVALID_PLAYER_ID, name);
		PTPM_SendClientMessageToAll(PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH, "You successful added the ~r~moderator ~b~\"%s\"", name);
		PTPM_SendClientMessage(playerid, PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH,	"\t-%s|%s|true-\r\n}\r\n", name, password);
		PTPM_freplace(1, "}", PTPM_String);
	#else
		PTPM_SendClientMessage(playerid, PTPM_System_Name ": You cant add Mods while the PTPM_FILE_SYSTEM is deactivaed!");
	#endif
	return true;
}

function PTPM_DelOp(playerid, rest[])
{
	#if PTPM_File_System == true
		format(PTPM_Name, NUM_STRING_LENGTH, rest);
		PTPM_String[0] = '1', PTPM_String[22] = EOS;
		switch(PTPM_CheckOpFile(playerid, PTPM_Name, PTPM_String, 0, false))
		{
			case 0: return PTPM_SendClientMessage(playerid, "Right Usage: /delop [name]");
			case 30: return PTPM_SendClientMessage(playerid, "~r~Account doesnt exist.");
		}
		format(PTPM_String, NUM_STRING_LENGTH, "~r~%s (%d) ~w~deleted the ~r~operator ~b~%s", PTPM_PlayerName[INVALID_PLAYER_ID], INVALID_PLAYER_ID, rest);
		PTPM_SendClientMessageToAll(PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH, "You successful deleted the ~r~operator ~b~\"%s\"", rest);
		PTPM_SendClientMessage(playerid, PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH,	"-%s|", rest);
		PTPM_freplace(0, PTPM_String, "");
	#else
		PTPM_SendClientMessage(playerid, PTPM_System_Name ": You cant remove Admins while the PTPM_FILE_SYSTEM is deactivaed!");
	#endif
	return true;
}

function PTPM_DelMod(playerid, rest[])
{
	#if PTPM_File_System == true
		format(PTPM_Name, NUM_STRING_LENGTH, rest);
		PTPM_String[0] = '1', PTPM_String[22] = EOS;
		switch(PTPM_CheckOpFile(playerid, PTPM_Name, PTPM_String, 1, false))
		{
			case 0: return PTPM_SendClientMessage(playerid, "Right Usage: /delmod [name]");
			case 30: return PTPM_SendClientMessage(playerid, "~r~Account doesnt exist.");
		}
		format(PTPM_String, NUM_STRING_LENGTH, "~r~%s (%d) ~w~deleted the ~r~moderator ~b~%s", PTPM_PlayerName[INVALID_PLAYER_ID], INVALID_PLAYER_ID, rest);
		PTPM_SendClientMessageToAll(PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH, "You successful deleted the ~r~moderator ~b~\"%s\"", rest);
		PTPM_SendClientMessage(playerid, PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH,	"-%s|", rest);
		PTPM_freplace(0, PTPM_String, "");
	#else
		PTPM_SendClientMessage(playerid, PTPM_System_Name ": You cant remove Mods while the PTPM_FILE_SYSTEM is deactivaed!");
	#endif
	return true;
}

function PTPM_ChangeName(playerid, rest[])
{
	if((i = strlen(rest)) <= 3 || i >= NUM_NAME_LENGTH)
		return PTPM_SendClientMessage(playerid, "Usage: /changename [newname]");
	while(--i >= 0)
		if(!PTPM_ValidNameCell(rest[i]))
			return PTPM_SendClientMessage(playerid, "~r~Valid Character: A-Z a-z 0-9 [] or _");
	format(PTPM_String, NUM_STRING_LENGTH, "~r~\"%s\" changed his name to \"%s\"", PTPM_PlayerName[playerid], rest);
	PTPM_SendClientMessageToAll(PTPM_String);
	PTPM_SetPlayerName(playerid, rest);
	return true;
}

function PTPM_SetPlayerName(playerid, const name[])
{
	if(playerid == INVALID_PLAYER_ID)
		format(PTPM_Logged_Name[playerid], NUM_NAME_LENGTH, name);
	else
	{
		if(!SetPlayerName(playerid, name)) return false;
		format(PTPM_PlayerName[playerid], NUM_NAME_LENGTH, name);
	}
	return true;
}

function PTPM_AdminChat(playerid, rest[])
{
	if(!PTPM_IsPlayerMod(playerid)) return false;
	else if(PTPM_IsEmpty(rest))
		return PTPM_SendClientMessage(playerid, "Right Usage: /adminchat [text]");
	format(PTPM_String, NUM_STRING_LENGTH, "~r~Adminchat %s(%s): %s", PTPM_PlayerName[playerid], PTPM_Logged_Name[playerid], rest);
	return PTPM_SendClientMessageToAdmin(PTPM_String);
}

function PTPM_TeamChat(playerid, rest[])
{
	if(PTPM_Class[playerid] == INVALID_CLASS) return false;
	else if(PTPM_IsEmpty(rest))
		return PTPM_SendClientMessage(playerid, "Right Usage: /teamchat [text]");
	format(PTPM_String, NUM_STRING_LENGTH, "~y~%s", rest);
	(Team:z) = PTPM_Team[PTPM_Class[playerid]];
	for(i = 0; i < PTPM_Players; i++)
		if(PTPM_Team[PTPM_Class[PTPM_Connected[i]]] == Team:z)
			PTPM_SendClientMessage(PTPM_Connected[i], PTPM_String);
	return true;
}


function PTPM_ShowAllOps(playerid)
{
	PTPM_OpenOpFile(io_read), PTPM_String[0] = EOS;
	PTPM_SendClientMessage(playerid, "---------");
	PTPM_SendClientMessage(playerid, "Operators");
	PTPM_SendClientMessage(playerid, "---------");
	z = 0;
	while(fread(PTPM_File, PTPM_Tmp))
		switch(z)
		{
			case 0: if(strfind(PTPM_Tmp, "Operators", true) != -1) z++;
			case 1:
			{
				if(PTPM_Tmp[0] == '{') continue;
				if(PTPM_Tmp[0] == '}') break;
				i = strfind(PTPM_Tmp, "-", true, 0);
				z = strfind(PTPM_Tmp, "|", true, i + 1);
				l = strfind(PTPM_Tmp, "|", true, z + 1);
				if(i == -1 || z == -1 || l == -1) continue;
				strmid(PTPM_Name, PTPM_Tmp, i + 1, z);
				strmid(PTPM_String, PTPM_Tmp, z + 1, l);
				strmid(PTPM_Tmp, PTPM_Tmp, l + 1, strlen(PTPM_Tmp) - 3);
				format(PTPM_String, NUM_STRING_LENGTH, "Name: %" #NUM_NAME_LENGTH "s Password: %" #NUM_NAME_LENGTH "s Enabled: %s",
								PTPM_Name, PTPM_String, PTPM_Tmp);
				PTPM_SendClientMessage(playerid, PTPM_String), z = 1;
			}
		}
	if(PTPM_IsEmpty(PTPM_String))
		PTPM_SendClientMessage(playerid, "No one, type /addop for adding one!");
	fclose(PTPM_File);
	return true;
}

function PTPM_ShowAllMods(playerid)
{
	PTPM_OpenOpFile(io_read), PTPM_String[0] = EOS;
	PTPM_SendClientMessage(playerid, "----------");
	PTPM_SendClientMessage(playerid, "Moderators");
	PTPM_SendClientMessage(playerid, "----------");
	z = 0;
	while(fread(PTPM_File, PTPM_Tmp))
		switch(z)
		{
			case 0: if(strfind(PTPM_Tmp, "Moderators", true) != -1) z++;
			case 1:
			{
				if(PTPM_Tmp[0] == '{') continue;
				if(PTPM_Tmp[0] == '}') break;
				i = strfind(PTPM_Tmp, "-", true, 0);
				z = strfind(PTPM_Tmp, "|", true, i + 1);
				l = strfind(PTPM_Tmp, "|", true, z + 1);
				if(i == -1 || z == -1 || l == -1) continue;
				strmid(PTPM_Name, PTPM_Tmp, i + 1, z);
				strmid(PTPM_String, PTPM_Tmp, z + 1, l);
				strmid(PTPM_Tmp, PTPM_Tmp, l + 1, strlen(PTPM_Tmp) - 3);
				format(PTPM_String, NUM_STRING_LENGTH, "Name: %" #NUM_NAME_LENGTH "s Password: %" #NUM_NAME_LENGTH "s Enabled: %s",
								PTPM_Name, PTPM_String, PTPM_Tmp);
				PTPM_SendClientMessage(playerid, PTPM_String), z = 1;
			}
		}
	if(PTPM_IsEmpty(PTPM_String))
		PTPM_SendClientMessage(playerid, "No one, type /addmod for adding one!");
	fclose(PTPM_File);
	return true;
}

function PTPM_ShowAllAdmins(playerid)
{
	PTPM_SendClientMessage(playerid, "------");
	PTPM_SendClientMessage(playerid, "Admins");
	PTPM_ShowAllOps(playerid);
	PTPM_ShowAllMods(playerid);
	return true;
}

function PTPM_ChangePassword(playerid, rest[])
{
	#if PTPM_File_System == true
		new oldpw[NUM_NAME_LENGTH], newpw[NUM_NAME_LENGTH];
		PTPM_Parse_Command(rest, oldpw, newpw, " ");
		switch(PTPM_CheckOpFile(playerid, PTPM_Logged_Name[playerid], oldpw, (PTPM_Logged[playerid] == 2) ? (0) : (1), true))
		{
			case 0: return PTPM_SendClientMessage(playerid, "Right Usage: /changepassword [oldpassword][newpassword]");
			default: return false;
		}
		format(PTPM_String, NUM_STRING_LENGTH, "~g~You successful changed your password from ~r~\"%s\" ~g~to ~r~\"%s\"", oldpw, newpw);
		PTPM_SendClientMessage(playerid, PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH,	"\t-%s|%s|true-", PTPM_Logged_Name[playerid], oldpw);
		format(PTPM_Tmp, NUM_STRING_LENGTH,		"\t-%s|%s|true-", PTPM_Logged_Name[playerid], newpw);
		PTPM_freplace(0, PTPM_String, PTPM_Tmp);
	#else
		PTPM_SendClientMessage(playerid, PTPM_System_Name ": You cant change your password while the PTPM_FILE_SYSTEM is deactived!");
	#endif
	return true;
}

function PTPM_ChangeOtherPassword(playerid, rest[])
{
	#if PTPM_File_System == true
		PTPM_Parse_Command(rest, PTPM_Name, PTPM_String, " ");
		PTPM_String[NUM_NAME_LENGTH - 2] = PTPM_Name[NUM_NAME_LENGTH - 2] = EOS;
		switch(PTPM_CheckOpFile(playerid, PTPM_Name, PTPM_String, 2, false))
		{
			case 0: return PTPM_SendClientMessage(playerid, "Right Usage: /changeotherpass (/cop) [name][newpassword]");
			case 30: return PTPM_SendClientMessage(playerid, "~r~Account doesnt exist.");
		}
		format(PTPM_Tmp, NUM_STRING_LENGTH, "\t-%s|%s|true-\r\n", PTPM_Name, PTPM_String);
		format(PTPM_String, NUM_STRING_LENGTH, "~g~You successful changed \"%s\" password ~g~to ~r~\"%s\"", PTPM_Name, PTPM_String);
		PTPM_SendClientMessage(playerid, PTPM_String);
		PTPM_freplace(0, PTPM_Name, PTPM_Tmp);
	#else
		PTPM_SendClientMessage(playerid, PTPM_System_Name ": You cant change passwords while the PTPM_FILE_SYSTEM is deactived!");
	#endif
	return true;
}

function PTPM_PlayerStats(playerid, Misc:swit)
{
	switch(swit)
	{
		case PS_Disconnect:
		{
			for(i = 0; ;)
				if(PTPM_Connected[i] < playerid) i += 5;
				else
				{
					if(PTPM_Connected[i--] == playerid)
					{
						for( ; i < PTPM_Players; i++)
							PTPM_Connected[i] = PTPM_Connected[i + 1];
						PTPM_Connected[i + 1] = SAMP_INVALID_PLAYER_ID;
						break;
					}
				}
			state ((--PTPM_Players) == 0) Gamemode:passive;
			PTPM_Mute[playerid] = false;
			PTPM_Logged[playerid] = false;
			PTPM_Spawned[playerid] = false;
			PTPM_PlayerIp[playerid][0] = EOS;
			PTPM_Offer_Time[playerid] = false;
			PTPM_PlayerName[playerid][0] = EOS;
			PTPM_Logged_Name[playerid][0] = EOS;
			PTPM_Class[playerid] = INVALID_CLASS;
			PTPM_Player_Teamkills[playerid] = false;
			PTPM_Player_Data[playerid][phealth] = 0.0;
			PTPM_Player_Data[playerid][parmour] = 0.0;
			PTPM_Playerid_Saver[playerid] =	 SAMP_INVALID_PLAYER_ID;
		}
		case PS_Connect:
		{
			if(playerid >= PTPM_MAX_PLAYERS) PTPM_Kick_Ex(playerid, 3);
			PTPM_ClearWindow(playerid, "3");
			PTPM_Connected[PTPM_Players] = playerid;
			state ((++PTPM_Players) == 1) Gamemode:active;
			GetPlayerIp(playerid, PTPM_PlayerIp[playerid], NUM_IP_LENGTH);
			GetPlayerName(playerid, PTPM_PlayerName[playerid], NUM_NAME_LENGTH);
		}
		case PS_Spawn:
		{
			PTPM_Spawned[playerid] = true;
			SetPlayerColor(playerid, PTPM_TeamColorHex(playerid));
		}
		case PS_Death:
		{
			PTPM_Spawned[playerid] = false;
			PTPM_Player_Kills[playerid] = 0;
			PTPM_GetPlayerInterior[playerid] = 0;
			SetPlayerColor(playerid, 0x000000FF);
			PTPM_Player_Data[playerid][phealth] = 0.0;
			PTPM_Player_Data[playerid][parmour] = 0.0;
			PTPM_Player_Legal_HeavyWeapon[playerid] = false;
		}
	}
}

function PTPM_Watch(playerid, rest[])
{
	if(PTPM_IsEmpty(rest))
	{
		if(PTPM_PlayerSpec[playerid] != SAMP_INVALID_PLAYER_ID)
				TogglePlayerSpectating(playerid, false),
				PTPM_PlayerSpec[playerid] = SAMP_INVALID_PLAYER_ID;
		else	PTPM_SendClientMessage(playerid, "Usage: /watch [id]");
		return true;
	}
	PTPM_GetIDEx(playerid, rest, i);
	if(PTPM_PlayerSpec[playerid] == SAMP_INVALID_PLAYER_ID)
		TogglePlayerSpectating(playerid, true);
	PTPM_PlayerSpec[playerid] = i;
	if(PTPM_IsPlayerInAnyVehicle[i])
			PlayerSpectateVehicle(playerid, PTPM_GetPlayerVehicleID[i]);
	else	PlayerSpectatePlayer(playerid, i);
	return true;
}

function PTPM_Query(playerid, rest[])
{
	if(PTPM_IsEmpty(rest)) return PTPM_SendClientMessage(playerid, "Right Usage: /query [playerid]");
	PTPM_GetIDEx(playerid, rest, i);
	PTPM_Playerid_Saver[playerid] = i;
	format(PTPM_String, NUM_STRING_LENGTH, "~b~Query established with %s.", PTPM_PlayerName[playerid][i]);
	PTPM_SendClientMessage(playerid, PTPM_String);
	PTPM_SendClientMessage(playerid, "~b~Usage: \"@text\"");
	return true;
}

function PTPM_PrivatMessage(playerid, rest[])
{
	if(PTPM_Playerid_Saver[playerid] == SAMP_INVALID_PLAYER_ID)
	{
		PTPM_Parse_Command(rest, PTPM_String, rest, " ");
		if(PTPM_IsEmpty(PTPM_String) || PTPM_IsEmpty(rest)) return PTPM_SendClientMessage(playerid, "Right Usage: /pm [playerid][text]");
		PTPM_GetIDEx(playerid, PTPM_String, i);
	}
	else i = PTPM_Playerid_Saver[playerid];
	format(PTPM_String, NUM_STRING_LENGTH, "~y~(From %s) %s", PTPM_PlayerName[playerid][playerid], rest);
	PTPM_SendClientMessage(i, PTPM_String);
	format(PTPM_String, NUM_STRING_LENGTH, "~y~(To %s) %s", PTPM_PlayerName[playerid][i], rest);
	PTPM_SendClientMessage(playerid, PTPM_String);
	return true;
}

function PTPM_LoadNpc(playerid, rest[])
	if(PTPM_IsEmpty(rest)) return PTPM_SendClientMessage(playerid, "Right Usage: /loadnpc [npcfile]");
	else if(ConnectNPC(rest, rest)) return true;
	else return PTPM_SendClientMessage(playerid, "Npcfile not founded!");

function PTPM_TeleTo(playerid, rest[])
{
	if(PTPM_IsEmpty(rest)) return PTPM_SendClientMessage(playerid, "Right Usage: /teleto [playerid]");
	PTPM_GetIDEx(playerid, rest, i);
	SetPlayerInterior(playerid, PTPM_GetPlayerInterior[i]);
	GetPlayerPos(i, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
	if(PTPM_IsPlayerInAnyVehicle[playerid])
			SetVehiclePos(PTPM_GetPlayerVehicleID[playerid], PTPM_Float[0], PTPM_Float[1], (PTPM_Float[2] + 1.0)),
			LinkVehicleToInterior(PTPM_GetPlayerVehicleID[playerid], PTPM_GetPlayerInterior[i]);
	else	SetPlayerPos(playerid, PTPM_Float[0], PTPM_Float[1], (PTPM_Float[2] + 1.0));
	return true;
}

function PTPM_Tele(playerid, rest[])
{
	if(PTPM_IsEmpty(rest) || !PTPM_ValidNumber(rest[0])) return PTPM_SendClientMessage(playerid, "Right Usage: /tele [X][Y][Z]");
	PTPM_Parse_Command(rest, PTPM_String, rest, " ");
	if(PTPM_IsEmpty(rest) || !PTPM_ValidNumber(rest[0])) return PTPM_SendClientMessage(playerid, "Right Usage: /tele [X][Y][Z]");
	PTPM_Parse_Command(rest, PTPM_Tmp, rest, " ");
	if(PTPM_IsEmpty(rest) || !PTPM_ValidNumber(rest[0])) return PTPM_SendClientMessage(playerid, "Right Usage: /tele [X][Y][Z]");
	else if(PTPM_String[0] == '+' || PTPM_Tmp[0] == '+')
	{
		GetPlayerPos(playerid, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
		GetPlayerFacingAngle(playerid, PTPM_Float[3]);
	}
	if(PTPM_String[0] == '+')	PTPM_Float[0] += (floatstr(PTPM_String[1]) * floatsin(-PTPM_Float[3], degrees));
	else						PTPM_Float[0] =	 floatstr(PTPM_String);
	if(PTPM_Tmp[0] == '+')		PTPM_Float[1] += (floatstr(PTPM_Tmp[1]) * floatcos(-PTPM_Float[3], degrees));
	else						PTPM_Float[1] =	 floatstr(PTPM_Tmp);
	if(rest[0] == '+')			PTPM_Float[2] += floatstr(rest[1]);
	else						PTPM_Float[2] =	 floatstr(rest);

	if(PTPM_IsPlayerInAnyVehicle[playerid])
			SetVehiclePos(PTPM_GetPlayerVehicleID[playerid], PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
	else	SetPlayerPos(playerid, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
	return true;
}

function PTPM_Velo(playerid, rest[])
{
	if(PTPM_IsEmpty(rest) || !PTPM_ValidNumber(rest[0])) return PTPM_SendClientMessage(playerid, "Right Usage: /velo [X][Y][Z]");
	PTPM_Parse_Command(rest, PTPM_String, rest, " ");
	if(PTPM_IsEmpty(rest) || !PTPM_ValidNumber(rest[0])) return PTPM_SendClientMessage(playerid, "Right Usage: /velo [X][Y][Z]");
	PTPM_Parse_Command(rest, PTPM_Tmp, rest, " ");
	if(PTPM_IsEmpty(rest) || !PTPM_ValidNumber(rest[0])) return PTPM_SendClientMessage(playerid, "Right Usage: /velo [X][Y][Z]");
	else if(PTPM_String[0] == '+' || PTPM_Tmp[0] == '+' || rest[0] == '+')
	{
		GetPlayerPos(playerid, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
		GetPlayerFacingAngle(playerid, PTPM_Float[3]);
	}
	if(PTPM_String[0] == '+')	PTPM_Float[0] += (floatstr(PTPM_String[1]) * floatsin(-PTPM_Float[3], degrees));
	else						PTPM_Float[0] =	 floatstr(PTPM_String);
	if(PTPM_Tmp[0] == '+')		PTPM_Float[1] += (floatstr(PTPM_Tmp[1]) * floatcos(-PTPM_Float[3], degrees));
	else						PTPM_Float[1] =	 floatstr(PTPM_Tmp);
	if(rest[0] == '+')			PTPM_Float[2] += floatstr(rest[1]);
	else						PTPM_Float[2] =	 floatstr(rest);

	if(PTPM_IsPlayerInAnyVehicle[playerid])
			SetVehicleVelocity(PTPM_GetPlayerVehicleID[playerid], PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
	else	SetPlayerVelocity(playerid, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
	return true;
}

#define _PTPM_SA_Functions_included_

//==============================================================================

public OnGameModeInit() <Gamemode:filterscript> return;
public OnGameModeInit() <> // OnGameModeInit START
{
	#if PTPM_Debug == true
		PTPM_SendClientMessageToAdmin("OnGameModeInit()");
	#endif

	state Gamemode:passive;

	#if defined PTPM_ServerIp // unused
		GetServerVarAsString("bind", PTPM_Name, NUM_IP_LENGTH); //By Y_Less - edited
		if(PTPM_Name[0] != EOS && (	strcmp(PTPM_Name, PTPM_ServerIp) != 0 ||
									strcmp(PTPM_Name, "127.0.0.1") != 0 ))
			for (;;) printf("Don't steal my script!");
	#endif

	GetServerVarAsString("version", PTPM_SA_MP_Version, sizeof PTPM_SA_MP_Version);

	PTPM_AddTimers(1_000,		"PTPM_RoundTick");
	PTPM_AddTimers(1_000,		"PTPM_Loop");
	#if PTPM_Pickup_Stream_Radius > 0
		PTPM_AddTimers(5_000,	"PTPM_Pickup_S");
	#endif
	#if PTPM_Object_Stream_Radius > 0
		PTPM_AddTimers(5_000,	"PTPM_Object_S");
	#endif
	#if PTPM_Vehicle_Stream_Radius > 0
		PTPM_AddTimers(2_000,	"PTPM_Vehicle_S");
	#endif
	PTPM_AddTimers(10_000,		"PTPM_GetMap");

	if(PTPM_SAMP_VERSION("0.2")) EnableTirePopping(true);
	AllowInteriorWeapons(true);
	UsePlayerPedAnims();

	PTPM_Whole_Time = PTPM_Round_Time_Minutes * 60 + PTPM_Round_Time_Seconds;

	PTPM_Player_Legal_HeavyWeapon[INVALID_PLAYER_ID] = false;
	PTPM_Logged_Name[INVALID_PLAYER_ID] = "Console";
	PTPM_PlayerIp[INVALID_PLAYER_ID] = "127.0.0.1";
	PTPM_GetPlayerInterior[INVALID_PLAYER_ID] = -1;
	PTPM_Class[INVALID_PLAYER_ID] = INVALID_CLASS;
	PTPM_PlayerName[INVALID_PLAYER_ID] = "Rcon";
	PTPM_Spawned[INVALID_PLAYER_ID] = false;
	PTPM_Logged[INVALID_PLAYER_ID] = 1337;

	getdate(_:PTPM_Dates[PTPM_Year], _:PTPM_Dates[PTPM_Month], _:PTPM_Dates[PTPM_Day]);
	gettime(_:PTPM_Dates[PTPM_Hour], _:PTPM_Dates[PTPM_Minute], _:PTPM_Dates[PTPM_Second]);

	format(PTPM_String, NUM_STRING_LENGTH, "%02d:%02d",
			PTPM_Round_Time_Minutes, PTPM_Round_Time_Seconds);
	PTPM_Clock = PTPM_TextDrawCreate(546, 22, PTPM_String);
	TextDrawLetterSize(PTPM_Clock, 0.6, 2.2);
	TextDrawFont(PTPM_Clock, 3);
	TextDrawSetOutline(PTPM_Clock, 2);
	PTPM_TextDrawShowForAll(PTPM_Clock);

	PTPM_ShowMap = PTPM_TextDrawCreate(555, 105, "_");
	TextDrawLetterSize(PTPM_ShowMap, 0.6, 0.8);
	TextDrawFont(PTPM_ShowMap, 0);
	TextDrawSetOutline(PTPM_ShowMap, 1);
	TextDrawAlignment(PTPM_ShowMap, 2);
	TextDrawTextSize(PTPM_ShowMap, 0.8, 125.0);
	PTPM_TextDrawShowForAll(PTPM_ShowMap);

	PTPM_Healthbar_BG = PTPM_TextDrawCreate(548.7, 57.8, "_");
	TextDrawLetterSize(PTPM_Healthbar_BG, 101.0, 0.6);
	TextDrawTextSize(PTPM_Healthbar_BG, 605.5, 1.0);
	TextDrawAlignment(PTPM_Healthbar_BG, 1);
	TextDrawUseBox(PTPM_Healthbar_BG, true);
	TextDrawBoxColor(PTPM_Healthbar_BG, 255);

	PTPM_Healthbar = PTPM_TextDrawCreate(551.2, 60.0, "_");
	TextDrawLetterSize(PTPM_Healthbar, 1.0, 0.1);
	TextDrawTextSize(PTPM_Healthbar, 603.9, 1.0);
	TextDrawAlignment(PTPM_Healthbar, 1);
	TextDrawUseBox(PTPM_Healthbar, true);

	PTPM_Max_Kills_Text = PTPM_TextDrawCreate(5.00, 425.00, "_");
	TextDrawLetterSize(PTPM_Max_Kills_Text, 0.40, 1.00);
	TextDrawTextSize(PTPM_Max_Kills_Text, 501.00, 1.00);
	TextDrawAlignment(PTPM_Max_Kills_Text, 1);
	TextDrawSetShadow(PTPM_Max_Kills_Text, 1);
	TextDrawBackgroundColor(PTPM_Max_Kills_Text, 255);
	TextDrawFont(PTPM_Max_Kills_Text, 0);
	TextDrawSetProportional(PTPM_Max_Kills_Text, true);
	PTPM_TextDrawShowForAll(PTPM_Max_Kills_Text);
	PTPM_Kill_Spee_Time = true;

	format(PTPM_Tmp, NUM_TMP_LENGTH, "loadfs %s", PTPM_Filterscript);
	SendRconCommand(PTPM_Tmp);

	if((PTPM_MAX_PLAYERS = GetMaxPlayers()) > INVALID_PLAYER_ID)
		PTPM_MAX_PLAYERS = INVALID_PLAYER_ID;

	#if 0 < MAX_CHATBOX_LINES
		#if 0 < MAX_PRIVAT_CHATBOX_LINES
			PTPM_Float[0] = 4.75;
		#else
			PTPM_Float[0] = 84.75;
		#endif
		for(i = 0; i < MAX_CHATBOX_LINES; i++, PTPM_Float[0] += 8.25)
		{
			PTPM_Chatbox[i] = PTPM_TextDrawCreate(15.0, PTPM_Float[0], " ");
			TextDrawFont(PTPM_Chatbox[i], 3);
			TextDrawSetOutline(PTPM_Chatbox[i], 1);
			PTPM_TextDrawShowForAll(PTPM_Chatbox[i]);
			TextDrawLetterSize(PTPM_Chatbox[i], 0.20, 0.70);
			format(PTPM_Chatbox_Line[i], NUM_STRING_LENGTH, " ");
		}
	#endif

	{ // Definition part START
