#include <a_samp>
#include <Streamer>
#include <sscanf2>
#include <zcmd>

#define MAX_ROBBERY_PICKUPS 10 // max 10 pickups per robbery
#define ROBBERY_DELAY 5 * 60 // 5 min

enum pData {
	epModel,
	Float: epX,
	Float: epY,
	Float: epZ,
	epExtra
}

new
	gPickupData[MAX_PICKUPS][pData],
	gRobber[MAX_PLAYERS] = {-1, ...};

enum lData {
	elInterior,
	Float: elX,
	Float: elY,
	Float: elZ,
	elPickups,
	elCount,
	elCountDown,
	elTimer,
	elLastRob,
	elCash,
	elRobber,
	Text: elRobbery,
	Text: elRobbed,
	Text: elCompletion
}

new RobberyLocations[][lData] = {
	{12, 1133.0699, -9.5731, 1000.6797} // RedsandsCasino
};

new RobberyNames[sizeof RobberyLocations][] = {
	"Redsands West Casino"
};

enum rData {
	erModel,
	Float: erX,
	Float: erY,
	Float: erZ
}

enum {
	PICKUP_CASH = 1212,
	PICKUP_MONEY = 1274
}

new const RedsandsCasino[][rData] = {
   {PICKUP_CASH, 1135.0880, -3.8712, 1000.6797},
   {PICKUP_CASH, 1134.9686, 0.6114, 1000.6797},
   {PICKUP_CASH, 1127.9138, 3.0049, 1000.6797},
   {PICKUP_CASH, 1126.9049, 3.0071, 1000.6797},
   {PICKUP_CASH, 1125.8707, 3.0053, 1000.6797},
   {PICKUP_CASH, 1124.8367, 3.0069, 1000.6797},
   {PICKUP_MONEY, 1132.8955, -1.6622, 1000.6797},
   {PICKUP_MONEY, 1125.0948, 1.5985, 1000.6797},
   {PICKUP_MONEY, 1119.0229, -1.7572, 1000.6911},
   {PICKUP_MONEY, 1125.2061, -5.0437, 1000.6797},
   {PICKUP_MONEY, 1128.7072, -1.7247, 1000.6797}

};

new const Float: GetawayLocations[][] = {
	{1110.6873, -306.7068, 73.9922}, 
	{1549.5365, -27.5008, 21.3255}, 
	{748.3065, 382.4322, 23.1719}, 
	{868.1728, -30.1904, 63.1953}, 
	{972.6216, -1256.0601, 16.9515}, 
	{830.9564, -1205.9083, 16.9766}, 
	{2452.3389, -2629.4285, 13.6641}, 
	{-902.8574, 2696.6189, 42.3703}, 
	{267.4315, 2889.4924, 10.7379}, 
	{-662.5790, 2305.8823, 136.0696}, 
	{-1979.1012, 430.4631, 25.2240}, 
	{-2502.0303, -699.5092, 139.3203}, 
	{-1650.8876, -2249.4426, 31.8059}, 
	{29.4854, -2661.0259, 40.5417}, 
	{-1108.9160, -1621.1917, 76.3672}, 
	{-80.4643, -1574.8823, 2.6107}, 
	{1655.0045, -1813.6067, 13.5450}, 
	{1607.7711, -1555.7310, 13.5811}, 
	{2612.4336, -1401.6194, 34.8997}
};

main() return ;

formatInt(value, delimiter = ',', currency = '$') {
    new
		step,
        tmp[16],
		ret[32],
		tpos = 0,
		rpos = (currency != 0);

	format(tmp, sizeof tmp, "%d", value);

	if(delimiter) {
		step = strlen(tmp);

		if(tmp[0] == '-') {
			tpos++;
			rpos++;
			step--;
		}
		if((step %= 3) == 0) {
			step = 3;
		}
		while(--step >= 0) {
			ret[rpos++] = tmp[tpos++];
		}
		while(tmp[tpos]) {
			ret[rpos++] = delimiter;

			#emit load.s.pri tpos
			#emit addr.alt tmp
			#emit idxaddr
			#emit push.pri

			#emit load.s.pri rpos
			#emit addr.alt ret
			#emit idxaddr
			#emit move.alt
			#emit pop.pri
			#emit movs 12

			tpos += 3;
			rpos += 3;
		}
	} else {
		strcat(ret[rpos], tmp, sizeof ret);
	}
	if(currency) {
		if(tmp[0] == '-') {
			ret[0] = '-';
			ret[1] = currency;
		} else {
			ret[0] = currency;
		}
	} else {
		if(tmp[0] == '-') {
			ret[0] = '-';
		}
	}
    return ret;
}

