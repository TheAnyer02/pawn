/*
 *	Position Saver v 1.2r
 *
 *	Copyright (C)   12. June 2010   Nero_3D
 *	Permission is granted to copy, distribute and/or modify this document
 *	under the terms of the GNU General Public License, Version 3
 *	or any later version published by the Free Software Foundation;
 *	A copy of the license can be found at www.gnu.org/licenses/gpl-3.0.html
 *
 *	v 1.0 -> 1.1
 *	- Autosave added
 *	- Autoload added
 *
 *	v 1.1 -> 1.2r (remade)
 *	- Default Teleports
 *	- ps_tele added
 *	- PoN dedection
 *	- OPCT rewritten
 */

#include <a_samp>

#define PS_TELEPORT_DIALOG (false)

#define PS_SHOW_DIALOG_LINES (10)

#define PS_MESSAGE_COLOR (0xFFFFFFAA)

stock PS_Default_Teleports(playerid) {
	//PS_Add_Default_Teleport(playerid, name[], Float:X, Float:Y, Float:Z, Interiorid)
	PS_Add_Default_Teleport(playerid, "Los Santos", 1481.3549, -1790.7388, 156.7533, 0);
	PS_Add_Default_Teleport(playerid, "San Fierro", -1791.1746, 567.7983, 332.8019, 0);
	PS_Add_Default_Teleport(playerid, "Las Venturas", 2399.2349, 1903.0409, 77.4118, 0);
}

#define PS_AUTOSAVE (true)
#define PS_AUTOLOAD (true)

#define PS_LOAD_DIALOGID (47)
#define PS_TELE_DIALOGID (55)
#define PS_DELETE_DIALOGID (39)
#define PS_COUNTER_PVAR ("PS_Counter")

#define PS_FILTER_SCRIPT_NAME	"Position Saver FS by Joker"

forward PS_Save_File(playerid);
forward PS_Load_File(playerid);
forward PS_Load_Default(playerid);
forward PS_Save(playerid, params[]);
forward PS_Load(playerid, params[]);
forward PS_Delete(playerid, params[]);
#if PS_TELEPORT_DIALOG == true
	forward PS_Tele(playerid, params[]);
#endif

public OnFilterScriptInit() {
	SendClientMessageToAll(PS_MESSAGE_COLOR, "Filterscript " PS_FILTER_SCRIPT_NAME " loaded!");
	for(new i; i != MAX_PLAYERS; i++) {
		if(PS_Load_File(i) == 0) {
			PS_Load_Default(i);
		}
	}
	return 1;
}

public OnFilterScriptExit() {
	for(new i; i != MAX_PLAYERS; i++) {
		PS_Delete_Data(i);
	}
	return 1;
}

