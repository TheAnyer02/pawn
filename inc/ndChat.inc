#define SCRIPT		"ndChat"
#define SCRIPTER	"Nero_3D"
#define VERSION		"v0.4"
#define DATE		"20.05.11"
#define CREDITS		"  Y_Less for YSI"

#include <a_samp>
#tryinclude <YSI\y_commands>
#tryinclude <YSI\y_hooks>
#tryinclude <YSI\y_master>

#define DEFAULT		"#public"

#if defined _inc_y_commands
	#define CALL:%0(%1) @yC_%0(%1, false)
#else
	public OnPlayerCommandText(playerid, cmdtext[]) {
		new
			pos;
		cmdtext[0] = 'c';
		while(cmdtext[++pos] > ' ') {
			cmdtext[pos] = tolower(cmdtext[pos]);
		}
		while(cmdtext[pos] == ' ') {
			cmdtext[pos++] = EOS;
		}
		if(!cmdtext[pos]) {
			if(CallLocalFunction(cmdtext, "isi", playerid, "\1", false)) {
				return true;
			}
		} else {
			if(strcmp(cmdtext, "chelp", true) == 0) {
				cmdtext[pos - 1] = 'c';
				if(CallLocalFunction(cmdtext[pos - 1], "isi", playerid, "\1", true)) {
					return true;
				}
				cmdtext[pos - 1] = EOS;
			}
			if(CallLocalFunction(cmdtext, "isi", playerid, cmdtext[pos], false)) {
				return true;
			}
		}
		return CallLocalFunction("ndChat_OnPlayerCommandText", "is", playerid, cmdtext);
	}
	#if defined _ALS_OnPlayerCommandText
		#undef OnPlayerCommandText
	#else
		#define _ALS_OnPlayerCommandText
	#endif
	#define OnPlayerCommandText ndChat_OnPlayerCommandText
	forward ndChat_OnPlayerCommandText(playerid, cmdtext[]);
	#if !defined isnull
		#define isnull(%1) ((%1[0] == 0) || (%1[0] == 1 && %1[1] == 0))
	#endif
	#define YCMD:%1(%2) forward c%1(%2); public c%1(%2)
	#define CALL:%0(%1) c%0(%1, false)
#endif

#if !defined HASH@SDBM
	#define HASH@SDBM(%0)		DO_HASH@SDBM(%0,@)
	#define END:DO_HASH@SDBM(@)	(0)
	#define DO_HASH@SDBM(%0,%1)	(%0+_:END:DO_HASH@SDBM(%1)*65599)

	stock SDBM(const buffer[], length = cellmax) {
		if(length == cellmax) {
			length = strlen(buffer);
		}
		new
			c,
			hash;
		while(length--) {
			c = buffer[length];
			if('a' <= c <= 'z') {
				c &= ~0x20;
			}
			hash = c + hash * 65599;
		}
		return hash;
	}
#endif

stock
	gl_nChannel[MAX_PLAYERS],
	gl_nQuery[MAX_PLAYERS] = {INVALID_PLAYER_ID, ...};

#define C_MSG_SYSTEM	0xD0D0FFFF
#define C_MSG_ME		0x00FF00FF
#define C_MSG_QUERY		0xFFFF00AA

#define SetPlayerChannel(%0,%1) SetPVarString((%0),SCRIPT,(%1))
#define GetPlayerChannel(%0,%1,%2) GetPVarString((%0),SCRIPT,(%1),(%2))