CreateRobberyPickup(model, Float: X, Float: Y, Float: Z, extra = 0, type = 1, virtualworld = 0) {
	type = CreatePickup(model, type, X, Y, Z, virtualworld);

	if(type != -1) {
		gPickupData[type][epModel] = model;
		gPickupData[type][epX] = X;
		gPickupData[type][epY] = Y;
		gPickupData[type][epZ] = Z;
		gPickupData[type][epExtra] = extra;
	}
	return type;
}

DestroyRobberyPickup(pickupid) {
	if(gPickupData[pickupid][epModel]) {		
		gPickupData[pickupid][epModel] = 0;

		return DestroyPickup(pickupid);
	}
	return false;
}

Float: GetAngleBetweenPoints(Float: x1, Float: y1, Float: x2, Float: y2) {
    return -atan2(x2 - x1, y2 - y1);
}

InitRobbery(idx, const pickups[][rData]) {
	new addr;

	#emit load.s.pri pickups
	#emit stor.s.pri addr

	RobberyLocations[idx][elPickups] = addr;
	RobberyLocations[idx][elTimer] = -1;
	RobberyLocations[idx][elCount] = 0;
	RobberyLocations[idx][elCash] = 0;
	RobberyLocations[idx][elLastRob] = 0;
	RobberyLocations[idx][elRobber] = 0;

	RobberyLocations[idx][elRobbery] = TextDrawCreate(400.0, 400.0, RobberyNames[idx]);
	RobberyLocations[idx][elRobbed] = TextDrawCreate(400.0, 410.0, "_");
	RobberyLocations[idx][elCompletion] = TextDrawCreate(400.0, 420.0, "_");
}

ResetRobbery(idx) {
	if(RobberyLocations[idx][elRobber]) {
		for(new i = GetPlayerPoolSize(); i >= 0; --i) {
			if(gRobber[i] == idx) {
				ResetPlayerRobbery(i);
			}
		}
	} else {
		KillTimer(RobberyLocations[idx][elTimer]);

		RobberyLocations[idx][elTimer] = -1;
		RobberyLocations[idx][elLastRob] = gettime() + ROBBERY_DELAY;

		TextDrawHideForAll(RobberyLocations[idx][elRobbery]);
		TextDrawHideForAll(RobberyLocations[idx][elRobbed]);
		TextDrawHideForAll(RobberyLocations[idx][elCompletion]);

		if(RobberyLocations[idx][elCount]) {
			for(new p; p < sizeof gPickupData; ++p) {
				switch(gPickupData[p][epModel]) {
					case PICKUP_CASH, PICKUP_MONEY: {
						if(gPickupData[p][epExtra] == idx) {
							DestroyRobberyPickup(p);
						}
					}
				}
			}
			RobberyLocations[idx][elCount] = 0;
		}
	}
}

ResetPlayerRobbery(playerid) {
	new idx = gRobber[playerid];

	if(idx != -1) {
		gRobber[playerid] = -1;

		if(--RobberyLocations[idx][elRobber] == 0) {
			ResetRobbery(idx);
		}
		TextDrawHideForPlayer(playerid, RobberyLocations[idx][elRobbery]);
		TextDrawHideForPlayer(playerid, RobberyLocations[idx][elRobbed]);
		TextDrawHideForPlayer(playerid, RobberyLocations[idx][elCompletion]);

		return RemovePlayerAttachedObject(playerid, 0);
	}
	return false;
}

IsPlayerAtRobbery(playerid, data[lData]) {
	if(	GetPlayerInterior(playerid) == data[elInterior] &&
		IsPlayerInRangeOfPoint(playerid, 100.0, data[elX], data[elY], data[elZ]))
	{
		if(gettime() < data[elLastRob]) return 4; // player needs to wait
		if(data[elTimer] != -1) { // robbery is already ongoing
			if(data[elCount]) return 2; // robbers @ casino

			return 3; // robbers to checkpoint
		}
		return 1;
	}
	return 0;
}

__StartRobbery(data[][rData], idx, location[lData], size = sizeof data) {
	if(size > MAX_ROBBERY_PICKUPS) { // randomize
		location[elCount] = MAX_ROBBERY_PICKUPS;

		new
			i, j, value,
			rand[MAX_ROBBERY_PICKUPS]
		;
		for(i = 0; i < sizeof rand; ++i) {
			value = random(size--);

			for(j = i; j > 0 && rand[j - 1] > value; --j) {
				rand[j] = rand[j - 1];
			}
			rand[j] = value;
		}
		for(i = 0; i < sizeof rand; ++i) {
			value = rand[i];

			for(j = i + 1; j < sizeof rand && rand[j] == value; ++j) {
				rand[j]++;
			}
		}
		while(--i >= 0) {
			j = rand[i];

			CreateRobberyPickup(data[j][erModel], data[j][erX], data[j][erY], data[j][erZ], idx);
		}
	} else { // create all pickups
		location[elCount] = size;

		while(--size >= 0) {
			CreateRobberyPickup(data[size][erModel], data[size][erX], data[size][erY], data[size][erZ], idx);
		}
	}
	new	tmp[32];

	format(tmp, sizeof tmp, "TAKE: ~g~$0 (~r~%d left~g~)", location[elCount]);
	TextDrawSetString(location[elRobbed], tmp);
	format(tmp, sizeof tmp, "Robbery Complete In: %d", location[elCountDown]);
	TextDrawSetString(location[elCompletion], tmp);
	return true;
}

