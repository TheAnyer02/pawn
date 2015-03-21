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

#if defined _PTPM_SA_Public_included_
	#endinput
#endif

#if !defined PTPM_Main_File
	#error "You cant compile PTPM_SA_Public.inc!"
#elseif !defined _PTPM_SA_Def_included_
	#if !defined _PTPM_SA_Functions_included_
		#error "PTPM_SA_Public needs to be included after PTPM_SA_Def and PTPM_SA_Functions!"
	#endif
	#error "PTPM_SA_Public needs to be included after PTPM_SA_Def!"
#else
	#if !defined _PTPM_SA_Functions_included_
		#error "PTPM_SA_Public needs to be included after PTPM_SA_Functions!"
	#endif
#endif

	} // Definition part END

	PTPM_ActivateTimers();

	if(!fexist(PTPM_File3)) fclose(fopen(PTPM_File3, io_write));
	format(PTPM_PM_Plan, NUM_STRING_LENGTH, " ");

	if(PTPM_OpenOpFile(io_read))
	{
		fread(PTPM_File, PTPM_Tmp);
		if(strfind(PTPM_Tmp, "true", true) != -1)
			PTPM_EveryoneIsOp = true;
		PTPM_Tmp[0] = false;
		fclose(PTPM_File);
	}

	PTPM_GetMap();
} // OnGameModeInit END