public OnPlayerConnect(playerid) {
	SendClientMessage(playerid, PS_MESSAGE_COLOR, "This server is using " PS_FILTER_SCRIPT_NAME "!");
	if(PS_Load_File(playerid) == 0) {
		PS_Load_Default(playerid);
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
	if(strcmp("/ps", cmdtext, true, 3) == 0) {
		if(cmdtext[3] == EOS || cmdtext[4] == EOS) {
			#if PS_TELEPORT_DIALOG == true
				return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Position Saver Help: /ps [save|load|delete|tele] (/ps [name] /? for more information)");
			#else
				return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Position Saver Help: /ps [save|load|delete] (/ps [name] /? for more information)");
			#endif
		} else if(strcmp("save", cmdtext[4], true, 4) == 0) {
			if(tolower(cmdtext[8]) == 'f') {
				if(PS_Save_File(playerid))
					return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Positions saved to file!");
			} else if(cmdtext[8] == ' ') {
				if(cmdtext[9] == '/' && cmdtext[10] == '?') {
					return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Position Saver Help: /ps [save|savef] (f - file)");
				}
				return PS_Save(playerid, cmdtext[9]);
			} else if(cmdtext[8] == EOS) {
					return PS_Save(playerid, "");
			}
			return 0;
		} else if(strcmp("load", cmdtext[4], true, 4) == 0) {
			if(tolower(cmdtext[8]) == 'f') {
				if(PS_Load_File(playerid) == 0)
						return SendClientMessage(playerid, PS_MESSAGE_COLOR, "You didnt saved a file!");
				else	return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Positions loaded from file!");
			} else if(cmdtext[8] == 'd') {
				if(PS_Load_Default(playerid))
					return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Default Positions loaded!");
			} else if(cmdtext[8] == ' ') {
				if(cmdtext[9] == '/' && cmdtext[10] == '?') {
					return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Position Saver Help: /ps [load|loadf|loadd] (f - file | d - default)");
				}
				return PS_Load(playerid, cmdtext[9]);
			} else if(cmdtext[8] == EOS) {
				return PS_Load(playerid, "");
			}
			return 0;
		} else if(strcmp("delete", cmdtext[4], true, 6) == 0) {
			if(cmdtext[10] == ' ') {
				if(cmdtext[11] == '/' && cmdtext[12] == '?') {
					return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Position Saver Help: /ps delete [id|part_of_name]");
				}
				return PS_Delete(playerid, cmdtext[11]);
			} else if(cmdtext[10] == EOS) {
				return PS_Delete(playerid, "");
			}
			return 0;
		}
	#if PS_TELEPORT_DIALOG == true
		else if(strcmp("tele", cmdtext[4], true, 4) == 0) {
			if(cmdtext[8] == ' ') {
				if(cmdtext[9] == '/' && cmdtext[10] == '?') {
					return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Position Saver Help: /ps tele [id|part_of_name]");
				}
				return PS_Tele(playerid, cmdtext[9]);
			} else if(cmdtext[8] == EOS) {
				return PS_Tele(playerid, "");
			}
			return 0;
		}
		return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Position Saver Help: /ps [save|load|delete|tele] (/ps [name] /? for more information)");
	#else
		return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Position Saver Help: /ps [save|load|delete] (/ps [name] /? for more information)");
	#endif
	}
	return 0;
}

public PS_Save(playerid, params[]) {
	if(params[0] == EOS) {
		return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Right usage: /ps save [name]");
	}
	if(strlen(params) > 24) {
		return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Use a key word! (max 24 character)");
	}
	new Float:A;
	if(GetPlayerFacingAngle(playerid, A)) {
		new	Float:X,
			Float:Y,
			Float:Z,
			temp[25];
		toupper(params[0]), GetPlayerPos(playerid, X, Y, Z);
		temp[0] = GetPVarInt(playerid, PS_COUNTER_PVAR);
		format(temp[1], sizeof temp, "I_%d", temp[0]);
		SetPVarInt(playerid, temp[1], GetPlayerInterior(playerid));
		temp[1] = 'S', SetPVarString(playerid, temp[1], params);
		SetPVarInt(playerid, PS_COUNTER_PVAR, temp[0] + 1);
		temp[1] = 'X', SetPVarFloat(playerid, temp[1], X);
		temp[1] = 'Y', SetPVarFloat(playerid, temp[1], Y);
		temp[1] = 'Z', SetPVarFloat(playerid, temp[1], Z);
		#if PS_AUTOSAVE == true
			PS_Save_Line(playerid, temp[0]);
		#endif
		format(temp, sizeof temp, "Position saved (%d)!", temp[0]);
		return SendClientMessage(playerid, PS_MESSAGE_COLOR, temp);
	}
	return 0;
}

#if PS_AUTOSAVE == true
	stock PS_Save_Line(playerid, const id) {
		new	Float:X,
			string[128];
		format(string, sizeof string, "X_%d", id);
		if((X = GetPVarFloat(playerid, string)) != 0.0) {
			if(GetPlayerName(playerid, string, MAX_PLAYER_NAME)) {
				new I,
					Float:Y,
					Float:Z,
					File:gfile;
				format(string, sizeof string, "PSJ_%s.inc", string);
				if(fexist(string) == 0) gfile = fopen(string, io_write);
				else gfile = fopen(string, io_append);
				format(string, sizeof string, "Y_%d", id);
				Y = GetPVarFloat(playerid, string), string[0] = 'Z';
				Z = GetPVarFloat(playerid, string), string[0] = 'I';
				I = GetPVarInt(playerid, string), string[0] = 'S';
				GetPVarString(playerid, string, string, 25);
				format(string, sizeof string, "%8.8f %8.8f %8.8f %2d %s\r\n", X, Y, Z, I, string);
				fwrite(gfile, string);
				return fclose(gfile);
			}
		}
		return 0;
	}
#endif

public PS_Load(playerid, params[]) {
	if(params[0] == EOS) {
		if(PS_Show_Dialog(playerid, PS_LOAD_DIALOGID, 0) == 0) {
			PS_Load_Default(playerid);
			PS_Show_Dialog(playerid, PS_LOAD_DIALOGID, 0);
		}
		return 1;
	}
	new temp[MAX_PLAYER_NAME];
	if(PS_Get_ID(playerid, params, temp, "Right Usage: /ps load [id|part_of_name]")) {
		return 1;
	}
	format(temp[1], sizeof temp, "X_%d", temp[0]);
	new Float:Y,
		Float:X = GetPVarFloat(playerid, temp[1]);
	temp[1] = 'Y', Y = GetPVarFloat(playerid, temp[1]);
	temp[1] = 'Z', SetPlayerPos(playerid, X, Y, GetPVarFloat(playerid, temp[1]));
	temp[1] = 'I', SetPlayerInterior(playerid, GetPVarInt(playerid, temp[1]));
	return 1;
}

public PS_Delete(playerid, params[]) {
	if(params[0] == EOS) {
		if(PS_Show_Dialog(playerid, PS_DELETE_DIALOGID, 0) == 0) {
			SendClientMessage(playerid, PS_MESSAGE_COLOR, "Nothing saved!");
		}
		return 1;
	}
	new temp[MAX_PLAYER_NAME];
	if(PS_Get_ID(playerid, params, temp, "Right Usage: /ps delete [id|part_of_name]")) {
		return 1;
	}
	format(temp[1], sizeof temp, "X_%d", temp[0]);
	DeletePVar(playerid, temp[1]), temp[1] = 'Y';
	DeletePVar(playerid, temp[1]), temp[1] = 'Z';
	DeletePVar(playerid, temp[1]), temp[1] = 'S';
	DeletePVar(playerid, temp[1]), temp[1] = 'I';
	DeletePVar(playerid, temp[1]);
	#if PS_AUTOSAVE == true
		PS_Save_File(playerid);
		PS_Load_File(playerid);
	#endif
	return 1;
}

stock PS_Get_ID(playerid, params[], temp[MAX_PLAYER_NAME], text[]) {
	if(('0' <= params[0]) && (params[0] <= '9')) {
		temp[0] = strval(params);
		if((temp[0] == 0) && (params[0] != '0')) {
			return SendClientMessage(playerid, PS_MESSAGE_COLOR, text);
		}
		format(temp[1], sizeof temp, "X_%d", temp[0]);
		if(GetPVarFloat(playerid, temp[1]) == 0.0) {
			return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Invalid id!");
		}
	} else {
		if(strlen(params) < 3) {
			return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Enter more character of the name!");
		}
		new cmax = (GetPVarInt(playerid, PS_COUNTER_PVAR) - 1);
		for( ; cmax != -1; cmax--) {
			format(temp, sizeof temp, "X_%d", cmax);
			if(GetPVarFloat(playerid, temp[1]) != 0.0) {
				temp[0] = 'S', GetPVarString(playerid, temp, temp, sizeof temp);
				if(strfind(temp, params, true) != -1) {
					temp[0] = cmax;
					break;
				}
			}
		}
		if(cmax == -1) {
			return SendClientMessage(playerid, PS_MESSAGE_COLOR, "No teleport found!");
		}
	}
	return 0;
}

stock PS_Delete_Data(playerid) {
	new cmax = GetPVarInt(playerid, PS_COUNTER_PVAR);
	if(cmax != 0) {
		new temp[10];
		for(cmax--; cmax != -1; cmax--) {
			format(temp, sizeof temp, "X_%d", cmax);
			if(GetPVarFloat(playerid, temp) == 0.0) {
				continue;
			}
			DeletePVar(playerid, temp), temp[0] = 'Y';
			DeletePVar(playerid, temp), temp[0] = 'Z';
			DeletePVar(playerid, temp), temp[0] = 'S';
			DeletePVar(playerid, temp), temp[0] = 'I';
			DeletePVar(playerid, temp);
		}
		DeletePVar(playerid, PS_COUNTER_PVAR);
		return 1;
	}
	return 0;
}

public PS_Load_Default(playerid) {
	if(IsPlayerConnected(playerid)) {
		PS_Delete_Data(playerid);
		PS_Default_Teleports(playerid);
		DeletePVar(playerid, "PS_Adder");
		SetPVarInt(playerid, PS_COUNTER_PVAR, 3);
		return 1;
	}
	return 0;
}

stock PS_Add_Default_Teleport(playerid, name[], Float:X, Float:Y, Float:Z, Interiorid) {
	new	string[10],
		number = GetPVarInt(playerid, "PS_Adder");
	format(string, sizeof string, "S_%d", number);
	SetPVarString(playerid, string, name), string[0] = 'X';
	SetPVarFloat(playerid, string, X), string[0] = 'Y';
	SetPVarFloat(playerid, string, Y), string[0] = 'Z';
	SetPVarFloat(playerid, string, Z), string[0] = 'I';
	SetPVarInt(playerid, string, Interiorid);
	SetPVarInt(playerid, "PS_Adder", (++number));
	return number;
}

public PS_Save_File(playerid) {
	new string[128];
	if(GetPlayerName(playerid, string, MAX_PLAYER_NAME)) {
		format(string, sizeof string, "PSJ_%s.inc", string);
		new File:gfile = fopen(string, io_write);
		if(gfile) {
			new	i,
				I,
				cmax,
				Float:X,
				Float:Y,
				Float:Z;
			for(cmax = GetPVarInt(playerid, PS_COUNTER_PVAR); i < cmax; i++) {
				format(string, sizeof string, "X_%d", i);
				if((X = GetPVarFloat(playerid, string)) == 0.0) {
					continue;
				}
				string[0] = 'Y', Y = GetPVarFloat(playerid, string);
				string[0] = 'Z', Z = GetPVarFloat(playerid, string);
				string[0] = 'I', I = GetPVarInt(playerid, string);
				string[0] = 'S', GetPVarString(playerid, string, string, 25);
				format(string, sizeof string, "%8.8f %8.8f %8.8f %2d %s\r\n", X, Y, Z, I, string);
				fwrite(gfile, string);
			}
			return fclose(gfile);
		}
	}
	return 0;
}

public PS_Load_File(playerid) {
	new string[128];
	if(GetPlayerName(playerid, string, MAX_PLAYER_NAME)) {
		format(string, sizeof string, "PSJ_%s.inc", string);
		new File:gfile = fopen(string, io_read);
		if(gfile) {
			new	count,
				temp[10];
			PS_Delete_Data(playerid);
			while(fread(gfile, string)) {
				if(string[0] != EOS) {
					string[17] = EOS;
					string[35] = EOS;
					string[53] = EOS;
					string[56] = EOS;
					string[(55 + strlen(string[57]))] = EOS;
					format(temp, sizeof temp, "X_%d", count++);
					SetPVarFloat(playerid, temp, floatstr(string)), temp[0] = 'Y';
					SetPVarFloat(playerid, temp, floatstr(string[18])), temp[0] = 'Z';
					SetPVarFloat(playerid, temp, floatstr(string[36])), temp[0] = 'I';
					SetPVarInt(playerid, temp, strval(string[54])), temp[0] = 'S';
					SetPVarString(playerid, temp, string[57]);
				}
			}
			SetPVarInt(playerid, PS_COUNTER_PVAR, count);
			return fclose(gfile);
		}
	}
	return 0;
}

stock PS_Show_Dialog(playerid, const dialogid, start) {
	new cmax,
		temp[25],
		counter = start,
		tmp[50 + (64 * PS_SHOW_DIALOG_LINES)];
	if(((cmax = GetPVarInt(playerid, PS_COUNTER_PVAR)) - start) > 0) {
		new I,
			Float:X,
			Float:Y,
			Float:Z;
		if(start != 0) {
			if((start - PS_SHOW_DIALOG_LINES) < 0) {
				format(tmp, sizeof tmp, "\r\nPrevious Page (%d..%d)", 0, (PS_SHOW_DIALOG_LINES - 1));
			} else {
				format(tmp, sizeof tmp, "\r\nPrevious Page (%d..%d)", (start - PS_SHOW_DIALOG_LINES), (start - 1));
			}
		}
		for(start += PS_SHOW_DIALOG_LINES; counter != start && counter != cmax; counter++) {
			format(temp, sizeof temp, "X_%d", counter);
			if((X = GetPVarFloat(playerid, temp)) == 0.0) {
				continue;
			}
			temp[0] = 'Y', Y = GetPVarFloat(playerid, temp);
			temp[0] = 'Z', Z = GetPVarFloat(playerid, temp);
			temp[0] = 'I', I = GetPVarInt(playerid, temp);
			temp[0] = 'S', GetPVarString(playerid, temp, temp, 25);
			format(tmp, sizeof tmp, "%s\r\n%d. \"%s\" (%.2f, %.2f, %.2f, %d)", tmp, counter, temp, X, Y, Z, I);
		}
		if(counter == start) {
			if(counter == (--cmax)) {
				format(tmp, sizeof tmp, "%s\r\nNext Page (%d)", tmp, counter);
			} else if((counter + PS_SHOW_DIALOG_LINES) > cmax) {
				format(tmp, sizeof tmp, "%s\r\nNext Page (%d..%d)", tmp, counter, cmax);
			} else {
				format(tmp, sizeof tmp, "%s\r\nNext Page (%d..%d)", tmp, counter, (counter + PS_SHOW_DIALOG_LINES - 1));
			}
		}
		return ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, PS_FILTER_SCRIPT_NAME, tmp[2], "Okay", "Cancel");
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
	    case PS_LOAD_DIALOGID: {
			if(response) {
				if(inputtext[0] == 'P') {
					inputtext[18] = EOS;
					return PS_Show_Dialog(playerid, PS_LOAD_DIALOGID, strval(inputtext[15]));
				}
				if(inputtext[0] == 'N') {
					inputtext[14] = EOS;
					return PS_Show_Dialog(playerid, PS_LOAD_DIALOGID, strval(inputtext[11]));
				}
				inputtext[3] = EOS;
				return PS_Load(playerid, inputtext);
			}
		}
		case PS_DELETE_DIALOGID: {
			if(response) {
				if(inputtext[0] == 'P') {
					inputtext[18] = EOS;
					return PS_Show_Dialog(playerid, PS_DELETE_DIALOGID, strval(inputtext[15]));
				}
				if(inputtext[0] == 'N') {
					inputtext[14] = EOS;
					return PS_Show_Dialog(playerid, PS_DELETE_DIALOGID, strval(inputtext[11]));
				}
				inputtext[3] = EOS;
				return PS_Delete(playerid, inputtext);
			}
		}
#if PS_TELEPORT_DIALOG == true
		case PS_TELE_DIALOGID: {
			if(response) {
				if(inputtext[0] == 'P') {
					inputtext[18] = EOS;
					return PS_Show_Dialog(playerid, PS_TELE_DIALOGID, strval(inputtext[15]));
				}
				if(inputtext[0] == 'N') {
					inputtext[14] = EOS;
					return PS_Show_Dialog(playerid, PS_TELE_DIALOGID, strval(inputtext[11]));
				}
				inputtext[3] = EOS;
				return PS_Tele(playerid, inputtext);
			}
		}
#endif
	}
	return 0;
}