_StartRobbery(playerid, idx, data[lData], time) {
	#pragma unused idx

	gRobber[playerid] = idx;

	SetPlayerAttachedObject(playerid, 0, 1550, 0, 0.105999, -0.160000, -0.018999, 0.099998, 89.299995, 174.300018, 0.758001, 0.782999, 0.729001);

	TextDrawShowForPlayer(playerid, data[elRobbery]);
	TextDrawShowForPlayer(playerid, data[elRobbed]);
	TextDrawShowForPlayer(playerid, data[elCompletion]);

	if(++data[elRobber] == 1) { // first time only
		data[elCountDown] = time;
		data[elCash] = 0;

		#emit load.s.pri data
		#emit stor.s.pri time

		data[elTimer] = SetTimerEx("RobberyCountdown", 1000, true, "ii", idx, time);

		playerid = data[elPickups];

		#emit lref.s.pri playerid
		#emit shr.c.pri 2
		#emit stor.s.pri time

		#emit const.pri __StartRobbery
		#emit add.c 4
		#emit sctrl 6
	}
	if(data[elCountDown] <= 0) {
		SetPlayerWantedLevel(playerid,  GetPlayerWantedLevel(playerid) + 4);
	}
	return true;
}

StartRobbery(playerid, idx, data[][lData], time = 0) {
	#pragma unused playerid, time

	#emit load.s.pri idx // doesn't do anything special
	#emit load.s.alt data // only jumps to _StartRobbery
	#emit idxaddr
	#emit move.alt
	#emit load.i
	#emit add
	#emit stor.s.pri data

	#emit const.pri _StartRobbery
	#emit add.c 4
	#emit sctrl 6
}

forward RobberyCountdown(idx, data[lData]);
public RobberyCountdown(idx, data[lData]) {
	if(--data[elCountDown] <= 0) {
		new
			i,
			level,
			tmp[144];

		for(i = GetPlayerPoolSize(); i >= 0; --i) {
			if(gRobber[i] == idx) {
				level = GetPlayerWantedLevel(i) + 4;

				SendClientMessage(i, -1, "{FFFFFF}The alarm has been triggered and the cops are on their way!");
				format(tmp, sizeof tmp, "Crime Committed! Attempted %s Robbery. Wanted Level increased to %i.", RobberyNames[idx], level);
				SendClientMessage(i, -1, tmp);

				SetPlayerWantedLevel(i, level);
			}
		}
		TextDrawSetString(data[elCompletion], "~r~Cops are on the way");
		KillTimer(data[elTimer]);
	} else {
		new tmp[32];
		format(tmp, sizeof tmp, "Robbery Complete In: %d", data[elCountDown]);
		TextDrawSetString(data[elCompletion], tmp);
    }
	return 1;
}

CMD:robbery(playerid, params[]) {
	if(gRobber[playerid] != -1) {
		return SendClientMessage(playerid, -1, "{FF0000}[ERROR]: {FFFFFF}Finish your Robbery first!");
	}
	for(new i; i < sizeof RobberyLocations; ++i) {
		switch(IsPlayerAtRobbery(playerid, RobberyLocations[i])) {
			case 3, 4: {
				return SendClientMessage(playerid, -1, "This location can't be robbed at the moment");
			}
			case 2: {
				StartRobbery(playerid, i, RobberyLocations);

				SendClientMessage(playerid, -1, "Robbery Begin!");
				return true;
			}
			case 1: {
				StartRobbery(playerid, i, RobberyLocations, 10 + random(51));

				SendClientMessage(playerid, -1, "{EDED05}Robbery {FFFFFF}Began! Please do not {FF0000}Leave {FFFFFF}this {EDED05}place{FFFFFF}.");
				SendClientMessage(playerid, -1, "You are the Leader of this Robbery. Type {33FF33}/stoprobbery{FFFFFF} to cancel the robbery at it's current instance.");
				return true;
			}
		}  
	}
	return SendClientMessage(playerid, -1, "{FF0000}[ERROR]: {FFFFFF}You Are Not At A Robbery Checkpoint / Vicinity!");
}