stock SendChannelMessage(const channel, const color, const message[]) {
	for(new i; i != MAX_PLAYERS; ++i) {
		if(gl_nChannel[i] == channel) {
			SendClientMessage(i, color, message);
		}
	}
	return false;
}
stock GetPlayerid(input[]) {
	new
		i;
	for( ; '0' <= input[i] <= '9'; ++i) {}
	if(input[i] == EOS) {
		i = strval(input);
		if(IsPlayerConnected(i)) {
			return i;
		}
	} else {
		new
			name[MAX_PLAYER_NAME];
		for(i = 0; i != MAX_PLAYERS; ++i) {
			if(GetPlayerName(i, name, sizeof name)) {
				if(strfind(name, input, true) != -1) {
					return i; 
				}
			}
		}
	}
	return INVALID_PLAYER_ID;
}
YCMD:commands(playerid, params[], help) {
	#pragma unused params
	if(help) {
		SendClientMessage(playerid, C_MSG_SYSTEM, " * /commands");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Lists all the commands a player can use");
	} else {
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Commands");
		#if defined _inc_y_commands
			new
				i,
				tmp[128] = " * ",
				count = Command_GetPlayerCommandCount(playerid);
			for( ; i != count; ++i) {
				format(tmp, sizeof tmp, "%s/%s ", tmp, Command_GetNext(i, playerid));
				if(tmp[sizeof tmp - (sizeof tmp / 4) - 6] != EOS) {
					SendClientMessage(playerid, C_MSG_SYSTEM, tmp);
					tmp[sizeof tmp - (sizeof tmp / 4) - 6] = EOS;
					tmp = " * ";
				}
			}
			SendClientMessage(playerid, C_MSG_SYSTEM, tmp);
		#else
			SendClientMessage(playerid, C_MSG_SYSTEM, " * /commands /help /channel /channellist /join /userlist /query /unquery /me");
		#endif
	}
	return true;
}
YCMD:help(playerid, params[], help) {
	if(help) {
		SendClientMessage(playerid, C_MSG_SYSTEM, " * /help");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Displays help about your mode");
	} else {
		if(isnull(params)) {
			SendClientMessage(playerid, C_MSG_SYSTEM, " * Help");
			#if defined _inc_y_commands
				new
					tmp[128];
				format(tmp, sizeof tmp, " * Type \"/%s [command]\" for more help on a command", Command_GetDisplayNamed("help", playerid));
				SendClientMessage(playerid, C_MSG_SYSTEM, tmp);
			#else
				SendClientMessage(playerid, C_MSG_SYSTEM, " * Type \"/help [command]\" for more help on a command");
			#endif
		} else {
			#if defined _inc_y_commands
				Command_ReProcess(playerid, params, true);
			#endif
		}
	}
	return true;
}
YCMD:channel(playerid, player[], help) {
	if(help) {
		SendClientMessage(playerid, C_MSG_SYSTEM, " * /channel [player]");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Shows the current channel of the player");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Shows your own without parameter");
	} else {
		new
			id;
		if(isnull(player)) {
			id = playerid;
		} else {
			id = GetPlayerid(player);
			if(id == INVALID_PLAYER_ID) {
				SendClientMessage(playerid, C_MSG_SYSTEM, " * Invalid player");
				return true;
			}
		}
		new
			tmp[128] = " * ";
		GetPlayerName(id, tmp[3], MAX_PLAYER_NAME);
		GetPlayerChannel(id, tmp[16 + MAX_PLAYER_NAME], sizeof tmp);
		strcat(tmp, "'s channel #");
		strcat(tmp, tmp[16 + MAX_PLAYER_NAME]);
		SendClientMessage(playerid, C_MSG_SYSTEM, tmp);
	}
	return true;
}
YCMD:channellist(playerid, empty[], help) {
	#pragma unused empty
	if(help) {
		SendClientMessage(playerid, C_MSG_SYSTEM, " * /channellist");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Shows all channels with at least one player");
	} else {
		new
			i,
			j,
			count,
			channel[32],
			tmp[128] = " * ",
			bool: checked[MAX_PLAYERS char];
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Channellist");
		for( ; i != MAX_PLAYERS; ++i) {
			if(!checked{i} && IsPlayerConnected(i)) {
				for(j = count = 0; j != MAX_PLAYERS; ++j) {
					if(!checked{j} && (gl_nChannel[i] == gl_nChannel[j])) {
						checked{i} = true;
						++count;
					}
				}
				GetPlayerChannel(i, channel, sizeof channel);
				format(tmp, sizeof tmp, "%s#%s(%d) ", tmp, channel, count);
				if(tmp[sizeof tmp - sizeof channel - 6] != EOS) {
					SendClientMessage(playerid, C_MSG_SYSTEM, tmp);
					tmp[sizeof tmp - sizeof channel - 6] = EOS;
					tmp = " * ";
				}
			}
		}
		SendClientMessage(playerid, C_MSG_SYSTEM, tmp);
	}
	return true;
}
YCMD:join(playerid, channel[], help) {
	if(help || isnull(channel)) {
		SendClientMessage(playerid, C_MSG_SYSTEM, " * /join [channel]");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Joins a new channel (channel start always with a '#')");
	} else {
		if(channel[0] != '#') {
			SendClientMessage(playerid, C_MSG_SYSTEM, " * No such channel");
		} else {
			new
				hash = SDBM(channel[1]);
			if(gl_nChannel[playerid] == hash) {
				SendClientMessage(playerid, C_MSG_SYSTEM, " * You are already on this channel");
			} else {
				new
					tmp[128] = " * ";
				if(GetPlayerChannel(playerid, tmp[16 + MAX_PLAYER_NAME], sizeof tmp)) {
					GetPlayerName(playerid, tmp[3], MAX_PLAYER_NAME);
					strcat(tmp, " has left #");
					strcat(tmp, tmp[16 + MAX_PLAYER_NAME]);
					SendChannelMessage(gl_nChannel[playerid], C_MSG_ME, tmp);
				}
				CALL:userlist(playerid, channel);
				GetPlayerName(playerid, tmp[3], MAX_PLAYER_NAME);
				strcat(tmp, " has joined #");
				strcat(tmp, channel[1]);
				gl_nChannel[playerid] = hash;
				SetPlayerChannel(playerid, channel[1]);
				SendChannelMessage(hash, C_MSG_ME, tmp);
			}
		}
	}
	return true;
}
YCMD:userlist(playerid, channel[], help) {
	if(help) {
		SendClientMessage(playerid, C_MSG_SYSTEM, " * /userlist [channel]");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Shows the userlist of the give channel");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Without parameter from your current channel");
	} else {
		if(isnull(channel)) {
			channel[0] = gl_nChannel[playerid];
		} else {
			if(channel[0] != '#') {
				SendClientMessage(playerid, C_MSG_SYSTEM, " * No such channel");
				return true;
			}
			channel[0] = SDBM(channel[1]);
		}
		new
			i,
			name[MAX_PLAYER_NAME],
			tmp[128] = " * Userlist #";
		strcat(tmp, channel[1]);
		SendClientMessage(playerid, C_MSG_SYSTEM, tmp);
		for(tmp = " * "; i != MAX_PLAYERS; ++i) {
			if((gl_nChannel[i] == channel[0]) && GetPlayerName(i, name, sizeof name)) {
				format(tmp, sizeof tmp, "%s%s(%d) ", tmp, name, i);
				if(tmp[sizeof tmp - sizeof name - 6] != EOS) {
					SendClientMessage(playerid, C_MSG_SYSTEM, tmp);
					tmp[sizeof tmp - sizeof name - 6] = EOS;
					tmp = " * ";
				}
			}
		}
		if(tmp[3] == EOS) {
			SendClientMessage(playerid, C_MSG_SYSTEM, " * Empty channel");
		} else {
			SendClientMessage(playerid, C_MSG_SYSTEM, tmp);
		}
	}
	return true;
}
YCMD:query(playerid, player[], help) {
	if(help || isnull(player)) {
		SendClientMessage(playerid, C_MSG_SYSTEM, " * /query [player]");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Established a query with the given player");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Messages starting with @ are PMs (/unquery to terminate)");
	} else {
		new
			id = GetPlayerid(player);
		if(id == INVALID_PLAYER_ID) {
			SendClientMessage(playerid, C_MSG_SYSTEM, " * Invalid player");
		} else {
			if(id == playerid) {
				SendClientMessage(playerid, C_MSG_SYSTEM, " * You cant query yourself");
			} else {
				SendClientMessage(playerid, C_MSG_SYSTEM, " * Query established");
				gl_nQuery[playerid] = id;
			}
		}
	}
	return true;
}
YCMD:unquery(playerid, empty[], help) {
	#pragma unused empty
	if(help) {
		SendClientMessage(playerid, C_MSG_SYSTEM, " * /unquery");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Terminates the current query");
	} else {
		if(gl_nQuery[playerid] != INVALID_PLAYER_ID) {
			SendClientMessage(playerid, C_MSG_SYSTEM, " * Query terminated");
			gl_nQuery[playerid] = INVALID_PLAYER_ID;
		} else {
			SendClientMessage(playerid, C_MSG_SYSTEM, " * No query to terminate");
		}
	}
	return true;
}
YCMD:me(playerid, text[], help) {
	if(help || isnull(text)) {
		SendClientMessage(playerid, C_MSG_SYSTEM, " * /me [text]");
		SendClientMessage(playerid, C_MSG_SYSTEM, " * Shows a message in the format \"PLAYERNAME text\"");
	} else {
		new
			tmp[128];
		GetPlayerName(playerid, tmp, MAX_PLAYER_NAME);
		strcat(tmp, " ");
		strcat(tmp, text);
		SendChannelMessage(gl_nChannel[playerid], C_MSG_ME, tmp);
	}
	return true;
}
main() {
	new
		len = strlen(" *** " SCRIPT " " VERSION " by " SCRIPTER " *** ");
	printf("\r\n%.*s\r\n *** " SCRIPT " " VERSION " by " SCRIPTER " ***\r\n%.*s\r\n Credits to\r\n" CREDITS "\r\n%.*s\r\n",
		len, "--------------------------------------------------------------------------------------------",
		len, "--------------------------------------------------------------------------------------------",
		len, "--------------------------------------------------------------------------------------------");

	CallLocalFunction("ndChat_main", "");
}
stock nOnPlayerDisconnect(playerid) {
	if(gl_nQuery[playerid] != INVALID_PLAYER_ID) {
		for(new i; i != MAX_PLAYERS; ++i) {
			if(gl_nQuery[i] == playerid) {
				SendClientMessage(i, C_MSG_SYSTEM, " * Query partner disconnected");
			}
		}
		gl_nQuery[playerid] = INVALID_PLAYER_ID;
	}
	new
		tmp[128] = " * ";
	if(GetPlayerChannel(playerid, tmp[16 + MAX_PLAYER_NAME], sizeof tmp)) {
		GetPlayerName(playerid, tmp[3], MAX_PLAYER_NAME);
		strcat(tmp, " has left #");
		strcat(tmp, tmp[16 + MAX_PLAYER_NAME]);
		SendChannelMessage(gl_nChannel[playerid], C_MSG_ME, tmp);
	}
	return true;
}
public OnPlayerText(playerid, text[]) {
	if((text[0] == '@') && (gl_nQuery[playerid] != INVALID_PLAYER_ID)) {
		new
			tmp[128] = "( ";
		GetPlayerName(playerid, tmp[2], MAX_PLAYER_NAME);
		strcat(tmp, ": ");
		strcat(tmp, text[1]);
		strcat(tmp, " )");
		SendClientMessage(playerid, C_MSG_QUERY, tmp);
		SendClientMessage(gl_nQuery[playerid], C_MSG_QUERY, tmp);
		return false;
	}
	if(CallLocalFunction("ndChat_OnPlayerText", "is", playerid, text)) {
		for(new i; i != MAX_PLAYERS; ++i) {
			if(gl_nChannel[i] == gl_nChannel[playerid]) {
				SendPlayerMessageToPlayer(i, playerid, text);
			}
		}
	}
	return false;
}
#if defined _ALS_main
	#undef main