stock PS_Tele_Dialog(playerid, const dialogid, start) {
	new i,
		Float:X,
		Float:Y,
		Float:Z,
		counter = start,
		name[MAX_PLAYER_NAME],
		tmp[50 + (64 * PS_SHOW_DIALOG_LINES)];
	if(start != 0) {
		if((start - PS_SHOW_DIALOG_LINES) < 0) {
			format(tmp, sizeof tmp, "\r\nPrevious Page (%d..%d)", 0, (PS_SHOW_DIALOG_LINES - 1));
		} else {
			format(tmp, sizeof tmp, "\r\nPrevious Page (%d..%d)", (start - PS_SHOW_DIALOG_LINES), (start - 1));
		}
	}
	for(start += PS_SHOW_DIALOG_LINES; counter != start && i != MAX_PLAYERS; i++) {
		if(GetPlayerPos(i, X, Y, Z)) {
			counter++;
			GetPlayerName(i, name, sizeof name);
			format(tmp, sizeof tmp, "%s\r\n%d. \"%s\" (%.2f, %.2f, %.2f, %d)", tmp, i, name, X, Y, Z, GetPlayerInterior(i));
		}
	}
	if(counter == start) {
		if(counter == (MAX_PLAYERS - 1)) {
			format(tmp, sizeof tmp, "%s\r\nNext Page (%d)", tmp, (MAX_PLAYERS - 1));
		} else if((counter + PS_SHOW_DIALOG_LINES) > (MAX_PLAYERS - 1)) {
			format(tmp, sizeof tmp, "%s\r\nNext Page (%d..%d)", tmp, counter, (MAX_PLAYERS - 1));
		} else {
			format(tmp, sizeof tmp, "%s\r\nNext Page (%d..%d)", tmp, counter, (counter + PS_SHOW_DIALOG_LINES - 1));
		}
	}
	return ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, PS_FILTER_SCRIPT_NAME, tmp[2], "Okay", "Cancel");
}