public OnGameModeInit() {	
	SetGameModeText("Robbery System");
	AddPlayerClass(19, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	AddStaticVehicle(411, 2028.9069, 1342.8992, 10.7126, 358.2861, 75, 67);

	InitRobbery(0, RedsandsCasino); // concatenates RobberyLocations[0] with the RedsandsCasino array
}

public OnPlayerRequestClass(playerid, classid) {
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);

	return true;
}

public OnPlayerSpawn(playerid) {
	ApplyAnimation(playerid, "BSKTBALL", "null", 0.0, 0, 0, 0, 0, 0);

	return true;
}

public OnPlayerDeath(playerid, killerid, reason) {
	SendDeathMessage(playerid, playerid, reason);

	if(gRobber[playerid] != -1) {
		new
			tmp[144],
			level = GetPlayerWantedLevel(playerid) + 4;

		SendClientMessage(playerid, -1, "You have {FF0000}failed {FFFFFF}to conduct the Robbery!");
		format(tmp, sizeof tmp, "Crime Committed! Attempted %s Robbery. Wanted Level increased to %i.", RobberyNames[gRobber[playerid]], level);
		SendClientMessage(playerid, -1, tmp);
		SetPlayerWantedLevel(playerid, level);

		ResetPlayerRobbery(playerid);
	}
	return true;
}

public OnPlayerPickUpPickup(playerid, pickupid) {
	switch(gPickupData[pickupid][epModel]) {
		case PICKUP_CASH, PICKUP_MONEY: {
			new idx = gRobber[playerid];

			if(idx == gPickupData[pickupid][epExtra]) {
				new
					tmp[144],
					Float: x,
					Float: y,
					Float: z;

				ClearAnimations(playerid);
				GetPlayerPos(playerid, x, y, z);
				SetPlayerFacingAngle(playerid, GetAngleBetweenPoints(x, y, gPickupData[pickupid][epX], gPickupData[pickupid][epY]));
				ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.1, 0, 1, 1, 0, 700);

				RobberyLocations[idx][elCash] += 8000 + random(4001);

				if(--RobberyLocations[idx][elCount] == 0) {
					new i = random(sizeof GetawayLocations);

					format(tmp, sizeof tmp, " {33FF33}%s {FFFFFF} stolen from {EDED05}%s{FFFFFF}.", formatInt(RobberyLocations[idx][elCash]), RobberyNames[idx]);
					SendClientMessageToAll(-1, tmp);

					x = GetawayLocations[i][0];
					y = GetawayLocations[i][1];
					z = GetawayLocations[i][2];

					for(i = GetPlayerPoolSize(); i >= 0; --i) {
						if(gRobber[i] == idx) {
							SetPlayerCheckpoint(i, x, y, z, 25.0);
						}
					}
					format(tmp, sizeof tmp, "TAKE: ~g~%s (COMPLETED)", formatInt(RobberyLocations[idx][elCash]));
				} else {
					format(tmp, sizeof tmp, "TAKE: ~g~%s (~r~%d left~g~)", formatInt(RobberyLocations[idx][elCash]), RobberyLocations[idx][elCount]);
				}
				TextDrawSetString(RobberyLocations[idx][elRobbed], tmp);

				DestroyRobberyPickup(pickupid);
			}
		}
	}
    return 1;
}

public OnPlayerEnterCheckpoint(playerid) {
	new idx = gRobber[playerid];

	if(idx != -1) {
		DisablePlayerCheckpoint(playerid);

		new
			i,
			tmp[144],
			money = RobberyLocations[idx][elCash] / RobberyLocations[idx][elRobber];

		GetPlayerName(playerid, tmp, MAX_PLAYER_NAME);
		format(tmp, sizeof tmp, " [%s Robbery]: {FFD700}%s(%d) {FFFFFF}has received {33FF33}%s{FFFFFF}.", RobberyNames[idx], tmp, playerid, formatInt(money));

		for(i = GetPlayerPoolSize(); i >= 0; --i) {
			if(gRobber[i] == idx) {
				SendClientMessage(i, -1, tmp);
			}
		}
		RobberyLocations[idx][elCash] -= money;
		GivePlayerMoney(playerid, money);
		ResetPlayerRobbery(playerid);
	}
	return true;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) {
	new idx = gRobber[playerid];

	if(idx != -1) {
		if(RobberyLocations[idx][elCount]) {
			new
				tmp[144],
				level = GetPlayerWantedLevel(playerid) + 4;

			SendClientMessage(playerid, -1, "You have {FF0000}failed {FFFFFF}to conduct the Robbery!");
			format(tmp, sizeof tmp, "Crime Committed! Attempted %s Robbery. Wanted Level increased to %i.", RobberyNames[gRobber[playerid]], level);
			SendClientMessage(playerid, -1, tmp);
			SetPlayerWantedLevel(playerid, level);

			ResetPlayerRobbery(playerid);
		}
	}
}