#else
	#define _ALS_main
#endif
#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif

#define main public ndChat_main
#define OnPlayerText ndChat_OnPlayerText

forward ndChat_main();
forward ndChat_OnPlayerText(playerid, text[]);

#if defined _inc_y_hooks
	Hook:ndChat_OnPlayerConnect(playerid) {
		CALL:join(playerid, DEFAULT);
	}
	Hook:ndChat_OnPlayerDisconnect(playerid, reason) {
		nOnPlayerDisconnect(playerid);
	}
#else
	public OnPlayerConnect(playerid) {
		CALL:join(playerid, DEFAULT);
		return CallLocalFunction("ndChat_OnPlayerConnect", "i", playerid);
	}
	public OnPlayerDisconnect(playerid, reason) {
		nOnPlayerDisconnect(playerid);
		return CallLocalFunction("ndChat_OnPlayerDisconnect", "ii", playerid, reason);
	}

	#if defined _ALS_OnPlayerConnect
		#undef OnPlayerConnect
	#else
		#define _ALS_OnPlayerConnect
	#endif
	#if defined _ALS_OnPlayerDisconnect
		#undef OnPlayerDisconnect
	#else
		#define _ALS_OnPlayerDisconnect
	#endif

	#define OnPlayerConnect ndChat_OnPlayerConnect
	#define OnPlayerDisconnect ndChat_OnPlayerDisconnect

	forward ndChat_OnPlayerConnect(playerid);
	forward ndChat_OnPlayerDisconnect(playerid, reason);
#endif