main()
{
	print("-----------------------------------------------");
	printf("Protect the Prime Minister - San Andreas (%4s)", #PTPM_Version);
	print("-----------------------------------------------");

	#if PTPM_ShowInfo == true

		#if MAX_PTPM_PWEAPON > 0
			for(i = 0, l = 0; i < NUM_CLASSES; i++)
				if(PTPM_PWeapon_Counter[Class:l] < PTPM_PWeapon_Counter[Class:i]) l = i;

			if(PTPM_PWeapon_Counter[Class:l] > MAX_PTPM_PWEAPON)
					printf("PTPM_PWeapon_Counter[%2d]%12d to much!!!", l, -(MAX_PTPM_PWEAPON - PTPM_PWeapon_Counter[Class:l]));
			else	printf("PTPM_PWeapon_Counter[%2d]%16d (%4d)", l, PTPM_PWeapon_Counter[Class:l], MAX_PTPM_PWEAPON);
		#endif

		#if MAX_PTPM_PICKUPS > 0 && MAX_PTPM_BCUBOID > 0
			if(PTPM_Banned_Cuboid_Counter > MAX_PTPM_BCUBOID)
					printf("PTPM_Banned_Cuboid_Counter%9d to much!!!", -(MAX_PTPM_BCUBOID - PTPM_Banned_Cuboid_Counter));
			else	printf("PTPM_Banned_Cuboid_Counter%14d (%4d)", PTPM_Banned_Cuboid_Counter, MAX_PTPM_BCUBOID);
		#endif

		#if MAX_PTPM_OBJECTS > 0
			#if PTPM_Object_Stream_Radius > 0
				if(PTPM_Object_Counter > MAX_PTPM_OBJECTS)
						printf("PTPM_Object_Counter%16d to much!!!", -(MAX_PTPM_OBJECTS - PTPM_Object_Counter));
				else	printf("PTPM_Object_Counter%21d (%4d)", PTPM_Object_Counter, MAX_PTPM_OBJECTS);
			#else
				if(PTPM_Object_Counter > MAX_PTPM_OBJECTS)
							printf("PTPM_Object_Counter%17d to much!!!", -(MAX_PTPM_OBJECTS - PTPM_Object_Counter));
				#if MAX_PTPM_OBJECTS == MAX_OBJECTS
					else	printf("PTPM_Object_Counter%21d [%4d]", PTPM_Object_Counter, MAX_PTPM_OBJECTS);
				#else
					else	printf("PTPM_Object_Counter%21d (%4d)", PTPM_Object_Counter, MAX_PTPM_OBJECTS);
				#endif
			#endif
		#endif

		#if MAX_PTPM_SPOINTS > 0
			for(i = 0, l = 0; i < NUM_TEAMS; i++)
				if(PTPM_Point_Counter[Team:l] < PTPM_Point_Counter[Team:i]) l = i;

			if(PTPM_Point_Counter[Team:l] > MAX_PTPM_SPOINTS)
					printf("PTPM_Point_Counter[%1d]%15d to much!!!", l, -(MAX_PTPM_SPOINTS - PTPM_Point_Counter[Team:l]));
			else	printf("PTPM_Point_Counter[%1d]%19d (%4d)", l, PTPM_Point_Counter[Team:l], MAX_PTPM_SPOINTS);
		#endif

		#if MAX_PTPM_PICKUPS > 0 && MAX_PTPM_WEAPONS > 0
			if(PTPM_Weapon_Counter > MAX_PTPM_WEAPONS)
					printf("PTPM_Weapon_Counter%17d to much!!!", -(MAX_PTPM_WEAPONS - PTPM_Weapon_Counter));
			else	printf("PTPM_Weapon_Counter%21d (%4d)", PTPM_Weapon_Counter, MAX_PTPM_WEAPONS);
		#endif

		#if MAX_PTPM_PICKUPS > 0
			#if PTPM_Pickup_Stream_Radius > 0
				if(PTPM_Pickup_Counter > MAX_PTPM_PICKUPS)
						printf("PTPM_Pickup_Counter%16d to much!!!", -(MAX_PTPM_PICKUPS - PTPM_Pickup_Counter));
				else	printf("PTPM_Pickup_Counter%21d (%4d)", PTPM_Pickup_Counter, MAX_PTPM_PICKUPS);
			#else
				if(PTPM_Pickup_Counter > MAX_PTPM_PICKUPS)
						printf("PTPM_Pickup_Counter%17d to much!!!", -(MAX_PTPM_PICKUPS - PTPM_Pickup_Counter));
				#if MAX_PTPM_PICKUPS == MAX_PICKUPS
					else	printf("PTPM_Pickup_Counter%21d [%4d]", PTPM_Pickup_Counter, MAX_PTPM_PICKUPS);
				#else
					else	printf("PTPM_Pickup_Counter%21d (%4d)", PTPM_Pickup_Counter, MAX_PTPM_PICKUPS);
				#endif
			#endif
		#endif

		#if MAX_PTPM_VEHICLE > 0
			#if PTPM_Vehicle_Stream_Radius > 0
				if(PTPM_Vehicle_Counter > MAX_PTPM_VEHICLE)
						printf("PTPM_Vehicle_Counter%16d to much!!!", -(MAX_PTPM_VEHICLE - PTPM_Vehicle_Counter));
				else	printf("PTPM_Vehicle_Counter%20d (%4d)", PTPM_Vehicle_Counter, MAX_PTPM_VEHICLE);
			#else
				if(PTPM_Vehicle_Counter > MAX_PTPM_VEHICLE)
						printf("PTPM_Vehicle_Counter%16d to much!!!", -(MAX_PTPM_VEHICLE - PTPM_Vehicle_Counter));
				#if MAX_PTPM_VEHICLE == MAX_VEHICLES
					else	printf("PTPM_Vehicle_Counter%20d [%4d]", PTPM_Vehicle_Counter, MAX_PTPM_VEHICLE);
				#else
					else	printf("PTPM_Vehicle_Counter%20d (%4d)", PTPM_Vehicle_Counter, MAX_PTPM_VEHICLE);
				#endif
			#endif
		#endif

		#if MAX_PTPM_PWEAPON > 0 || MAX_PTPM_PICKUPS > 0 || MAX_PTPM_OBJECTS > 0 || MAX_PTPM_SPOINTS > 0 || MAX_PTPM_VEHICLE > 0
			print("-----------------------------------------------");
		#endif

		printf("PTPM_MAX_PLAYERS%10d (%4d) {%4d} [%4d]", PTPM_MAX_PLAYERS, GetMaxPlayers(), MAX_PLAYERS, MAX_SAMP_PLAYERS);

		print("-----------------------------------------------");
		print("Type /help for console commands!!!!!!!!!!!!!!!!");
		print("-----------------------------------------------");
	#endif

	if(funcidx("PTPM_main") != -1) CallLocalFunction("PTPM_main", "");
}

#if defined OnGameModeExit
	public OnGameModeExit() <Gamemode:filterscript> return;
	public OnGameModeExit() <>
	{
		PTPM_TextDrawHideForAll(PTPM_Clock);
		#if 0 < MAX_CHATBOX_LINES
			for(z = 0; z < MAX_CHATBOX_LINES; z++)
				PTPM_TextDrawHideForAll(PTPM_Chatbox[z]);
		#endif
		#if 0 < MAX_PRIVAT_CHATBOX_LINES
			for(z = 0; z < MAX_PRIVAT_CHATBOX_LINES; z++)
				for(i = 0; i < PTPM_Players; i++)
					PTPM_TextDrawHideForPlayer(PTPM_Connected[i], PTPM_Privat_Chatbox[z][i]);
		#endif

		format(PTPM_Tmp, NUM_TMP_LENGTH, "unloadfs %s", PTPM_Filterscript);
		SendRconCommand(PTPM_Tmp);

		#if PTPM_Debug == true
			PTPM_SendClientMessageToAdmin("OnGameModeExit()");
		#endif

		if(funcidx("PTPM_OnGameModeExit") != -1) CallLocalFunction("PTPM_OnGameModeExit", "");
	}
#endif

#if defined OnFilterScriptInit
	public OnFilterScriptInit()
	{
		#if PTPM_Debug == true
			PTPM_SendClientMessageToAdmin("OnFilterScriptInit()");
		#endif

		state Gamemode:filterscript;

		z = strlen("\"\" isnt a filterscrpit!") + strlen(PTPM_Mode_Name);
		for(i = 0; i < z && i < NUM_TMP_LENGTH; i++)
			PTPM_Tmp[i] = '-';
		PTPM_Tmp[i] = EOS;

		print(PTPM_Tmp);
		printf("\"%s\" isnt a filterscrpit!", PTPM_Mode_Name);
		print(PTPM_Tmp);
	}
#endif

#if defined OnFilterScriptExit && PTPM_Debug == true
	public OnFilterScriptExit()
	{
		PTPM_SendClientMessageToAdmin("OnFilterScriptExit()");
	}
#endif

#if defined OnPlayerConnect
	public OnPlayerConnect(playerid) <Gamemode:filterscript> return true;
	public OnPlayerConnect(playerid) <>
	{
		PTPM_PlayerStats(playerid, PS_Connect);

		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerConnect(%d, %s)", playerid, PTPM_PlayerIp[playerid]);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		for(i = 0; i < PTPM_TextDraw_Count; i++)
			if(PTPM_TextDrawActive[INVALID_PLAYER_ID][Text:i])
				PTPM_TextDrawShowForPlayer(playerid, Text:i);

		#if 0 < MAX_PRIVAT_CHATBOX_LINES
			for(i = 0, PTPM_Float[0] = 360.0; i < MAX_PRIVAT_CHATBOX_LINES; i++, PTPM_Float[0] += 8.25)
			{
				PTPM_Privat_Chatbox[i][playerid] = PTPM_TextDrawCreate(150.0, PTPM_Float[0], " ");
				TextDrawLetterSize(PTPM_Privat_Chatbox[i][playerid], 0.20, 0.70);
				TextDrawFont(PTPM_Privat_Chatbox[i][playerid], 3);
				TextDrawSetOutline(PTPM_Privat_Chatbox[i][playerid], 1);
				format(PTPM_Privat_Chatbox_Line[i][playerid], NUM_STRING_LENGTH, " ");
				PTPM_TextDrawShowForPlayer(playerid, PTPM_Privat_Chatbox[i][playerid]);
			}
		#endif

		if(PTPM_PM_Timeouted > 0)
		{
			if(!strcmp(PTPM_PM_Name, PTPM_PlayerName[playerid], false))
			{
				PTPM_PM_Name[0] = EOS;
				PTPM_PM_Timeouted = false;
				PTPM_Class[playerid] = C_PrimeMinister;
				PTPM_SpawnPlayer(playerid);
				return true;
			}
		}
		
		#if defined PTPM_Server_Name
			format(PTPM_String, NUM_STRING_LENGTH, "~y~Welcome %s on %s", PTPM_PlayerName[playerid], PTPM_Server_Name);
			PTPM_SendClientMessage(playerid, PTPM_String);
		#endif
		format(PTPM_String, NUM_STRING_LENGTH, "%s(%d) joined the server", PTPM_PlayerName[playerid], playerid);
		PTPM_SendClientMessageToAll(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerDisconnect
	public OnPlayerDisconnect(playerid, reason) <Gamemode:filterscript> return true;
	public OnPlayerDisconnect(playerid, reason) <>
	{
		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerDisconnect(%d, %d)", playerid, reason);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		if((PTPM_Class[playerid] == C_PrimeMinister) && (reason == 0))
		{
			i = PTPM_Whole_Time - PTPM_Round_Time;
			z = floatround(i / 60, floatround_floor);

			format(PTPM_String, NUM_STRING_LENGTH, "%02d:%02d (No PM)",	z, (i - z * 60));
			PTPM_SetServerData("worldtime", PTPM_String, false);

			if(PTPM_Restart_Count_Ex == 0 && reason == 0)
				format(PTPM_PM_Name, NUM_NAME_LENGTH, PTPM_PlayerName[playerid]),
				PTPM_PM_Timeouted = 60;

			PTPM_Old_PM_ID = SAMP_INVALID_PLAYER_ID;
		}

		if(PTPM_Spawned[playerid])
			PTPM_Team_Player[PTPM_Team[PTPM_Class[playerid]]]--;

		for(i = 0; i < PTPM_TextDraw_Count; i++)
			if(PTPM_TextDrawActive[INVALID_PLAYER_ID][Text:i])
				PTPM_TextDrawHideForPlayer(playerid, Text:i);

		#if 0 < MAX_PRIVAT_CHATBOX_LINES
			for(i = MAX_PRIVAT_CHATBOX_LINES - 1; i >= 0; i--)
				PTPM_TextDrawDestroy(PTPM_Privat_Chatbox[i][playerid]);
		#endif

		if(PTPM_TextDrawActive[playerid][PTPM_Healthbar]) OnPlayerStateChange(playerid, PLAYER_STATE_NONE, PLAYER_STATE_DRIVER);

		switch(reason)
		{
			case 0: format(PTPM_String, NUM_STRING_LENGTH, "%s(%d) left the server (Timeout)",	PTPM_PlayerName[playerid], playerid);
			case 1: format(PTPM_String, NUM_STRING_LENGTH, "%s(%d) left the server (Leaving)",	PTPM_PlayerName[playerid], playerid);
			case 2: format(PTPM_String, NUM_STRING_LENGTH, "%s(%d) left the server (Kicked)",	PTPM_PlayerName[playerid], playerid);
			case 3: format(PTPM_String, NUM_STRING_LENGTH, "%s(%d) left the server (Rejoin)",	PTPM_PlayerName[playerid], playerid),
						SetTimerEx("OnPlayerConnect", 1000, false, "i", playerid);
		}

		PTPM_PlayerStats(playerid, PS_Death);
		PTPM_PlayerStats(playerid, PS_Disconnect);
		PTPM_SendClientMessageToAll(PTPM_String);

		SetPlayerVirtualWorld(playerid, playerid + 1);
		return true;
	}
#endif

#if defined OnPlayerSpawn
	public OnPlayerSpawn(playerid) <Gamemode:filterscript> return true;
	public OnPlayerSpawn(playerid) <>
	{
		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerSpawn(%d)", playerid);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		if(PTPM_Restart_Count_Ex == 0)
		{
			format(PTPM_String, NUM_STRING_LENGTH, "~y~You are %s~n~~w~/duty to get orders~n~", PTPM_TeamNames(PTPM_Team[PTPM_Class[playerid]]));
			if(PTPM_Team[PTPM_Class[playerid]] == T_PrimeMinister) format(PTPM_String, NUM_STRING_LENGTH, "%s/swapclass to change", PTPM_String);
			else format(PTPM_String, NUM_STRING_LENGTH, "%s/reclass to change", PTPM_String);
			PTPM_GameTextForPlayer(playerid, PTPM_String, 5000, 4);
			if(PTPM_Team[PTPM_Class[playerid]] == T_PrimeMinister)
			{
				PTPM_Old_PM_ID = playerid;
				format(PTPM_String, NUM_STRING_LENGTH, "%s%s%s is now %s.",
					PTPM_TeamColor(playerid), PTPM_PlayerName[playerid], PTPM_TeamNames(PTPM_Team[PTPM_Class[playerid]]));
				PTPM_SendClientMessageToAll(PTPM_String);
				format(PTPM_String, NUM_STRING_LENGTH, "~y~~h~%s(%d)~n~~r~~h~%s",
					PTPM_PlayerName[playerid], PTPM_Old_PM_ID, PTPM_MapName());
				TextDrawSetString(PTPM_ShowMap, PTPM_String);
			}
		}

		SetPlayerSkin(playerid,					PTPM_Class_Data[PTPM_Class[playerid]][Skin]);
		PTPM_SetPlayerHealth(playerid,			PTPM_Class_Data[PTPM_Class[playerid]][SHealth]);
		if(IsPlayerNPC(playerid))
				PTPM_SetPlayerArmour(playerid,	100.0);
		else	PTPM_SetPlayerArmour(playerid,	PTPM_Class_Data[PTPM_Class[playerid]][SArmour]);

		PTPM_PlayerStats(playerid, PS_Spawn);

		#if MAX_PTPM_PWEAPON > 0
			ResetPlayerWeapons(playerid);
			for(i = 0; i < PTPM_PWeapon_Counter[PTPM_Class[playerid]]; i++)
				GivePlayerWeapon(playerid, PTPM_Class_Weapon[PTPM_Class[playerid]][i][0], PTPM_Class_Weapon[PTPM_Class[playerid]][i][1]);
		#endif

		#if MAX_PTPM_SPOINTS > 0
			(Team:z) = PTPM_Team[PTPM_Class[playerid]];
			i = PTPM_Team_Map_Data[Team:z][PTPM_Map][random(PTPM_TM_Counter[Team:z][PTPM_Map])];
			SetPlayerPos(playerid,			PTPM_Team_Data[Team:z][i][TX],
											PTPM_Team_Data[Team:z][i][TY],
											PTPM_Team_Data[Team:z][i][TZ]);
			SetPlayerFacingAngle(playerid,	PTPM_Team_Data[Team:z][i][TAngle]);
			SetPlayerInterior(playerid,		PTPM_Team_Data[Team:z][i][TInt]);
		#endif

		#if defined PTPM_Pocket_Money
			PTPM_ResetPlayerMoney(playerid), PTPM_GivePlayerMoney(playerid, PTPM_Pocket_Money);
		#endif
		return true;
	}
#endif

#if defined OnPlayerDeath
	public OnPlayerDeath(playerid, killerid, reason) <Gamemode:filterscript> return true;
	public OnPlayerDeath(playerid, killerid, reason) <>
	{
		#if (MAX_CHATBOX_LINES != 0) && (MAX_PRIVAT_CHATBOX_LINES != 0)
			PTPM_ClearWindow(playerid, "3");
		#endif

		PTPM_Team_Player[PTPM_Team[PTPM_Class[playerid]]]--;

		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerDeath(%d, %d, %d)", playerid, killerid, reason);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		if(PTPM_Class[playerid] == C_PrimeMinister)
		{
			format(PTPM_String, NUM_STRING_LENGTH, "The Prime Minister was killed");
			if(killerid == SAMP_INVALID_PLAYER_ID)
											format(PTPM_String, NUM_STRING_LENGTH, "%s in an accident!", PTPM_String);
			else
			{
				reason = _:PTPM_Team[PTPM_Class[killerid]];
				if(Team:reason == T_Psycho)
					format(PTPM_String, NUM_STRING_LENGTH, "%s by a psycho!", PTPM_String);
				else if(Team:reason == T_Terrorist)
					format(PTPM_String, NUM_STRING_LENGTH, "%s by the terrorists!", PTPM_String);
				else if(Team:reason == T_PrimeMinister)
					format(PTPM_String, NUM_STRING_LENGTH, "%s in an accident!", PTPM_String);
				else if(Team:reason == T_Bodyguard)
					format(PTPM_String, NUM_STRING_LENGTH, "%s by his treacherous bodyguards!", PTPM_String);
				else if(Team:reason == T_Cop)
					format(PTPM_String, NUM_STRING_LENGTH, "%s by the cops!", PTPM_String);
			}
			PTPM_GameTextForAll(PTPM_String, 5000, 4);
			PTPM_Reset(PTPM_Restart_Count, true);
			return true;
		}

		if(killerid != SAMP_INVALID_PLAYER_ID && killerid != SAMP_INVALID_PLAYER_ID)
		{
			PTPM_Player_Kills[killerid]++;
			PTPM_GivePlayerMoney(killerid, PTPM_Money[playerid]);
			GetPlayerPos(playerid, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
			SetPlayerCameraPos(playerid, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
			GetPlayerPos(killerid, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
			SetPlayerCameraLookAt(playerid,	PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
			if(PTPM_Class[playerid] > C_Psycho4 && PTPM_Team[PTPM_Class[playerid]] == PTPM_Team[PTPM_Class[killerid]])
			{
				PTPM_Player_Teamkills[killerid]++;
				switch(PTPM_Player_Teamkills[killerid])
				{
					case 1:	PTPM_GameTextForPlayer(killerid, "~w~Do ~r~NOT~w~ team kill!~n~use /duty", 7000, 4);
					case 2:
					{
						PTPM_GameTextForPlayer(killerid, "~w~Do ~r~NOT~w~ team kill!~n~(frozen for 7 seconds)", 7000, 4);
						PTPM_SetPlayerControllable(killerid, false, 7);
					}
					case 3:
					{
						if(PTPM_GetPlayerInterior[killerid] == 0)
						{
							GetPlayerPos(killerid, PTPM_Float[0], PTPM_Float[1], PTPM_Float[2]);
							SetPlayerPos(killerid, PTPM_Float[0], PTPM_Float[1], floatadd(PTPM_Float[2], 1000.0));
						}
						else
						{
							PTPM_SetPlayerControllable(killerid, false, 15);
						}
						PTPM_GameTextForPlayer(killerid, "~w~Team killing ~r~punishment", 7000, 4);
					}
					case 4:
					{
						PTPM_SetPlayerHealth(killerid, 0.0);
						PTPM_GameTextForPlayer(killerid, "~r~FINAL WARNING!", 7000, 4);
						PTPM_Class[killerid] = C_Psycho1 + Class:random(PTPM_Team_Size[T_Psycho]);
					}
					case 5:
					{
						PTPM_Kick(killerid, PTPM_System_Name, "Teamkiller", 2);
					}
				}
			}
			if(PTPM_Player_Kills[killerid] > 2)
				format(PTPM_Tmp, NUM_TMP_LENGTH,	"~y~%s~n~   ~r~%s ~g~is on ~r~killing spree ~g~with ~r~%d kills!",
													PTPM_Mode_Name, PTPM_PlayerName[killerid], PTPM_Player_Kills[killerid]),
				TextDrawSetString(PTPM_Max_Kills_Text, PTPM_Tmp), PTPM_Kill_Spee_Time = 30;
			else if(PTPM_Player_Kills[playerid] > 2)
				format(PTPM_Tmp, NUM_TMP_LENGTH,	"~y~%s~n~   ~r~%s ~g~has stopped ~r~%s's ~g~killing spree of ~r~%d!",
													PTPM_Mode_Name, PTPM_PlayerName[killerid], PTPM_PlayerName[playerid], PTPM_Player_Kills[playerid]),
				TextDrawSetString(PTPM_Max_Kills_Text, PTPM_Tmp), PTPM_Kill_Spee_Time = 30;
		}

		SendDeathMessage(killerid, playerid, reason);
		PTPM_PlayerStats(playerid, PS_Death);
		return true;
	}
#endif

#if defined OnVehicleSpawn && PTPM_Debug == true
	public OnVehicleSpawn(vehicleid) <Gamemode:filterscript> return true;
	public OnVehicleSpawn(vehicleid) <>
	{
		#if PTPM_Vehicle_Stream_Radius > 0
			format(PTPM_String, NUM_STRING_LENGTH, "OnVehicleSpawn(%d, %d)", vehicleid, PTPM_GetVehicleNumber[vehicleid]);
		#else
			format(PTPM_String, NUM_STRING_LENGTH, "OnVehicleSpawn(%d)", vehicleid);
		#endif
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnVehicleDeath && PTPM_Debug == true
	public OnVehicleDeath(vehicleid, killerid) <Gamemode:filterscript> return true;
	public OnVehicleDeath(vehicleid, killerid) <>
	{
		#if PTPM_Vehicle_Stream_Radius > 0
			format(PTPM_String, NUM_STRING_LENGTH, "OnVehicleDeath(%d, %d, %d)", vehicleid, killerid, PTPM_GetVehicleNumber[vehicleid]);
		#else
			format(PTPM_String, NUM_STRING_LENGTH, "OnVehicleDeath(%d, %d)", vehicleid, killerid);
		#endif
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerText
	public OnPlayerText(playerid, text[]) <Gamemode:filterscript> return true;
	public OnPlayerText(playerid, text[]) <>
	{
		if(PTPM_Mute[playerid]) return !PTPM_SendClientMessage(playerid, "You are muted.");

		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerText(%d, %s)", playerid, text);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		#if PTPM_Enable_Text_Change == false
			LetterDeleter(text, '~');
		#endif

		if(text[0] == '!') return PTPM_TeamChat(playerid, text[1]), false;
		if(text[0] == '.') return PTPM_AdminChat(playerid, text[1]), false;
		if(text[0] == '@') return PTPM_PrivatMessage(playerid, text[1]), false;

		SetPlayerChatBubble(playerid, text,	0xFFFFFFFF,	100.0, 10_000);
		format(PTPM_String, NUM_STRING_LENGTH, "%s%s%s:~w~ %s", PTPM_TeamColor(playerid), PTPM_PlayerName[playerid], text);
		PTPM_SendClientMessageToAll(PTPM_String);
		return false;
	}
#endif

#if defined OnPlayerCommandText
	public OnPlayerCommandText(playerid, cmdtext[]) <Gamemode:filterscript> return false;
	public OnPlayerCommandText(playerid, cmdtext[]) <Gamemode:restart>
		return PTPM_SendClientMessage(playerid, "~r~Commands are while restart disabled");
	public OnPlayerCommandText(playerid, cmdtext[]) <>
	{
		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerCommandText(%d, %s)", playerid, cmdtext);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		#if PTPM_Enable_Text_Change == false
			if(!LetterDeleter(cmdtext, '~')) return false;
		#endif
		if('A' <= cmdtext[1] && cmdtext[1] <= 'Z') tolower(cmdtext[1]);
		for(i = 0; i < sizeof PTPM_Commands_Array; i++)
		{
			if(PTPM_Commands_Array[i][ca_name][0] == cmdtext[1])
			{
				if(!(PTPM_EveryoneIsOp || PTPM_Logged[playerid] >= PTPM_Commands_Array[i][ca_level]))
				{
					break;
				}
				else if( strcmp(cmdtext[1], PTPM_Commands_Array[i][ca_name], true, PTPM_Commands_Array[i][ca_len]) == 0 &&
						(cmdtext[PTPM_Commands_Array[i][ca_len] + 1] == EOS || cmdtext[PTPM_Commands_Array[i][ca_len] + 1] == 32))
				{
					switch(PTPM_Commands_Array[i][ca_args])
					{
						case 0: CallLocalFunction(PTPM_Commands_Array[i][ca_fname], "");
						case 1: CallLocalFunction(PTPM_Commands_Array[i][ca_fname], "i", playerid);
						case 2, 3:
						{
							if(	cmdtext[PTPM_Commands_Array[i][ca_len] + 1] == 32 &&
								cmdtext[PTPM_Commands_Array[i][ca_len] + 2] != EOS)
									CallLocalFunction(PTPM_Commands_Array[i][ca_fname], "is",
											playerid, cmdtext[PTPM_Commands_Array[i][ca_len] + 2]);
							else	CallLocalFunction(PTPM_Commands_Array[i][ca_fname], "is", playerid, "/?");
						}
					}
					return true;
				}
			}
		}
		return PTPM_SendClientMessage(playerid, "SERVER: Unknown Command.");
	}
#endif

#if defined OnPlayerInfoChange && PTPM_Debug == true
	public OnPlayerInfoChange(playerid) <Gamemode:filterscript> return true;
	public OnPlayerInfoChange(playerid) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerInfoChange(%d)", playerid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerRequestClass
	public OnPlayerRequestClass(playerid, classid) <Gamemode:filterscript> return true;
	public OnPlayerRequestClass(playerid, classid) <Gamemode:restart> return false;
	public OnPlayerRequestClass(playerid, classid) <>
	{
		#if (MAX_CHATBOX_LINES != 0) && (MAX_PRIVAT_CHATBOX_LINES != 0)
			PTPM_ClearWindow(playerid, "3");
		#endif

		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerRequestClass(%d, %d)", playerid, classid);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif


		if(PTPM_Class[playerid] == INVALID_CLASS)
		{
			z = 0;
			if(PTPM_OpenOpFile(io_read))
			{
				format(PTPM_String, NUM_STRING_LENGTH, "|%s|", PTPM_PlayerName[playerid]);
				format(PTPM_F_String, NUM_STRING_LENGTH, "-%s|", PTPM_PlayerIp[playerid]);
				while(fread(PTPM_File, PTPM_Tmp) && z != -1)
				{
					switch(z)
					{
						case 0: if(!strfind(PTPM_Tmp, "Banned", true)) z++;
						case 1: if(strfind(PTPM_Tmp, PTPM_String, true) != -1)
									PTPM_Kick(playerid, PTPM_System_Name, "Bannlisted (Name)", 1);
								else if(strfind(PTPM_Tmp, PTPM_F_String, true) != -1)
									PTPM_Kick(playerid, PTPM_System_Name, "Bannlisted (Ip)", 1);
					}
				}
				fclose(PTPM_File);
			}
		}

		PTPM_Class[playerid] = Class:classid;

		SetPlayerPos(playerid,			PTPM_Selection_Data[PTPM_Map][SX],
										PTPM_Selection_Data[PTPM_Map][SY],
										PTPM_Selection_Data[PTPM_Map][SZ]);

		SetPlayerFacingAngle(playerid,	PTPM_Selection_Data[PTPM_Map][SA]);

		SetPlayerCameraPos(playerid,	PTPM_Selection_Data[PTPM_Map][SCX],
										PTPM_Selection_Data[PTPM_Map][SCY],
										PTPM_Selection_Data[PTPM_Map][SCZ]);

		SetPlayerCameraLookAt(playerid,	PTPM_Selection_Data[PTPM_Map][SX],
										PTPM_Selection_Data[PTPM_Map][SY],
										PTPM_Selection_Data[PTPM_Map][SZ]);

		SetPlayerInterior(playerid,		PTPM_Selection_Data[PTPM_Map][Sint]);
		return true;
	}
#endif

#if defined OnPlayerEnterVehicle && PTPM_Debug == true
	public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) <Gamemode:filterscript> return true;
	public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) <>
	{
		#if PTPM_Vehicle_Stream_Radius > 0
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerEnterVehicle(%d, %d, %d, %d)", playerid, vehicleid, PTPM_GetVehicleNumber[vehicleid], ispassenger);
		#else
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerEnterVehicle(%d, %d, %d)", playerid, vehicleid, ispassenger);
		#endif
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerExitVehicle && PTPM_Debug == true
	public OnPlayerExitVehicle(playerid, vehicleid) <Gamemode:filterscript> return true;
	public OnPlayerExitVehicle(playerid, vehicleid) <>
	{
		#if PTPM_Vehicle_Stream_Radius > 0
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerExitVehicle(%d, %d, %d)", playerid, vehicleid, PTPM_GetVehicleNumber[vehicleid]);
		#else
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerExitVehicle(%d, %d)", playerid, vehicleid);
		#endif
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerStateChange
	public OnPlayerStateChange(playerid, newstate, oldstate) <Gamemode:filterscript> return true;
	public OnPlayerStateChange(playerid, newstate, oldstate) <>
	{
		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerStateChange(%d, %d, %d)", playerid, newstate, oldstate);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		switch(newstate)
		{
			case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER:
			{
				PTPM_GetPlayerVehicleID[playerid] = GetPlayerVehicleID(playerid);
				if(!PTPM_TextDrawActive[playerid][PTPM_Healthbar])
				{
					TextDrawBoxColor(PTPM_Healthbar, GetPlayerColor(playerid));
					GetVehicleHealth(PTPM_GetPlayerVehicleID[playerid], PTPM_Float[0]);
					TextDrawTextSize(PTPM_Healthbar, (551.2 + ((PTPM_Float[0] - 250) * 0.0702666667)), 1); // x * 52.7 / 750.0
					PTPM_TextDrawShowForPlayer(playerid, PTPM_Healthbar_BG);
					PTPM_TextDrawShowForPlayer(playerid, PTPM_Healthbar);
					PTPM_PlayerVehicleHealth[playerid] = PTPM_Float[0];
				}

				#if PTPM_Vehicle_Stream_Radius > 0 && MAX_PTPM_VEHICLE > 0
					PTPM_GetPlayerVehicleModel[playerid] = PTPM_Vehicle[PTPM_GetVehicleNumber[PTPM_GetPlayerVehicleID[playerid]]][vmodel];
				#else
					PTPM_GetPlayerVehicleModel[playerid] = GetVehicleModel(PTPM_GetPlayerVehicleID[playerid]);
				#endif
				if(PTPM_Cant_Enter_Vehicle[PTPM_Team[PTPM_Class[playerid]]][(PTPM_GetPlayerVehicleModel[playerid] - 400)][(newstate - 2)])
				{
					if(newstate == PLAYER_STATE_DRIVER)
							PTPM_GameTextForPlayer(playerid, "~y~You are ~r~not qualified~n~ ~y~to use this vehicle!", 3000, 4);
					else	PTPM_GameTextForPlayer(playerid, "~y~You are ~r~not qualified~n~ ~y~to enter this vehicle!", 3000, 4);
					PTPM_RemovePlayerFromVehicle(playerid);
				}
				#if PTPM_Vehicle_Stream_Radius > 0
					else PTPM_Vehicle[z][vused] = true;
				#endif

				for(i = 0; i < PTPM_Players; i++)
					if(PTPM_PlayerSpec[PTPM_Connected[i]] == playerid)
						PlayerSpectateVehicle(PTPM_Connected[i], PTPM_GetPlayerVehicleID[playerid]);
						
				switch(PTPM_GetPlayerVehicleModel[playerid])
				{
					case VEHICLE_ENFORCER:
					{
						PTPM_SetPlayerArmour(playerid, 100.0);
					}
					case VEHICLE_COPCARLA, VEHICLE_COPCARRU, VEHICLE_COPCARSF, VEHICLE_COPCARVG:
					{
						GetPlayerWeaponData(playerid, S_SHOTGUNS, i, z);
						if(i == 0)
							GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 5);
						else if(z == 0)
							GivePlayerWeapon(playerid, i, 5);
					}
				}
			}
		}
		switch(oldstate)
		{
			case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER:
			{
				if(PTPM_TextDrawActive[playerid][PTPM_Healthbar])
				{
					PTPM_TextDrawHideForPlayer(playerid, PTPM_Healthbar_BG);
					PTPM_TextDrawHideForPlayer(playerid, PTPM_Healthbar);
				}
				#if PTPM_Vehicle_Stream_Radius > 0 && MAX_PTPM_VEHICLE > 0
					z = PTPM_GetVehicleNumber[PTPM_GetPlayerVehicleID[playerid]];
					if(PTPM_Vehicle[z][vused])
					{
						GetVehiclePos(PTPM_Vehicle[z][vid],		PTPM_Vehicle[z][VCX],
																PTPM_Vehicle[z][VCY],
																PTPM_Vehicle[z][VCZ]),
						GetVehicleZAngle(PTPM_Vehicle[z][vid],	PTPM_Vehicle[z][VCA]),
						GetVehicleHealth(PTPM_Vehicle[z][vid],	PTPM_Vehicle[z][VCH]);
						PTPM_Vehicle[z][vused] = false;
					}
				#endif
				PTPM_GetPlayerVehicleModel[playerid] = false;
				PTPM_GetPlayerVehicleID[playerid] = INVALID_VEHICLE_ID;

				for(i = 0; i < PTPM_Players; i++)
					if(PTPM_PlayerSpec[PTPM_Connected[i]] == playerid)
						PlayerSpectatePlayer(PTPM_Connected[i], playerid);
			}
		}
		return true;
	}
#endif

#if defined OnPlayerEnterCheckpoint && PTPM_Debug == true
	public OnPlayerEnterCheckpoint(playerid) <Gamemode:filterscript> return true;
	public OnPlayerEnterCheckpoint(playerid) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerEnterCheckpoint(%d)", playerid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerLeaveCheckpoint && PTPM_Debug == true
	public OnPlayerLeaveCheckpoint(playerid) <Gamemode:filterscript> return true;
	public OnPlayerLeaveCheckpoint(playerid) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerLeaveCheckpoint(%d)", playerid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerEnterRaceCheckpoint && PTPM_Debug == true
	public OnPlayerEnterRaceCheckpoint(playerid) <Gamemode:filterscript> return true;
	public OnPlayerEnterRaceCheckpoint(playerid) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerEnterRaceCheckpoint(%d)", playerid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerLeaveRaceCheckpoint && PTPM_Debug == true
	public OnPlayerLeaveRaceCheckpoint(playerid) <Gamemode:filterscript> return true;
	public OnPlayerLeaveRaceCheckpoint(playerid) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerLeaveRaceCheckpoint(%d)", playerid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnRconCommand
	public OnRconCommand(cmd[]) <Gamemode:filterscript> return false;
	public OnRconCommand(cmd[]) <>
	{
		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnRconCommand(%s)", cmd);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		#if PTPM_Enable_Text_Change == false
			LetterDeleter(cmd, '~');
		#endif

		if(cmd[0] == '/')
		{
			if('A' <= cmd[1] && cmd[1] <= 'Z') tolower(cmd[1]);
			for(i = 0; i < sizeof PTPM_Commands_Array; i++)
			{
				if(PTPM_Commands_Array[i][ca_name][0] == cmd[1])
				{
					if(	 strcmp(cmd[1], PTPM_Commands_Array[i][ca_name], true, PTPM_Commands_Array[i][ca_len]) == 0 &&
						(cmd[PTPM_Commands_Array[i][ca_len] + 1] == EOS || cmd[PTPM_Commands_Array[i][ca_len] + 1] == 32))
					{
						switch(PTPM_Commands_Array[i][ca_args])
						{
							case 0: CallLocalFunction(PTPM_Commands_Array[i][ca_fname], "");
							case 1: CallLocalFunction(PTPM_Commands_Array[i][ca_fname], "i", INVALID_PLAYER_ID);
							case 2, 3:
							{
								if(	cmd[PTPM_Commands_Array[i][ca_len] + 1] == 32 &&
									cmd[PTPM_Commands_Array[i][ca_len] + 2] != EOS)
										CallLocalFunction(PTPM_Commands_Array[i][ca_fname], "is",
												INVALID_PLAYER_ID, cmd[PTPM_Commands_Array[i][ca_len] + 2]);
								else	CallLocalFunction(PTPM_Commands_Array[i][ca_fname], "is", INVALID_PLAYER_ID, "/?");
							}
						}
						print("\r");
						return true;
					}
				}
			}
			return PTPM_SendClientMessage(INVALID_PLAYER_ID, "CONSOLE: Unknown Command.");
		}
		else
		{
			if(cmd[0] == ':')		return PTPM_SayCom(INVALID_PLAYER_ID, cmd[1]);
			else if(cmd[0] == '!')	return PTPM_TellCom(INVALID_PLAYER_ID, cmd[1]);
			else if(cmd[0] == '.')	return PTPM_AdminChat(INVALID_PLAYER_ID, cmd[1]);
			else 					return PTPM_WriteToLog(cmd, INVALID_PLAYER_ID);
		}
	}
#endif

#if defined OnPlayerPrivmsg && PTPM_Debug == true
	public OnPlayerPrivmsg(playerid, recieverid, text[]) <Gamemode:filterscript> return true;
	public OnPlayerPrivmsg(playerid, recieverid, text[]) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerPrivmsg(%d)", playerid, recieverid, text);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return false;
	}
#endif

#if defined OnPlayerRequestSpawn
	public OnPlayerRequestSpawn(playerid) <Gamemode:filterscript> return true;
	public OnPlayerRequestSpawn(playerid) <Gamemode:restart> return false;
	public OnPlayerRequestSpawn(playerid) <>
	{
		if(PTPM_Class[playerid] == C_PrimeMinister && playerid == PTPM_Old_PM_ID)
			return PTPM_SendClientMessage(playerid, "You already was the Prime Minister in the last round!");

		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerRequestSpawn(%d)", playerid);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		i =	_:PTPM_Class[playerid];

		if(PTPM_Team[PTPM_Class[playerid]] == T_PrimeMinister	&& PTPM_Team_Player[T_PrimeMinister]	> 0)
			PTPM_Class[playerid] = C_Bodyguard1	+ Class:(random(PTPM_Team_Size[T_Bodyguard]));
		if(PTPM_Team[PTPM_Class[playerid]] == T_Bodyguard		&& PTPM_Team_Player[T_Bodyguard]		> PTPM_Balance_Counter)
			PTPM_Class[playerid] = C_Cop1 +	Class:(random(PTPM_Team_Size[T_Cop]));
		if(PTPM_Team[PTPM_Class[playerid]] == T_Cop				&& PTPM_Team_Player[T_Cop]				> PTPM_Balance_Counter * 2)
			PTPM_Class[playerid] = C_Terrorist1	+ Class:(random(PTPM_Team_Size[T_Terrorist]));
		if(PTPM_Team[PTPM_Class[playerid]] == T_Terrorist		&& PTPM_Team_Player[T_Terrorist]		> PTPM_Balance_Counter * 3)
			PTPM_Class[playerid] = C_Psycho1 + Class:(random(PTPM_Team_Size[T_Psycho]));
		if(PTPM_Team[PTPM_Class[playerid]] == T_Psycho)													PTPM_Balance_Counter++;

		if((Class:i) != PTPM_Class[playerid]) PTPM_SendClientMessage(playerid, "The class you selected was full, picking something else...");

		PTPM_Team_Player[PTPM_Team[PTPM_Class[playerid]]]++;
		return true;
	}
#endif

#if defined OnObjectMoved && PTPM_Debug == true
	public OnObjectMoved(objectid) <Gamemode:filterscript> return true;
	public OnObjectMoved(objectid) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnObjectMoved(%d)", objectid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerObjectMoved && PTPM_Debug == true
	public OnPlayerObjectMoved(playerid, objectid) <Gamemode:filterscript> return true;
	public OnPlayerObjectMoved(playerid, objectid) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerObjectMoved(%d, %d)", playerid, objectid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerPickUpPickup
	public OnPlayerPickUpPickup(playerid, pickupid) <Gamemode:filterscript> return true;
	public OnPlayerPickUpPickup(playerid, pickupid) <>
	{
		#if PTPM_Debug == true
			#if PTPM_Pickup_Stream_Radius > 0
				format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerPickUpPickup(%d, %d, %d)", playerid, pickupid, PTPM_GetPickupNumber[pickupid]);
			#else
				format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerPickUpPickup(%d, %d)", playerid, pickupid);
			#endif
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		#if MAX_PTPM_PICKUPS > 0
			#if PTPM_Pickup_Stream_Radius > 0
				pickupid = PTPM_GetPickupNumber[pickupid];
			#endif
			#if MAX_PTPM_WEAPONS > 0
				if(PTPM_Pickup[pickupid][PWP] != -1)
				{
					if(PTPM_Weapon[PTPM_Pickup[pickupid][PWP]][HeavyWeapon])
						PTPM_Player_Legal_HeavyWeapon[playerid] = true;
					PTPM_OnPlayerPickUpWeaponPickup(playerid, PTPM_Pickup[pickupid][PWP], pickupid);
					return true;
				}
			#endif
			#if MAX_PTPM_BCUBOID > 0
				if(PTPM_Pickup[pickupid][PBC] != -1)
				{
					if(	!PTPM_Banned_Cuboid[PTPM_Pickup[pickupid][PBC]][BVehicle] &&
						PTPM_IsPlayerInAnyVehicle[playerid]) return false;
					PTPM_Activate_Banned_Cuboid(playerid, PTPM_Pickup[pickupid][PBC]);
					return true;
				}
			#endif
			PTPM_OnPlayerPickUpKit(playerid, pickupid, PTPM_Pickup[pickupid][pmodel]);
		#endif
		return true;
	}
#endif

#if defined OnVehicleMod && PTPM_Debug == true
	public OnVehicleMod(playerid, vehicleid, componentid) <Gamemode:filterscript> return true;
	public OnVehicleMod(playerid, vehicleid, componentid) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnVehicleMod(%d, %d, %d)", playerid, vehicleid, componentid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnEnterExitModShop && PTPM_Debug == true
	public OnEnterExitModShop(playerid, enterexit, interiorid) <Gamemode:filterscript> return true;
	public OnEnterExitModShop(playerid, enterexit, interiorid) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnEnterExitModShop(%d, %d, %d)", playerid, enterexit, interiorid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif


#if defined OnVehiclePaintjob && PTPM_Debug == true
	public OnVehiclePaintjob(playerid, vehicleid, paintjobid) <Gamemode:filterscript> return true;
	public OnVehiclePaintjob(playerid, vehicleid, paintjobid) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnVehiclePaintjob(%d, %d, %d)", playerid, vehicleid, paintjobid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnVehicleRespray && PTPM_Debug == true
	public OnVehicleRespray(playerid, vehicleid, color1, color2) <Gamemode:filterscript> return true;
	public OnVehicleRespray(playerid, vehicleid, color1, color2) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnVehicleRespray(%d, %d, %d, %d)", playerid, vehicleid, color1, color2);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerSelectedMenuRow && PTPM_Debug == true
	public OnPlayerSelectedMenuRow(playerid, row) <Gamemode:filterscript> return true;
	public OnPlayerSelectedMenuRow(playerid, row) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerSelectedMenuRow(%d, %d, %d)", playerid, row, _:GetPlayerMenu(playerid));
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerExitedMenu && PTPM_Debug == true
	public OnPlayerExitedMenu(playerid) <Gamemode:filterscript> return true;
	public OnPlayerExitedMenu(playerid) <>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerExitedMenu(%d, %d)", playerid, _:GetPlayerMenu(playerid));
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerInteriorChange
	public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) <Gamemode:filterscript> return true;
	public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) <>
	{
		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerInteriorChange(%d, %d, %d)", playerid, newinteriorid, oldinteriorid);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		PTPM_GetPlayerInterior[playerid] = newinteriorid;

		for(i = 0; i < PTPM_Players; i++)
			if(PTPM_PlayerSpec[PTPM_Connected[i]] == playerid)
				SetPlayerInterior(PTPM_Connected[i], newinteriorid);
		return true;
	}
#endif

#if defined OnPlayerKeyStateChange
	public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) <Gamemode:filterscript> return true;
	public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) <>
	{
		if(newkeys & KEY_ANALOG_LEFT)
			if(PTPM_IsMedic(playerid))			PTPM_PlayerHealPlayer(playerid);
			else
			{
				(Team:l) = PTPM_Team[PTPM_Class[playerid]];
				if(Team:l == T_Cop)					PTPM_ImmediateSupport(playerid);
				else if(Team:l == T_Terrorist)		PTPM_Sacrifice(playerid);
				else if(Team:l == T_Bodyguard)		PTPM_ArmourForHealth(playerid);
				else if(Team:l == T_PrimeMinister)	PTPM_SendClientMessage(playerid, "~r~No spezial function available!");
				else if(Team:l == T_Psycho)			PTPM_SendClientMessage(playerid, "~r~No spezial function available!");
			}
		if(oldkeys & KEY_FIRE)
			switch(GetVehicleComponentInSlot(PTPM_GetPlayerVehicleID[playerid], CARMODTYPE_NITRO))
			{
				case 1008: AddVehicleComponent(PTPM_GetPlayerVehicleID[playerid], 1008);
				case 1009: AddVehicleComponent(PTPM_GetPlayerVehicleID[playerid], 1009);
				case 1010: AddVehicleComponent(PTPM_GetPlayerVehicleID[playerid], 1010);
			}
		return true;
	}
#endif

#if defined OnRconLoginAttempt
	public OnRconLoginAttempt(ip[], password[], success) <Gamemode:filterscript> return true;
	public OnRconLoginAttempt(ip[], password[], success) <>
	{
		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnRconLoginAttempt(%s, %s, %d)", ip, password, success);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		if(!success)
		{
			for(i = 0; i < PTPM_Players; i++)
				if(PTPM_PlayerIp[PTPM_Connected[i]][0] != EOS && strcmp(ip, PTPM_PlayerIp[PTPM_Connected[i]]) == 0)
					break;
			OnPlayerDisconnect(PTPM_Connected[i], 3);
		}
		return true;
	}
#endif

#if defined OnPlayerUpdate
//	public OnPlayerUpdate(playerid) return true;
#endif

#if defined OnPlayerStreamIn && PTPM_Debug == true
	public OnPlayerStreamIn(playerid, forplayerid) <> return true;
	public OnPlayerStreamIn(playerid, forplayerid) <Gamemode:active>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerStreamIn(%d, %d)", playerid, forplayerid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnPlayerStreamOut && PTPM_Debug == true
	public OnPlayerStreamOut(playerid, forplayerid) <> return true;
	public OnPlayerStreamOut(playerid, forplayerid) <Gamemode:active>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerStreamOut(%d, %d)", playerid, forplayerid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnVehicleStreamIn && PTPM_Debug == true && PTPM_Vehicle_Stream_Radius < 1
	public OnVehicleStreamIn(vehicleid, forplayerid) <> return true;
	public OnVehicleStreamIn(vehicleid, forplayerid) <Gamemode:active>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnVehicleStreamIn(%d, %d)", vehicleid, forplayerid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnVehicleStreamOut && PTPM_Debug == true && PTPM_Vehicle_Stream_Radius < 1
	public OnVehicleStreamOut(vehicleid, forplayerid) <> return true;
	public OnVehicleStreamOut(vehicleid, forplayerid) <Gamemode:active>
	{
		format(PTPM_String, NUM_STRING_LENGTH, "OnVehicleStreamOut(%d, %d)", vehicleid, forplayerid);
		PTPM_SendClientMessageToAdmin(PTPM_String);
		return true;
	}
#endif

#if defined OnDialogResponse
	public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) <> return true;
	public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) <Gamemode:active>
	{
		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnDialogResponse(%d, %d, %d, %d, %s)", playerid, dialogid, response, listitem, inputtext);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		if(response)
			switch(dialogid)
			{
				case PTPM_DIALOG_COMMAND:
				{
					for(i = 0; i < sizeof PTPM_Commands_Array; i++)
					{
						if(inputtext[1] == PTPM_Commands_Array[i][ca_name][0])
						{
							if(strcmp(inputtext[1], PTPM_Commands_Array[i][ca_name][0], true, PTPM_Commands_Array[i][ca_len]) == 0)
							{
								format(PTPM_Name, NUM_NAME_LENGTH, "%d", PTPM_Playerid_Saver[playerid]);
								CallLocalFunction(PTPM_Commands_Array[i][ca_fname], "is", playerid, PTPM_Name);
								break;
							}
						}
					}
				}
			}
		if(dialogid == PTPM_DIALOG_COMMAND)
			PTPM_Playerid_Saver[playerid] = SAMP_INVALID_PLAYER_ID;
		return true;
	}
#endif


#if defined OnPlayerClickPlayer
	public OnPlayerClickPlayer(playerid, clickedplayerid, source) <> return true;
	public OnPlayerClickPlayer(playerid, clickedplayerid, source) <Gamemode:active>
	{
		#if PTPM_Debug == true
			format(PTPM_String, NUM_STRING_LENGTH, "OnPlayerClickPlayer(%d, %d, %d)", playerid, clickedplayerid, source);
			PTPM_SendClientMessageToAdmin(PTPM_String);
		#endif

		switch(source)
		{
			case CLICK_SOURCE_SCOREBOARD:
			{
				if(PTPM_EveryoneIsOp)
				{
					for(i = 0, PTPM_Tmp[0] = EOS; i < sizeof PTPM_Commands_Array; i++)
						if(PTPM_Commands_Array[i][ca_args] == 3)
							format(PTPM_Tmp, NUM_TMP_LENGTH, "%s\n/%s", PTPM_Tmp, PTPM_Commands_Array[i][ca_name]);
				}
				else
				{
					for(i = 0, PTPM_Tmp[0] = EOS; i < sizeof PTPM_Commands_Array; i++)
						if(PTPM_Logged[playerid] < PTPM_Commands_Array[i][ca_level]) break;
						else if(PTPM_Commands_Array[i][ca_args] == 3)
							format(PTPM_Tmp, NUM_TMP_LENGTH, "%s\n/%s", PTPM_Tmp, PTPM_Commands_Array[i][ca_name]);
				}
				if(PTPM_Tmp[0] == EOS) return false;
				if(PTPM_Playerid_Saver[playerid] != SAMP_INVALID_PLAYER_ID)
					PTPM_SendClientMessage(playerid, "~b~Info: This function reset your query!");
				ShowPlayerDialog(playerid, PTPM_DIALOG_COMMAND, DIALOG_STYLE_LIST, "Commands", PTPM_Tmp[1], "Ok", "Cancel");
				PTPM_Playerid_Saver[playerid] = clickedplayerid;
			}
		}
		return true;
	}
#endif

//#undef _inc_PTPM_SA_Def
#define _PTPM_SA_Public_included_