#if PS_TELEPORT_DIALOG == true
	public PS_Tele(playerid, params[]) {
		if(params[0] == EOS) {
			return PS_Tele_Dialog(playerid, PS_TELE_DIALOGID, 0);
		}
		new temp[25];
		if(('0' <= params[0]) && (params[0] <= '9')) {
			temp[0] = strval(params);
			if((temp[0] == 0) && (params[0] != '0')) {
				return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Right Usage: /ps tele [id|part_of_name]");
			}
			if(IsPlayerConnected(temp[0]) == 0) {
				return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Invalid playerid!");
			}
		} else {
			if(strlen(params) < 3) {
				return SendClientMessage(playerid, PS_MESSAGE_COLOR, "Enter more character of the name!");
			}
			new i;
			for( ; i != MAX_PLAYERS; i++) {
				if(GetPlayerName(i, temp, MAX_PLAYER_NAME)) {
					if(strfind(temp, params, true) != -1) {
						temp[0] = i;
						break;
					}
				}
			}
			if(i == MAX_PLAYERS) {
				return SendClientMessage(playerid, PS_MESSAGE_COLOR, "No player with that part found!");
			}
		}
		new	I,
			VW,
			Float:X,
			Float:Y,
			Float:Z;
		GetPlayerPos(temp[0], X, Y, Z);
		I = GetPlayerInterior(temp[0]);
		VW = GetPlayerVirtualWorld(temp[0]);
		SetPlayerInterior(playerid, I);
		SetPlayerVirtualWorld(playerid, VW);
		if(IsPlayerInAnyVehicle(playerid)) {
			playerid = GetPlayerVehicleID(playerid);
			SetVehiclePos(playerid, X, Y, Z);
			LinkVehicleToInterior(playerid, I);
			SetVehicleVirtualWorld(playerid, VW);
		} else {
			SetPlayerPos(playerid, X, Y, Z);
		}
		return 1;
	}
#endif
