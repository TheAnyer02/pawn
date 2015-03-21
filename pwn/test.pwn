#include <a_samp>

/**
  *	<section> Test FilterScript </section>
  *
  */

//#include <ntest>
//#include <sscanf2>
//#include <pointers>
//#include <offset>
//#include <called>

/*
RX = asin(Rotation.getZ()) * RADIAN_TO_DEG - 90.0;
RZ = atan2(Rotation.getY(), Rotation.GetX()) * RADIAN_TO_DEG;
*/

/*
#define DEBUG 2

#if DEBUG != 0
    #define debug(%0, debug%0(

    #if DEBUG >= 1
        #define debug1(%0); printf(%0);
    #else
        #define debug1(%0);
    #endif
    #if DEBUG >= 2
        #define debug2(%0); printf(%0);
    #else
        #define debug2(%0);
    #endif
#else
    #define debug(%0);
#endif


#include <collision>
#include <nrace>

stock Float: RaceOne[][] = {
	{ -1145.5658, -1045.6901, 128.5027, 25.0 },
	{ -1183.2870, -1002.4471, 128.5025, 25.0 },
	{ -1172.3785, -988.5954, 128.5025, 25.0 },
	{ -1129.6694, -1018.2800, 128.5025, 25.0 },
	{ -1098.4072, -1057.1410, 128.4954, 25.0 },
	{ -1045.0264, -1022.5968, 128.4956, 25.0 },
	{ -1011.6423, -980.4113, 128.5025, 25.0 },
	{ -1035.6104, -953.7844, 128.5026, 25.0 },
	{ -1081.0226, -997.9811, 128.5026, 25.0 },
	{ -1089.9166, -962.7728, 128.5025, 25.0 },
	{ -1123.8011, -964.7301, 128.5021, 25.0 },
	{ -1156.1207, -932.0033, 128.5025, 25.0 },
	{ -1210.1948, -1017.1234, 127.5494, 25.0 },
	{ -1145.9674, -1034.9795, 128.5025, 25.0 }
};

Init() {
	debug(1, "%d %f %f",  LineInSphere(Float: {0.0, 0.0, 0.0}, Float: {-1.0, 2.0, 3.0}, Float: {1.0, 1.0, 1.0}, 1.0));

	printf("%032b", 1.0);
	printf("%032b", 2.0);
	printf("%032b", 3.0);
	printf("%032b", 4.0);
	printf("%032b", 5.0);

	SetPlayerFirstRaceCheckpoint(0, RaceOne);
}
*/
/*
#include <quat>

new
	object
;

stock Float: GetZAngle(Float: X1, Float: Y1, Float: X2, Float: Y2) {
    return -atan2(X2 - X1, Y2 - Y1);
}

stock Float: GetXYAngle(Float: X1, Float: Y1, Float: Z1, Float: X2, Float: Y2, Float: Z2) {
    return atan((Z2 - Z1) / VectorSize(X2 - X1, Y2 - Y1, 0.0));
}

Init() {
	object = CreateObject(345, 0.0, 0.0, 7.0, 0.0, 0.0, 0.0);

	new	Float: X, Float: Y, Float: Z;
	QuatRotateVector(0.5, 0.5, 0.5, 0.5, 5.0, 6.0, 7.0, X, Y, Z);

	printf("%f %f %f", X, Y, Z);

	printf("%f", GetXYAngle(0.0, 0.0, 0.0, 1.0, 0.0, -1.0));
	printf("%f", GetZAngle(0.0, 0.0, 1.0, 1.0));
}

public OnPlayerUpdate(playerid) {
	new
		vehicleid = GetPlayerVehicleID(playerid)
	;
	if(vehicleid) {
		new
			Float: vX,
			Float: vY,
			Float: vZ,
			Float: qX,
			Float: qY,
			Float: qZ
		;
		GetVehiclePos(vehicleid, vX, vY, vZ);
		GetVehicleRelativePos(vehicleid, qX, qY, qZ, 5.0, -10.0, 5.0);
		SetObjectPos(object, qX, qY, qZ);
		SetObjectRot(object, GetXYAngle(qX, qY, qZ, vX, vY, vZ), 0.0, GetZAngle(qX, qY, vX, vY));

	}
	return true;
}
*/
/*
enum vCorner {
    VEHICLE_CORNER_FRONTRIGHT,
    VEHICLE_CORNER_FRONTLEFT,
    VEHICLE_CORNER_REARRIGHT,
    VEHICLE_CORNER_REARLEFT
}

stock GetVehicleCorner(vehicleid, vCorner: corner, & Float: X, & Float: Y, & Float: Z, Float: scale = 1.0) {
    new
        Float: zA
    ;
    if(GetVehicleZAngle(vehicleid, zA)) {
        new
            Float: sX,
            Float: sY,
            Float: sZ
        ;
        GetVehiclePos(vehicleid, X, Y, Z);
        GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, sX, sY, sZ);

        scale /= 2.0;

        sX *= scale;
        sY *= scale;

        new
            Float: cos = floatcos(zA, degrees),
            Float: sin = floatsin(zA, degrees)
        ;
        switch(corner) {
            case VEHICLE_CORNER_FRONTRIGHT: { // right front
                X += cos * sX - sin * sY;
                Y += sin * sX + cos * sY; 
            }
            case VEHICLE_CORNER_FRONTLEFT: { // left front
                X -= cos * sX + sin * sY;
                Y -= sin * sX - cos * sY; 
            }
            case VEHICLE_CORNER_REARRIGHT: { // right rear
                X += cos * sX + sin * sY;
                Y += sin * sX - cos * sY; 
            }
            case VEHICLE_CORNER_REARLEFT: { // left rear
                X -= cos * sX - sin * sY;
                Y -= sin * sX + cos * sY;
            }
        }
        return true;
    }
    return false;
}
*/
/*
#include <sscanf2>

Init() {
	new
		tmp[256],
		Float: X,
		Float: Y,
		Float: Z,
		Float: Angle,
		model,
		File: rhandle = fopen("vehicle.txt", io_read),
		File: whandle = fopen("vehicle.js", io_write)
	;
	fwrite(whandle, "MapAddArray('Icon_55', [\r\n");
	while(fread(rhandle, tmp)) {
		sscanf(tmp, "p<\t>ffffi{s}", X, Y, Z, Angle, model);

		format(tmp, sizeof tmp, "\t[%f, %f, 'Z: %f\\nAngle: %f\\nModelid: %d'],\r\n", X, Y, Z, Angle, model);
		fwrite(whandle, tmp);
	}
	fwrite(whandle, "]);");
	fclose(whandle);
	fclose(rhandle);
}
*/
/*
stock Float: GET_RANK_POINTS(rank) {
    return rank + 400.0 * floatpower(2.0, rank / 7.0);
}

Init() {
	for(new i = 0; i <= 100; i++) {
		printf("%d: %f", i, GET_RANK_POINTS(i));
	}
}
*/
/*
// Create a temporary file stream
new
    File: thandle = ftemp()
; 
// Check, if temporary file stream is open
if(thandle) {
    new
        file[64],
        tmp[128],
        File: handle
    ;
    // Construct the complete filename for this player's account
    format(file, sizeof file, PlayerFile, targetname); 

    if((handle = fopen(file, io_read))) {
        while(fread(handle, tmp)) {
            fwrite(thandle, tmp);
        }
        fclose(handle);

        if((handle = fopen(file, io_write))) {
            // Set the file pointer of the temporary file stream to the first byte
            fseek(thandle, 0, seek_start);

            while(fread(thandle, tmp)) {
                if(strcmp(tmp, "Bans=", false, 5) == 0) {
                    format(tmp, sizeof tmp, "Bans=5\r\n");
                }
                else if(strcmp(tmp, "BanTime=", false, 8) == 0) {
                    format(tmp, sizeof tmp, "BanTime=2147483640\r\n");
                }
                fwrite(handle, tmp); 
            }
            fclose(thandle);
            fclose(handle);
        }
    }
}
*/
/*
stock Float: floatrandom() {
	return Float: ((random(23) + 127) << 23 | random(0x800000));
}

Init() {
	for(new i = 12, var; i >= -5; --i) {
		var = _: float(i);

		if(0 <= i) {
//			printf("+%02d - 0b%b 0b%08b 0b%023b", i, var >>> 31, var >> 23 & 0xFF, var & 0x7FFFFF);
		} else {
//			printf("%02d - 0b%b 0b%08b 0b%023b", i, var >>> 31, var >> 23 & 0xFF, var & 0x7FFFFF);
		}
	}
	printf("%f", floatrandom());
}*/
/*
stock ReplaceLines(filename[], func[]) {
    new
        File: thandle = ftemp()
    ;
    if(thandle) {
        new
            File: handle
        ;
        if((handle = fopen(filename, io_read))) {
			new
				addr,
				tmp[128]
			;
			#emit addr.pri tmp
			#emit stor.s.pri addr

            while(fread(handle, tmp)) {
                fwrite(thandle, tmp);
            }
            fclose(handle);

            if((handle = fopen(filename, io_write))) {
                fseek(thandle, 0, seek_start);

                while(fread(thandle, tmp)) {
					CallLocalFunction(func, "ii", addr, sizeof tmp);
                    fwrite(handle, tmp);
                }
                fclose(handle);
            }
        }
		fclose(thandle);
		return true;
    }
	return false;
}

stock iReplaceLines(filename[], tmp[], size = sizeof tmp) {
    static
		File: handle,
        File: thandle
    ;
	if(thandle) {
		fwrite(handle, tmp);

		if(fread(thandle, tmp, size)) {
			return true;
		}
		fclose(thandle);
		fclose(handle);
	} else {
		if((thandle = ftemp())) {
			if((handle = fopen(filename, io_read))) {
				while(fread(handle, tmp, size)) {
					fwrite(thandle, tmp);
				}
				fclose(handle);

				if((handle = fopen(filename, io_write))) {
					fseek(thandle, 0, seek_start);

					if(fread(thandle, tmp, size)) {
						return true;
					}
					fclose(handle);
				}
			}
			fclose(thandle);
		}
    }
	return _: (thandle = File: 0);
}

// sucks, we cant delete something -pawn-
stock fdelete(File: handle, key[]) {
	if(handle) {
		fseek(handle, 0, seek_start);

		new
			offset,
			tmp[128],
			len = strlen(key)
		;
		while(fread(handle, tmp)) {
			if(strcmp(tmp, key, false, len) == 0) {
				offset = strlen(tmp);

				while((len = fread(handle, tmp))) {
					fseek(handle, -(offset + len), seek_current);
					fwrite(handle, tmp);
					fseek(handle, offset, seek_current);
				}
				fseek(handle, -offset, seek_current);

				while(offset--) {
					fputchar(handle, '\r');
				}
				break;
			}
		}
		return true;
	}
	return false;
}

stock fadd(File: handle, string[], pos = 0) {
	if(handle) {
		new
			len,
			ret,
			tmp[2048]
		;
		len = strcat(tmp, string);
		fseek(handle, pos, seek_start);

		while((ret = fread(handle, tmp[len], sizeof tmp - len))) {
			len += ret;
		}
		fseek(handle, pos, seek_start);
		fwrite(handle, tmp);
	}
}

Init() {
	fremove("test.txt");

	new
		File: gFile = fopen("test.txt", io_readwrite)
	;
	if(gFile) {
		fwrite(gFile, "Hello World!\r\n");
		fwrite(gFile, "My name is Markus.\r\n");
		fwrite(gFile, "How are you?\r\n");
		fadd(gFile, "1) ", 0);
		fadd(gFile, "2) ", 17);
		fadd(gFile, "3) ", 40);
		fadd(gFile, "0) First Line!\r\n");
//		fdelete(gFile, "2) ");
//		fwrite(gFile, "4) I am Markus.\r\n");

//		fseek(gFile, 0);
//		new tmp[128];
//		while(fread(gFile, tmp)) printf("\"%s\"", tmp);
		fclose(gFile);

//		ReplaceLines("test.txt", "NewBans");

		new
			tmp[128]
		;
		while(iReplaceLines("test.txt", tmp)) {
			if(strcmp(tmp, "2)", false, 2) == 0) {
				format(tmp, sizeof tmp, "2) My name is indeed Markus!\r\n");
			}
		}
	}
}

#define function%0(%1) forward%0(%1);public%0(%1)

function NewBans(string[], size) {
	if(strcmp(string, "2)", false, 2) == 0) {
		format(string, size, "2) My name is indeed Markus!\r\n");
	}
}*/

/*
stock Float: GetAngle(Float: X1, Float: Y1, Float: X2, Float: Y2) // player - target
    return -atan2(X2 - X1, Y2 - Y1); // returns values between (180.0) and (-180.0)

stock Float: GetAngleBetweenPlayerAndObject(playerid, objectid) {
	new
		Float: pX,
		Float: pY,
		Float: oX,
		Float: oY,
		Float: angle
	;
	if(GetPlayerPos(playerid, pX, pY, angle) && GetObjectPos(objectid, oX, oY, angle)) {
		GetPlayerFacingAngle(playerid, angle);

		angle = GetAngle(pX, pY, oX, oY) - angle + 90.0;
		// range (-450) - (+270)
		while(angle < 0.0) {
			angle += 360.0;
		}
		// range (+0) - (+360)
		return angle;
	}
	return 0.0;
}

Init() {
	printf("%f", GetAngle(0.0, 0.0, 1.0, 1.0));
	printf("%f", GetAngle(0.0, 0.0, -1.0, 1.0));
	printf("%f", GetAngle(0.0, 0.0, -1.0, -1.0));
	printf("%f", GetAngle(0.0, 0.0, 1.0, -1.0));

	GetAngleBetweenPlayerAndObject(0, 0);
}
*/
/*
Init() {
	new
		Float: sX = -75.0,
		Float: sY = 300.0
	;
	// out of screen
	sX -= 320.0; // x Transformation to the center
	sY -= 240.0; // y Transformation to the center

	printf("%f %f", sX, sY);

	new
		Float: v1 = (320.0 * 0.9) / floatabs(sX), // I only want positive values
		Float: v2 = (240.0 * 0.9) / floatabs(sY)
	;
	printf("%f < %f", v1, v2);

	if(v1 < v2) {
		//x outweighs
		sX *= v1;
		sY *= v1;
	} else {
		//y outweighs
		sX *= v2;
		sY *= v2;
	}
	printf("%f %f", sX, sY);

	sX += 320.0;
	sY += 240.0;

	printf("%f %f", sX, sY);
}
*/
/*
#include <gametext>

public OnPlayerSpawn(playerid) {
	GameTextForPlayer(playerid, "Who are you?", 10000, 4);
	GameTextForPlayer(playerid, "Hello World!", 12000, 4);
	GameTextForPlayer(playerid, "You suck!", 8000, 4);

	GameTextForAll(":)", 4000, 4);

	GameTextForPlayer(playerid, "How are you?", 6000, 4);
}
*/

/*
enum test
{
    something[6]
}
new Testing[MAX_PLAYERS][test];

Init() {
	new
		playerid = 100
	;
	for(new p; p < sizeof(Testing[]); p++) {
		Testing[playerid - 1][test: p] = p + 1;
		Testing[playerid][test: p] = p + 1;
		Testing[playerid + 1][test: p] = p + 1;

		printf("Testing[%d][%d] = %d", playerid - 1, p, Testing[playerid - 1][test: p]);
		printf("Testing[%d][%d] = %d", playerid, p, Testing[playerid][test: p]);
		printf("Testing[%d][%d] = %d", playerid + 1, p, Testing[playerid + 1][test: p]);
	}

//	#emit const.alt Testing
//	#emit load.s.pri playerid
//	#emit shl.c.pri 2
//	#emit add
//	#emit move.alt
//	#emit load.i
//	#emit add

//	const
//		size = _: test << 2
//	;
//	#emit move.alt
//	#emit zero.pri
//	#emit fill size

//	new
//		adr = GetAddress(Testing[playerid])
//	;
//	adr += LoadAddress(adr);
//	Fill(adr, 0, _: test);

	FillArray(Testing[playerid], 99);

//	new array[5][4][3];

//	for(new i, j, k; i < sizeof array; ++i) {
//		for(j = 0; j < sizeof array[]; ++j) {
//			for(k = 0; k < sizeof array[][]; ++k) {
//				printf("array[%d][%d][%d] %d", i, j, k, array[i][j][k]);
//			}
//		}
//	}
//	FillArrayEx(array, 2, 5, 3, 1);

//	for(new i, j, k; i < sizeof array; ++i) {
//		for(j = 0; j < sizeof array[]; ++j) {
//			for(k = 0; k < sizeof array[][]; ++k) {
//				printf("array[%d][%d][%d] %d", i, j, k, array[i][j][k]);
//			}
//		}
//	}

	for(new p; p < sizeof(Testing[]); p++) {
		printf("Testing[%d][%d] = %d", playerid - 1, p, Testing[playerid - 1][test: p]);
		printf("Testing[%d][%d] = %d", playerid, p, Testing[playerid][test: p]);
		printf("Testing[%d][%d] = %d", playerid + 1, p, Testing[playerid + 1][test: p]);
	}
}
// (((0 + 1) * 2 + 1) * 3 + 1) * 5
// 2 * 3 * 5 + 3 * 5 + 5
stock FillArrayEx(...) {
	new
		size,
		value,
		adr
	;
	#emit addr.pri 16
	#emit stor.s.pri value

	const n8 = -8;

	#emit load.s.alt 8
	#emit add
	#emit add.c n8
	#emit stor.s.pri adr

	if((size = GetArraySize(value, adr)) == 0) {
		return ;
	}
	size -= value = GetArraySize(value, adr - 4);

	#emit load.s.pri 12
	#emit load.s.alt value
	#emit add
	#emit stor.s.pri adr

	#emit lref.s.pri 16
	#emit stor.s.pri value

	printf("%d, %d, %d", adr, value, size);

	Fill(adr, value, size);
}

stock GetArraySize(start, end) {
	new
		size
	;
	while(start < end) {
		#emit load.s.pri size
		#emit add.c 1
		#emit move.alt
		#emit lref.s.pri end
		#emit load.i
		#emit smul
		#emit stor.s.pri size

		end -= 4;
	}
	return size;
}

stock FillArray(array[], value, size = sizeof array) {	
	new
		adr = GetAddress(array)
	;
	Fill(adr + LoadAddress(adr), value, size);
}


stock GetAddress(...) {
	#emit load.s.pri 12
	#emit retn
	return 0;
}

stock LoadAddress(adr) {
	#emit lref.s.pri adr
	#emit retn
	return 0;
}

stock Fill(adr, value, size) {
	printf("fill - %d %d %d", adr, value, size);

	SetCellAfterReturn(size << 2, 20);

	#emit load.s.alt adr
	#emit load.s.pri value
	#emit fill 0

	printf("fill - %d %d %d", adr, value, size);
}

stock SetCellAfterReturn(value, offset) {
	#emit lctrl 0
	#emit move.alt
	#emit lctrl 1
	#emit sub.alt

	#emit load.s.alt 4
	#emit add
	#emit load.s.alt offset
	#emit add
	#emit stor.s.pri offset

	#emit load.s.pri value
	#emit sref.s.pri offset
}
*/
/*
Init() {
	new
		string[] = "Hello World!"
	;
	valstr(string, 1147483647);

	printf("%s - %d - {%c, EOS, %c}", string, cellmax, string[9], string[11]); 
}
*/
/*
#include <zcmd>
#include <sscanf2>

new number;

CMD:checkphone(playerid, params[]) {
    if(sscanf(params, "{i<0 - >}")) {
        return SendClientMessage(playerid, -1, "USE: /checkphone [number]");
    }
    new
        i,
        string[128]
    ;
    while(i < MAX_PLAYERS) {
        valstr(string, number);

        if(strfind(string, params) != -1) {
            GetPlayerName(i, string, MAX_PLAYER_NAME);
            format(string, sizeof string, "[ID:%d] %s *%d*", i, string, number);
            SendClientMessage(playerid, -1, string); 
        }
        i++;
    }
    return (string[12] != EOS) || SendClientMessage(playerid, -1, "Number not found!");
}
*/
/*
forward ConNPC();
public ConNPC() {
	SendRconCommand("maxnpc 32");

	static
		name[8] = "NPC",
		count = 0
	;
	valstr(name[3], count++, false);
	ConnectNPC(name, "npcidle");
}

#include <streamer>
#include <zcmd>

CMD:npc(playerid, params[]) {
	ConNPC();
	return true;
}

AttachDyn3DTextLabelToPlayer(Text3D: id, playerid, Float: OffsetX, Float: OffsetY, Float: OffsetZ) {
	Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, id, E_STREAMER_ATTACHED_PLAYER, playerid);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, id, E_STREAMER_ATTACH_OFFSET_X, OffsetX);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, id, E_STREAMER_ATTACH_OFFSET_Y, OffsetY);
	Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, id, E_STREAMER_ATTACH_OFFSET_Z, OffsetZ);
}

CMD:3dtext(playerid, params[]) {
	static
		Text3D: stext
	;
	if(!stext) {
		stext = CreateDynamic3DTextLabel("On Admin Duty!", 0xFFFFFFFF, 0.0, 0.0, 0.0, 50.0, playerid = 1, .testlos = 1);
//		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, stext, E_STREAMER_ATTACH_OFFSET_Z, 0.7);
//		stext = Create3DTextLabel("Hello!", 0xFFFFFFFF, 0.0, 0.0, 7.0, 50.0, 0);
		SendClientMessage(playerid, -1, "Created!");
	} else {
//		Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, stext, E_STREAMER_ATTACHED_PLAYER, strval(params));
		AttachDyn3DTextLabelToPlayer(stext, strval(params), 0.0, 0.0, 0.7);
//		Attach3DTextLabelToPlayer(stext, strval(params), 0.0, 0.0, 0.7);
	}
	return true;
}
*/
/*
stock DotProdukt(& Float: dx, & Float: dy, & Float: dz, Float: v1x, Float: v1y, Float: v1z, Float: v2x, Float: v2y, Float: v2z) {
	dx = v1y * v2z - v1z * v2y;
	dy = v1z * v2x - v1x * v2z;
	dz = v1x * v2y - v1y * v2x;
}

// d = |front vector x (player2 pos - player1 pos)| / |front vector|
stock Float: GetDistranceBetweenLineAndPoint(Float: sx, Float: sy, Float: sz, Float: vx, Float: vy, Float: vz, Float: px, Float: py, Float: pz) {
	DotProdukt(sx, sy, sz, vx, vy, vz, px - sx, py - sy, pz - sz);

	return VectorSize(sx, sy, sz) / VectorSize(vx, vy, vz);
}
*/
/*
// d = |front vector x (player2 pos - player1 pos)| / |front vector|
stock Float: GetDistranceBetweenLineAndPoint(Float: sx, Float: sy, Float: sz, Float: vx, Float: vy, Float: vz, Float: px, Float: py, Float: pz) {
	px -= sx;
	py -= sy;
	pz -= sz;

	return VectorSize(vy * pz - vz * py, vz * px - vx * pz, vx * py - vy * px) / VectorSize(vx, vy, vz);
}

stock IsPlayerLookAtPlayer(playerid, giveplayerid, Float: offset = 1.0) {
    new
        Float: cX,
        Float: cY,
        Float: cZ,
        Float: vX,
        Float: vY,
        Float: vZ,
        Float: gX,
        Float: gY,
        Float: gZ
    ;
    if(GetPlayerPos(giveplayerid, gX, gY, gZ) && GetPlayerCameraPos(playerid, cX, cY, cZ) && GetPlayerCameraFrontVector(playerid, vX, vY, vZ)) {
        vX = GetDistranceBetweenLineAndPoint(cX, cY, cZ, vX, vY, vZ, gX, gY, gZ);
        vY = VectorSize(gX - cX, gY - cY, gZ - cZ);
        vZ = floatsqroot(vY * vY - vX * vX);

        return (vX / vZ) < offset;
    }
    return false;
}
*/

/*
#include <streamer>

stock AttachDyn3dTextLabelToPlayer(Text3D:id, playerid, Float:OffsetX, Float:OffsetY, Float:OffsetZ) {
    Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, id, E_STREAMER_ATTACHED_PLAYER, playerid);
    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, id, E_STREAMER_ATTACH_OFFSET_X, OffsetX);
    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, id, E_STREAMER_ATTACH_OFFSET_Y, OffsetY);
    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, id, E_STREAMER_ATTACH_OFFSET_Z, OffsetZ);
}

stock CheckValidDate(day, month, year) {
    static const
        days[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    ;
    return
        (1582 < year) &&
        (1 <= month <= 12) && (
            (day <= days[month - 1]) ||
            (month == 2 && day == 29 && ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)))
        )
    ;
}

Init() {
	AttachDyn3dTextLabelToPlayer(Text3D:0, 0, 0.0, 0.0, 0.0);

	printf("%d", CheckValidDate(15, 03, 1997));
	printf("%d", CheckValidDate(1, 1, 1400));
	printf("%d", CheckValidDate(23, 03, 2015));

	new var;
	if(var++) {}
	if((var += 1)) {}
	if(++var) {}
}
*/
/*
Init() {
	for(new i; i < 256; ++i) {
		printf("%d '%c'", i, i);
	}
	new
		var
	;
	switch(var) {
//		case 'A'..'�', 'a'..'�', ' ': {}
		case '�'..'�', '�'..'�', ' ': {}
	}
	new 
		tmp[] = "� � a u o � � a u o � A � A A �"
	;
	printf("\"%s\"", tmp);

	for(new i; i < sizeof tmp; ++i) {
		printf("%d '%c'", tmp[i], tmp[i]);
	}
}
*/
/*
stock split(const strsrc[], strdest[][], delimiter)
{
    new i, li;
    new aNum;
    new len;
    while(i <= strlen(strsrc))
    {
        if(strsrc[i] == delimiter || i == strlen(strsrc))
        {
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0;
            li = i+1;
            aNum++;
        }
        i++;
    }
    return 1;
}

enum kInfo
{
    KingdomTaken,
    KingdomName[20],
    KingdomKing[20],
//  Color[20], // you don't need that
    KingdomColor,
    KingdomFlagColor
};

new KingdomInfo[9][kInfo];

stock HexToInt(string[]) {
    new
        result
    ;
    do {
		result <<= 4;

        if('0' <= string[0] <= '9') {
            result += string[0] - '0';
        }
        else if('A' <= string[0] <= 'F') {
            result += string[0] - ('A' - 10);
        }
        else if('a' <= string[0] <= 'f') {
            result += string[0] - ('a' - 10);
        } else {
			return false;
		}
		#emit load.s.pri string
		#emit add.c 4
		#emit stor.s.pri string
    } while(string[0]);

    return result;
}

Init() {
    new File: file = fopen("LARP/kingdoms.cfg", io_read);
    if (file)
    {
        new idx;
        new arrCoords[5][64];
        new strFromFile2[256];

        while (idx < sizeof(KingdomInfo))
        {
            fread(file, strFromFile2);
            split(strFromFile2, arrCoords, '|');

            arrCoords[4][10] = EOS; // removing the '\n' from the last parameter

            KingdomInfo[idx][KingdomName][0] = KingdomInfo[idx][KingdomKing][0] = EOS;

            KingdomInfo[idx][KingdomTaken] = strval(arrCoords[0]);
            strcat(KingdomInfo[idx][KingdomName], arrCoords[1]);
            strcat(KingdomInfo[idx][KingdomKing], arrCoords[2]);
            KingdomInfo[idx][KingdomColor] = HexToInt(arrCoords[3][2]);
            KingdomInfo[idx][KingdomFlagColor] = HexToInt(arrCoords[4][2]);

            //printf("Family:%d Taken: %d Name:%s MOTD:%s Leader:%s Members:%d SpawnX:%f SpawnY:%f SpawnZ:%f Int:%d",
            //idx,FamilyInfo[idx][FamilyTaken],FamilyInfo[idx][FamilyName],FamilyInfo[idx][FamilyMOTD],FamilyInfo[idx][FamilyLeader],FamilyInfo[idx][FamilyMembers],FamilyInfo[idx][FamilySpawn][0],FamilyInfo[idx][FamilySpawn][1],FamilyInfo[idx][FamilySpawn][2],FamilyInfo[idx][FamilyInterior]);

            idx++;
        }
        fclose(file);
        return true;
    }
    return false;
}
*/
/*
stock GetNextPointOnCircle(Float: cX, Float: cY, & Float: X, & Float: Y, Float: angle, const anglemode: amode = degrees) {
    new
        Float: cos = floatcos(angle, amode),
        Float: sin = floatsin(angle, amode),
        Float: tX = X - cX,
        Float: tY = Y - cY
    ;
    X = tX * cos - tY * sin + cX;
    Y = tX * sin + tY * cos + cY;
}

Init() {
	new
		dots = 15,
		Float: cX = 6.0, // center of circle
		Float: cY = 4.0, // center of circle
		Float: X = 6.0, // first point
		Float: Y = 1.0, // first point
		Float: angle = 360.0 / dots // split the circle in x (dots) pieces
	;
	while(dots--) { // crashes your server if dots < 0
		GetNextPointOnCircle(cX, cY, X, Y, angle);

		printf("%f %f", X, Y);
	}
}
*/

/*
native fwritechar(File: handle, value, bool: utf8 = false) = fputchar;
native freadchar(File: handle, value = 0, bool: utf8 = false) = fgetchar; 

stock fwriteEx(File:handle, string[]) {
	if(0 <= string[0] <= ucharmax) {
		for(new i, j, s; ; ++i) {
			if(string[i] > 127) {
				fwritechar(handle, string[i]);
				printf("'%c'", string[i]);
			} else {
				if(string[i]) {
					for(j = i; 0 < string[++i] < 128; ) {}

					s = string[i];
					string[i] = EOS;
					fwrite(handle, string[j]);
					printf("\"%s\"", string[j]);
					string[i--] = s;
				} else {
					break;
				}
			}
		}
	} else {
		for(new i; string{i}; ++i) {
			fwritechar(handle, string{i});
		}
	}
}

stock freadEx(File:handle, string[], size = sizeof string, bool: pack = false) {
	if(pack) {
		size *= 4;

		for(new i; i < size; ++i) {
			if((string{i} = freadchar(handle)) == EOF) {
				string{i} = EOS;
				break;
			}
		}
	} else {
		for(new i; i < size; ++i) {
			if((string[i] = freadchar(handle)) == EOF) {
				string[i] = EOS;
				break;
			}
		}
	}
}

Init() {
	printf("%d %d", charmax, ucharmax);

	new
		dest[16],
		string[] = "ÅŸÃ¼ÄŸesÄŸÃ¼Dei_Mudda",
		filename[] = "hareket.txt"
	;
	new File: wFile = fopen(filename, io_write);

	if(wFile) {
		fwriteEx(wFile, string);
		fclose(wFile);
		print(string);
	}
	new File: rFile = fopen(filename, io_read);

	if(rFile) {
		freadEx(rFile, dest, sizeof dest, true);
		fclose(rFile);
		print(dest);
	}
}
*/
/*
#include <ntest>

nTest(3x10000) {
	new
		string[] = "loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong string\r\n",
		filename[] = "hareket.txt",
		File: tFile
	;
	tFile = fopen(filename, io_write);

	if(tFile) {
		Test("fwrite") {
			fwrite(tFile, string);
		}
		fclose(tFile);
	}
	tFile = fopen(filename, io_write);

	if(tFile) {
		Test("fwriteEx") {
			fwriteEx(tFile, string);
		}
		fclose(tFile);
	}
	tFile = fopen(filename, io_read);

	if(tFile) {
		Test("fread") {
			fread(tFile, string);
		}
		fclose(tFile);
	}
	tFile = fopen(filename, io_read);

	if(tFile) {
		Test("freadEx") {
			freadEx(tFile, string);
		}
		fclose(tFile);
	}
}
*/
/*
#include <a_zones>

CheckQuickStrings(playerid, string[], size = sizeof string)
{
    new idx = strfind(string, "$");

    if(idx != -1)
    {
        do
        {
            if(strcmp(string[idx], "$loc", true, 4) == 0)
            {
                new zone[MAX_ZONE_NAME];
                GetPlayer2DZone(playerid, zone, MAX_ZONE_NAME);

                strdel(string, idx, idx + 4);
                strins(string, zone, idx, size);
                continue;
            }
            if(strcmp(string[idx], "$cash", true, 5) == 0)
            {
                new pmoney[32];
                format(pmoney, sizeof(pmoney), "$%d", GetPlayerMoney(playerid));

                strdel(string, idx, idx + 5);
                strins(string, pmoney, idx, size);
                continue;
            }
            if(strcmp(string[idx], "$ply", true, 4) == 0)
            {
                new id = 0; // GetPlayerWhoIsClosest(playerid)
                if(!IsPlayerConnected(id)) id = playerid;

                new closeststr[32];
                format(closeststr, sizeof(closeststr), "%s (%d)",  "Franz", id); //PlayerInfo[id][pName]

                strdel(string, idx, idx + 4);
                strins(string, closeststr, idx, size);
                continue;
            }
        }
        while((idx = strfind(string, "$", false, idx + 1)) != -1);

        return true;
    }
    return false;
}

#include <zcmd>

COMMAND:say(playerid, params[])
{
//    if (PlayerInfo[playerid][pSpawned] != 1)
//        return SendClientMessage(playerid, COLOR_ERROR, "You Cannot Use This Command When You're Dead.");
//    if (PlayerInfo[playerid][pMuted] == 1)
//        return SendClientMessage(playerid,COLOR_ERROR,"#Error: You Muted.");
    if (!strlen(params))
        return SendClientMessage(playerid, -1, "USAGE: /me (message).");
//    if (stringContainsIP(params))
//        return SendClientMessage(playerid,COLOR_ERROR,"Invalid Message.");

    new string[144];

    strcat(string, params);
    CheckQuickStrings(playerid, string); // replaces all tags inside string
    format(string, sizeof(string), "%s (%d): %s", "Franz", playerid, string); // PlayerInfo[playerid][pName]

    return SendClientMessageToAll(GetPlayerColor(playerid), string);
}

public OnPlayerText(playerid, text[]) {
	new string[144];
	strcat(string, text);
	CheckQuickStrings(playerid, string);
	SendPlayerMessageToAll(playerid, string);
	return false;
}
*/
/*
ExpandTags(playerid, string[], size = sizeof string) {
    new
        idx = strfind(string, "$")
    ;
    if(idx != -1) {
        do {
            if(strcmp(string[idx], "$loc", true, 4) == 0) {
                new
                    zone[MAX_ZONE_NAME]
                ;
                GetPlayer2DZone(playerid, zone, MAX_ZONE_NAME);

                if(zone[0] == EOS) {
                    zone = "Unknown";
                }
                strdel(string, idx, idx + 4);
                strins(string, zone, idx, size);
                continue;
            }
        } while((idx = strfind(string, "$", false, idx + 1)) != -1);

        return false;
    }
	return false;
}

public OnPlayerText(playerid, text[]) {
	new
		string[144]
	;
	strcat(string, text);

	if(ExpandTags(playerid, string)) {
		SendPlayerMessageToAll(playerid, string);
		return false;
	}
    return true; // if no $ was found send the message
}
*/
/*
public OnPlayerText(playerid, text[]) {
	new
		idx = strfind(text, "$")
	;
	
    printf("strfind %d - %s", idx, (idx == -1) ? ("No tags found") : ("Searching for tags"));
	if(idx != -1) {
		new
			string[144]
		;
		strcat(string, text);

		do {
			if(strcmp(string[idx], "$loc", true, 4) == 0) {
				new
					zone[MAX_ZONE_NAME]
				;
				GetPlayer2DZone(playerid, zone, MAX_ZONE_NAME);

				if(zone[0] == EOS) {
					zone = "Unknown";
				}
				strdel(string, idx, idx + 4);
				strins(string, zone, idx);
				continue;
			}
		} while((idx = strfind(string, "$", false, idx + 1)) != -1);

		SendPlayerMessageToAll(playerid, string);
		return false;
	}
	return true;
}
*/
/*
enum {
	VEHICLE_SIDE_LEFT,
	VEHICLE_SIDE_RIGHT
}

stock calcVehicleWheelsOffset(vehicleid, wheelModelInfo, side, Float: angle = 360.0, & Float: x = 0.0, & Float: y = 0.0, & Float: z = 0.0) {
	new
		model = GetVehicleModel(vehicleid)
	;
    if(model) {
		if(angle == 360.0) {
			GetVehiclePos(vehicleid, x, y, z);
			GetVehicleZAngle(vehicleid, angle);
		}
		new
			Float: wX,
			Float: wY,
			Float: wZ,
			Float: cos = floatcos(angle, degrees),
			Float: sin = floatsin(angle, degrees)
		;
		GetVehicleModelInfo(model, wheelModelInfo, wX, wY, wZ);

		x -= wY * sin;
		y += wY * cos;
		z += wZ;

		if(side == VEHICLE_SIDE_RIGHT) {
			x += wX * cos;
			y += wX * sin;
		} else {
			x -= wX * cos;
			y -= wX * sin;
		}
		return true;
	}
    return false;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
	if(hittype == BULLET_HIT_TYPE_VEHICLE) {
		new
			Float: x,
			Float: y,
			Float: z,
			Float: wX,
			Float: wY,
			Float: wZ,
			tiresUpdate,
			Float: angle,
			model = GetVehicleModel(hitid)
		;
		new
			Float: cos = floatcos(angle, degrees),
			Float: sin = floatsin(angle, degrees)
		;
		new
			Float: frontTireSize = 0.508,
			Float: rearTireSize = 0.508
		;
		new string[128];
		format(string, sizeof string, "Offset %f %f %f", fX, fY, fZ);
		SendClientMessage(playerid, -1, string);
		// FRONT
		GetVehicleModelInfo(model, VEHICLE_MODEL_INFO_WHEELSFRONT, wX, wY, wZ);

		z = wZ;
		// FRONT LEFT
		x =-wY * sin - wX * cos;
		y = wY * cos - wX * sin;

		format(string, sizeof string, "FRONT LEFT %f %f %f - %f < %f", x, y, z, VectorSize(fX - x, fY - y, fZ - z), frontTireSize);
		SendClientMessage(playerid, -1, string);
	
		if(VectorSize(fX - x, fY - y, fZ - z) < frontTireSize) {
			tiresUpdate = 0b1000;
		}
		// FRONT RIGHT
		x =-wY * sin + wX * cos;
		y = wY * cos + wX * sin;

		format(string, sizeof string, "FRONT RIGHT %f %f %f - %f < %f", x, y, z, VectorSize(fX - x, fY - y, fZ - z), frontTireSize);
		SendClientMessage(playerid, -1, string);
	
		if(VectorSize(fX - x, fY - y, fZ - z) < frontTireSize) {
			tiresUpdate = 0b0010;
		}
		// REAR
		GetVehicleModelInfo(model, VEHICLE_MODEL_INFO_WHEELSREAR, wX, wY, wZ);

		z = wZ;
		// REAR LEFT
		x =-wY * sin - wX * cos;
		y = wY * cos - wX * sin;

		format(string, sizeof string, "REAR LEFT %f %f %f - %f < %f", x, y, z, VectorSize(fX - x, fY - y, fZ - z), frontTireSize);
		SendClientMessage(playerid, -1, string);
	
		if(VectorSize(fX - x, fY - y, fZ - z) < rearTireSize) {
			tiresUpdate = 0b0100;
		}
		// REAR RIGHT
		x =-wY * sin + wX * cos;
		y = wY * cos + wX * sin;

		format(string, sizeof string, "REAR RIGHT %f %f %f - %f < %f", x, y, z, VectorSize(fX - x, fY - y, fZ - z), frontTireSize);
		SendClientMessage(playerid, -1, string);
	
		if(VectorSize(fX - x, fY - y, fZ - z) < rearTireSize) {
			tiresUpdate = 0b0001;
		}
		//
		if(tiresUpdate) {
			new panels, doors, lights, tires;
			GetVehicleDamageStatus(hitid, panels, doors, lights, tires);
			UpdateVehicleDamageStatus(hitid, panels, doors, lights, (tires | tiresUpdate));
		}
	}
}
*/
/*
Init() {
	new
		reason[20] = "Hello Word.",
		len = strlen(reason) - 1
	;
//	printf("'%c' - %d", reason[len], strfind(reason, ".", .pos = len));

  //  if(strfind(reason, ".", .pos = len))
  //  {
  //      strdel(reason, strlen(reason)-1, strlen(reason));
  //  }
	if(reason[len] == '.')
	{
		reason[len] = EOS;
	}
    printf("%s", reason);

	printf("%d", 0.1);
}
*/
/*
#define MAX_FACTIONS 10

enum {
    fRankS = 24,
    fDeptNameS = 24,
    fDeptTagS = 12
}

enum fInfo
{
    fLeader[MAX_PLAYER_NAME],
    fMembers, 
    fRank[10 * fRankS],  // Line 325
    fDeptName[4 * fDeptNameS],
    fDeptTag[4 * fDeptTagS]
}
new FactionInfo[MAX_FACTIONS][fInfo];

#define f2d][%0][%1][%2] %0][((%1) * (%0S)) + (%2)] 

Init() {
	printf("%d", fRank);

	FactionInfo[1][fRank][1] = 1;

	FactionInfo[1][f2d][fRank][1][2] = 1;
}
*/
/*
enum ePlayerList {
    Text: pTID, // Textdrawid
    pPID // playerid
} // just an example variable
new gPlayerList[20][ePlayerList];

Init() {
	// I expect that you create the textdraw in OnGameModeInit, something like that
	for(new i; i < 20; ++i) {
		// setting every position to INVALID_PLAYER_ID
		gPlayerList[i][pPID] = INVALID_PLAYER_ID;
		// the first textdraw (id 0) is the highest one in my example
		gPlayerList[i][pTID] = TextDrawCreate(10.0, 100.0 + i * 5.0, "_");
		// other textdraw functions to customize it
	}
}

PlayerListAdd(playerid) {
    for(new idx; idx < sizeof gPlayerList; ++idx) {
        if(gPlayerList[idx][pPID] == INVALID_PLAYER_ID) {
            // we found a free spot
            new
                name[MAX_PLAYER_NAME]
            ;
            if(GetPlayerName(playerid, name, sizeof name)) {
				SendClientMessageToAll(-1, name);

                TextDrawSetString(gPlayerList[idx][pTID], name);
                gPlayerList[idx][pPID] = playerid;
                return true;
            }
            break;
        }
    }
    return false;
}

PlayerListRemove(playerid) {
    for(new idx; idx < sizeof gPlayerList; ++idx) {
        if(gPlayerList[idx][pPID] == playerid) {
            // we found the player in the list, now shuffle everyone up and update the names
            new
                name[MAX_PLAYER_NAME]
            ;
            do {
                if(GetPlayerName((gPlayerList[idx][pPID] = gPlayerList[idx + 1][pPID]), name, sizeof name) == 0) {
                    // we hit in INVALID PLAYER ID because it isn't connected
                    TextDrawSetString(gPlayerList[idx][pTID], "_");
                    return true;
                }
                TextDrawSetString(gPlayerList[idx][pTID], name);
            } while(++idx < (sizeof gPlayerList - 1));
            // if the list was full we set the last to invalid
            TextDrawSetString(gPlayerList[sizeof gPlayerList - 1][pTID], "_");
            gPlayerList[sizeof gPlayerList - 1][pPID] = INVALID_PLAYER_ID;
            return true;
        }
    }
    return false;
}
public OnPlayerConnect(playerid) {
	for(new i; i < sizeof gPlayerList; ++i) {
		TextDrawShowForPlayer(playerid, gPlayerList[i][pTID]);
	}
	PlayerListAdd(playerid);
	return true;
}

public OnPlayerDisconnect(playerid, reason) {
	// we don't need to check if the player is a vip here because it only removes the player if he is on the list
	// but it will prevent useless function calls
	PlayerListRemove(playerid);
	return true;
}


forward ConNPC();
public ConNPC() {
	SendRconCommand("maxnpc 32");

	static
		name[8] = "NPC",
		count = 0
	;
	valstr(name[3], count++, false);
	ConnectNPC(name, "npcidle");
}

public OnPlayerCommandText(playerid, cmdtext[]) {
	if(strcmp("/npc", cmdtext, true) == 0) {
		ConNPC();

		return true;
	}
	if(strcmp("/akick", cmdtext, true) == 0) {
		for(new i; i < MAX_PLAYERS; ++i) {
			if(i != playerid) {
				Kick(i);
			}
		}
		return true;
	}
	return false;
}
*/
/*

#include <zcmd>

CMD:virus(playerid, params[]) {
    #pragma unused params

	Virus(42, 1000, -1.0, 20);
    return true;
}

Virus(weather, interval, Float: heal, tic) {
	if(0 < tic) {
		VirusEffect(interval, heal, tic);
		SetPlayerWeatherForAll(weather);
		return true;
	}
	return false;
}

forward VirusEffect(interval, Float: heal, tic);
public VirusEffect(interval, Float: heal, tic) {
    if(tic < 1) {
		SetPlayerWeatherForAll(0);
	} else {
        new
            Float: health
        ;
        for(new i; i != MAX_PLAYERS; ++i) {
            if(GetPlayerHealth(i, health)) {
                SetPlayerHealth(i, health + heal);
            }
        }
        SetTimerEx("VirusEffect", interval, false, "ifi", interval, heal, tic - 1);
    }
}

forward SetPlayerWeatherForAll(weather);
public SetPlayerWeatherForAll(weather) {
	for(new i; i != MAX_PLAYERS; ++i) {
		SetPlayerWeather(i, weather);
    }
}
*/
/*
Init() {
	new arry[5], idx = 7;

	arry[idx] = 0;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    if (strcmp("/radiopos", cmdtext, true) == 0)
    {
        new Float:X, Float:Y, Float:Z, Float:Distance = 5.0;
        GetPlayerPos(playerid, X, Y, Z);
		PlayAudioStreamForPlayer(playerid, "http://somafm.com/tags.pls", X, Y, Z, Distance, 1);
		return true;
    }
	return false;
}
*/
/*
stock GetXYForRacer(& Float: x, & Float: y, Float: a, rowSize, & startPosition) {
    if(rowSize < 1) {
        rowSize = 1;
    }
    const
        Float: rowSpace = 5.0,
        Float: columnSpace = 3.0
    ;
    if(++startPosition <= 1) {
        startPosition = 1;
        // moving 0.5 row to the left because the startPos is in the middle
        GetXYAtAngleFromPos(x, y, a + 90.0, (columnSpace * (rowSize - 1)) / 2.0);
    } else {
        if((startPosition % rowSize) == 1) {
             // moving the pos to the left again
            GetXYAtAngleFromPos(x, y, a + 90.0, columnSpace * (rowSize - 1));
            // and one row down
            GetXYAtAngleFromPos(x, y, a + 180.0, rowSpace);
        } else {
            // moving one to the right
            GetXYAtAngleFromPos(x, y, a - 90.0, columnSpace);
        }
    }
}

stock GetXYAtAngleFromPos(&Float:x, &Float:y, Float:a, Float: distance) 
{
    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
}

Init() {
	new
		Float: x = 0.0,
		Float: y = 0.0,
		startPosition = 0,
		i = 0
	;
	while(++i <= 10) {
		GetXYForRacer(x, y, 0.0, 3, startPosition);

		printf("%d. %f %f", startPosition, x, y);
	}
}
*/
/*
#include <mapandreas>

new gObjectid, npc;

enum myenum {
	string[16],
	notastring
}

new aenum[myenum];

Init() {
	MapAndreas_Init(MAP_ANDREAS_MODE_FULL);

	new variable = 0;

	variable |= 1 << 0;
	variable |= 1 << 18;
	variable |= 1 << 23;
	variable |= 1 << 24;

	printf("0b%b", variable);

	new tmp[16] = "Hello";

	aenum[string] = tmp;

	print(aenum[string]);

	ConnectNPC("NPC", "npcidle");
}

Unload() {
	Kick(npc);
	DestroyObject(gObjectid);
}

public OnPlayerConnect(playerid) {
	if(IsPlayerNPC(playerid)) {
		npc = playerid;
	} else {
		gObjectid = CreatePlayerObject(playerid, 1598, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	}
	return true;
}

public OnPlayerSpawn(playerid) {
	if(npc == playerid) {
		SetPlayerPos(npc, 0.0, 0.0, 6.0);
	}
	return true;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
	if(strcmp("/attach", cmdtext, true, 7) == 0) {
		static
			Usage[] = "USAGE /attach [playerid]"
		;
		if(cmdtext[7] == EOS) {
			return SendClientMessage(playerid, -1, Usage);
		}
		if(cmdtext[7] == ' ') {
			if(cmdtext[8] == EOS) {
				return SendClientMessage(playerid, -1, Usage);
			}
			AttachObjectToPlayer(gObjectid, strval(cmdtext[8]), 0.0, 0.0, 2.0, 0.0, 0.0, 0.0);
			return true;
		}
	}
	return false;
}

enum {
    OBJECT_UNUSED,
    OBJECT_GRENADE
}

new // variable which stores data related to the object
    gObjectData[MAX_OBJECTS + 1][8]
;

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
	new
		Float: oX,
		Float: oY,
		Float: oZ,
		Float: vX,
		Float: vY,
		Float: vZ
	;
	GetPlayerLastShotVectors(playerid, oX, oY, oZ, fX, fY, fZ);
	GetPlayerCameraFrontVector(playerid, vX, vY, vZ);

	Grenade(oX, oY, oZ, asin(vZ), -atan2(vX, vY), 100.0);

	new
		tmp[128]
	;
	format(tmp, sizeof tmp, "%d %d %d %d %f %f %f", playerid, weaponid, hittype, hitid, fX, fY, fZ);
	SendClientMessage(playerid, -1, tmp);
	return true;
}

#define UPDATE_SPEED (0.25)

Grenade(Float: X, Float: Y, Float: Z, Float: pitch, Float: yaw, Float: speed) {
    // rotations needs to be reconfigurated for the object
    new objectid = CreateObject(1974, X, Y, Z, pitch, 0.0, yaw);

    if(0 < objectid < sizeof gObjectData) {
        new
            Float: Vx = speed * floatcos(pitch, degrees) * floatsin(-yaw, degrees),
            Float: Vy = speed * floatcos(pitch, degrees) * floatcos(yaw, degrees),
            Float: Vz = speed * floatsin(pitch, degrees)
        ;
		MoveObject(objectid,
			X + Vx * UPDATE_SPEED,
			Y + Vy * UPDATE_SPEED,
			Z + (Vz - 4.905 * UPDATE_SPEED) * UPDATE_SPEED,
			VectorSize(Vx, Vy, Vz - 9.81 * UPDATE_SPEED)
		);
        gObjectData[objectid][0] = OBJECT_GRENADE;
        gObjectData[objectid][1] = _: Vx;
        gObjectData[objectid][2] = _: Vy;
        gObjectData[objectid][3] = _: Vz;
		gObjectData[objectid][4] = 1;

		AttachCameraToObject(0, objectid);
        return true;
    }
    return false;
}

public OnObjectMoved(objectid) {
    switch(gObjectData[objectid][0]) {
        case OBJECT_GRENADE: {
            new
                Float: X,
                Float: Y,
                Float: Z,
				Float: rZ
            ;
            GetObjectPos(objectid, X, Y, Z);

            MapAndreas_FindZ_For2DCoord(X, Y, rZ);

			if(Z < rZ) {
				CreateExplosion(X, Y, rZ, 2, 10.0);
				SetCameraBehindPlayer(0);
				DestroyObject(objectid);
			} else {
				new
					Float: Vx = Float: gObjectData[objectid][1],
					Float: Vy = Float: gObjectData[objectid][2],
					Float: Vz = Float: gObjectData[objectid][3],
					Float: t = (gObjectData[objectid][4] += 2)
				;
				MoveObject(objectid,
					X + (Vx * UPDATE_SPEED),
					Y + (Vy * UPDATE_SPEED),
					Z + (Vz - 4.905 * UPDATE_SPEED * t) * UPDATE_SPEED,
					VectorSize(Vx, Vy, Vz - 9.81 * UPDATE_SPEED)
				);
			}
        }
    }
}
*/
/*
formula(loop) { // get a better name for that function
    new
        result = 0,
        Float: root = 1.0 / 7.0
    ;
    while(--loop > 0) {
        result += loop + floatround(300.0 * floatpower((1 << loop), root), floatround_floor);
    }
    return result / 4;
}

Init() {
    for(new i = 1; i < 10; i++)
    {
        printf("%i", formula(i));
    }
}*/

/*
#include <nPlotter>

public OnPlayerSpawn(playerid) {
*/
/*
	PlotAddPointEx(-82.382369, -79.631103, 0xFF0000FF);
	PlotAddPointEx(-77.569534, -74.824592, 0xFF0000FF);
	PlotAddPointEx(-72.155113, -69.420570, 0xFF0000FF);
	PlotAddPointEx(-66.439888, -63.710987, 0xFF0000FF);
	PlotAddPointEx(-60.875053, -58.266784, 0xFF0000FF);
	PlotAddPointEx(-55.611026, -52.889633, 0xFF0000FF);
	PlotAddPointEx(-50.196590, -47.477653, 0xFF0000FF);
	PlotAddPointEx(-44.481353, -41.764690, 0xFF0000FF);
	PlotAddPointEx(-39.367725, -36.655563, 0xFF0000FF);
	PlotAddPointEx(-33.652473, -30.938812, 0xFF0000FF);
	PlotAddPointEx(-28.238019, -25.527931, 0xFF0000FF);
	PlotAddPointEx(-23.124376, -20.413002, 0xFF0000FF);
	PlotAddPointEx(-17.409130, -14.698774, 0xFF0000FF);
	PlotAddPointEx(-12.145080, -9.435621, 0xFF0000FF);
	PlotAddPointEx(-6.730622, -4.023089, 0xFF0000FF);
	PlotAddPointEx(-1.466571, 1.240970, 0xFF0000FF);
	PlotAddPointEx(4.098281, 6.804887, 0xFF0000FF);
	PlotAddPointEx(9.362335, 12.067897, 0xFF0000FF);
	PlotAddPointEx(14.626388, 17.330907, 0xFF0000FF);
	PlotAddPointEx(20.191228, 22.894731, 0xFF0000FF);
	PlotAddPointEx(25.304870, 28.007026, 0xFF0000FF);
	PlotAddPointEx(30.418502, 33.119503, 0xFF0000FF);
	PlotAddPointEx(35.983341, 38.683021, 0xFF0000FF);
	PlotAddPointEx(40.796176, 43.493762, 0xFF0000FF);

	PlotAddPointEx(-82.554229, -78.443565, 0x00FF00FF);
	PlotAddPointEx(-77.397689, -73.234107, 0x00FF00FF);
	PlotAddPointEx(-71.811309, -67.744033, 0x00FF00FF);
	PlotAddPointEx(-66.225006, -62.191318, 0x00FF00FF);
	PlotAddPointEx(-60.853515, -56.831272, 0x00FF00FF);
	PlotAddPointEx(-55.696891, -51.667087, 0x00FF00FF);
	PlotAddPointEx(-49.895664, -46.032413, 0x00FF00FF);
	PlotAddPointEx(-44.739028, -40.728054, 0x00FF00FF);
	PlotAddPointEx(-38.937808, -34.936885, 0x00FF00FF);
	PlotAddPointEx(-33.996040, -29.972478, 0x00FF00FF);
	PlotAddPointEx(-28.409692, -24.388978, 0x00FF00FF);
	PlotAddPointEx(-22.823354, -18.791330, 0x00FF00FF);
	PlotAddPointEx(-17.451883, -13.462028, 0x00FF00FF);
	PlotAddPointEx(-12.295267, -8.289857, 0x00FF00FF);
	PlotAddPointEx(-6.708934, -2.708734, 0x00FF00FF);
	PlotAddPointEx(-1.122596, 2.872287, 0x00FF00FF);
	PlotAddPointEx(3.819165, 7.823921, 0x00FF00FF);
	PlotAddPointEx(9.620359, 13.618931, 0x00FF00FF);
	PlotAddPointEx(14.562115, 18.557407, 0x00FF00FF);
	PlotAddPointEx(20.148448, 24.136533, 0x00FF00FF);
	PlotAddPointEx(25.734783, 29.725351, 0x00FF00FF);
	PlotAddPointEx(30.246835, 34.238349, 0x00FF00FF);
	PlotAddPointEx(35.833202, 39.815204, 0x00FF00FF);
	PlotAddPointEx(40.774990, 44.757053, 0x00FF00FF);

	PlotAddPointEx(-82.983955, -76.746421, 0x0000FFFF);
	PlotAddPointEx(-77.268722, -71.126037, 0x0000FFFF);
	PlotAddPointEx(-72.155067, -65.816040, 0x0000FFFF);
	PlotAddPointEx(-66.139030, -60.109493, 0x0000FFFF);
	PlotAddPointEx(-60.724601, -54.664306, 0x0000FFFF);
	PlotAddPointEx(-55.610973, -49.541812, 0x0000FFFF);
	PlotAddPointEx(-49.895736, -43.810871, 0x0000FFFF);
	PlotAddPointEx(-44.481304, -38.492218, 0x0000FFFF);
	PlotAddPointEx(-39.367668, -33.359283, 0x0000FFFF);
	PlotAddPointEx(-33.652420, -27.847669, 0x0000FFFF);
	PlotAddPointEx(-28.538778, -22.472503, 0x0000FFFF);
	PlotAddPointEx(-22.823522, -16.851348, 0x0000FFFF);
	PlotAddPointEx(-17.409059, -11.403629, 0x0000FFFF);
	PlotAddPointEx(-11.994602, -5.992217, 0x0000FFFF);
	PlotAddPointEx(-6.580150, -0.967706, 0x0000FFFF);
	PlotAddPointEx(-1.165699, 4.823312, 0x0000FFFF);
	PlotAddPointEx(3.665139, 9.654224, 0x0000FFFF);
	PlotAddPointEx(9.681196, 15.653947, 0x0000FFFF);
	PlotAddPointEx(14.494043, 20.466587, 0x0000FFFF);
	PlotAddPointEx(20.209300, 26.168127, 0x0000FFFF);
	PlotAddPointEx(25.322954, 31.288295, 0x0000FFFF);
	PlotAddPointEx(30.436599, 36.395679, 0x0000FFFF);
	PlotAddPointEx(35.550231, 41.507888, 0x0000FFFF);
	PlotAddPointEx(40.964675, 46.924438, 0x0000FFFF);
*/
/*
	PlotAddPointEx(-89.000045, -86.137496, 0xFF0000FF);
	PlotAddPointEx(-82.382369, -79.618301, 0xFF0000FF);
	PlotAddPointEx(-77.419136, -74.799079, 0xFF0000FF);
	PlotAddPointEx(-71.854316, -69.120079, 0xFF0000FF);
	PlotAddPointEx(-66.439888, -63.711132, 0xFF0000FF);
	PlotAddPointEx(-60.875053, -58.150463, 0xFF0000FF);
	PlotAddPointEx(-55.460624, -52.739501, 0xFF0000FF);
	PlotAddPointEx(-50.046188, -47.327381, 0xFF0000FF);
	PlotAddPointEx(-44.782161, -42.069648, 0xFF0000FF);
	PlotAddPointEx(-39.367733, -36.657081, 0xFF0000FF);
	PlotAddPointEx(-33.652511, -30.938947, 0xFF0000FF);
	PlotAddPointEx(-28.238077, -25.527952, 0xFF0000FF);
	PlotAddPointEx(-23.124437, -20.412679, 0xFF0000FF);
	PlotAddPointEx(-17.258794, -14.551254, 0xFF0000FF);
	PlotAddPointEx(-12.445954, -9.736438, 0xFF0000FF);
	PlotAddPointEx(-6.580290, -3.871829, 0xFF0000FF);
	PlotAddPointEx(-1.165838, 1.541626, 0xFF0000FF);
	PlotAddPointEx(4.098211, 6.806557, 0xFF0000FF);
	PlotAddPointEx(9.061462, 11.767108, 0xFF0000FF);
	PlotAddPointEx(14.776720, 17.481441, 0xFF0000FF);
	PlotAddPointEx(19.739950, 22.443286, 0xFF0000FF);
	PlotAddPointEx(25.455205, 28.157447, 0xFF0000FF);
	PlotAddPointEx(30.268039, 32.977214, 0xFF0000FF);
	PlotAddPointEx(35.983276, 38.696067, 0xFF0000FF);
	PlotAddPointEx(40.796104, 43.495346, 0xFF0000FF);
	PlotAddPointEx(45.000000, 47.696544, 0xFF0000FF);

	PlotAddPointEx(-89.000045, -84.770698, 0x00FF00FF);
	PlotAddPointEx(-82.769119, -78.657012, 0x00FF00FF);
	PlotAddPointEx(-77.182754, -73.101699, 0x00FF00FF);
	PlotAddPointEx(-71.596435, -67.654548, 0x00FF00FF);
	PlotAddPointEx(-66.224945, -62.157554, 0x00FF00FF);
	PlotAddPointEx(-60.638633, -56.612510, 0x00FF00FF);
	PlotAddPointEx(-55.267147, -51.257965, 0x00FF00FF);
	PlotAddPointEx(-50.325363, -46.300743, 0x00FF00FF);
	PlotAddPointEx(-44.524139, -40.528656, 0x00FF00FF);
	PlotAddPointEx(-39.152633, -35.147155, 0x00FF00FF);
	PlotAddPointEx(-33.995990, -29.851428, 0x00FF00FF);
	PlotAddPointEx(-28.194774, -24.197441, 0x00FF00FF);
	PlotAddPointEx(-23.038162, -19.028282, 0x00FF00FF);
	PlotAddPointEx(-17.666683, -13.585650, 0x00FF00FF);
	PlotAddPointEx(-12.080351, -8.075496, 0x00FF00FF);
	PlotAddPointEx(-6.923737, -2.920985, 0x00FF00FF);
	PlotAddPointEx(-1.552260, 2.454371, 0x00FF00FF);
	PlotAddPointEx(4.463796, 8.461144, 0x00FF00FF);
	PlotAddPointEx(9.405555, 13.389565, 0x00FF00FF);
	PlotAddPointEx(14.562172, 18.554376, 0x00FF00FF);
	PlotAddPointEx(20.578224, 24.570209, 0x00FF00FF);
	PlotAddPointEx(25.305122, 29.275388, 0x00FF00FF);
	PlotAddPointEx(30.461750, 34.456352, 0x00FF00FF);
	PlotAddPointEx(35.833255, 39.817478, 0x00FF00FF);
	PlotAddPointEx(41.132518, 45.111064, 0x00FF00FF);
	PlotAddPointEx(44.355422, 48.331459, 0x00FF00FF);

	PlotAddPointEx(-89.000045, -82.817085, 0x0000FFFF);
	PlotAddPointEx(-82.683128, -76.455680, 0x0000FFFF);
	PlotAddPointEx(-77.569488, -71.221786, 0x0000FFFF);
	PlotAddPointEx(-72.455856, -65.866256, 0x0000FFFF);
	PlotAddPointEx(-66.439826, -60.343093, 0x0000FFFF);
	PlotAddPointEx(-61.025394, -54.686561, 0x0000FFFF);
	PlotAddPointEx(-55.610961, -49.554153, 0x0000FFFF);
	PlotAddPointEx(-49.594924, -43.601615, 0x0000FFFF);
	PlotAddPointEx(-44.782100, -38.526576, 0x0000FFFF);
	PlotAddPointEx(-38.766056, -32.730621, 0x0000FFFF);
	PlotAddPointEx(-33.953220, -27.924270, 0x0000FFFF);
	PlotAddPointEx(-28.237968, -22.222591, 0x0000FFFF);
	PlotAddPointEx(-23.124315, -17.147729, 0x0000FFFF);
	PlotAddPointEx(-17.409055, -11.385550, 0x0000FFFF);
	PlotAddPointEx(-11.994597, -6.013916, 0x0000FFFF);
	PlotAddPointEx(-6.580142, -0.640507, 0x0000FFFF);
	PlotAddPointEx(-1.165691, 4.842229, 0x0000FFFF);
	PlotAddPointEx(4.248759, 10.080507, 0x0000FFFF);
	PlotAddPointEx(9.061606, 15.063659, 0x0000FFFF);
	PlotAddPointEx(14.776863, 20.740018, 0x0000FFFF);
	PlotAddPointEx(19.890518, 25.988653, 0x0000FFFF);
	PlotAddPointEx(25.605781, 31.563863, 0x0000FFFF);
	PlotAddPointEx(30.117818, 36.228870, 0x0000FFFF);
	PlotAddPointEx(35.833057, 41.793952, 0x0000FFFF);
	PlotAddPointEx(40.946697, 46.888118, 0x0000FFFF);
	PlotAddPointEx(45.000000, 50.938789, 0x0000FFFF);

	PlotAddPointEx(0.0, 0.0, -1);

	
	//	y = a·(x+d)^2+e
	//	S(-d/e) S(-77.294738/-0.974735 * 100.0)
	//	P(-39.894561/ -0.638915 * 100.0)
	
	return true;
}

PlotAddPointEx(Float: X, Float: Y, color) {
	static
		Float: sValue,
		sColor,
		sCount
	;
	new
		Float: value = (Y - X)
	;
	if(sColor != color) {
		printf("0x%08x (%d) %f", sColor, sCount, sValue / sCount);

		sCount = 0;
		sColor = color;
		sValue = 0.0;
	}
	sValue += value;
	sCount++;

	PlotAddPoint(X, value * 10.0, color);
}
*/

/*
#include <ntest>

nTest(3x1000) {
	const playerid = 0;

	Test("distance") {
		new
			v,
			Float: X,
			Float: Y,
			Float: Z
		;
		GetPlayerPos(playerid, X, Y, Z);

		while(++v < MAX_VEHICLES) {
			if(0.0 < GetVehicleDistanceFromPoint(v, X, Y, Z) < 30.0) {
				// your code
			}
		}
	}
	Test("range") {
		new
			v,
			Float: X,
			Float: Y,
			Float: Z
		;
		while(++v < MAX_VEHICLES) {
			if(GetVehiclePos(v, X, Y, Z) && IsPlayerInRangeOfPoint(playerid, 30.0, X, Y, Z)) {
				// your code
			}
		}
	}
	Test("oldstyle") {
		new
			v,
			Float: pX,
			Float: pY,
			Float: pZ,
			Float: vX,
			Float: vY,
			Float: vZ
		;
		GetPlayerPos(playerid, pX, pY, pZ);

		while(++v < MAX_VEHICLES) {
			if(GetVehiclePos(v, vX, vY, vZ) && VectorSize(vX - pX, vY - pY, vZ - pZ) < 30.0) {
				// your code
			}
		}
	}
}
*/
/*
#include <gpcwv>
#include <mapandreas>

Init() {
	MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
}

enum eRocket {
	eRocketID,
	eRocketDist,
	Float: eRocketX,
	Float: eRocketY,
	Float: eRocketZ
}

new
	RocketData[eRocket]
;

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(newkeys & KEY_FIRE) {
		if(RocketData[eRocketID] == 0) {
			new
				objectid,
				Float: X,
				Float: Y,
				Float: Z,
				Float: vX,
				Float: vY,
				Float: vZ
			;
			GetPlayerPos(playerid, X, Y, Z);
			GetPlayerCameraWeaponVector(playerid, vX, vY, vZ);
			objectid = CreateObject(345, X, Y, Z, asin(vZ), 0.0, -atan2(vX, vY));
			MoveObject(objectid, X + vX, Y + vY, Z + vZ, 150.0);

			RocketData[eRocketID] = objectid;
			RocketData[eRocketDist] = 300;
			RocketData[eRocketX] = vX;
			RocketData[eRocketY] = vY;
			RocketData[eRocketZ] = vZ;
		}
	}
	return true;
}

public OnObjectMoved(objectid) {
	if(objectid == RocketData[eRocketID]) {
		new
			Float: oX,
			Float: oY,
			Float: oZ,
			Float: wZ
		;
		GetObjectPos(objectid, oX, oY, oZ);
		MapAndreas_FindZ_For2DCoord(oX, oY, wZ);

		if((oZ < wZ) || (RocketData[eRocketDist] == 0)) {
			DestroyObject(objectid);
			CreateExplosion(oX, oY, oZ, 2, 25.0);
			RocketData[eRocketID] = 0;
		} else {
			MoveObject(objectid, oX + RocketData[eRocketX], oY + RocketData[eRocketY], oZ + RocketData[eRocketZ], 150.0);
			RocketData[eRocketDist]--;
		}
	}
	return true;
}
*/
/*
#include <YSI\y_iterate>

stock GetFreeSeat(vehicleid, & count = 0) {
    new
        tmp,
        seat
    ;
    count = 0;

    foreach(new i: Player) {
        if(GetPlayerVehicleID(i) == vehicleid) {
            if(0 <= (seat = GetPlayerVehicleSeat(i)) < cellbits) {
                tmp |= 1 << seat;
            }
            count++;
        }
    }
    tmp = ~tmp;

    switch(~(tmp - 1) & tmp) {
        case 1 << 0: return 0;
        case 1 << 1: return 1;
        case 1 << 2: return 2;
        case 1 << 3: return 3;
        case 1 << 4: return 4;
        case 1 << 5: return 5;
        case 1 << 6: return 6;
        case 1 << 7: return 7;
        case 1 << 8: return 8;
        // could be extented till 31
    }
    return -1;
}

GetFreeSeatTest() {
    new
        player[] = {1, 0}
    ;
    for(new i = 0; i < sizeof player; ++i) {
        for(new j = 0; j < 9; j++) {
            if(player[i] == j) continue;
            else return j;
        }
        return -1;
    }
    return 1;
}

Init() {
	GetFreeSeat(0);

	printf("%d %d %d", GetFreeSeatTest(), cellmax, cellbits);
}
*/
/*
stock GetVehicleRelativePos(vehicleid, &Float:x, &Float:y, &Float:z, Float:xoff= 0.0, Float:yoff= 0.0, Float:zoff= 0.0)
{
    new Float:rot;
    GetVehicleZAngle(vehicleid, rot);
    GetVehiclePos(vehicleid, x, y, z);
    x += floatcos(rot, degrees) * xoff - floatsin(rot, degrees) * yoff;
    y += floatsin(rot, degrees) * xoff + floatcos(rot, degrees) * yoff;
    z += zoff;
}

Init() {
	new Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2;
		
	//For the front left tyre:
		GetVehicleModelInfo(GetVehicleModel(veh), VEHICLE_MODEL_INFO_WHEELSFRONT, x, y, z);
		GetVehicleRelativePos(veh, x2, y2, z2, -x - 0.5, y, z);
		SetPlayerCheckpoint(playerid, x2, y2, z2, 0.5);

	//For the front right tyre...
		GetVehicleModelInfo(GetVehicleModel(veh), VEHICLE_MODEL_INFO_WHEELSFRONT, x, y, z);
		GetVehicleRelativePos(veh, x2, y2, z2, x + 0.5, y, z);
		SetPlayerCheckpoint(playerid, x2, y2, z2, 0.5);

	//For the Back left tyre...
		GetVehicleModelInfo(GetVehicleModel(veh), VEHICLE_MODEL_INFO_WHEELSREAR, x, y, z);
		GetVehicleRelativePos(veh, x2, y2, z2, -x - 0.5, y, z);
		SetPlayerCheckpoint(playerid, x2, y2, z2, 0.5);

	//For the Back right tyre...
		GetVehicleModelInfo(GetVehicleModel(veh), VEHICLE_MODEL_INFO_WHEELSREAR, x, y, z);
		GetVehicleRelativePos(veh, x2, y2, z2, x + 0.5, y, z);
		SetPlayerCheckpoint(playerid, x2, y2, z2, 0.5);
}
*/
/*
Init() {
	#define COL_GREEN "green"
	#define green "green"
	#define Servername "servername"

	const
		playerid = 0,
		Dialog_Jobs = 0
	;
	ShowPlayerDialog(
		playerid, Dialog_Jobs, DIALOG_STYLE_MSGBOX, COL_GREEN "Available Jobs",
		green Servername " Stunt/Freeroam Tester Commands!\n\n", "Close", ""
	);
}
*/
/*
swap(& var1, & var2) {
    #emit lref.s.pri var1
    #emit lref.s.alt var2
    #emit sref.s.pri var2
    #emit sref.s.alt var1
}

strscramble(src[], dest[], ssize = sizeof src, dsize = sizeof dest) {
    if(dsize < ssize) {
        return false;
    }
    strcat(dest, src, dsize);
    ssize = strlen(src);
    dsize = 0;

	printf("\"%s\" - \"%s\"", src, dest);

    while(dsize != ssize) {
        swap(dest[dsize], dest[dsize + random(ssize - dsize)]);
        dsize++;
    }
    return true;
}

randomizeArray(src[], dest[], ssize = sizeof src, dsize = sizeof dest) {
    if(dsize < ssize) {
        return false;
    }
    memcpy(dest, src, 0, ssize >> 2, dsize >> 2);
    dsize = 0;

    while(dsize < ssize) {
        swap(dest[dsize], dest[dsize + random(ssize - dsize)]);
        dsize++;
    }
    return true;
}

Init() {
	new tmp[5] = {0, 1, 2, ...};
	static empty[sizeof tmp];

	printf("%d %d %d %d %d", tmp[0], tmp[1], tmp[2], tmp[3], tmp[4]);

	const fill = sizeof tmp * 4;

	#emit zero.pri
	#emit addr.alt tmp
	#emit fill fill

	printf("%d %d %d %d %d", tmp[0], tmp[1], tmp[2], tmp[3], tmp[4]);

	tmp = empty;

	new
		temp[] = "Hello World",
		dest[sizeof temp]
	;
	strscramble(temp, dest);

	printf("\"%s\" - \"%s\"", temp, dest);

	new
		array[] = {1, 2, 3, 4, 5, 0, 0, 0, 0}
	;
	randomizeArray(array, array, 5);

	printf("%d %d %d %d %d", array[0], array[1], array[2], array[3], array[4]);
}
*/
/*
Init() {
	const bool: utf8 = false;

	new
		value,
		File: gFile = fopen("test.txt", io_write)
	;
	fputchar(gFile, 0x44, utf8);
	fputchar(gFile, 0x21, utf8);
	fputchar(gFile, 0x3c, utf8);
	fputchar(gFile, 0xda, utf8);
	fputchar(gFile, 0xbe, utf8);
	fputchar(gFile, 0x0, utf8);
	fputchar(gFile, 0x0a, utf8);
	fputchar(gFile, 0xff, utf8);

	fclose(gFile);
	
	gFile = fopen("test.txt", io_read);

	new
		tmp[16],
		var = 1
	;
	while((value = fgetchar(gFile, var, utf8)) != -1) {
		printf("0x%x | %d", value, var);
	}
	print("\r");
	fseek(gFile, 0);
	fblockread(gFile, tmp);

	for(new i, j; i < sizeof tmp; i++) {
		tmp[i] = swapchars(tmp[i]);

		for(j = 0; j < 4; j++) {
			printf("0x%x", tmp{i * 4 + j});

			if(tmp{i * 4 + j} == 0xFF) {
				i = sizeof tmp;
				break;
			}
		}
	}
	fclose(gFile);
}
*/
/*
funcname(playerid, ...) {
    new
        arg,
        args,
        addr,
		size
    ;
    #emit addr.pri 12
    #emit stor.s.pri arg
    #emit load.s.alt 8
    #emit add
    #emit stor.s.pri args

    while((arg += 4) < args) {
        static
            tmp[1][1]
        ;
        #emit lref.s.pri arg
        #emit stor.s.pri addr
        #emit load.i
		#emit shr.c.pri 2
		#emit stor.s.pri size

        funcPhrase2D(playerid, addr, tmp, size);
    }
}

funcPhrase2D(playerid, addr, array[][], size) {
    #emit load.s.pri addr
    #emit stor.s.pri array

	while(--size >= 0) {
		print(array[size]);
	}
}


new str1[][] = {"hello", "beautiful", "world"};
new str2[][] = {"Nero", "3D"};

Init() {
	funcname(0, str1, str2);
}
*/
/*
#include <screentoworld>

public OnPlayerSpawn(playerid) {
	const
		Float: distance = 25.0
	;
	new
		Float: TextDrawX = 400.0,
		Float: TextDrawY = 300.0,
		Float: cameraX,
		Float: cameraY,
		Float: cameraZ,
		Float: vectorX,
		Float: vectorY,
		Float: vectorZ
	;
	GetPlayerCameraPos(playerid, cameraX, cameraY, cameraZ);
	ScreenToWorld(playerid, TextDrawX, TextDrawY, vectorX, vectorY, vectorZ);

	cameraX += vectorX * distance;
	cameraY += vectorY * distance;
	cameraZ += vectorZ * distance;

	printf("%f %f %f", cameraX, cameraY, cameraZ);
	// and reverse
	WorldToScreen(playerid, cameraX, cameraY, cameraZ, TextDrawX, TextDrawY);

	printf("%f %f", TextDrawX, TextDrawY);
}
*/
/*
static const OFFSET = 100;

SetPlayerToFacePlayer(playerid, targetid) {
    new
        Float: pX,
        Float: pY,
        Float: tX,
        Float: tY
    ;
    return
        GetPlayerPos(targetid, tX, tY, Float: targetid) &&
        GetPlayerPos(playerid, pX, pY, Float: targetid) &&
        SetPlayerFacingAngle(playerid, -atan2(tX - pX, tY - pY))
    ;
}

Float: GetAngleByXY(Float: x, Float: y) {
    if((x = -atan2(x, y)) < 0.0) {
        return x + 360.0;
    }
    return x;
}

Init() {
	printf("%f %f %d", GetAngleByXY(0.5, 0.5), -atan2(0.5, 0.5), OFFSET);

	SetPlayerToFacePlayer(0, 1);

	new str[2];
	return format(str, sizeof str, "");
}
*/
/*
#include <YSI\y_inline>
#include <YSI\y_text>

loadtext mode_text[all];

Init() {
	Langs_Add("EN", "English");
    Langs_Add("NL", "Nederlands");

	Extra_DoRegister(0, "");
}

stock Extra_DoRegister(playerid, string:pw[])
{
//	if (Player_IsLoggedIn(playerid))
//	{
//		Text_Send(playerid, $YSI_LOGIN_ALREADY);
//		return 1;
//	}
//	else if (Player_IsRegistered(playerid))
//	{
//		//Text_Send(playerid, $YSI_LOGIN_ALREADY);
//		Text_Send(playerid, $YSI_REG_TAKEN);
//		Extra_DoLogin(playerid, NULL);
//		return 1;
//	}
	if (isnull(pw))
	{
		// Enter password.
		inline Response1(pid1, dialogid1, response1, listitem1, string:text1[])
		{
			#pragma unused listitem1, dialogid1, pid1
			if (response1)
			{
				switch (strlen(text1))
				{
					case 0:
					{
						Text_Send(playerid, $YSI_LOGIN_ENTER);
					}
					case 1:
					{
						if (isnull(text1)) Text_Send(playerid, $YSI_LOGIN_ENTER);
						else Text_Send(playerid, $YSI_LOGIN_LENGTH);
					}
					case 2 .. 5:
					{
						Text_Send(playerid, $YSI_LOGIN_LENGTH);
					}
					default:
					{
						// Can add code here to test the strength of the pass.
						Extra_DoRegister(playerid, text1);
						return 1;
					}
				}
				Extra_DoRegister(playerid, NULL);
			}
		}
		Text_PasswordBox(playerid, using inline Response1, $YSI_EXTRA_REGISTER_TITLE, $YSI_EXTRA_REGISTER_PROMPT, $DIALOG_OK, $DIALOG_CANCEL);
	}
	else
	{
		// Store the password localy in the function and get confirmation.
		new
			pass[32];
		strcpy(pass, pw);
		inline Response2(pid2, dialogid2, response2, listitem2, string:text2[])
		{
			#pragma unused listitem2, dialogid2, pid2
			if (response2)
			{
				switch (strlen(text2))
				{
					case 0:
					{
						Text_Send(playerid, $YSI_LOGIN_ENTER);
					}
					case 1:
					{
						if (isnull(text2)) Text_Send(playerid, $YSI_LOGIN_ENTER);
						else Text_Send(playerid, $YSI_LOGIN_LENGTH);
					}
					case 2 .. 5:
					{
						Text_Send(playerid, $YSI_LOGIN_LENGTH);
					}
					default:
					{
						if (strcmp(pass, text2))
						{
							Text_Send(playerid, $YSI_EXTRA_REGISTER_MISMATCH);
						}
						else
						{
//							Player_TryRegister(playerid, text2);
							return 1;
						}
					}
				}
				// Try again.
				Extra_DoRegister(playerid, pass);
			}
		}
		Text_PasswordBox(playerid, using inline Response2, $YSI_EXTRA_REGISTER_TITLE, $YSI_EXTRA_CONFIRM_PROMPT, $DIALOG_OK, $DIALOG_CANCEL);
	}
	return 1;
}
*/
/*
#include <md-sort>
#include <YSI\y_iterate>

enum pInfo { pScore }
new PlayerInfo[MAX_PLAYERS][pInfo];

GetHighScorePlayers(array[MAX_PLAYERS][2]) {
    // and we store the playerid and the score in the array
    foreach(new i : Player) {
        array[i][0] = i;
        array[i][1] = PlayerInfo[i][pScore];
    }
    // now we just sort the whole array descending by the value stored in [1] (the score)
    SortDeepArray(array, 1, .order = SORT_DESC);
}

SortPlayersBy(array[MAX_PLAYERS][2], pInfo: idx, E_SORT_ORDER: order = SORT_DESC) {
    // and we store the playerid and the score in the array
    foreach(new i : Player) {
        array[i][0] = i;
        array[i][1] = PlayerInfo[i][idx];
    }
    // now we just sort the whole array descending by the value stored in [1] (the score)
    SortDeepArray(array, 1, .order = order);
}

new Text: FirstPlace;

main() {
// example
    new
        wPlayers[MAX_PLAYERS][2]
    ;
    GetHighScorePlayers(wPlayers);
    // wPlayers[x][0] stores the playerid
    // wPlayers[x][1] stores the score
    new
        first[MAX_PLAYER_NAME],
        second[MAX_PLAYER_NAME],
        third[MAX_PLAYER_NAME],
        string[128]
    ;
    GetPlayerName(wPlayers[0][0], first, sizeof first);
    GetPlayerName(wPlayers[1][0], second, sizeof second);
    GetPlayerName(wPlayers[2][0], third, sizeof third);

    format(string, sizeof string,
        "\
            %s(%d)\n\
            %s(%d)\n\
            %s(%d)\
        "
        , first, wPlayers[0][1]
        , second, wPlayers[1][1]
        , third, wPlayers[2][1]
    );
    TextDrawSetString(FirstPlace, string);
    TextDrawShowForAll(FirstPlace);
}
*/
/*
native SetString(str[], len = sizeof(str));

main() {
	new array[32];
	SetString(array);

	print(array);
}
*/
/*
stock DumpVariable( { _, Float, Text3D, Menu, Text, DB, DBResult, bool, File }: xVariable, iType = tagof( xVariable ) ) {
	#pragma unused xVariable

	return iType;
}

main()  {
	enum e_02 {
			id,
			Float: valeur,
			www[2]
	};
	new tab[e_02];
	tab[id] = 5;
	tab[valeur] = 4.0;
	tab[www][0] = -6;

	new	Float: fvar, var;
		   
	for(new i; i < sizeof(tab); i++) printf("tab[%i] = %d (%d)", i, tab[e_02: i], DumpVariable(tab[e_02: i])); // problem with tab[i]
	printf("%d %d %d %d %d %d", tagof( _: ), DumpVariable( tab[id] ), DumpVariable( fvar ), DumpVariable( tab[valeur] ), DumpVariable( e_02 ), DumpVariable( tab[www] ) );
}
*/
/*
new Colors[] = {
    0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
    0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
    0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
    0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
    0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
    0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
    0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
    0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
    0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
    0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
    0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
    0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
    0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF,
    // SA-MP extended colours (0.3x)
    0x177517FF, 0x210606FF, 0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF,
    0xB7B7B7FF, 0x464C8DFF, 0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF,
    0x1E1D13FF, 0x1E1306FF, 0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF,
    0x992E1EFF, 0x2C1E08FF, 0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF,
    0x481A0EFF, 0x7A7399FF, 0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF,
    0x7B3E7EFF, 0x3C1737FF, 0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF,
    0x163012FF, 0x16301BFF, 0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF,
    0x2B3C99FF, 0x3A3A0BFF, 0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF,
    0x2C5089FF, 0x15426CFF, 0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF,
    0x995C52FF, 0x99581EFF, 0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF,
    0x96821DFF, 0x197F19FF, 0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF,
    0x8A653AFF, 0x732617FF, 0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF,
    0x561A28FF, 0x4E0E27FF, 0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};

public OnPlayerCommandText(playerid, cmdtext[]) {
	if(strcmp(cmdtext, "/colourlist", true) == 0) {
		new
			dstring[2048 + 1]
		;
		for(new i; i < sizeof Colors; i++) {
			if((i % 10) == 0) {
				format(dstring, sizeof dstring, "%s\n{%06x}%02d|%d", dstring, Colors[i] >>> 8, i / 10, i % 10);
			} else {
				format(dstring, sizeof dstring, "%s{%06x}%d", dstring, Colors[i] >>> 8, i % 10);
			}
		}
		for(new i = sizeof dstring; dstring[--i] != '\n'; dstring[i] = EOS) {}
		return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_INPUT, "Vehicle Colours", dstring[1], "Okay", "");
//		for(new i; i < sizeof Colors; i++) {
//			format(dstring, sizeof dstring, "%s\n{%06x}Col#%03d", dstring, Colors[i] >>> 8, i);
//		}
//		return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, "Vehicle Colours", dstring[1], "Okay", "");
	}
	return false;
}
*/
/*
public OnPlayerUpdate(playerid) {
	new
		tmp[64],
		Float: A,
		Float: vX,
		Float: vY,
		Float: vZ
	;
	GetPlayerFacingAngle(playerid, A);
	GetPlayerCameraFrontVector(playerid, vX, vY, vZ);
	format(tmp, sizeof tmp, "atan2(%f, %f) %f - %f", vX, vY, -atan2(vX, vY), A);
	SendClientMessage(playerid, -1, tmp);
	return true;
}
*/
/*
stock RetnArray(array[]) {
	// Resetting stack
	#emit load.s.pri 0
	#emit move.alt
	#emit sctrl 4 // stack
	// Copying return address
	#emit add.c 4
	#emit load.i
	#emit stor.s.pri 4
	// Getting return position
	#emit const.pri 8
	#emit add
	#emit move.alt
	#emit load.i
	#emit add
	#emit add.c 4
	// Overwritting address
	#emit move.alt
	#emit load.s.pri array
	#emit stor.i
	// Return
	#emit retn
	// We return an array
	new
		tmp[1]
	;
	return tmp;
}

stock Language(lang, lang_eng[], lang_de[]) {
	switch(lang) {
		case 1: {
			return RetnArray(lang_de);
		}
	}
	return RetnArray(lang_eng);
}
*/
/*
stock Language(lang, lang_eng[144], lang_de[144]) {
	switch(lang) {
		case 0: {
			return lang_eng;
		}
		case 1: {
			return lang_de;
		}
	}
	return lang_eng;
}

main()
{
	new sz_str[144];
	format(sz_str,sizeof(sz_str),Language(random(2),"The sky is blue. %s","Der Himmel ist blau. %s"),"WTF ERROR");
	printf("%s",sz_str);
}
*/
/*
#include <ndialog>

public OnPlayerConnect(playerid) {
	ShowPlayerDialog(playerid, GetPublicDialogID("Connect_Dialog"), DIALOG_STYLE_MSGBOX, "Welcome", "Press Continue to select a class!", "Continue", "");
	TogglePlayerSpectating(playerid, true);

	SetPlayerCameraPos(playerid,323.4-1.5-1.0,305.6,999.1+0.7);
	SetPlayerCameraLookAt(playerid,323.4-1.0,305.6,999.1+0.7);
	return true;
}

public OnPlayerRequestClass(playerid, classid) {
	return true;
}

Dialog:Connect_Dialog(playerid, dialogid, response, listitem, inputtext[]) {
	TogglePlayerSpectating(playerid, false);
	return true;
}
*/
/*
#include <a_samp>

SwapArrayRow( { Float, _ }: ...) {
	// loading array address
	#emit load.s.alt 12
	// calculating slot 1
	#emit lref.s.pri 16
	#emit shl.c.pri 2
	#emit add
	#emit stor.s.pri 16
	// calculating slot 2
	#emit lref.s.pri 20
	#emit shl.c.pri 2
	#emit add
	#emit stor.s.pri 20
	// calculating difference
	#emit load.s.alt 16
	#emit sub
	#emit stor.s.pri 12
	// swapping addresses
	#emit lref.s.alt 20
	#emit add
	#emit lref.s.alt 16
	#emit sref.s.pri 16
	#emit load.s.pri 12
	#emit sub.alt
	#emit sref.s.pri 20
}

stock GnomSort(array[][], idx = 0, start = 0, size = sizeof array) {
	new
		i = start,
		j
	;
	while(++i < size) {
		for(j = i; (j != start) && (array[j][idx] < array[j - 1][idx]); --j) { // ascending
			SwapArrayRow(array, j, j - 1);
		}
	}
}

stock BubbleSort(array[][], idx = 0, start = 0, len = sizeof(array)) {
    new
        i,
        l
    ;
    len--;

    do {
        for(l = 0, i = start; i < len; ++i) {
            if(array[i + 1][idx] < array[i][idx]) {
                SwapArrayRow(array, i + 1, (l = i));
            }
        }
    } while((len = l));
}

enum eListInfo { l_int, l_str[10], Float:l_float }

new List[][eListInfo] = {
    {2,"2Test",2.2},
    {1,"1Test",1.1},
    {4,"4Test",4.4},
    {3,"3Test",3.3},
    {5,"5Test",5.5}
};

enum eDataInfo { d_int, d_str[10], Float:d_float }

new Data[][eDataInfo] = {
    {7,"3Test",1.1},
    {4,"2Test",8.8},
    {2,"5Test",3.3},
    {8,"6Test",5.5},
    {6,"9Test",7.7}
};

main()
{
//	GnomSort(List);

    BubbleSort(List, l_int);
    for(new i;i<sizeof(List);i++) printf("%d %s %.f",List[i][l_int],List[i][l_str],List[i][l_float]);

	printf("");

    BubbleSort(Data, d_str);
    for(new i;i<sizeof(Data);i++) printf("%d %s %.f",Data[i][d_int],Data[i][d_str],Data[i][d_float]);
	return 1;
}
*/
/*
#define DEBUG 3

#if !defined DEBUG
	#define DEBUG 0
#endif

native debug_1(const format[], {Float, _}: ...) = printf;
native debug_2(const format[], {Float, _}: ...) = printf;
native debug_3(const format[], {Float, _}: ...) = printf;
native debug_4(const format[], {Float, _}: ...) = printf;
native debug_5(const format[], {Float, _}: ...) = printf;
native debug_6(const format[], {Float, _}: ...) = printf;

#define debug::%0( debug_%0(

#if DEBUG >= 1
#else
	#define debug_1(%0);
#endif
#if DEBUG >= 2
#else
	#define debug_2(%0);
#endif
#if DEBUG >= 3
#else
	#define debug_3(%0);
#endif
#if DEBUG >= 4
#else
	#define debug_4(%0);
#endif
#if DEBUG >= 5
#else
	#define debug_5(%0);
#endif
#if DEBUG >= 6
#else
	#define debug_6(%0);
#endif

main() {
	debug::1("W", 5);
	debug::2("o", 5);
	debug::3("r", 5);
	debug::4("l", 5);
	debug::5("d", 5);
}
*/

/*
#include <ntest>
#include <zcmd>

#undef OnPlayerCommandText

nTest(3x100000) {
	Test("strcmp") {
        OnPlayerCommandText_strcmp(0, "/test6 Hello World");
    }
	Test("zcmd") { // faster at around 6 cmds
        OnPlayerCommandText(0, "/test6 Hello World");
    }
}

static stock
	cEOS[] = 0
;

#define dcmd(%2,%1,%0) static const %2c[] = "/" #%2; if((strcmp((%1), %2c, true, sizeof %2c) == 0) && ((((%1)[sizeof %2c] == ' ') && cmd_%2((%0), (%1)[sizeof %2c + 1])) || cmd_%2((%0), cEOS))) return 1

forward OnPlayerCommandText_strcmp(playerid, cmdtext[]);
public OnPlayerCommandText_strcmp(playerid, cmdtext[]) {
	dcmd(test0, cmdtext, playerid);
	dcmd(test1, cmdtext, playerid);
	dcmd(test2, cmdtext, playerid);
	dcmd(test3, cmdtext, playerid);
	dcmd(test4, cmdtext, playerid);
	dcmd(test5, cmdtext, playerid);
	dcmd(test6, cmdtext, playerid);
	dcmd(test7, cmdtext, playerid);
	dcmd(test8, cmdtext, playerid);
	dcmd(test9, cmdtext, playerid);
	dcmd(test10, cmdtext, playerid);
	dcmd(test11, cmdtext, playerid);
	dcmd(test12, cmdtext, playerid);
	dcmd(test13, cmdtext, playerid);
	dcmd(test14, cmdtext, playerid);
	dcmd(test15, cmdtext, playerid);
	dcmd(test16, cmdtext, playerid);
	dcmd(test17, cmdtext, playerid);
	dcmd(test18, cmdtext, playerid);
	dcmd(test19, cmdtext, playerid);
	dcmd(test20, cmdtext, playerid);
	dcmd(test21, cmdtext, playerid);
	dcmd(test22, cmdtext, playerid);
	dcmd(test23, cmdtext, playerid);
	dcmd(test24, cmdtext, playerid);
	dcmd(test25, cmdtext, playerid);
	dcmd(test26, cmdtext, playerid);
	dcmd(test27, cmdtext, playerid);
	dcmd(test28, cmdtext, playerid);
	dcmd(test29, cmdtext, playerid);
	dcmd(test30, cmdtext, playerid);
	dcmd(test31, cmdtext, playerid);
	dcmd(test32, cmdtext, playerid);
	dcmd(test33, cmdtext, playerid);
	dcmd(test34, cmdtext, playerid);
	dcmd(test35, cmdtext, playerid);
	dcmd(test36, cmdtext, playerid);
	dcmd(test37, cmdtext, playerid);
	dcmd(test38, cmdtext, playerid);
	dcmd(test39, cmdtext, playerid);
	dcmd(test40, cmdtext, playerid);
	dcmd(test41, cmdtext, playerid);
	dcmd(test42, cmdtext, playerid);
	dcmd(test43, cmdtext, playerid);
	dcmd(test44, cmdtext, playerid);
	dcmd(test45, cmdtext, playerid);
	dcmd(test46, cmdtext, playerid);
	dcmd(test47, cmdtext, playerid);
	dcmd(test48, cmdtext, playerid);
	dcmd(test49, cmdtext, playerid);

	return false;
}

CMD:test0(playerid, params[]) return true;
CMD:test1(playerid, params[]) return true;
CMD:test2(playerid, params[]) return true;
CMD:test3(playerid, params[]) return true;
CMD:test4(playerid, params[]) return true;
CMD:test5(playerid, params[]) return true;
CMD:test6(playerid, params[]) return true;
CMD:test7(playerid, params[]) return true;
CMD:test8(playerid, params[]) return true;
CMD:test9(playerid, params[]) return true;
CMD:test10(playerid, params[]) return true;
CMD:test11(playerid, params[]) return true;
CMD:test12(playerid, params[]) return true;
CMD:test13(playerid, params[]) return true;
CMD:test14(playerid, params[]) return true;
CMD:test15(playerid, params[]) return true;
CMD:test16(playerid, params[]) return true;
CMD:test17(playerid, params[]) return true;
CMD:test18(playerid, params[]) return true;
CMD:test19(playerid, params[]) return true;
CMD:test20(playerid, params[]) return true;
CMD:test21(playerid, params[]) return true;
CMD:test22(playerid, params[]) return true;
CMD:test23(playerid, params[]) return true;
CMD:test24(playerid, params[]) return true;
CMD:test25(playerid, params[]) return true;
CMD:test26(playerid, params[]) return true;
CMD:test27(playerid, params[]) return true;
CMD:test28(playerid, params[]) return true;
CMD:test29(playerid, params[]) return true;
CMD:test30(playerid, params[]) return true;
CMD:test31(playerid, params[]) return true;
CMD:test32(playerid, params[]) return true;
CMD:test33(playerid, params[]) return true;
CMD:test34(playerid, params[]) return true;
CMD:test35(playerid, params[]) return true;
CMD:test36(playerid, params[]) return true;
CMD:test37(playerid, params[]) return true;
CMD:test38(playerid, params[]) return true;
CMD:test39(playerid, params[]) return true;
CMD:test40(playerid, params[]) return true;
CMD:test41(playerid, params[]) return true;
CMD:test42(playerid, params[]) return true;
CMD:test43(playerid, params[]) return true;
CMD:test44(playerid, params[]) return true;
CMD:test45(playerid, params[]) return true;
CMD:test46(playerid, params[]) return true;
CMD:test47(playerid, params[]) return true;
CMD:test48(playerid, params[]) return true;
CMD:test49(playerid, params[]) return true;
*/
/*
stock SpawnToHospital(playerid) {
    static Float: hspawns[][] = {
        {2034.1670,-1406.0623,17.2181,150.4297},
        {1177.3391,-1324.2300,14.0658,268.3749}
    };
    new
        closest = GetClosestFromPlayer(playerid, hspawns)
    ;
    if(closest != -1) {
//        dead[playerid] = false;
        SetPlayerPos(playerid, hspawns[closest][0], hspawns[closest][1], hspawns[closest][2]);
        SetPlayerFacingAngle(playerid, hspawns[closest][3]);
        return SetCameraBehindPlayer(playerid);
    }
    return false;
}

GetClosestFromPlayer(playerid, const {_, Float}: data[][], Float: distance = 0.0, size = sizeof data) {
    if((distance = GetPlayerDistanceFromPoint(playerid, data[0][0], data[0][1], data[0][2]))) {
        new
            closest,
            Float: tmp
        ;
        while(--size) {
            tmp = GetPlayerDistanceFromPoint(playerid, data[size][0], data[size][1], data[size][2]);

            if(tmp < distance) {
                distance = tmp;
                closest = size;
            }
        }
        return closest;
    }
    return -1;
}

main() {
	SpawnToHospital(0);
}
*/
/*
#include <gpcwv>

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
	new
		Float: oX,
		Float: oY,
		Float: oZ,
		Float: vX,
		Float: vY,
		Float: vZ
	;
	GetPlayerCameraPos(playerid, oX, oY, oZ);
	GetPlayerCameraWeaponVector(playerid, vX, vY, vZ);

	CreateExplosion(
		oX + vX * 25.0,
		oY + vY * 25.0,
		oZ + vZ * 25.0,
		0, 5.0
	);
	return true;
}
*/

/*
main() {
	static
		addr,
		array[] = "Hello World"
	;
	format(array, sizeof array, array);
	print("");

	const
		size = sizeof array,
		byte = size * -4
	;
	#emit lctrl 4 // stack
	#emit add.c byte
	#emit stor.pri addr

	new tmp[sizeof array] = "Hi"; // works

	#emit push.c array
	#emit push.c size
	#emit push addr
	#emit push.c 12
	#emit sysreq.c format
	#emit stack 16

//	#emit push addr
//	#emit push.c 4
//	#emit sysreq.c print
//	#emit stack 8

//	new tmp[sizeof array] = "Hi"; // doesn't

	print(tmp);
}
*/
/*
#include <a_samp>
#include <YSI\y_va>

main() {
	new
		resultHolder[128];

	format(resultHolder, sizeof resultHolder, "");

	Fine(resultHolder, sizeof resultHolder, "Hello %s %s %s", "World", "of", "pain");
	printf("Fine: %s", resultHolder);
	NotFine(resultHolder, sizeof resultHolder, "Hello %s %s %s", "World", "of", "pain");
	printf("NotFine: %s", resultHolder);
}

Fine(out[], size, const fmt[], va_args<>) {
	va_format(out, size, fmt, va_start<3>);
}

NotFine(out[], size, const fmt[], va_args<>) {
	static
		killer[128];

	va_format(killer, sizeof killer, fmt, va_start<3>);

	#pragma unused out, size
}
*/
/*
native SendErrorMessage(playerid, color = 0xFF0000FF, const message[] = "Error") = SendClientMessage;
native SetSpawnInfoEx(playerid, team = NO_TEAM, skin = 0, Float: X = 0.0, Float: Y = 0.0, Float: Z = 7.0, Float: rot = 0.0, w1 = 0, a1 = 0, w2 = 0, a2 = 0, w3 = 0, a3 = 0) = SetSpawnInfo;

public OnPlayerDeath(playerid, killerid, reason) {
	SetSpawnInfoEx(playerid);
	return true;
}
*/
/*
new
	Float: LastShot[MAX_PLAYERS]
;

public OnPlayerDisconnect(playerid, reason) {
	LastShot[playerid] = 0.0;

	return true;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
	static
		Float: oX,
		Float: oY,
		Float: oZ,
		Float: hX,
		Float: hY,
		Float: hZ
	;
	GetPlayerLastShotVectors(playerid, oX, oY, oZ, hX, hY, hZ);

	oX = (hX * hY * hZ);

	if(LastShot[playerid] != oX) {
		CreateExplosion(hX, hY, hZ, 0, 5.0);

		LastShot[playerid] = oX;
	}
	return true;
}
*/
/*
GetPublicAddr(func[]) {
	new
		idx = funcidx(func)
	;
	if(idx != -1) {
		#emit lctrl 1
		#emit neg
		#emit move.alt
		#emit add.c 32
		#emit stor.s.pri func
		#emit lref.s.pri func
		#emit add
		#emit load.s.alt idx
		#emit shl.c.alt 3
		#emit add
		#emit stor.s.pri idx
		#emit lref.s.pri idx
		#emit retn
	}
}

ChangeCasePointer(casevalue, addr) { // uses the amx offset, to bored to look in zeex amx liberay :p
	// this function needs to be at the end of the case!
	new
		dat,
		cod,
		tmp
	;
	#emit lctrl 1 // dat
	#emit stor.s.pri dat
	#emit lctrl 0 // cod
	#emit stor.s.pri cod

	#emit load.s.pri 4 // return address
	#emit stor.s.pri addr

	addr += 4 + cod - dat;

	printf("%d", addr);

	#emit lref.s.pri addr
	#emit stor.s.pri addr
	#emit stor.s.pri 4

	return 0;

	addr -= dat;

	printf("%d", addr);

	do {
		addr -= 8;

		#emit lref.s.pri addr
		#emit stor.s.pri tmp

		printf("%d", tmp);
	} while(tmp != casevalue);
}

main() {
	printAssembly();

	switch(0) {
		case 1: print("hi");
		default: {}
	}
	ChangeCasePointer(0, GetPublicAddr("MyFunc"));
}
*/
/*
printAmx() {
	new
		dat,
		heap,
		tmp[1]
	;
	#emit lctrl 1
	#emit neg
	#emit move.alt
	#emit stor.s.pri dat
	#emit add.c 20
	#emit stor.s.pri heap
	#emit lref.s.pri heap
	#emit add
	#emit stor.s.pri heap

	while(dat < heap) {
		#emit lref.s.pri dat
		#emit stor.s.pri tmp

		printf(\"%d. %d - %d %d %d %d : %c - %c %c %c %c", dat, tmp, tmp{3}, tmp{2}, tmp{1}, tmp{0}, tmp, tmp{3}, tmp{2}, tmp{1}, tmp{0});

		dat += 4;		
	}
}

main() {
	printAmx();
}
*/

/*
#include <YSI\y_iterate>

ProxDetector(playerid, Float: radius, string[], col1, col2, col3, col4, col5) {
    new
        Float: x,
        Float: y,
        Float: z
    ;
    if(GetPlayerPos(playerid, x, y, z)) {
        new
            interior = GetPlayerInterior(playerid),
            virtualworld = GetPlayerVirtualWorld(playerid)
        ;
        foreach(Player, i) {
            if((GetPlayerInterior(i) == interior) && (GetPlayerVirtualWorld(i) == virtualworld)) {
                switch(floatround((radius / GetPlayerDistanceFromPoint(i, x, y, z)), floatround_floor)) {
                    case 0: {} // not in range
                    case 1: SendClientMessage(i, col5, string);
                    case 2, 3: SendClientMessage(i, col4, string);
                    case 4..7: SendClientMessage(i, col3, string);
                    case 8..15: SendClientMessage(i, col2, string);
                    default: SendClientMessage(i, col1, string); // 16 or over
                }
            }
        }
        return true;
    }
    return false;
}

#include <nTest>

nTest(3x100000) {
	new
		playerid = random(MAX_PLAYERS),
		string[] = "Hello World",
		Float: radius = 15.0,
		col1 = 1,
		col2 = 2,
		col3 = 3,
		col4 = 4,
		col5 = 5
	;
	Test("1") {
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);

        for(new i; i != MAX_PLAYERS; ++i) {
                switch(floatround((radius / GetPlayerDistanceFromPoint(i, x, y, z)), floatround_floor)) {
                    case 0: {} // not in range
                    case 1: SendClientMessage(i, col5, string);
                    case 2, 3: SendClientMessage(i, col4, string);
                    case 4..7: SendClientMessage(i, col3, string);
                    case 8..15: SendClientMessage(i, col2, string);
                    default: SendClientMessage(i, col1, string); // 16 or over
                }
        }
	}
	Test("2") {
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		new Float:ix, Float:iy, Float:iz;
		new Float:cx, Float:cy, Float:cz;
		for(new i; i != MAX_PLAYERS; ++i)
		{
			GetPlayerPos(i, ix, iy, iz);
			cx = (x - ix);
			cy = (y - iy);
			cz = (z - iz);
			if(((cx < radius/16) && (cx > -radius/16)) && ((cy < radius/16) && (cy > -radius/16)) && ((cz < radius/16) && (cz > -radius/16)))
			{
				SendClientMessage(i, col1, string);
			}
			else if(((cx < radius/8) && (cx > -radius/8)) && ((cy < radius/8) && (cy > -radius/8)) && ((cz < radius/8) && (cz > -radius/8)))
			{
				SendClientMessage(i, col2, string);
			}
			else if(((cx < radius/4) && (cx > -radius/4)) && ((cy < radius/4) && (cy > -radius/4)) && ((cz < radius/4) && (cz > -radius/4)))
			{
				SendClientMessage(i, col3, string);
			}
			else if(((cx < radius/2) && (cx > -radius/2)) && ((cy < radius/2) && (cy > -radius/2)) && ((cz < radius/2) && (cz > -radius/2)))
			{
				SendClientMessage(i, col4, string);
			}
			else if(((cx < radius) && (cx > -radius)) && ((cy < radius) && (cy > -radius)) && ((cz < radius) && (cz > -radius)))
			{
				SendClientMessage(i, col5, string);
			}
		}
	}
}
*/
//#pragma dynamic 4096 // 16kB
/*
main()
{
    new time = GetTickCount();

	new str1[] ="+++++++++++++++++++++++++++++++++++++++string++++++++++++++++++++++++++++++++++++++++++";
	Games_trim2(str1, '+');
	printf("- Games_trim2(): \"%s\"", str1);

	new str2[] = "+++++++++++++++++++++++++++++++++++++++string++++++++++++++++++++++++++++++++++++++++++";
	Games_trimE(str2, '+');
	printf("- Games_trimE(): \"%s\"", str2);

	new str3[] = "+++++++++++++++++++++++++++++++++++++++string++++++++++++++++++++++++++++++++++++++++++";
	Games_trimX(str3, '+');
	printf("- Games_trimX(): \"%s\"\n\n", str3);

    for(new i; i < 1000000; i++) {
        new str[] ="+++++++++++++++++++++++++++++++++++++++string++++++++++++++++++++++++++++++++++++++++++";
        Games_trim2(str, '+');
    }
    printf("- Games_trim2(): %i (ms)", GetTickCount()-time);

    time = GetTickCount();
    for(new i; i < 1000000; i++) {
        new str[] = "+++++++++++++++++++++++++++++++++++++++string++++++++++++++++++++++++++++++++++++++++++";
        Games_trimE(str, '+');
    }
    printf("- Games_trimE(): %i (ms)", GetTickCount()-time);

    time = GetTickCount();
    for(new i; i < 1000000; i++) {
        new str[] = "+++++++++++++++++++++++++++++++++++++++string++++++++++++++++++++++++++++++++++++++++++";
        Games_trimX(str, '+');
    }
    printf("- Games_trimX(): %i (ms)\n\n", GetTickCount()-time);

    time = GetTickCount();
    for(new i; i < 1000000; i++) {
        new str[] = "+string+";
        Games_trim2(str, '+');
    }
    printf("- Games_trim2(): %i (ms)", GetTickCount()-time);

    time = GetTickCount();
    for(new i; i < 1000000; i++) {
        new str[] = "+string+";
        Games_trimE(str, '+');
    }
    printf("- Games_trimE(): %i (ms)", GetTickCount()-time);

    time = GetTickCount();
    for(new i; i < 1000000; i++) {
        new str[] = "+string+";
        Games_trimX(str, '+');
    }
    printf("- Games_trimX(): %i (ms)\n\n", GetTickCount()-time);
}



Games_trim2(str[], Char = ' ')
{
    new i;
    while(str[i] == Char) i++;
    strdel(str, 0, i);

    if(!i) return 1;

    i = strlen(str) - 1;
    while(str[i] == Char) i--;
    str[i + 1] = '\0';

    return 1;
}


Games_trimE(str[], Char = ' '){
    new i = -1;
    while(str[++i] == Char){}
    strdel(str, 0, i);

    if(!i) return ;

    i = strlen(str);
    while(str[--i] == Char){}
    str[++i] = '\0';

    return ;
} 

Games_trimX(str[], ch = ' '){
    new
		start = -1,
		end = strlen(str)
	;
    while(str[++start] == ch) {}
	while(str[--end] == ch) {}

	strmid(str, str, start, end, ++end);
}
*/
/*
native fwritechar(File: handle, value, bool: utf8 = false) = fputchar;
native freadchar(File: handle, value = 0, bool: utf8 = false) = fgetchar; 

#define TEST_FILE "test_file.bin"

main() {
    new
		File: my_file = fopen(TEST_FILE, io_write)
	;
    if(my_file) {
		new
			dat[] = !"Hello World"
		;
		for(new i; i < sizeof dat; i++) {
			fwritechar(my_file, dat[i] & 0xFF);
			fwritechar(my_file, (dat[i]>>>8)&0xFF);
			fwritechar(my_file, (dat[i]>>>16)&0xFF);
			fwritechar(my_file, (dat[i]>>>24)&0xFF);
//			fwritechar(my_file, dat{i});
		}
		fwrite(my_file, "\n");
		fblockwrite(my_file, dat);
		fwrite(my_file, "\n");
		fwrite(my_file, dat);

        fclose(my_file);

        if((my_file = fopen(TEST_FILE, io_read))) {
            printf("Our stored number was: %d", freadchar(my_file));

            fclose(my_file);
        }
    }    
}
*/
/*
#include <ndialog> // works

public OnPlayerConnect(playerid) {
	return ShowPlayerDialog(playerid, GetPublicDialogID("MyFunc"), DIALOG_STYLE_MSGBOX, "MyFunc", "Testing :P", "Click me", "");
}

Dialog:MyFunc(playerid, response, listitem, inputtext[]) {
	new
		tmp[128]
	;
	format(tmp, sizeof tmp, "MyFunc(%d, %d, %d, \"%s\")", playerid, response, listitem, inputtext);
	SendClientMessage(playerid, -1, tmp);
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	new
		tmp[128]
	;
	format(tmp, sizeof tmp, "OnDialogResponse(%d, %d, %d, %d, \"%s\")", playerid, dialogid, response, listitem, inputtext);
	SendClientMessage(playerid, -1, tmp);
}
*/
/*
#include <zcmd>
#include <colors>
#include <sscanf2>

enum ePInfo { Level }

new PInfo[1][ePInfo];

COMMAND:ban(playerid, params[]) {
    if(PInfo[playerid][Level] > 1 || IsPlayerAdmin(playerid)) {
		new
			targetid,
			string[144]
		;
		if(sscanf(params, "ds[24]", targetid, string)) {
			return SendClientMessage(playerid, 0xFFFF00AA, "Usage /ban [playerid].");
		}
		if(targetid != INVALID_PLAYER_ID) {
			Ban(targetid);
			format(string, sizeof string, "Administrator %s has banned %s[ID:%d]", string, targetid, playerid);
			return SendClientMessageToAll(0xFFC0CBAA, string);
		}
	}
	return false;
}
*/
#if 0 // By Y_Less
	#include <ytime>
#endif
/*
forward unused();public unused() {
	new	tmp[1];
	format(tmp, 0, "");
}

stock SCM4(playerid, color, form[], {Float, _}: ...) {
	#pragma unused form

	static
		tmp[144]
	;
	new
		t1 = playerid,
		t2 = color
	;
	const
		n4 = -4,
		n16 = -16,
		size = sizeof tmp << 2
	;
	#emit stack 28
	#emit push.c size
	#emit push.c tmp
	#emit stack n4
	#emit sysreq.c format
	#emit stack n16

	print(tmp);

	return SendClientMessage(t1, t2, tmp);
}

main() {
	SCM4(0, -1, "%s", "Hello World");
}
*/

/*
forward @i_like_cookies(); @i_like_cookies() {
    format("", 0, "");
	SendRconCommand("");
}
stock SendCommand(cmd[], ...) {
	#pragma unused cmd

	static
        dest[128]
	;
	const
		m8 = -8,
		size = sizeof dest
	;
	// moving the stack pointer down to prevent the invalid memory access warning
	#emit stack m8
	// moving the pointers 8 bytes down
	#emit move.pri
	#emit addr.alt m8
	#emit movs 8
	// correcting the bytes and putting it at the correct place
	#emit load.s.pri 8
	#emit add.c 8
	#emit stor.s.pri 0
	// setting the last two parameter
	#emit const.pri size
	#emit stor.s.pri 8
	#emit const.pri dest
	#emit stor.s.pri 4
	// setting correct stack position
	#emit stack 8
	// calling format
	#emit sysreq.c format
	// fixing pointers
	#emit addr.pri m8
	#emit sctrl 5
	#emit sctrl 4
	// final
	return SendRconCommand(dest);
#if 0
    static
		save[3],
        dest[128]
	;
	const
		movs = sizeof save << 2,
		size = sizeof dest
	;
	// saving the pointers
	#emit addr.pri 0
	#emit const.alt save
	#emit movs movs
	// correcting the bytes and putting it at the correct place
	#emit load.s.pri 8
	#emit add.c 8
	#emit stor.s.pri 0
	// setting the last two parameter
	#emit const.pri size
	#emit stor.s.pri 8
	#emit const.pri dest
	#emit stor.s.pri 4
	// calling format
	#emit sysreq.c format
	// restoring the pointers
	#emit const.pri save
	#emit addr.alt 0
	#emit movs movs
	// final
	return SendRconCommand(dest);
#endif
}

main() {
	SendCommand("hostname %s", "hey hey hey");
}
*/
/*
stock GetHighest(array[], size = sizeof array) {
    new
        highest,
        value = array[0]
    ;
    while(--size > 0) {
        if(value < array[size]) {
            value = array[(highest = size)];
        }
    }
    return highest;
}
*/
/*
#include <VehicleMatrix>

main() {
	GivePlayerMoney(0, 99999999);
}

stock Float: Det3x3({ Float, _ }: mat[][]) {
	return
		(mat[0][0] * mat[1][1] * mat[2][2] + mat[0][1] * mat[1][2] * mat[2][0] + mat[0][2] * mat[1][0] * mat[2][1]) -
		(mat[2][0] * mat[1][1] * mat[0][2] + mat[2][1] * mat[1][2] * mat[0][0] + mat[2][2] * mat[1][0] * mat[0][1])
	;
}

stock OffsetFromVehiclePosition(vehicle, Float: x, Float: y, Float: z, & Float: offX, & Float: offY, & Float: offZ) {
	//initial processing step - gather information
	new
		Float: Mat3x3_1[3][3],
		Float: Mat3x3_2[3][3],
		Float: Mat3x3_3[3][3],
		Mat4x3[MatrixParts][MatrixIndicator]
	;
    GetVehicleMatrix(vehicle, Mat4x3);
	//offset calculation math

	x -= Mat4x3[mp_POS][mi_X];
	y -= Mat4x3[mp_POS][mi_Y];
	z -= Mat4x3[mp_POS][mi_Z];
	
	Mat3x3_1[0][0] = Mat4x3[mp_PITCH][mi_X];
	Mat3x3_1[1][0] = Mat4x3[mp_PITCH][mi_Y];
	Mat3x3_1[2][0] = Mat4x3[mp_PITCH][mi_Z];
	Mat3x3_1[0][1] = Mat4x3[mp_ROLL][mi_X];
	Mat3x3_1[1][1] = Mat4x3[mp_ROLL][mi_Y];
	Mat3x3_1[2][1] = Mat4x3[mp_ROLL][mi_Z];
	Mat3x3_1[0][2] = Mat4x3[mp_YAW][mi_X];
	Mat3x3_1[1][2] = Mat4x3[mp_YAW][mi_Y];
	Mat3x3_1[2][2] = Mat4x3[mp_YAW][mi_Z];

	offZ = Det3x3(Mat3x3_1);

	if(offZ != 0.0) {
		Mat3x3_2 = Mat3x3_1;
		Mat3x3_3 = Mat3x3_1;

		Mat3x3_1[0][0] = Mat3x3_2[0][1] = Mat3x3_3[0][2] = x;
		Mat3x3_1[1][0] = Mat3x3_2[1][1] = Mat3x3_3[1][2] = y;
		Mat3x3_1[2][0] = Mat3x3_2[2][1] = Mat3x3_3[2][2] = z;

		offX = Det3x3(Mat3x3_1) / offZ;
		offY = Det3x3(Mat3x3_2) / offZ;
		offZ = Det3x3(Mat3x3_3) / offZ;
	}

#if 0
	new
		Float: pX = Mat4x3[mp_PITCH][mi_X],
		Float: pY = Mat4x3[mp_PITCH][mi_Y],
		Float: pZ = Mat4x3[mp_PITCH][mi_Z],
		Float: rX = Mat4x3[mp_ROLL][mi_X],
		Float: rY = Mat4x3[mp_ROLL][mi_Y],
		Float: rZ = Mat4x3[mp_ROLL][mi_Z],
		Float: yX = Mat4x3[mp_YAW][mi_X],
		Float: yY = Mat4x3[mp_YAW][mi_Y],
		Float: yZ = Mat4x3[mp_YAW][mi_Z]
	;

	new
		tmp[256]
	;
	format(tmp, sizeof tmp, "%f = %f | %f = %f | %f = %f",
		x, offX * pX + offY * rX + offZ * yX,
		y, offX * pY + offY * rY + offZ * yY,
		z, offX * pZ + offY * rZ + offZ * yZ
	);

	offZ = ((z * pX - pZ * x) * rX - (rZ * pX - pZ * rX) * x) / ((yZ * pX - pZ * yX) * rX - (rZ * pX - pZ * rX) * yX);
	offY = (y * pX - pY * x - offZ * (yY * pX - pY * yX)) / (rY * pX - pY * rX);
	offX = (x - offZ * yX - offY * rX) / pX;
	// recalc z
//	offZ = (z - offX * pZ - offY * rZ) / yZ;

	format(tmp, sizeof tmp, "%s - %f = %f | %f = %f | %f = %f", tmp,
		x, offX * pX + offY * rX + offZ * yX,
		y, offX * pY + offY * rY + offZ * yY,
		z, offX * pZ + offY * rZ + offZ * yZ
	);

	SendClientMessageToAll(-1, tmp);
#endif
#if 0
	offZ = (rX * (z * pX - 2.0 * x * pZ) - rZ * pX * x) / (rX * (yZ * pX - 2.0 * pZ * yX) - rZ * pX * yX);
	offY = (pX * (y - offZ * yY) - pY * (x + offZ * yX)) / (rY * pX - pY * rX);
	offX = (x - offZ * yX - offY * rX) / pX;

	x = offX * pX + offY * rX + offZ * yX;
	y = offX * pY + offY * rY + offZ * yY; | pX * II - pY * I
	z = offX * pZ + offY * rZ + offZ * yZ; | pX * III - pZ * I

	x = pX + rX + yX;
	(y * pX - pY * x) = 0 + (rY * pX - pY * rX) + (yY * pX - pY * yX);
	(z * pX - pZ * x) = 0 + (rZ * pX - pZ * rX) + (yZ * pX - pZ * yX); | rX * III - (rZ * pX - pZ * rX) * I

	x = pX + rX + yX;
	(y * pX - pY * x) = 0 + ((rY * pX) - (pY * rX)) + (yY * pX - pY * yX);
	((z * pX - pZ * x) * rX - (rZ * pX - pZ * rX) * x) = 0 + 0 + ((yZ * pX - pZ * yX) * rX - (rZ * pX - pZ * rX) * yX);
#endif
	return 1;
}


stock GetVehicleRotation2(vehicle, & Float: yaw, & Float: roll, & Float: pitch) {
	//initial processing step - gather information
	new
		Mat4x3[MatrixParts][MatrixIndicator]
	;
    GetVehicleMatrix(vehicle, Mat4x3);
	//offset calculation math
	yaw = atan2(Mat4x3[mp_YAW][mi_X], Mat4x3[mp_YAW][mi_Y]);
	roll = atan2(Mat4x3[mp_ROLL][mi_X], Mat4x3[mp_ROLL][mi_Z]);
	pitch = atan2(Mat4x3[mp_PITCH][mi_Y], Mat4x3[mp_PITCH][mi_Z]);

	return 1;
}

static
	object,
	Float: offset[3]
;

public OnPlayerCommandText(playerid, cmdtext[]) {
	if(strcmp(cmdtext, "/attach", true) == 0) {
		if(object == 0) {
			object = CreateObject(1598, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		}
		new
			vehicleid = GetPlayerVehicleID(playerid)
		;
		if(vehicleid) {
			AttachObjectToVehicle(object, vehicleid, 0.0, 1.0, 1.0, 0.0, 0.0, 0.0);
			offset[0] = 0.0;
			offset[1] = 1.0;
			offset[2] = 1.0;
			return true;
		}
	}
	if(strcmp(cmdtext, "/edit", true) == 0) {
		if(object) {
			new
				vehicleid = GetPlayerVehicleID(playerid)
			;
			if(vehicleid) {
				new
					Float: X = offset[0],
					Float: Y = offset[1],
					Float: Z = offset[2],
					Float: rX,
					Float: rY,
					Float: rZ
				;
				GetObjectRot(object, rX, rY, rZ);

				new tmp[64];
				format(tmp, sizeof tmp, "%f %f %f", X, Y, Z);
				SendClientMessage(playerid, -1, tmp);

				PositionFromVehicleOffset(vehicleid, X, Y, Z, X, Y, Z);

				DestroyObject(object);
				object = CreateObject(1598, X, Y, Z, rX, rY, rZ);
				EditObject(playerid, object);
				return true;
			}
		}
	}
	return false;
}

unload() {
	DestroyObject(object);
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ) {
	if(!playerobject) {
		new
			Float: oX,
			Float: oY,
			Float: oZ,
			Float: oRotX,
			Float: oRotY,
			Float: oRotZ
		;
		GetObjectPos(objectid, oX, oY, oZ);
		GetObjectRot(objectid, oRotX, oRotY, oRotZ);

	    MoveObject(objectid, fX, fY, fZ, 10.0, fRotX, fRotY, fRotZ);

		switch(response) {
			case EDIT_RESPONSE_FINAL: {
				new
					vehicleid = GetPlayerVehicleID(playerid)
				;
				OffsetFromVehiclePosition(vehicleid, fX, fY, fZ, fX, fY, fZ);

				new tmp[64];
				format(tmp, sizeof tmp, "%f %f %f", fX, fY, fZ);
				SendClientMessage(playerid, -1, tmp);

				AttachObjectToVehicle(objectid, vehicleid, fX, fY, fZ, fRotX, fRotY, fRotZ);
				offset[0] = fX;
				offset[1] = fY;
				offset[2] = fZ;
			}
			case EDIT_RESPONSE_CANCEL: {
				SetObjectPos(objectid, oX, oY, oZ);
				SetObjectRot(objectid, oRotX, oRotY, oRotZ);
			}
		}
	}
	return true;
}


stock RotateX(Float: rot, Float: X, & Float: Y, & Float: Z) {
	new
		Float: cos = floatcos(rot, degrees),
		Float: sin = floatsin(rot, degrees)
	;
	X = Y * cos - Z * sin;
	Z = Y * sin + Z * cos;
	Y = X;
}

stock RotateY(Float: rot, & Float: X, Float: Y, & Float: Z) {
	new
		Float: cos = floatcos(rot, degrees),
		Float: sin = floatsin(rot, degrees)
	;
	Y = X * cos - Z * sin;
	Z = Z * cos + X * sin;
	X = Y;
}

stock RotateZ(Float: rot, & Float: X, & Float: Y, Float: Z) {
	new
		Float: cos = floatcos(rot, degrees),
		Float: sin = floatsin(rot, degrees)
	;
	Z = X * cos - Y * sin;
	Y = X * sin + Y * cos;
	X = Z;
}

stock GetVehicleRotation(vehicleid,&Float:heading, &Float:attitude, &Float:bank)
{
    new Float:quat_w,Float:quat_x,Float:quat_y,Float:quat_z;
    GetVehicleRotationQuat(vehicleid,quat_w,quat_x,quat_y,quat_z);
    ConvertNonNormaQuatToEuler(quat_w,quat_x,quat_z,quat_y, heading, attitude, bank);
    return 1;
}

stock ConvertNonNormaQuatToEuler(Float: qw, Float: qx, Float:qy, Float:qz, &Float:heading, &Float:attitude, &Float:bank)
{
    new Float: sqw = qw*qw;
    new Float: sqx = qx*qx;
    new Float: sqy = qy*qy;
    new Float: sqz = qz*qz;
    new Float: unit = sqx + sqy + sqz + sqw; // if normalised is one, otherwise is correction factor
    //???? normalised, - ????, ? ????????? ?????? - ?????????? ?????????
    new Float: test = qx*qy + qz*qw;
    if (test > 0.499*unit)
    { // singularity at north pole - ??????????? ?? ???????? ??????
        heading = 2*atan2(qx,qw);
        attitude = 3.141592653/2;
        bank = 0;
        return 1;
    }
    if (test < -0.499*unit)
    { // singularity at south pole - ??????????? ?? ????? ??????
        heading = -2*atan2(qx,qw);
        attitude = -3.141592653/2;
        bank = 0;
        return 1;
    }
    heading = -atan2(2*qy*qw - 2*qx*qz, sqx - sqy - sqz + sqw);
    attitude = asin(2*test/unit);
    bank = -atan2(2*qx*qw - 2*qy*qz, -sqx + sqy - sqz + sqw);
    return 1;
}

stock GetXYZInFrontOfVehicle(vehicleid, Float: distance, & Float: X, & Float: Y, & Float: Z) {
	if(GetVehiclePos(vehicleid, X, Y, Z)) {
		new
			Float: pitch,
			Float: roll,
			Float: yaw,
			Float: tX,
			Float: tY = distance,
			Float: tZ
		;
		GetVehicleRotation(vehicleid, yaw, roll, pitch);

		RotateX(pitch, tX, tY, tZ);
		RotateY(roll, tX, tY, tZ);
		RotateZ(yaw, tX, tY, tZ);

		X += tX;
		Y += tY;
		Z += tZ;

		return true;
	}
	return false;
}


//stock
//	object[MAX_PLAYERS]
//;

public OnPlayerUpdate(playerid) {
	static
		Float: w,
		Float: x,
		Float: y,
		Float: z,
		Float: pitch,
		Float: roll,
		Float: yaw,
		vehicleid
	;
	if((vehicleid = GetPlayerVehicleID(playerid))) {
		new
			tmp[128]
		;
		GetVehicleRotation(vehicleid, yaw, roll, pitch);

		format(tmp, sizeof tmp, "%f %f %f", yaw, roll, pitch);

		GetVehicleRotation2(vehicleid, yaw, roll, pitch);

		format(tmp, sizeof tmp, "%s - %f %f %f", tmp, yaw, roll, pitch);

		SendClientMessage(playerid, -1, tmp);

//		DestroyPlayerObject(playerid, objectid[playerid]);
//		GetXYZInFrontOfVehicle(vehicleid, 25.0, x, y, z);
//		objectid[playerid] = CreatePlayerObject(playerid, 2114, x, y, z, 0.0, 0.0, 0.0);
	}
	return true;
}
*/
/*
unload() {
	for(new i; i != MAX_PLAYERS; ++i) {
		DestroyPlayerObject(i, objectid[i]);
	}
}*/
/*
main() {
	new
		Float: rmat[2][2],
		Float: vmat[2][2],
		Float: emat[2][2],
		Float: angle = 45.0
	;
	rmat[0][0] =  (rmat[1][1] = floatcos(angle, degrees));
	rmat[0][1] = -(rmat[1][0] = floatsin(angle, degrees));

	vmat[0][0] =  (vmat[1][1] = floatcos(angle, degrees));
	vmat[0][1] = -(vmat[1][0] = floatsin(angle, degrees));

//	vmat[0][0] = 1.0;
//	vmat[1][0] = 0.0;

	MatrixMultiply(emat, rmat, vmat);

	printf("%f %f %f %f", emat[0][0], emat[0][1], emat[1][0], emat[1][1]);

	rmat[0][0] =  (rmat[1][1] = floatcos(2 * angle, degrees));
	rmat[0][1] = -(rmat[1][0] = floatsin(2 * angle, degrees));

	printf("%f %f %f %f", rmat[0][0], rmat[0][1], rmat[1][0], rmat[1][1]);
}

stock Float: MatrixMultiply(Float: matRet[][], Float: mat1[][], Float: mat2[][], s1 = sizeof mat1, s2 = sizeof mat2[], s3 = sizeof mat1[]) {
	for(new i, j; --s1 > -1; ) {
		for(i = s2; --i > -1; ) {
			for(j = s3; --j > -1; ) {
				matRet[s1][i] += mat1[s1][j] * mat2[j][i];
			}
		}
	}
}
*/
/*
#define MAX_LOOPS 10

enum Pam
{
    pamo[256],
    firstpam[256]
}

#define GetSize(%0,%1) %0 + %0 * %1

#define idx(%0,%1,%2) (%2 + (%0 * %0:%1))

enum Times
{
    lMinute,
    lHour,
    sName[30],
    paranum,
    sParameter[idx(Pam, 50, Pam: 0)]
}
new Loop[MAX_LOOPS][Times];


main() {
    strcat(Loop[0][sParameter][idx(Pam, 25, pamo)], "Hello World", 256);
    strcat(Loop[0][sParameter][idx(Pam, 20, pamo)], "Hello World 2", 256);

	printf(Loop[0][sParameter][idx(Pam, 20, pamo)]);
	printf(Loop[0][sParameter][idx(Pam, 25, pamo)][4]);

	HackArray2("MyFunc2", Loop[0][sParameter]);

//	printf(Loop[0][sParameter][Pam]);
}

forward MyFunc2(array1d[], array2d[][Pam]);
public MyFunc2(array1d[], array2d[][Pam]) {
	strcat(array2d[25][pamo], "Hello World", 256);
}
*/
/*
public OnPlayerUpdate(playerid) {
	new
		tmp[32],
		count = gettime() % 1440
	;
	format(tmp, sizeof tmp, "%d %d", count / 60, count % 60);
	return SendClientMessage(playerid, -1, tmp);
}

stock
	gArray[][][] = {
		{5, "Hello World", 6},
		{7, "Bye Bye", 8}
	},
	eArray[14]
;

stock Swap(...) {
	#emit lref.s.pri 12
	#emit lref.s.alt 16
	#emit sref.s.alt 12
	#emit sref.s.pri 16
}

#define function%0(%1) forward%0(%1);%0(%1)

main() {
	TogglePlayerClock(0, true);

	new
		count = gettime() % 1440
	;
	SetPlayerTime(0, count / 60, count % 60);

	HackArray2("InitArray", eArray, 2, 2, 2);
	HackArray2("MyFunc", eArray);

	HackArray2("SwapIdx", gArray[0], 0, 5);

	printf("%d \"%s\" %d", gArray[0][0], gArray[0][1], gArray[0][2]);
	printf("%d \"%s\" %d", gArray[1][0], gArray[1][1], gArray[1][2]);
}

function public MyFunc(array2d[][], array3d[][][]) {
	array3d[0][0][0] = 0;
	array3d[0][0][1] = 1;
	array3d[0][1][0] = 2;
	array3d[0][1][1] = 3;

	array3d[1][0][0] = 4;
	array3d[1][0][1] = 5;
	array3d[1][1][0] = 6;
	array3d[1][1][1] = 7;

	printf("%d %d %d %d %d %d %d %d",
		array3d[0][0][0],
		array3d[0][0][1],
		array3d[0][1][0],
		array3d[0][1][1],

		array3d[1][0][0],
		array3d[1][0][1],
		array3d[1][1][0],
		array3d[1][1][1]
	);
}

function public InitArray(array1d[], array2[][], & size1, & size2, & size3) {
	switch(numargs()) {
		case 3: {
			return size1;
		}
		case 4: {
			new
				idx = 0,
				offset = size1 << 2,
				add = (size2 - 1) << 2
			;
			while(idx < size1) {
				array1d[idx++] = offset;
				offset += add;
			}
			return size1 * (size2 + 1);
		}
		case 5: {
			new
				idx = 0,
				end = size1,
				offset = end << 2,
				add = (size2 - 1) << 2
			;
			while(idx < end) {
				array1d[idx++] = offset;

				offset += add;
			}
			offset = (end * size2) << 2;
			add = (size3 - 1) << 2;
			end *= (size2 + 1);

			while(idx < end) {
				array1d[idx++] = offset;

				offset += add;
			}
			return size1 * (size2 * (size3 + 1) + 1);
		}
	}
	return -1;
}

function public SwapIdx(array1d[], array2d[][], & idx1, & idx2) {
	new
		offset = (idx2 - idx1) << 2
	;
	Swap(array1d[idx1], array1d[idx2]);

	array1d[idx1] += offset;
	array1d[idx2] -= offset;	
}

stock HackArray(func[], { Float, _ }: ...) {
	new
		addr
	;
	#emit load.s.pri 16
	#emit stor.s.pri addr

	return CallLocalFunction(func, "iiii", addr, addr, addr, addr);
}

stock HackArray2(func[], { Float, _ }: ...) {
	new
		idx = funcidx(func)
	;
	if(idx != -1) {
		// Getting public offset
		#emit lctrl 1 // dat
		#emit neg
		#emit move.alt
		#emit add.c 32 // public
		#emit stor.s.pri 12
		#emit lref.s.pri 12
		#emit add
		// Adding idx
		#emit load.s.alt idx
		#emit shl.c.alt 3
		#emit add
		#emit stor.s.pri idx
		// Overwritting func
		#emit load.s.alt 16
		#emit stor.s.alt 12
		// Resetting stack
		#emit stack 4
		// Calling func
		#emit lref.s.pri idx
		#emit add.c 4
		#emit sctrl 6
	}
}
*/
/*
public OnGameModeInit() {
	AddPlayerClass(0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
}

new
	LoggedIn[MAX_PLAYERS]
;

public OnPlayerConnect(playerid) {
	SendClientMessage(playerid, -1, "OnPlayerConnect");

	LoggedIn[playerid] = false;

	return true;
}

public OnPlayerRequestClass(playerid, classid) {
	SendClientMessage(playerid, -1, "OnPlayerRequestClass");

	if(LoggedIn[playerid]) {
		return SpawnPlayer(playerid);
//		return SetTimerEx("tSpawnPlayer", 0, false, "i", playerid);
	}
	return true;
}

forward public tSpawnPlayer(playerid);
public tSpawnPlayer(playerid) return SpawnPlayer(playerid);

public OnPlayerSpawn(playerid) {
	SendClientMessage(playerid, -1, "OnPlayerSpawn");

	LoggedIn[playerid] = true;

	ForceClassSelection(playerid);

	return true;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
	if(strcmp(cmdtext, "/kill", false) == 0) return SetPlayerHealth(playerid, 0.0); 

	return false;
}
*/

/*
stock HackArray(array[]) {
	static
		tArray[1][1][1]
	;
	iHackArray(array, tArray[0], tArray);
}

stock iHackArray(array1d[], array2d[][], array3d[][][]) {
	#emit load.s.pri 12
	#emit stor.s.pri 16
	#emit stor.s.pri 20
}
*/

/*
#include <gpcwv>
#include <gpcwv_old> // faster
#include <nTest>

nTest(3x1000000) {
	new
		Float: vX,
		Float: vY,
		Float: vZ
	;
	Test("New") {
		new
			Float: angle = -(atan2(vX, vY) + 0.026706)
		;
		vX += floatcos(angle, degrees) * 0.019815;
		vY += floatsin(angle, degrees) * 0.019815;
		vZ += 0.047126;
	}
	Test("Old") {
		AdjustVector(vX, vY, vZ, 0.016204, 0.009899, 0.047177);
	}
}
*/
/*
main() {
    OnPlayerCommandText(0, "/asd");
}

#define ABC:%1(%2) ABCW(xyz_,%1,%2)
#define ABCW(%1,%2,%3) \
    forward %1%2(%3); \
    public %1%2(%3)

#define LOL         2

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(newkeys & KEY_YES) {
		SetSpawnInfo(playerid, NO_TEAM, 0, 0.0, 0.0, 5.0, 0.0, 0, 0, 0, 0, 0, 0);
		TogglePlayerSpectating(playerid, false);
	}

	new
		tmp[128]
	;
	format(tmp, sizeof tmp, "OnPlayerKeyStateChange(%d, %d, %d)", playerid, newkeys, oldkeys);
	return SendClientMessage(playerid, -1, tmp);
}

public OnPlayerConnect(playerid) {
	TogglePlayerSpectating(playerid, true);
	return true;
}

public OnPlayerUpdate(playerid) {
	new
		keys,
		updown,
		leftright
	;
	if(GetPlayerKeys(playerid, keys, updown, leftright) && (keys || updown || leftright)) {
		new
			tmp[128]
		;
		format(tmp, sizeof tmp, "GetPlayerKeys(%d, %d, %d, %d)", playerid, keys, updown, leftright);
		SendClientMessage(playerid, -1, tmp);
	}
	return true;
}

public OnPlayerCommandText(playerid,cmdtext[])
{
    if(!strcmp(cmdtext,"/asd",true))
    {
        print("xyz_" #LOL);
        CallLocalFunction("xyz_" #LOL, "i", 345);
        return 1;
    }
	if(!strcmp(cmdtext, "/kill", true)) return SetPlayerHealth(playerid, 0.0);
    return 0;
}

ABC:LOL(playerid)
{
    printf("Called: %d",playerid);
    return 1;
}
*/
/*
public OnPlayerUpdate(playerid) {
	new
		vehicleid = GetPlayerVehicleID(playerid)
	;
	if(vehicleid) {
		new
			tmp[64],
			Float: w,
			Float: x,
			Float: y,
			Float: z
		;
		GetVehicleRotationQuat(vehicleid, w, x, y, z);
		format(tmp, sizeof tmp, "%f %f %f %f", w, x, y, z);
		SendClientMessage(playerid, -1, tmp);
		SetPlayerHealth(playerid, 100.0);
	}
	return true;
}
*/
/*
enum eRanks {
    RankXP,
    RankName[32]
}

new const RankList[][eRanks] = {
    {0, "Newbie"},
    {10, "Starter"},
    {100, "Advanced"}
};

enum ePlayerRank {
    pRankNumber,
    pRankXP
}
new PlayerRank[MAX_PLAYERS][ePlayerRank];



main() {
	printf("%d", GetRank(-1));
	printf("%d", GetRank(0));
	printf("%d", GetRank(5));
	printf("%d", GetRank(10));
	printf("%d", GetRank(50));
	printf("%d", GetRank(100));
	printf("%d", GetRank(500));
	printf("%d", GetRank(50, 0));
	printf("%d", GetRank(50, 1));
	printf("%d", GetRank(500, 1));
	printf("%d", GetRank(500, 2));
	printf("%d", GetRank(500, 50));
	printf("%d", GetRank(50, 2));

	SetPlayerExp(0, random(RankList[sizeof RankList - 1][RankXP] * 2));

	printf("%d", GetPlayerRank(0));

	printf("Rank No. = %d, Rank Exp. = %d, Rank Name = %s", GetPlayerRank(0), GetPlayerExp(0), GetPlayerRankName(0));
}

GetRank(exp, rank = 0) {
	if(exp < RankList[0][RankXP]) {
		return 0;
	}
	if(!(0 <= rank < sizeof RankList) || (exp < RankList[rank][RankXP])) {
		rank = 0;
	}
    while((rank < sizeof RankList) && (RankList[rank][RankXP] <= exp)) rank++;

    return rank - 1;
}

GetPlayerRank(playerid) return PlayerRank[playerid][pRankNumber];
GetPlayerExp(playerid) return PlayerRank[playerid][pRankXP];
GivePlayerExp(playerid, exp) return (PlayerRank[playerid][pRankNumber] = GetRank((PlayerRank[playerid][pRankXP] += exp), PlayerRank[playerid][pRankNumber]));
SetPlayerExp(playerid, exp) return (PlayerRank[playerid][pRankNumber] = GetRank((PlayerRank[playerid][pRankXP] = exp)));

GetPlayerRankName(playerid) {
	GetPlayerRank(playerid);

	#emit const.alt RankList
	#emit idxaddr
	#emit move.alt
	#emit load.i
	#emit add
	#emit add.c 4
	#emit stor.s.pri 16
	#emit retn
	// That code below also works, /\ that is just faster
	new
		tmp[32]
	;
	strcat(tmp, RankList[GetPlayerRank(playerid)][RankName]);
	return tmp;
}
*/
/*
#include <screentoworld>

new
	Text: gText
;

main() {
	new
		Float: x,
		Float: y,
		Float: z
	;
	ScreenToWorld(0, 100.0, 100.0, x, y, z);
	WorldToScreen(0, 1.0, 2.0, 3.0, x, y);

	for(new i, tmp[8] = "~r~"; i != 480; ++i) {
		valstr(tmp[3], i, false);

		gText = TextDrawCreate((i * 31) % 620 + 20, i, tmp);
		TextDrawLetterSize(gText, 0.20, 0.70);
		TextDrawAlignment(gText, 2);
		TextDrawSetOutline(gText, 1);
		TextDrawFont(gText, 1);

		TextDrawShowForAll(gText);
	}
}

unload() {
	for(new i; i != 480; ++i) {
		TextDrawDestroy(gText - Text: i);
	}
}

public OnPlayerConnect(playerid) {
	for(new i; i != 480; ++i) {
		TextDrawShowForPlayer(playerid, gText - Text: i);
	}
}
*/
/*
enum eUser { USER_EXP, USER_RANK }

stock User[MAX_PLAYERS][eUser];

static const
	cExpData[] = {
		0,
		500,
		1000,
		2000,
		3500,
		4000,
		5000,
		5500,
		7000,
		8500,
		10000,

		10500,
		11000,
		12000,
		13500,
		14000,
		15000,
		15500,
		17000,
		18500,
		20000,

		20500,
		21000,
		22000,
		23500,
		24000,
		25000,
		25500,
		27000,
		28500,
		30000,

		30500,
		31000,
		32000,
		33500,
		34000,
		35000,
		35500,
		37000,
		38500,
		40000,

		40500,
		41000,
		42000,
		43500,
		44000,
		45000,
		45500,
		47000,
		48500,
		50000,

		50500,
		51000,
		52000,
		53500,
		54000,
		55000,
		55500,
		57000,
		58500,
		60000
	};

rankcheck1(exp, & rank) { // don't use this if you didn't understood what I said above
    if(0 <= rank < (sizeof cExpData - 1)) {
		while(exp >= cExpData[rank + 1]) {
			if(++rank == sizeof cExpData) {
				break;
			}
		}
    }
	return rank;
}

rankcheck2(exp, & rank) { // switch ftw
	switch(exp) {
		case 0: return rank = 0;
		case 500: return rank = 1;
		case 1000: return rank = 2;
		case 2000: return rank = 3;
		case 3500: return rank = 4;
		case 4000: return rank = 5;
		case 5000: return rank = 6;
		case 5500: return rank = 7;
		case 7000: return rank = 8;
		case 8500: return rank = 9;
		case 10000: return rank = 10;

		case 10500: return rank = 11;
		case 11000: return rank = 12;
		case 12000: return rank = 13;
		case 13500: return rank = 14;
		case 14000: return rank = 15;
		case 15000: return rank = 16;
		case 15500: return rank = 17;
		case 17000: return rank = 18;
		case 18500: return rank = 19;
		case 20000: return rank = 20;

		case 20500: return rank = 21;
		case 21000: return rank = 22;
		case 22000: return rank = 23;
		case 23500: return rank = 24;
		case 24000: return rank = 25;
		case 25000: return rank = 26;
		case 25500: return rank = 27;
		case 27000: return rank = 28;
		case 28500: return rank = 29;
		case 30000: return rank = 30;

		case 30500: return rank = 31;
		case 31000: return rank = 32;
		case 32000: return rank = 33;
		case 33500: return rank = 34;
		case 34000: return rank = 35;
		case 35000: return rank = 36;
		case 35500: return rank = 37;
		case 37000: return rank = 38;
		case 38500: return rank = 39;
		case 40000: return rank = 40;

		case 40500: return rank = 41;
		case 41000: return rank = 42;
		case 42000: return rank = 43;
		case 43500: return rank = 44;
		case 44000: return rank = 45;
		case 45000: return rank = 46;
		case 45500: return rank = 47;
		case 47000: return rank = 48;
		case 48500: return rank = 49;
		case 50000: return rank = 50;

		case 50500: return rank = 51;
		case 51000: return rank = 52;
		case 52000: return rank = 53;
		case 53500: return rank = 54;
		case 54000: return rank = 55;
		case 55000: return rank = 56;
		case 55500: return rank = 57;
		case 57000: return rank = 58;
		case 58500: return rank = 59;
		case 60000: return rank = 60;
	}
	return 0;
}

#include <nTest>

nTest(3x10000000) {
	new
		rank = random(sizeof cExpData)
	;
	User[0][USER_RANK] = 0;
	User[0][USER_EXP] = cExpData[rank];

//	printf("%d %d", rank, cExpData[rank]);

	Test("rankcheck1 - search") {
		rank = rankcheck1(User[0][USER_EXP], User[0][USER_RANK]);
//		printf("%d %d", rank, cExpData[rank]);
	}
	Test("rankcheck2 - search") {
		rank = rankcheck2(User[0][USER_EXP], User[0][USER_RANK]);
//		printf("%d %d", rank, cExpData[rank]);
	}
	rank = random(sizeof cExpData);

	User[0][USER_RANK] = rank - 1;
	User[0][USER_EXP] = cExpData[rank];

//	printf("%d %d", rank - 1, cExpData[rank]);

	Test("rankcheck1 - next") {
		rank = rankcheck1(User[0][USER_EXP], User[0][USER_RANK]);
//		printf("%d %d", rank, cExpData[rank]);
	}
	Test("rankcheck2 - next") {
		rank = rankcheck2(User[0][USER_EXP], User[0][USER_RANK]);
//		printf("%d %d", rank, cExpData[rank]);
	}

}
*/
/*
stock FilterColourTags1( sz_Text[ ] )
{
    new
        iStart,
        iEnd,
        bool: using_colour
    ;
    do
    {
        iStart = strfind( sz_Text, "{" );
        iEnd = strfind( sz_Text, "}" );
        using_colour = true;
       
        if( iStart != -1 && iEnd != -1 && iEnd - iStart == 7 )
        {
            for( new i = iStart + 1; i != iEnd; i++ )
            {
                switch( sz_Text[ i ] )
                {
                    case 'A' .. 'Z', 'a' .. 'z', '0' .. '9': continue;
                    default:
                    {
                        using_colour = false;
                        break;
                    }
                }
            }
            if( using_colour ) strdel( sz_Text, iStart, iEnd + 1 );
        }
        else using_colour = false;
    }
    while( using_colour );
}

stock FilterColourTags2( sz_Text[ ] )
{
    new
        iStart,
        iEnd,
        bool: using_colour
    ;
    do
    {
        iStart = strfind( sz_Text, "{" );
        iEnd = strfind( sz_Text, "}" );
        using_colour = true;

        if( iStart != -1 && iEnd != -1 && iEnd - iStart == 7 )
        {
            for( new i = iStart + 1; i != iEnd; ++i )
            {
                switch( sz_Text[ i ] )
                {
                    case 'A' .. 'Z', 'a' .. 'z', '0' .. '9': continue;
                    default:
                    {
                        using_colour = false;
                        break;
                    }
                }
            }
            if( using_colour ) strdel( sz_Text, iStart, iEnd + 1 );
        }
        else using_colour = false;
    }
    while( using_colour );
}

stock FilterColourTags3(str[]) {
	new
		start = strfind(str, "{", true, 0),
		end = strfind(str, "}", true, start + 1),
		c
	;
	while((end - start) == 7) {
		while((++start < end) && (('A' <= (c = str[start]) <= 'F') || ('a' <= c <= 'f') || ('0' <= c <= '9'))) {}

		if(start == end) strdel(str, end - 7, end + 1);

		start = strfind(str, "{", true, 0);
		end = strfind(str, "}", true, start + 1);
    }
}

stock FilterColourTags4(str[]) {
	new
		start = strfind(str, "{", true, 0),
		end = strfind(str, "}", true, start + 1)
	;
	while((end - start) == 7) {
		while(++start < end) {
			switch(str[start]) {
				case 'A' .. 'F', 'a' .. 'f', '0' .. '9': continue;
				default: break;
			}
		}
		if(start == end) strdel(str, end - 7, end + 1);

		start = strfind(str, "{", true, 0);
		end = strfind(str, "}", true, start + 1);
    }
}

stock FilterColourTags42(str[]) {
	new
		start,
		end = strfind(str, "}", true, (start = strfind(str, "{", true, 0)) + 1)
	;
	while((end - start) == 7) {
		while(++start < end) {
			switch(str[start]) {
				case 'A' .. 'F', 'a' .. 'f', '0' .. '9': continue;
				default: break;
			}
		}
		if(start == end) strdel(str, end - 7, end + 1);

		end = strfind(str, "}", true, (start = strfind(str, "{", true, 0)) + 1);
    }
}

stock FilterColourTags43(str[]) {
	new
		start,
		end = strfind(str, "}", false, (start = strfind(str, "{", false, 0)) + 1)
	;
	while((end - start) == 7) {
		while(++start < end) {
			switch(str[start]) {
				case 'A' .. 'F', 'a' .. 'f', '0' .. '9': continue;
				default: break;
			}
		}
		if(start == end) strdel(str, end - 7, end + 1);

		end = strfind(str, "}", false, (start = strfind(str, "{", false, 0)) + 1);
    }
}

stock FilterColourTags432(str[]) { // winner
	new
		start,
		end
	;
	while(((end = strfind(str, "}", false, (start = strfind(str, "{", false, 0)) + 1)) - start) == 7) {
		while(++start < end) {
			switch(str[start]) {
				case 'A' .. 'F', 'a' .. 'f', '0' .. '9': continue;
				default: break;
			}
		}
		if(start == end) strdel(str, end - 7, end + 1);
    }
}

stock FilterColourTags44(str[]) {
	new
		start,
		end = strfind(str, "}", false, (start = strfind(str, "{", false, 0)) + 1)
	;
	while((end - start) == 7) {
		while(++start < end) {
			switch(str[start]) {
				case 'A' .. 'F', 'a' .. 'f', '0' .. '9': continue;
			}
		}
		if(start == end) strdel(str, end - 7, end + 1);

		end = strfind(str, "}", false, (start = strfind(str, "{", false, 0)) + 1);
    }
}

stock FilterColourTags45(str[]) {
	new
		start,
		end = strfind(str, "}", false, (start = strfind(str, "{", false, 0)) + 1)
	;
	while((end - start) == 7) {
		for( ; ; ) {
			if(++start >= end) {
				strdel(str, end - 7, end + 1);
			} else {
				switch(str[start]) {
					case 'A' .. 'F', 'a' .. 'f', '0' .. '9': continue;
				}
			}
			end = strfind(str, "}", false, (start = strfind(str, "{", false, 0)) + 1);
			break;
		}
    }
}

stock FilterColourTags46(str[]) {
	new
		start,
		end
	;
	while(((end = strfind(str, "}", false, (start = strfind(str, "{", false, 0)) + 1)) - start) == 7) {
		for( ; ; ) {
			if(++start >= end) {
				strdel(str, end - 7, end + 1);
				break;
			}
			switch(str[start]) {
				case 'A' .. 'F', 'a' .. 'f', '0' .. '9': continue;
			}
			break;
		}
    }
}

stock FilterColourTags462(str[]) {
	new
		start,
		end
	;
	while(((end = strfind(str, "}", false, (start = strfind(str, "{", false, 0)) + 1)) - start) == 7) {
		for( ; ; ) {
			if(++start >= end) {
				strdel(str, end - 7, end + 1);
				break;
			}
			switch(str[start]) {
				case 'A' .. 'F', 'a' .. 'f', '0' .. '9': continue;
				default: break;
			}
		}
    }
}

stock FilterColourTags47(str[]) {
	new
		start,
		end
	;
	while(((end = strfind(str, "}", false, (start = strfind(str, "{", false, 0)) + 1)) - start) == 7) {
		for( ; ; ) {
			if(++start < end) {
				switch(str[start]) {
					case 'A' .. 'F', 'a' .. 'f', '0' .. '9': continue;
					default: break;
				}
			}
			strdel(str, end - 7, end + 1);
			break;
		}
    }
}


stock FilterColourTags5(str[]) {
	new
		start = strfind(str, "{"),
		end = strfind(str, "}")
	;
	while((end - start) == 7) {
		while(++start < end) {
			switch(str[start]) {
				case 'A' .. 'F', 'a' .. 'f', '0' .. '9': continue;
				default: break;
			}
		}
		if(start == end) strdel(str, end - 7, end + 1);

		start = strfind(str, "{");
		end = strfind(str, "}");
    }
}

stock FilterColourTags52(str[]) {
	new
		start = strfind(str, "{", true),
		end = strfind(str, "}", true)
	;
	while((end - start) == 7) {
		while(++start < end) {
			switch(str[start]) {
				case 'A' .. 'F', 'a' .. 'f', '0' .. '9': continue;
				default: break;
			}
		}
		if(start == end) strdel(str, end - 7, end + 1);

		start = strfind(str, "{", true);
		end = strfind(str, "}", true);
    }
}

#include <nTest>

nTest(3x10000000) {
	new
		ctext[] = "{ffffff}H{fefefe}E{111111}LLO{121212} guy{152152}s",
		stext[sizeof ctext]
	;
	Test("FilterColourTags1") {
		FilterColourTags1((stext = ctext, stext));
//		print(stext);
	}
	Test("FilterColourTags2") {
		FilterColourTags2((stext = ctext, stext));
//		print(stext);
	}
//	Test("FilterColourTags3") {
//		FilterColourTags3((stext = ctext, stext));
//		print(stext);
//	}
//	Test("FilterColourTags4") {
//		FilterColourTags4((stext = ctext, stext));
//		print(stext);
//	}
//	Test("FilterColourTags42") {
//		FilterColourTags42((stext = ctext, stext));
//		print(stext);
//	}
	Test("FilterColourTags43") {
		FilterColourTags43((stext = ctext, stext));
//		print(stext);
	}
	Test("FilterColourTags432") {
		FilterColourTags432((stext = ctext, stext));
//		print(stext);
	}
	Test("FilterColourTags44") {
		FilterColourTags44((stext = ctext, stext));
//		print(stext);
	}
	Test("FilterColourTags45") {
		FilterColourTags45((stext = ctext, stext));
//		print(stext);
	}
	Test("FilterColourTags46") {
		FilterColourTags46((stext = ctext, stext));
//		print(stext);
	}
	Test("FilterColourTags462") {
		FilterColourTags462((stext = ctext, stext));
//		print(stext);
	}
	Test("FilterColourTags47") {
		FilterColourTags47((stext = ctext, stext));
//		print(stext);
	}
	Test("FilterColourTags5") {
		FilterColourTags5((stext = ctext, stext));
//		print(stext);
	}
//	Test("FilterColourTags52") {
//		FilterColourTags52((stext = ctext, stext));
//		print(stext);
//	}
}
*/
/*
stock GetServerUTC() {
    static
        utc_offset = cellmax
    ;
    if(utc_offset == cellmax) {
        new
            thour,
            tminute,
            tyear,
            tmonth,
            tday
        ;
        gettime(thour, tminute, utc_offset);
        getdate(tyear, tmonth, tday);

        utc_offset += (unix(utc_offset, tminute, thour, tday, tmonth, tyear) - gettime()) / (60 * 60);
    }
    return utc_offset;
}

stock unix(second, minute, hour, day, month, year) { // wiki
    static const
        days[] = {0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334}
    ;
    new
        leapyear = (((year - 1969) / 4) - ((year - 1901) / 100) + ((year - 1601) / 400))
    ;
    if ( (month > 2) && (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ) {
        second += 60 * 60 * 24;
    }
    return second
        + (minute * 60)
        + ((hour - GetServerUTC()) * (60 * 60))
        + ((days[month - 1] + day - 1 + ((year - 1970) * 365) + leapyear) * (60 * 60 * 24))
    ;
}

stock unix_reverse(unix, & second, & minute, & hour, & day, & month, & year) { // rework something wrong at the end of days / or months
    year = (unix / (60 * 60 * 24 * 365)) + 1970;
    day = ((year - 1970) * 365) + ((year - 1969) / 4) - ((year - 1901) / 100) + ((year - 1601) / 400);

    if(unix < (day * (60 * 60 * 24))) {
        day = ((--year - 1970) * 365) + ((year - 1969) / 4) - ((year - 1901) / 100) + ((year - 1601) / 400);
    }
    unix -= day * (60 * 60 * 24);

    new
        days[13]
    ;
    if(((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
        days = {0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366};
    } else {
        days = {0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
    }
    day = unix / (60 * 60 * 24);
    month = (day / 28) + 1;

    while(day < days[month - 1]) {
        month--;
    }
    day = (unix -= (days[month - 1] * 60 * 60 * 24)) / (60 * 60 * 24);
    unix -= day * 60 * 60 * 24;
    hour = unix / (60 * 60);
    unix -= hour * 60 * 60;
    minute = unix / 60;
    unix -= minute * 60;
    second = unix;
	day++;

    hour += GetServerUTC();
}

Init() {
	new
		hour,
		minute,
		second,
		year,
		month,
		day,
		time = gettime()
	;
	gettime(hour, minute, second);
	getdate(year, month, day);

	printf("%d %d %d %d %d %d", second, minute, hour, day, month, year);

	printf("%d %d %d %d",
		time,
//		mktime(hour - 1, minute, second, day - 1, month, year),
//		mktimeO(hour - 1, minute, second, day - 1, month, year),
		unix(second, minute, hour, day, month, year)
	);
	unix_reverse(time, second, minute, hour, day, month, year);

	printf("%d %d %d %d %d %d", second, minute, hour, day, month, year);
}
*/
/*
stock IsVehicleDrivingBackwards(vehicleid)
{
    new Float:Float[3];
    if(GetVehicleVelocity(vehicleid, Float[1], Float[2], Float[0])) {
        GetVehicleZAngle(vehicleid, Float[0]);
        if(Float[0] < 90) {
            if(Float[1] > 0 && Float[2] < 0)    return true;
        } else if(Float[0] < 180) {
            if(Float[1] > 0 && Float[2] > 0)    return true;
        } else if(Float[0] < 270) {
            if(Float[1] < 0 && Float[2] > 0)    return true;
        } else if(Float[1] < 0 && Float[2] < 0) return true;
    }
    return false;
}

//	Forward:
//	   Left 360 - x
//	  Right 0 + x
//	Backward
//	   Left 180 - x
//	  Right 180 + x

stock Float: GetVehicleDriftVector(vehicleid) {
    new
		Float: X,
		Float: Y,
		Float: Z
	;
    if(GetVehicleVelocity(vehicleid, X, Y, Z)) {
        GetVehicleZAngle(vehicleid, Z);

		if((X = -atan2(X, Y)) != 0.0) {
			if(180.0 < Z) {
				Z -= 360.0;
			}
			if(Z < X) {
				Z += 360.0;
			}
			return Z - X;		
		}
    }
    return 0.0;
}

stock nIsVehicleDrivingBackwards(vehicleid) {
	return (90.0 < GetVehicleDriftVector(vehicleid) < 270.0);
}


public OnPlayerUpdate(playerid) {
	if(IsPlayerInAnyVehicle(playerid)) {
		new
			tmp[32],
			vehicleid = GetPlayerVehicleID(playerid)
		;
		format(tmp, sizeof tmp, "Backwards %d - %d - %f", IsVehicleDrivingBackwards(vehicleid), nIsVehicleDrivingBackwards(vehicleid), GetVehicleDriftVector(vehicleid));
		SendClientMessage(playerid, -1, tmp);
	}
	return true;
}

#include <YSI\YSI\y_amx>
#include <nlanguage>

AddTextPointer() {
	gt_Welcome,
	gt_Selection
};

AddLanguage(English) {
	"Welcome to my server!",
	"Choose your gender"
};

AddLanguage(French) {
	"Bienvenue sur mon serveur!",
	"Choisissez votre sexe"
};

AddLanguage(German) {
	"Willkommen auf meinem Server!",
	"Wähle dein Geschlecht"
};

public const MyVar1 = 1;
stock MyVar2 = 2;
public const MyVar3 = 3;
stock MyVar4 = 4;


main() {
	SetPlayerLanguage(0, English);

	print(GetLanguageText(0, gt_Welcome));
	
	SetPlayerLanguage(0, French);

	print(GetLanguageText(0, gt_Welcome));
	
	SetPlayerLanguage(0, German);

	print(GetLanguageText(0, gt_Welcome));

//	for(new i; i != sizeof gl_Data; ++i) {
//		printf("%d - %c", i, gl_Data[i]);
//	}

//	MyVar1 = 1;
//	MyVar2 = 2;
//	MyVar3 = 3;
//	MyVar4 = 4;

	printf("%d %d %d %d", ref(MyVar1), ref(MyVar2), ref(MyVar3), ref(MyVar4));

	static
		base,
		pubvar,
		tags
	;
	if(base == 0) {
		#emit lctrl 1
		#emit neg
		#emit stor.pri base
		#emit add.c 44
		#emit stor.pri pubvar
		#emit lref.alt pubvar
		#emit stor.alt pubvar
		#emit add.c 4
		#emit stor.pri tags
		#emit lref.alt tags
		#emit stor.alt tags

		pubvar += base;
		tags += base;
	}
	new
		addr,
		cell,
		tmp[32],
		i = pubvar,
		find[] = !"aVyM"
	;
	while(i < tags) {
		#emit load.s.pri i
		#emit add.c 4
		#emit stor.s.pri addr
		#emit lref.s.pri addr
		#emit load.alt base
		#emit add
		#emit stor.s.pri addr
		#emit lref.s.pri addr
		#emit stor.s.pri cell

		if(find[0] == cell) {
			#emit lref.s.pri i
			#emit stor.s.pri cell

			AMX_ReadString(addr, tmp);
			strunpack(tmp, tmp);

			printf("%d - \"%s\"", cell, tmp);
		}
		i += 8;
	}

}

stock ref(...) {
	#emit load.s.pri 12
	#emit retn

	return 0;
}
*/
/*
forward MyFunc(var, var2);
public MyFunc(var, var2) printf("%d %d", var, var2);

main() {
	static const
		base,
		offset
	;
	if(offset == 0) {
		#emit lctrl 1 // dat
		#emit neg
		#emit move.alt
		#emit stor.alt base
		#emit add.c 32 // public
		#emit stor.pri offset
		#emit lref.pri offset
		#emit add
		#emit stor.pri offset
	}
	new
		idx = funcidx("MyFunc")
	;
	if(idx != -1) {
		CallLocalFunctionByIdx2(idx, 0, idx, 5);

		new
			tmp[32],
			stext[] = "Hello World",
			addr = idx * 8 + offset + 4
		;
		#emit lref.s.pri addr
		#emit stor.s.pri addr

		addr += base;

		strcat("", "");
		strunpack("", "");

		#emit push.c 32
		#emit push.adr stext
		#emit push.adr tmp
		#emit push.c 12
		#emit sysreq.c strcat
		#emit stack 16

		print(tmp);

		for(new i, t[5]; i != 2; ++i) {
			t[0] = addr + i * 4;

			#emit lref.s.pri t
			#emit stor.s.pri t

			printf("%c", t{3});
			printf("%c", t{2});
			printf("%c", t{1});
			printf("%c", t{0});

			t[1] = EOS;
			t[0] = (buffer >>> 24) | (buffer >> 8 & 0x0000FF00) | (buffer << 8 & 0x00FF0000) | (buffer << 24);

			strunpack(t, t);

			printf("%s", t);

		}


		AMX_ReadString(addr, tmp);

		print(tmp);
	}
}

stock AMX_ReadString(addr, str[], len = sizeof (str))
{
	new
		buffer,
		idx;
	do
	{
		// Read 4 bytes.
		#emit LREF.S.pri                addr
		#emit STOR.S.pri                buffer
		// Write PACKED strings.
		buffer = (buffer >>> 24) | (buffer >> 8 & 0x0000FF00) | (buffer << 8 & 0x00FF0000) | (buffer << 24);
		str[idx] = buffer;
		if (!(buffer & 0x000000FF && buffer & 0x0000FF00 && buffer & 0x00FF0000 && buffer & 0xFF000000))
		{
			return;
		}
		addr += 4;
	}
	while (++idx < len);
}

stock GetTextFromAddress(address) {
	#emit load.s.pri address
	#emit stor.s.pri 16
	#emit retn

	new
		tmp[1]
	;
	return tmp;
}

stock GetPublicOffset(idx) {
	static const
		offset
	;
	if(offset == 0) {
		#emit lctrl 1 // dat
		#emit neg
		#emit move.alt
		#emit add.c 32 // public
		#emit stor.pri offset
		#emit lref.pri offset
		#emit add
		#emit stor.pri offset
	}
	if(idx != -1) {
		idx = idx * 8 + offset;
	}
	return idx;
}

stock CallLocalFunctionByIdx2(idx, const form, {Float, _}: ...) {
	if(idx != -1) {
		static const
			offset
		;
		if(offset == 0) {
			#emit lctrl 1 // dat
			#emit neg
			#emit move.alt
			#emit add.c 32 // public
			#emit stor.pri offset
			#emit lref.pri offset
			#emit add
			#emit stor.pri offset
		}
		new
			end,
			start,
			power = 1
		;
		#emit addr.pri 16
		#emit stor.s.pri start

		#emit load.s.pri 8
		#emit addr.alt 8
		#emit add
		#emit stor.s.pri end

		while(start < end) {
			if((form & power) == 0) {
				#emit lref.s.pri end
				#emit load.i
				#emit sref.s.pri end
			}
			power <<= 1;
			end -= 4;
		}
		idx = idx * 8 + offset;

		#emit stack 32
		#emit lref.s.alt idx
		#emit load.s.pri 8
		#emit add.c 0xFFFFFFF8
		#emit push.pri
		#emit push.s 4
		#emit load.s.pri 0
		#emit sctrl 5
		#emit move.pri
		#emit sctrl 6
	}
	return 0;
}
*/
/*
new
//	var = 7,
	timer
;
main() {
	Timer(timer, 5);

//	SetTimerEx("tChange", 1000, false, "i", var);
//	SetTimerEx("tPrint", 2000, false, "i", var);

	new
		addr
	;
	#emit const.pri timer
	#emit stor.s.pri addr

	SetTimerEx("tPrint", 0500, false, "i", addr);
	SetTimerEx("tPrint", 1500, false, "i", addr);
	SetTimerEx("tPrint", 2500, false, "i", addr);
	SetTimerEx("tPrint", 3500, false, "i", addr);
	SetTimerEx("tPrint", 4500, false, "i", addr);
}

forward tChange(& change);
public tChange(& change) change = 3;

forward tPrint(& value);
public tPrint(& value) printf(".%d", value);

forward Timer(& ref, value);
public Timer(& ref, value) {
	if(value) {
		new
			addr
		;
		#emit load.s.pri ref
		#emit stor.s.pri addr
		
		printf("x%d", (ref = SetTimerEx("Timer", 1000, false, "ii", addr, --value)));
		printf("y%d", ref);
	}
}
*/
/*
stock AddLine(delimiter, const line[]) {
	#emit load.s.pri line
	#emit add.c 0xFFFFFFFC
	#emit move.alt
	#emit load.s.pri delimiter
	#emit stor.i
}

main() {
	static const
		sinit = true,
		stext[] = "%s - Level %d | %s | Age: %d | Total wealth: $%d | Playing hours: %d | Phone number: %s | Warnings: %d"
	;
	if(sinit) {
		AddLine('\n', "Cash: $%d | Bank balance: $%d | Upgrade points: %d | Spawn armor: %.0f | Next level: %d/%d hours ($%d)");
		AddLine('\n', "%s: %s | Rank: %s (%d) | Division: %s | Job: %s (level: %d) | Job 2: %s (level: %d)");
		AddLine('\n', "Married to: %s | Biggest fish: %d | Pot: %d | Crack: %d | Packages: %d | Crates: %d | Radio frequency: %d khz");
		AddLine('\n', "Materials: %d | Rope: %d | Cigars: %d | Sprunk: %d | Spray: %d | Screwdrivers: %d | VIP tokens: %d | Checks: %d | VIP: %s");
		AddLine('\n', "ADMutes: %d | NMutes: %d | RMutes: %d | Weapons Restricted: %d | Gang Warns: %d");

		#emit zero sinit
	}
	print(stext);
	

	new
		tmp[1024]
	;
	format(tmp, sizeof tmp, stext,
		GetPlayerNameEx(targetid), level, sext, age, totalwealth, ptime, pnumber, warns,
		cash, account, upgradep, shealth, exp, expamount, costlevel,
		facfam, employer, rank, PlayerInfo[targetid][pRank], division, jtext,jlevel,jtext2, jlevel2,
		married, bigfish, pot, crack, packages, crates, radiofreq,
		mats, rope, cigars, sprunk, spray, PlayerInfo[targetid][pScrewdriver], tokens, checks, drank,
		admutes, nmutes, PlayerInfo[targetid][pRMutedTotal], PlayerInfo[targetid][pWRestricted], PlayerInfo[targetid][pGangWarn]
	);
	if (PlayerInfo[playerid][pAdmin] >= 2) {
		strcat(tmp, "House: %d | House 2: %d | Renting: %d | Int: %d | VW: %d | Real VW: %d | Jail: %d sec | WJail: %d sec | AFK: %i", sizeof tmp);
		format(tmp, sizeof tmp, tmp, housekey, housekey2, rentkey, intir, vw, realvw, jailt, wjailt, playerAFKTime[targetid]);
	}
	if (PlayerInfo[playerid][pAdmin] >= 1337) {
		if (PlayerInfo[targetid][pAdmin] >= 2 && PlayerInfo[playerid][pAdmin] >= 2) {
			strcat(tmp, "Accepted reports: %d | Trashed reports: %d", sizeof tmp);
			format(tmp, sizeof tmp, tmp, PlayerInfo[targetid][pAcceptReport], PlayerInfo[targetid][pTrashReport]);
		}
		if (PlayerInfo[targetid][pHelper] >= 2 && PlayerInfo[playerid][pAdmin] >= 2) {
			strcat(tmp, "Hours on duty: %d | Accepted help requests: %d", sizeof tmp);
			format(tmp, sizeof tmp, tmp, PlayerInfo[targetid][pDutyHours], PlayerInfo[targetid][pAcceptedHelp]);
		}
	}
	ShowPlayerDialog(playerid, DIALOGID, DIALOG_STYLE_MSGBOX, "Stats", tmp, "Okay", "");

}
*/

/*
stock mktime(hour, minute, second, day, month, year) { // missing check for current leap year
    for(new j = 1970; j < year; j++) {
        if ( ((j % 4 == 0) && (j % 100 != 0)) || (j % 400 == 0) ) {
            second += 31536000 + 86400; // Schaltjahr + 1 Tag
        } else {
            second += 31536000;
        }
    }
    if(month > 1) { // No January Calculation, because its always the 0 past months
        new
            days_of_month[12] = {31,28,31,30,31,30,31,31,30,31,30,31}
        ;
        if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) {
            days_of_month[1] = 29; // Schaltjahr
        }
        for(new i = 1; i < month; i++) {
            day += days_of_month[i - 1];
        }
    }
    return second + (minute * 60) + (hour * 3600) + (day * 86400);
}

stock mktimeO(hour,minute,second,day,month,year) { // original - broken
	new timestamp2;

	timestamp2 = second + (minute * 60) + (hour * 3600);

	new days_of_month[12];

	if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) {
			days_of_month = {31,29,31,30,31,30,31,31,30,31,30,31}; // Schaltjahr
		} else {
			days_of_month = {31,28,31,30,31,30,31,31,30,31,30,31}; // keins
		}
	new days_this_year = 0;
	days_this_year = day;
	if(month > 1) { // No January Calculation, because its always the 0 past months
		for(new i=0; i<month-1;i++) {
			days_this_year += days_of_month[i];
		}
	}
	timestamp2 += days_this_year * 86400;

	for(new j=1970;j<year;j++) {
		timestamp2 += 31536000;
		if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) )  timestamp2 += 86400; // Schaltjahr + 1 Tag
	}

	return timestamp2;
}
*/

/*
enum a {
    str[MAX_PLAYER_NAME],
	int
}

new array[1][a];

main() {
	strcat(array[0][str], "Shisk", MAX_PLAYER_NAME);

	printf("%s", array[0][str]);

	printf("%s", returnPlayerName(0));

	printf("%s", returnPlayerNameEx(0));

	print("Hello World");
}

#define retn(%0,%1) retArray(%0); new _tmp[%1]; return _tmp

returnPlayerName(playerid) {
	retn(array[playerid][str], MAX_PLAYER_NAME);
}

retArray({Float, _}: ...) {
	#emit load.s.pri 0
	#emit sctrl 4
	#emit add.c 8
	#emit move.alt
	#emit load.i
	#emit add
	#emit add.c 4
	#emit move.alt
	#emit load.s.pri 12
	#emit stor.i
	#emit retn
}

#define retnEx(%0,%1) retArrayEx(%0); new _tmp[%1]; return _tmp

returnPlayerNameEx(playerid) {
	retnEx(array[playerid][str], MAX_PLAYER_NAME);
}

retArrayEx({Float, _}: ...) {
	#emit load.s.pri 0
	#emit sctrl 4
	#emit add.c 4
	#emit move.alt
	#emit load.i
	#emit add.c 4
	#emit stor.i
	#emit load.s.pri 12
	#emit retn
}
*/
/*
stock frename(ofilename[], nfilename[]) {
    new
        File: oFile = fopen(ofilename, io_read)
    ;
    if(oFile) {
        new
            File: nFile = fopen(nfilename, io_write)
        ;
        if(nFile) {
            new
                tmp[2048]
            ;
            while(fblockwrite(nFile, tmp, fblockread(oFile, tmp, sizeof tmp - 1))) {}

            fclose(oFile);
            fclose(nFile);

            fremove(ofilename);
            return true;
        }
        fclose(oFile);
    }
    return false;
}

main() {
	frename("myfile1.txt", "myfile2.txt");
}
*/
/*
stock g_ptrarr[1000];

#define @ptr[%1] \
    (!~g_ptrarr)[%1 / 4]

main() {
	new
		text1[] = "/all",
		text2[] = "/all Hello, my name is Garwan50!"
	;
	printf("%d", strcmp(text1, text2, true)); // -28
	printf("%d", strcmp(text1, text1, true)); // 0
	printf("%d", strcmp(text2, text1, true)); // 28

	if(strcmp(text1, text2, true) == -1) {
		print("-1");
	}

	new
		playerid,
		cmdtext[10]
	;
    if(strcmp("/all", cmdtext, true, 4) == 0) {
        static const
            text[] = "[USE] /all <text>"
        ;
        if(cmdtext[4] == EOS) {
            return SendClientMessage(playerid, 0x41A5F5FF, text);
        }
        if(cmdtext[4] == ' ') {
            if(cmdtext[5] == EOS) {
                return SendClientMessage(playerid, 0x41A5F5FF, text);
            }
            new
                tmp[144]
            ;
            GetPlayerName(playerid, tmp, MAX_PLAYER_NAME);
//            RPName(tmp);
            format(tmp, sizeof tmp, "[ALL] {00CED1}%s {FAF427}say: %s", tmp, cmdtext[5]);
            return SendClientMessageToAll(-1, tmp);
        }
    }
//    new address = ref("hello"); // ref gets the address of the argument
 
//	printf("%d", address);

//    print(@ptr[address]);
	return false;
}

stock ref(...) {
	#emit load.s.pri 12
	#emit retn

	return 0;
}
*/
/*
new
	array[2][2][2]
;

main() {
	array[1][1][1] = 0;
	Hi(array);
}

Hi(...) {}

SetAll(value, dimensions, {Float, _}: ...) {
	if(1 <= dimensions <= 3) {
		new
			addr
		;
		#emit load.s.pri 20
		#emit stor.s.pri addr

		while(dimensions--) {
			#emit lref.s.pri start
			#emit load.s.alt addr
			#emit add
			#emit stor.s.pri addr

			start += 4;
		}
		return true;
	}
	return false;


	while(idx != args) {
		addr

		idx++;
	}
	
    static
        x,
        addr1,
        addr2,
        slot;

    for( x = 0; x != size_2; ++x )
        array[0][x] = value;

    // get array
    #emit load.s.pri        array
    
    // move to pri -> alt
    #emit move.alt
    
    // load in pri first idx of array
    #emit load.i
    
    // add pri with alt
    #emit add
    
    // stor in addr result
    #emit stor.pri  addr1

    for( x = 1; x != size_1; ++x ) {

        slot = x;

        #emit LOAD.S.pri    array
        #emit SHL.C.alt     2
        #emit ADD
        #emit STOR.pri  slot

        #emit LOAD.I
        #emit ADD
        #emit STOR.pri  addr2

        #emit LOAD.pri  addr1
        #emit LOAD.alt  slot
        #emit SUB
        #emit STOR.I
    }

    return true;

}*/

/*
enum aenum {
	hey[10],
	world[10]
}

main() {
	new
		array1[aenum] = { "Hello", "World" },
		array2[aenum] = { "Hello", "World" }
	;
	printf("%s %c %s %c %d", array1[hey], array1[hey], array2[hey], array2[hey], (array1[hey] == array2[hey]));
}
*/

/*
ShowStats(playerid, targetid) {
    if(IsPlayerConnected(targetid)) {
        static const
            cZero[] = "None",
            cGender[][] = { "Female", "Male" }, // (PlayerInfo[targetid][pSex] == 1)
            cSTD[][] = { "Chlamydia", "Gonorrhea", "Syphilis" }, // STDPlayer[targetid] - 1
            cJob[][] = { // PlayerInfo[targetid][pJob] - 1 // pJob2
                "Detective",
                "Lawyer",
                "Whore",
                "Drugs Dealer",
                "Car Jacker",
                "News Reporter",
                "Car Mechanic",
                "Bodyguard",
                "Arms Dealer",
                "Car Dealer",
                "Boxer",
                "Drug Smuggler",
                "Paper Boy",
                "Trucker",
                "Taxi Driver",
                "Craftsman",
                "Bartender",
                "Trucker",
                "Pizza Boy",
                "Fedex Driver"
            },
            cDrunk[][] = { // PlayerInfo[targetid][pDonateRank] - 1
                "Bronze",
                "Silver",
                "Gold",
                "Platinum",
                "Server Investor"
            },
            cInsurance[][] = { // PlayerInfo[targetid][pInsurance] - 1
                "County General",
                "All Saints",
                "Red County",
                "Fort Carson",
                "San Fierro",
                "Club VIP",
                "Home care",
                "",
	            "El Quabrados",
                "Demorgan"
            }
        ;
        new sext[16], std[20], employer[64], rank[64], division[64], jtext2[20], jtext[20], pnumber[20], facfam[20];
        if(PlayerInfo[targetid][pPnumber] == 0) pnumber = "None"; else format(pnumber, sizeof(pnumber), "%d", PlayerInfo[targetid][pPnumber]);

        if(PlayerInfo[targetid][pFMember] < 255) {
            facfam = "Family";
            division = cZero;

            strcat(employer, FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyName]);

            switch(PlayerInfo[targetid][pRank]) {
                case 2: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank2]);
                case 3: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank3]);
                case 4: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank4]);
                case 5: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank5]);
                case 6: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank6]);
                default: format(rank, sizeof(rank), "%s", FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyRank1]);
            }
        } else {
            facfam = "Faction";

            GetPlayerFactionInfo(targetid, rank, division, employer);
        }
        new
            jlevel1,
            jlevel2
        ;
        switch(PlayerInfo[targetid][pJob]) {
            case 1: jlevel1 = PlayerInfo[targetid][pDetSkill];
            case 2: jlevel1 = PlayerInfo[targetid][pLawSkill];
            case 3: jlevel1 = PlayerInfo[targetid][pSexSkill];
            case 4: jlevel1 = PlayerInfo[targetid][pDrugsSkill];
            case 7: jlevel1 = PlayerInfo[targetid][pMechSkill];
            case 9: jlevel1 = PlayerInfo[targetid][pArmsSkill];
            case 12: jlevel1 = PlayerInfo[targetid][pBoxSkill];
            case 14: jlevel = 1;
            case 20: jlevel1 = PlayerInfo[targetid][pTruckSkill];
            default: jlevel1 = -1;
        }
        if(jlevel1 < 0) jlevel1 = 0;
        else if(jlevel1 <= 50) jlevel1 = 1;
        else if(jlevel1 <= 100) jlevel1 = 2;
        else if(jlevel1 <= 200) jlevel1 = 3;
        else if(jlevel1 <= 400) jlevel1 = 4;
        else jlevel1 = 5;

        switch(PlayerInfo[targetid][pJob2]) {
            case 1: jlevel2 = PlayerInfo[targetid][pDetSkill];
            case 2: jlevel2 = PlayerInfo[targetid][pLawSkill];
            case 3: jlevel2 = PlayerInfo[targetid][pSexSkill];
            case 4: jlevel2 = PlayerInfo[targetid][pDrugsSkill];
            case 7: jlevel2 = PlayerInfo[targetid][pMechSkill];
            case 9: jlevel2 = PlayerInfo[targetid][pArmsSkill];
            case 12: jlevel2 = PlayerInfo[targetid][pBoxSkill];
            case 14: jlevel2 = 1;
            case 20: jlevel2 = PlayerInfo[targetid][pTruckSkill];
            default: jlevel2 = -1;
        }
        if(jlevel2 < 0) jlevel2 = 0;
        else if(jlevel2 <= 50) jlevel2 = 1;
        else if(jlevel2 <= 100) jlevel2 = 2;
        else if(jlevel2 <= 200) jlevel2 = 3;
        else if(jlevel2 <= 400) jlevel2 = 4;
        else jlevel2 = 5;



        new
		    married[20]
        ;
        strcat(married, PlayerInfo[targetid][pMarriedTo]);

        new upgradep = PlayerInfo[targetid][gPupgrade];
		new bigfish = PlayerInfo[targetid][pBiggestFish];
		new crimes = PlayerInfo[targetid][pCrimes];
		new arrests = PlayerInfo[targetid][pArrested];
		new pot = PlayerInfo[targetid][pPot];
		new crack = PlayerInfo[targetid][pCrack];
		new mats = PlayerInfo[targetid][pMats];
		new wanted = PlayerInfo[targetid][pWantedLevel];
		new exp = PlayerInfo[targetid][pExp];
		new nxtlevel = PlayerInfo[targetid][pLevel]+1;
		new expamount = nxtlevel*levelexp;
		new costlevel = nxtlevel*levelcost;//10k for testing purposes
		new housekey = PlayerInfo[targetid][pPhousekey];
		new housekey2 = PlayerInfo[targetid][pPhousekey2];
		new rentkey = PlayerInfo[targetid][pRenting];
		new radiofreq = PlayerInfo[targetid][pRadioFreq];
		new intir = GetPlayerInterior(targetid);
		new tokens = PlayerInfo[targetid][pTokens];
		new ptokens = PlayerInfo[targetid][pPaintTokens];
		new checks = PlayerInfo[targetid][pChecks];
		new Float:shealth = PlayerInfo[targetid][pSHealth];
		//new Float:sarmor = PlayerInfo[targetid][pSArmor];
		new Float:health, Float:armor;
		new packages = GetPVarInt(targetid, "Packages");
		new crates = PlayerInfo[targetid][pCrates];
		new rope = PlayerInfo[targetid][pRope],
			rag = PlayerInfo[targetid][pRag],
			cigars = PlayerInfo[targetid][pCigar],
			sprunk = PlayerInfo[targetid][pSprunk],
			spray = PlayerInfo[targetid][pSpraycan],
			realvw = GetPlayerVirtualWorld(targetid),
			vw = PlayerInfo[targetid][pVW],
			warns = PlayerInfo[targetid][pWarns],
			jailt = PlayerInfo[targetid][pJailTime],
			wjailt = PlayerInfo[targetid][pBeingSentenced];
		GetPlayerHealth(targetid,health);
		GetPlayerArmour(targetid,armor);
		new Float:px,Float:py,Float:pz;
		GetPlayerPos(targetid, px, py, pz);
		new totalwealth;
		new name[MAX_PLAYER_NAME];
		GetPlayerName(targetid, name, sizeof(name));
		new nmutes = PlayerInfo[targetid][pNMuteTotal];
		new admutes = PlayerInfo[targetid][pADMuteTotal];
		new oocmutes = PlayerInfo[targetid][pOOCMuteTotal];
		new rpskill = PlayerInfo[targetid][pRPSkill];
		new
			totalwealth,
			cash =  GetPlayerCash(targetid),
			account = PlayerInfo[targetid][pAccount]
		;
		totalwealth = account + cash;
		if(PlayerInfo[targetid][pPhousekey] != INVALID_HOUSE_ID && strcmp(name, HouseInfo[PlayerInfo[targetid][pPhousekey]][hOwner], true) == 0) totalwealth += HouseInfo[PlayerInfo[targetid][pPhousekey]][hSafeMoney];
		if(PlayerInfo[targetid][pPhousekey2] != INVALID_HOUSE_ID && strcmp(name, HouseInfo[PlayerInfo[targetid][pPhousekey2]][hOwner], true) == 0) totalwealth += HouseInfo[PlayerInfo[targetid][pPhousekey2]][hSafeMoney];

		static
			str1[] = "%s\n Level %d\n %s\n Age: %d\n Total wealth: $%d\n Playing hours: %d\n Phone number: %s\n RP Skill: %d",
			str2[] = "Cash: $%d\n Bank balance: $%d\n Upgrade points: %d\n Spawn armor: %.0f\n Next level: %d/%d hours ($%d)",
			str3[] = "%s: %s\n Rank: %s (%d)\n Division: %s\n Job: %s (level: %d)\n Job 2: %s (level: %d)",
			str4[] = "Crimes: %d\n Arrests: %d\n Insurance: %s\n Wanted level: %d\n Health: %.1f\n Armor: %.1f\n Paintball Tokens: %d",
			str5[] = "Married to: %s\n Biggest fish: %d\n Pot: %d\n Crack: %d\n Packages: %d\n Crates: %d\n Radio frequency: %d mhz",
			str6[] = "Materials: %d\n Rope: %d\n Rag: %d\n Cigars: %d\n Sprunk: %d\n Spray: %d\n Screwdrivers: %d\n VIP tokens: %d\n Checks: %d\n VIP: %s",
			str7[] = "OOCMutes: %d\n ADMutes: %d\n NMutes: %d\n RMutes: %d\n Weapons Restricted: %d\n Gang Warns: %d\n Warnings: %d",
			str8[] = "House: %d\n House 2: %d\n Renting: %d\n Int: %d\n VW: %d\n Real VW: %d\n Jail: %d sec\n WJail: %d sec\n AFK: %i",
			str9[] = "Hours on duty: %d\n Accepted help requests: %d",

		    bool: init = true
		;
		if(init) {
			str1[sizeof str1 - 1] = str2[sizeof str2 - 1] = str3[sizeof str3 - 1] = str4[sizeof str4 - 1] = str5[sizeof str5 - 1] = str6[sizeof str6 - 1] = '\n';
			str8[sizeof str9 - 1] = EOS;

			init = false;
		}
		if(PlayerInfo[playerid][pAdmin] >= 2) str7[sizeof str7 - 1] = '\n'; else str7[sizeof str7 - 1] = EOS;
		if(PlayerInfo[playerid][pAdmin] >= 1337 && PlayerInfo[targetid][pHelper] >= 2) str8[sizeof str8 - 1] = '\n'; else str8[sizeof str8 - 1] = EOS;

		new
		    tmp[2048]
		;
		format(tmp, sizeof tmp, string,
			GetPlayerNameEx(targetid),
			PlayerInfo[targetid][pLevel],
			cGender[(PlayerInfo[targetid][pSex] == 1)],
			PlayerInfo[targetid][pAge],
			totalwealth,
			PlayerInfo[targetid][pConnectTime],
			(PlayerInfo[targetid][pPnumber] == 0) ? cZero : PlayerInfo[targetid][pPnumber],
			rpskill);
		SendClientMessageEx(playerid, COLOR_WHITE,coordsstring);
		format(coordsstring, sizeof(coordsstring), "Cash: $%d | Bank balance: $%d | Upgrade points: %d | Spawn armor: %.0f | Next level: %d/%d hours ($%d)", cash, account, upgradep, shealth, exp, expamount, costlevel);
		SendClientMessageEx(playerid, COLOR_GRAD1,coordsstring);
		format(coordsstring, sizeof(coordsstring), "%s: %s | Rank: %s (%d) | Division: %s | Job: %s (level: %d) | Job 2: %s (level: %d)", facfam, employer, rank, PlayerInfo[targetid][pRank], division, jtext,jlevel,jtext2, jlevel2);
		SendClientMessageEx(playerid, COLOR_GRAD5,coordsstring);
		format(coordsstring, sizeof(coordsstring), "Crimes: %d | Arrests: %d | Insurance: %s | Wanted level: %d | Health: %.1f | Armor: %.1f | Paintball Tokens: %d",crimes,arrests,insur, wanted, health, armor, ptokens);
		SendClientMessageEx(playerid, COLOR_GRAD1,coordsstring);
		format(coordsstring, sizeof(coordsstring), "Married to: %s | Biggest fish: %d | Pot: %d | Crack: %d | Packages: %d | Crates: %d | Radio frequency: %d mhz",married,bigfish,pot,crack,packages,crates, radiofreq);
		SendClientMessageEx(playerid, COLOR_GRAD5,coordsstring);
		format(coordsstring, sizeof(coordsstring), "Materials: %d | Rope: %d | Rag: %d | Cigars: %d | Sprunk: %d | Spray: %d | Screwdrivers: %d | VIP tokens: %d | Checks: %d | VIP: %s",mats,rope,rag,cigars,sprunk,spray, PlayerInfo[targetid][pScrewdriver],tokens,checks,drank);
		SendClientMessageEx(playerid, COLOR_GRAD1,coordsstring);
		format(coordsstring, sizeof(coordsstring), "OOCMutes: %d | ADMutes: %d | NMutes: %d | RMutes: %d | Weapons Restricted: %d | Gang Warns: %d | Warnings: %d", oocmutes, admutes, nmutes, PlayerInfo[targetid][pRMutedTotal],PlayerInfo[targetid][pWRestricted], PlayerInfo[targetid][pGangWarn], warns);
		SendClientMessageEx(playerid, COLOR_GRAD1,coordsstring);
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
		    format(coordsstring, sizeof(coordsstring), "House: %d | House 2: %d | Renting: %d | Int: %d | VW: %d | Real VW: %d | Jail: %d sec | WJail: %d sec | AFK: %i", housekey,housekey2,rentkey,intir,vw,realvw,jailt,wjailt, playerAFKTime[targetid]);
		    SendClientMessageEx(playerid, COLOR_GRAD5,coordsstring);
		}
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			if(PlayerInfo[targetid][pHelper] >= 2 && PlayerInfo[playerid][pAdmin] >= 2)
			{
			    format(coordsstring, sizeof(coordsstring), "Hours on duty: %d | Accepted help requests: %d", PlayerInfo[targetid][pDutyHours], PlayerInfo[targetid][pAcceptedHelp]);
			    SendClientMessageEx(playerid, COLOR_GRAD5,coordsstring);
			}
		}
		SendClientMessageEx(playerid, COLOR_GREEN,"___________________________________________________________________________________________________");
	}
}

main() {
	static const
		cZero[] = "None"
	;
	new
		tmp[20]
	;
	tmp = cZero;
}
*/
/*
stock MovePlayer(playerid, Float: dX, Float: dY, Float: dZ, time) {
    new
        Float: X,
        Float: Y,
        Float: Z
    ;
    if(GetPlayerPos(playerid, X, Y, Z)) {
        time *= 10; // 10 times per second

        dX = (dX - X) / time;
        dY = (dY - Y) / time;
        dZ = (dZ - Z) / time;

        tMovePlayer(playerid, X + dX, Y + dY, Z + dZ, dX, dY, dZ, time);
        return true;
    }
    return false;
}

forward tMovePlayer(playerid, Float: X, Float: Y, Float: Z, Float: sX, Float: sY, Float: sZ, tick);
public tMovePlayer(playerid, Float: X, Float: Y, Float: Z, Float: sX, Float: sY, Float: sZ, tick) {
    if(SetPlayerPos(playerid, X, Y, Z) && tick--) {
        SetTimerEx("tMovePlayer", 100, false, "iffffffi", playerid, X + sX, Y + sY, Z + sZ, sX, sY, sZ, tick);
    }
}

main() {
	MovePlayer(0, 1.0, 2.0, 3.0, 5);
}*/

/*
stock doAdd(a , b) { // ipsBruno
	printf("doAdd(%d, %d) %b %b", a, b, a, b);

    for( ; b ; ) {
        a ^= b;
        b = (a ^ b) & b;
		printf("%b %b => %b", a, b, b << 1);
        b <<=  1;
    }
    return a;
}

main() {
	new
		rand1 = random(64),
		rand2 = random(64)
	;
	printf("%d = %d", doAdd(rand1, rand2), rand1 + rand2);
}
*/
/*
stock ConvertToBase(deci, base) {
    new
        mod,
        tmp[33],
        i = sizeof tmp - 1
    ;
    do {
        mod = deci % base;
        tmp[--i] = (mod < 10) ? (mod + '0') : (mod + 'A' - 10);
        deci /= base;
    } while(deci);

    if(i != 0) {
        strcat(tmp, tmp[i]);
    }
    return tmp;
}

stock ConvertToDecimal(src[], base) {
    new
        i = strlen(src),
        result,
        m = 1,
        c
    ;
    while(--i != -1) {
        if('a' <= (c = src[i])) c = src[i] - 'a' + 10;
        else if('A' <= c) c = src[i] - 'A' + 10;
        else c = src[i] - '0';

        result += c * m;
        m *= base;
    }
    return result;
}

main() {
	new
		rand = random(cellmax),
		result[33]
	;
	result = ConvertToBase(rand, 2);
	printf("%d - %s - %d", rand, result, ConvertToDecimal(result, 2)); 
}
*/
/*
#include <ntest>
#include <YSI\y_ini>
#include <nFile>

new
	gInt
;

INI:y_ini[](name[], value[])
{
    INI_Int("TEST_TAG", gInt);
	return 0;
}

nTest(3x10000) {
    new
		super[20] = "super dooper string"
	;
	Test("yini reading") {
		INI_Load("y_ini.txt");
	}
	Test("nfile reading") {
		new
			File: gFile = nFile::fopen("temp.txt", io_readwrite)
		;
		nFile::fwrite(gFile, "d[2]f[16]s[*]", 3, 3.14159265, strlen("Hello World"), "Hello World");

		new
			data[32]
		;
		nFile::fseek(gFile, seek_start, +, 0); // we jump back to the start
		nFile::fread(gFile, "dfs", data[0], data[1], data[2]);
		nFile::fclose(gFile);
	}
    
    return 1;
}
*/
/*
public OnPlayerConnect(playerid) {
	SendClientMessage(playerid, -1, "Connect");
	SetSpawnInfo(playerid, NO_TEAM, 0, 0.0, 0.0, 5.0, 0.0, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	return true;
}

public OnPlayerRequestClass(playerid, classid) {
	SendClientMessage(playerid, -1, "RequestClass");
//	SetTimerEx("tSpawnPlayer", 0, false, "i", playerid);
	return true;
}

forward tSpawnPlayer(playerid);
public tSpawnPlayer(playerid) SpawnPlayer(playerid);

public OnPlayerRequestSpawn(playerid) {
	SendClientMessage(playerid, -1, "RequestSpawn");
	return true;
}

public OnPlayerSpawn(playerid) {
	SendClientMessage(playerid, -1, "Spawn");
	TogglePlayerControllable(playerid, true);
	return true;
}
*/
/*
stock Func(q)
{
    return printf("Hello World: %d", q);
}

main()
{

    printf("NON");
    
    #emit LCTRL         6
    #emit ADD.C         44
    
    #emit PUSH.C        564 // FISRT PARAMETER
    #emit PUSH.C        4
    #emit PUSH.PRI
    #emit CONST.PRI     Func
    #emit SCTRL         6

    printf("NAIN");
}
*/
/*
stock xprint(const string[]) {
    print("1");
	return print(string);
}
#if defined _ALS_print
    #undef print
#else
    #define _ALS_print
#endif
#define print xprint

stock hprint(const string[]) {
	print("2");
    return print(string);
}
#if defined _ALS_print
    #undef print
#else
    #define _ALS_print
#endif
#define print hprint

main() {
	print("My name is Markus");
}
*/

/*
new
    Team: gTeam[MAX_PLAYERS char],
    Team: gTeamClass[300 char] = {Team: -1, ...},
    Team: gTeamVehicle[MAX_VEHICLES + 1 char] = {Team: -1, ...}
;

SetClassToTeam(Team: teamid, classid) {
    if((0 <= classid < (sizeof gTeamClass * 4)) && (0 <= _: teamid <= 255)) {
        gTeamClass{classid} = teamid;
        return classid;
    }
    return printf("* SetClassToTeam(%d, %d) failed", _: teamid, classid);
}

SetVehicleToTeam(Team: teamid, vehicleid) {
    if((1 <= vehicleid < (sizeof gTeamVehicle * 4)) && (0 <= _: teamid <= 255)) {
        gTeamVehicle{vehicleid} = teamid;
        return vehicleid;
    }
    return printf("* SetVehicleToTeam(%d, %d) failed", _: teamid, vehicleid);
}

enum Team {
    GROVE_STREET,
    POLICE
}

new const
   gTeamColors[Team] = {
        0x00820FAA, // GROVE
        0x003DF5AA // POLICE
    }
;

public OnPlayerRequestClass(playerid, classid) {
    gTeam{playerid} = gTeamClass{classid};
    return true;
}

public OnPlayerRequestSpawn(playerid) {
    SetPlayerColor(playerid, gTeamColors[gTeam{playerid}]);
}

public OnGameModeInit() {
    SetClassToTeam(GROVE_STREET, AddPlayerClass(105,2497.2693,-1676.9578,13.3398,23.6501,0,0,0,0,0,0));
    SetClassToTeam(GROVE_STREET, AddPlayerClass(105,2497.2693,-1676.9578,13.3398,23.6501,0,0,0,0,0,0));

    SetVehicleToTeam(GROVE_STREET, CreateVehicle(492,2484.3054,-1655.0886,13.1036,90.8565,44,16,900)); //Greenwood

    SetClassToTeam(POLICE, AddPlayerClass(280,1544.0514,-1675.7766,13.5577,98.0974,0,0,0,0,0,0));
    SetClassToTeam(POLICE, AddPlayerClass(280,1544.0514,-1675.7766,13.5577,98.0974,0,0,0,0,0,0));

    SetVehicleToTeam(POLICE, CreateVehicle(596,1536.0603,-1676.5302,13.1054,0.6847,-1,-1,900)); //LSPD Cruiser
}

public OnPlayerStateChange(playerid, newstate, oldstate) {
    if(newstate == PLAYER_STATE_DRIVER) {
        new
            vehicleid = GetPlayerVehicleID(playerid)
        ;
        if(gTeamVehicle{vehicleid} != gTeam{playerid}) {
            RemovePlayerFromVehicle(playerid);
        }
    }
    return true;
}
*/
/*
new
    pDrugs[MAX_PLAYERS],
    pDrugTicks[MAX_PLAYERS char]
;

new
    PlayerText: ptDrugs[MAX_PLAYERS],
    PlayerText: ptDrugsTaken[MAX_PLAYERS]
;

#define function%0(%1) forward public%0(%1);public%0(%1)

HealSlowly(playerid, ticks) {
    new
        sum = pDrugTicks{playerid} + ticks
    ;
    if(255 < sum) {
        return false;
    }
    pDrugTicks{playerid} = sum;

    if(sum == ticks) {
        pDrugTicks{playerid}++;

        SetTimerEx("HealSlowlyEx", 0, false, "i", playerid);
        PlayerTextDrawShow(playerid, ptDrugsTaken[playerid]);
    }
    return true;
}

function HealSlowlyEx(playerid) {
    new
        Float: health
    ;
    if(GetPlayerHealth(playerid, health)) {
        SetPlayerHealth(playerid, ++health);

        if(--pDrugTicks{playerid} && (health < 100.0)) {
            static
                tmp[32] = "Drugs remaining: "
            ;
            valstr(tmp[17], (pDrugTicks{playerid} / 5), false);
            PlayerTextDrawSetString(playerid, ptDrugsTaken[playerid], tmp);

            SetTimerEx("HealSlowlyEx", 666, false, "i", playerid);
        } else {
            SendClientMessage(playerid, 0xFF0000FF, "The drugs have worn off!");
            PlayerTextDrawHide(playerid, ptDrugsTaken[playerid]);

            printf("%d - %d", GetPlayerDrugs(playerid), pDrugTicks{playerid} / 5);

            SetPlayerDrugs(playerid, GetPlayerDrugs(playerid) + (pDrugTicks{playerid} / 5));

            pDrugTicks{playerid} = 0;
        }
    }
}


stock SetPlayerDrugs(playerid, drugs) {
    static
        tmp[32] = "Drugs: "
    ;
    valstr(tmp[7], (pDrugs[playerid] = drugs), false);
    return PlayerTextDrawSetString(playerid, ptDrugs[playerid], tmp);
}

stock GetPlayerDrugs(playerid) return pDrugs[playerid];

public OnPlayerConnect(playerid) {
    ApplyAnimation(playerid, "SMOKING", "null", 0.0, 0, 0, 0, 0, 0, 0);

    ptDrugs[playerid] = CreatePlayerTextDraw(playerid, 20.0, 100.0, "_");
    ptDrugsTaken[playerid] = CreatePlayerTextDraw(playerid, 20.0, 200.0, "_");

    PlayerTextDrawShow(playerid, ptDrugs[playerid]);

    SetPlayerDrugs(playerid, 500);

    return true;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    if(strcmp("/td", cmdtext, true, 3) == 0) {
        static const
            sUsage[] = "Usage: /td [amount]"
        ;
        if(cmdtext[3] == EOS) {
            return SendClientMessage(playerid, -1, sUsage);
        }
        if(cmdtext[3] == ' ') {
            if(cmdtext[4] == EOS) {
                return SendClientMessage(playerid, -1, sUsage);
            }
            new
                drugs = strval(cmdtext[4])
            ;
            if(!(0 < drugs < 51)) {
                return SendClientMessage(playerid, -1, "You can only take 1-50 drugs at once!");
            }
            if(GetPlayerDrugs(playerid) < drugs) {
                return SendClientMessage(playerid, -1, "You dont have that many drungs!");
            }
            if(!HealSlowly(playerid, drugs * 5)) {
                return SendClientMessage(playerid, -1, "You cant take anymore drugs at the moment!");
            }
            SetPlayerDrugs(playerid, GetPlayerDrugs(playerid) - drugs);
            ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.2, 0, 0, 0, 0, 0, 1);
            return SendClientMessage(playerid, 0xFF0000AA, "You are on drugs, health refilling!");
        }
    }
    return false;
}
*/
/*
forward HealSlowly(playerid, time);
public HealSlowly(playerid, time) {
    new
        Float: health
    ;
    if(GetPlayerHealth(playerid, health)) {
        SetPlayerHealth(playerid, ++health);

        if(time-- && (health < 100.0)) {
            SetTimerEx("HealSlowly", 666, false, "ii", playerid, time);
        }
    }
}

main() {
	HealSlowly(0, 30);
}
*/
/*
new
	vehicleid
;

main() {
	new
		Float: X, Float: Y, Float: Z
	;
	GetPlayerPos(0, X, Y, Z);

	vehicleid = CreateVehicle(522, X, Y, Z, 0.0, -1, -1, -1);
	vehicleid = CreateVehicle(522, X + 5.0, Y + 5.0, Z, 0.0, -1, -1, -1);
}

public OnRconCommand(cmd[]) {
	if(strcmp(cmd, "rot", true) == 0) {
		new
			Float: A
		;
		GetVehicleZAngle(vehicleid, A);
		return SetVehicleZAngle(vehicleid, A + 3.6);
	}
	return false;
}

unload() {
	DestroyVehicle(vehicleid - 1);
	DestroyVehicle(vehicleid);
}
*/
/*
#include <ssmoney2>

main() {
//	SetPlayerMoney(0, 5);
	GivePlayerMoney(0, 10);
//	GetPlayerMoney(0);
//	ResetPlayerMoney(0);
}
*/
/*
forward _SafeReturnCode_(dest[], src[], bytes);

public _SafeReturnCode_(dest[], src[], bytes)
{
    memcpy(dest, src, 0, bytes, bytes);
}

stock SafeReturnCode(const src[], const bytes = sizeof (src))
{
    // Push the lengths for the memcpy (needs "pri", so done first).
    #emit LOAD.S.pri    bytes
    #emit SHL.C.pri     2
    #emit PUSH.pri
    #emit PUSH.pri
   
    // Get the parameter count.
    #emit LOAD.S.pri    0
    #emit MOVE.alt
    #emit ADD.C         8
    #emit LOAD.I
   
    // Get the desination pointer.
    #emit ADD
    #emit ADD.C         12
    #emit LOAD.I
   
    // Do a raw memcpy (pointer to pointer, not array to array).
    #emit PUSH.C        0
    #emit PUSH.S        src
    #emit PUSH.pri
    #emit PUSH.C        20
    #emit SYSREQ.C      memcpy
   
    // Return to the caller's caller.
    #emit MOVE.pri
    #emit SCTRL         5
    #emit SCTRL         4
    #emit RETN
   
    // Compiler cleanup.
    return 0;
}

#define safe_return%0; return SafeReturnCode(%0),(%0);

Crash(...)
{
    new str[256] = "Hello, this is the return";
    //safe_return str;
    return str;
}

main()
{
    new str2[256];
    str2 = Crash(1, 2, 3, 4, "hello", 42);
    printf("str2 = %s", str2);
}
*/
/*
#define PRICE_BAT 11500
#define EMBED: #

new gWeaponPrice[][] = {
	{11500, "11500"},
	{11501, "11501"}
};

main() {
	printf("%d \"%s\"", gWeaponPrice[0][0], gWeaponPrice[0][1]);
	printf("%d \"%s\"", gWeaponPrice[1][0], gWeaponPrice[1][1]);

	print("Baseball Bat - $" EMBED:PRICE_BAT);
}
*/
/*
main() {
	printf("%d", 5 / 2 * 3);
}
*/
/*
stock Seperator1() { static Text: TextDraws[3][MAX_PLAYERS]; }
stock Seperator2() { static Text: TextDraws[MAX_PLAYERS][3]; }

main() {
//	Seperator1();
	Seperator2();
}
*/
/*
enum E_PLAYER_STATS // Percentages (between 0 - 100)
{
        Float:pStat_fat,
        Float:pStat_stamina,
        Float:pStat_muscle,
        Float:pStat_respect,
        Float:pStat_sexappeal,
		pStat_integer
};
 
new PlayerStats[MAX_PLAYERS][E_PLAYER_STATS];

#define ChangePlayerStat(%0,%1,%2) ChangePlayerStat2(%0,%1,(PlayerStats[%0][%1] += %2))

ChangePlayerStat2(playerid, E_PLAYER_STATS: stat, {_, Float}: var, const tag = tagof var) {
	switch(tag) {
		case ( tagof  Float: ): {
			if(Float: var > 100.0) var = _: 100.0;
			if(Float: var < 0.0) var = _: 0.0;
		}
		case ( 0 ): {
			if(var > 100) var = 100;
			if(var < 0) var = 0;
		}
	}
	PlayerStats[playerid][stat] = var;
	return tag;
}
*/
/*
ChangePlayerStat(playerid, E_PLAYER_STATS:stat, {_, Float}: amount, const tag = tagof stat) {
	new
		var = PlayerStats[playerid][stat]
	;
	switch(tag) {
		case ( tagof  Float: ): {
			printf("%f", var);

			floatadd(var, amount);
	
			printf("%f", var);

			if(floatcmp(var, 100.0) == 1) var = _: 100.0;
			printf("%f", var);
			if(floatcmp(var, 0.0) == -1) var = _: 0.0;
			printf("%f", var);
		}
		case ( 0 ): {
			var += amount;

			if(var > 100) var = 100;
			if(var < 0) var = 0;
		}
	}
	PlayerStats[playerid][stat] = var;
}

stock PrintPlayerRespect(playerid) printf("pStat_respect = %.2f", PlayerStats[playerid][pStat_respect]);
 
main()
{
//	printf("'%d' '%d' '%d'", ( tagof Float:), ( tagof _: ), ( tagof E_PLAYER_STATS ));

//	printf("'%d'", ChangePlayerStat(0, pStat_respect, 69.0));

	ChangePlayerStat(0, pStat_respect, 69);
	ChangePlayerStat(0, pStat_integer, 5.0);

    PrintPlayerRespect(0);
}
*/
/*
main() {
	print(randomString());
}

stock randomString(length = 10) {
	new
		rand
	;
    while(0 < --length) {
		rand = random(26) + (random(2) ?  'a' : 'A');

		#emit push.s rand
	}
	#emit stack 0
	#emit stor.s.alt 16

	rand = 0;

	#emit lctrl 5
	#emit sctrl 4

	#emit retn

	new
		str[1]
	;
    return str;
}
*/
/*
#define MAX_CONTACTS    (20)

enum e_Contacts
{
	ContactNumber,
	ContactName[32],
}

new Contact[MAX_PLAYERS][MAX_CONTACTS][e_Contacts];

main() {
	const
		playerid = 0
	;
    for(new i, text[32] = "None"; i < sizeof Contact[]; i++) {
        Contact[playerid][i][ContactName] = text;
        Contact[playerid][i][ContactNumber] = 0;
    }
    new
        str[MAX_CONTACTS * 38] = "Lisa uus kontakt"
    ;
    for(new i; i < sizeof Contact[]; i++) {
        format(str, sizeof str, "%s\n%s (%d)", str, Contact[playerid][i][ContactName], Contact[playerid][i][ContactNumber]);
    }
//    TELEFON_valik[playerid] = 10;
	print(str);
//    ShowPlayerDialog(playerid, DIALOG_TELEFON, DIALOG_STYLE_LIST, "Telefon (Kontaktid)", str, "Vali", "Katkesta");
}
*/
/*
main() {
	OC1_SendClientMessage(0, 0xFF00FFFF, "Hello {FF0000}World{/}!");
	OC2_SendClientMessage(0, 0xFF00FFFF, "Hello {FF0000}World{/}!");
}

stock OC1_SendClientMessage(playerid, colour, str[])
{
    static const
        chars[] = "0123456789ABCDEF";
    new
        send[144],
        ins0[6],
        ins1 = chars[(colour >>> 8) & 0x0F];
    format(ins0, sizeof (ins0), "%05x", colour >>> 12),
    strcat(send, str);
    for (new pos; ; )
    {
        pos = strfind(send, "{/}", false, pos);
        if (pos == -1) break;
        strins(send, ins0, pos + 1),
        send[pos + 6] = ins1;
    }
	printf("{%06x}%s", colour >>> 8, send);
//    return SendClientMessage(playerid, colour, send);
}

stock OC2_SendClientMessage(playerid, colour, str[])
{
    new
        send[144],
        ins[7]
	;
    format(ins, sizeof (ins), "%06x", colour >>> 8);
	ins[6] = ins[5];
	ins[5] = EOS;
    strcat(send, str);
    for (new pos; ; )
    {
        pos = strfind(send, "{/}", false, pos);
        if (pos == -1) break;
        strins(send, ins, pos + 1);
        send[pos + 6] = ins[6];
    }
	printf("{%06x}%s", colour >>> 8, send);
//    return SendClientMessage(playerid, colour, send);
}
*/
/*

	Circle = (A_X / A_Y) + (cos(a) / sin(a)) * radius
	Line = (B_X / B_Y) + (C_X - B_X / C_Y - B_Y) * y

	Circle = Line

	(A_X / A_Y) + (cos(a) / sin(a)) * radius = (B_X / B_Y) + (C_X - B_X / C_Y - B_Y) * y

	1)

	A_X + cos(a) * radius = B_X + (C_X - B_X) * y
	y = (A_X + cos(a) * radius - B_X) / (C_X - B_X)

	2)

	A_Y + sin(a) * radius = B_Y + (C_Y - B_Y) * y
	A_Y + sin(a) * radius = B_Y + (C_Y - B_Y) * (A_X + cos(a) * radius - B_X) / (C_X - B_X)
	A_Y + sin(a) * radius - B_Y = (C_Y - B_Y) * (A_X - B_X) / (C_X - B_X) + ((C_Y - B_Y) * cos(a) * radius) / (C_X - B_X)
	- B_Y - (C_Y - B_Y) * (A_X - B_X) / (C_X - B_X) = ((C_Y - B_Y) * cos(a) * radius) / (C_X - B_X) - A_Y + sin(a) * radius
	- B_Y - (C_Y - B_Y) * (A_X - B_X) / (C_X - B_X) = ((C_Y - B_Y) * cos(a) * radius) - (A_Y + sin(a) * radius) * (C_X - B_X)  / (C_X - B_X)
	- B_Y - (C_Y - B_Y) * (A_X - B_X) / (C_X - B_X) = (C_Y * cos(a) * radius - B_Y * cos(a) * radius - A_Y * C_X + A_Y * B_X - sin(a) * radius * C_X + sin(a) * radius * B_X) / (C_X - B_X)
	- B_Y - (C_Y - B_Y) * (A_X - B_X) / (C_X - B_X) = (radius * (C_Y * cos(a) - B_Y * cos(a) - sin(a) * C_X + sin(a) * B_X) + A_Y * (B_X - C_X)) / (C_X - B_X)
	(- B_Y - (C_Y - B_Y) * (A_X - B_X) / (C_X - B_X)) * (C_X - B_X) = (radius * (C_Y * cos(a) - B_Y * cos(a) - sin(a) * C_X + sin(a) * B_X) + A_Y * (B_X - C_X))
	-(B_Y * (C_X - B_X) + (C_Y - B_Y) * (A_X - B_X)) = (radius * (C_Y * cos(a) - B_Y * cos(a) - sin(a) * C_X + sin(a) * B_X) + A_Y * (B_X - C_X))
	radius * (cos(a) * (C_Y - B_Y) + sin(a) * (B_X - C_X)) = B_Y * (B_X - C_X) + (B_Y - C_Y) * (A_X - B_X) + A_Y * (C_X - B_X)
	radius = (B_Y * (B_X - C_X) + (B_Y - C_Y) * (A_X - B_X) + A_Y * (C_X - B_X)) / (cos(a) * (C_Y - B_Y) + sin(a) * (B_X - C_X))

*/

/*
main() {
	new
		tmp[1]
	;
	format(tmp, sizeof tmp, "");

	printf2("%s (%d) color is 0x%06x (%f)", "Shisk", "2", 0xFF0000, 5.0);
}

printf2(form[], { Float, _ }:...) {
	new
		string[128]
	;
	showStack();

	sformat(string, sizeof string, form, 2);

	showStack();

	print(string);
}

stock showStack() {
	new
		stack
	;
	#emit lctrl 5
	#emit add.c 4
	#emit stor.s.pri stack

	printf("stack %d", stack);
}

stock iformat(output[], len, form[], start) {
	new
		end,
		args
	;
	#emit load.s.alt 0
	#emit load.s.pri start
	#emit shl.c.pri 2
	#emit add
	#emit add.c 4
	#emit stor.s.pri start
	#emit add.c 8
	#emit load.i
	#emit add
	#emit add.c 8
	#emit stor.s.pri end
	#emit load.s.alt start
	#emit sub
	#emit add.c 12
	#emit stor.s.pri args

	while(start < end) {
		#emit lref.s.pri end
		#emit push.pri

		end -= 4;
	}
	#emit push.s form
	#emit push.s len
	#emit push.s output
	#emit push.s args
	#emit sysreq.c format

	#emit lctrl 4
	#emit load.s.alt args
	#emit add
	#emit add.c 12
	#emit sctrl 4
	#emit retn
}

stock sformat(output[], len, form[], start) {
	#pragma unused output, len, form

	new
		tmp[4],
		stack,
		addr
	;
	showStack();

	#emit lctrl 4
	#emit stor.s.pri stack

	#emit load.s.alt start
	#emit shl.c.alt 2
	#emit stor.s.alt start

	#emit load.s.pri 0
	#emit add.c 8
	#emit load.i
	#emit sub
	#emit add.c 16
	#emit stor.s.pri 8

	#emit load.s.alt 0
	#emit load.s.pri start
	#emit add
	#emit add.c 0xFFFFFFF8 // -8
	#emit stor.s.pri addr

	#emit addr.alt tmp
	#emit movs 16
	#emit move.alt
	#emit addr.pri 8
	#emit movs 16

	#emit move.pri
	#emit sctrl 4

//	#emit sysreq.c format

	#emit load.s.pri stack
	#emit sctrl 4

	for(new i = addr, j; i != (addr + 32); i += 4) {
		#emit lref.s.pri i
		#emit stor.s.pri j

		printf("%d - %d", i, j);
	}

	#emit addr.pri tmp
	#emit load.s.alt addr
	#emit movs 16

	#emit const.pri 16
	#emit stor.s.pri 8

	showStack();
}
*/
/*
#include <sscanf2>

main() {
	new
		id
	;
	printf("%d %d", id, sscanf("10 Model: Turismo", "i", id));
}
*/
/*
main() {
	new
		i = -1,
		count,
		tmp[16],
		File: tFile
	;
	while(++i != 16) {
		format(tmp, sizeof tmp, "test_%d.ini", i);

		if((tFile = fopen(tmp, io_write))) {
			fclose(tFile);
		}
	}
	do {
        format(tmp, sizeof tmp, "test_%d.ini", count++);
    } while(fexist(tmp));

	while(i-- != -1) {
		format(tmp, sizeof tmp, "test_%d.ini", i);

		fremove(tmp);
	}

	printf("Files %d", count);
}
*/
/*
enum E_EG
{
    E_EG_NUM,
    E_EG_STR[10],
}

main()
{
    // Part 1.
    new eg[E_EG] = {42, "hi"};
    printf("1) %s %d", eg[E_EG_STR], sizeof (eg[E_EG_STR]));
    printf("2) %s %d", eg[E_EG_STR][0], sizeof (eg[E_EG_STR]));
    func(eg[E_EG_STR]);
    printf("3) %d", eg[E_EG:2]);
    printf("4) %d", eg[E_EG_STR + E_EG:1]);
    printf("5) %d", _:E_EG_STR);
    // Part 2.
    new eg2[10] = "hi";
    printf("6) %s %d", eg2[0], sizeof (eg2[]));
    func(eg2[0]);
    // Part 3.
    new eg3[10][E_EG];
    printf("7) %s", eg3[0][E_EG_STR]);
    func(eg3[5][E_EG_STR]);
}

func(data[], size = sizeof (data))
{
    printf("F) %s %d", data, size);
}
*/
/*
main() {
	new
		delimiter[10] = {'-', ...},
		text[] = {'H', 'e', 'l', 'l', 'o'},
		countdown[15] = {1, 2, 3, ...},
		empty[5]
	;
}
*/
/*
stock
	gText[] = !"\
		Hello World\n\
		How are you?\n\
		Booo!"
;

main() {
	printf(gText);
	print(gText);

	ShowPlayerDialog(0, 0, 0, "Hi", gText, "Okay", "Cancel");
}
*/
/*
main() {
//CMD:admins(playerid, params[]) {
    new
        i,
        count
    ;
    while(i < MAX_PLAYERS) {
        if(IsPlayerAdmin(i)) {
            count++;
        }
        i++;
    }
	static
		text[32] = "Administrators online: "
	;
	valstr(text[23], count, false);

	print(text);
//    return SendClientMessage(playerid, 0x33FF33AA , tmp);
//}
}
*/
/*
#include <MapAndreas>

main() {
	MapAndreas_Init(2);
}

new
	bool: pShooting[MAX_PLAYERS],
	pWeapon[MAX_PLAYERS],
	pAmmo[MAX_PLAYERS]
;

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	#define KEY_AIMFIRE (132)
 
	if((newkeys & KEY_AIMFIRE == KEY_AIMFIRE) && (oldkeys & KEY_AIMFIRE != KEY_AIMFIRE)) {
		pShooting[playerid] = true;
	}
	if((oldkeys & KEY_AIMFIRE == KEY_AIMFIRE) && (newkeys & KEY_AIMFIRE != KEY_AIMFIRE)) {
		pShooting[playerid] = false;
	}
	return true;
}

public OnPlayerDisconnect(playerid, reason) {
	pShooting[playerid] = false;
	return true;
}

public OnPlayerUpdate(playerid) {
	new
		weapon = GetPlayerWeapon(playerid),
		ammo = GetPlayerAmmo(playerid)
	;
	if(weapon != pWeapon[playerid]) {
		pWeapon[playerid] = weapon;
		pAmmo[playerid] = ammo;
	}
	if(pShooting[playerid]) {
		if(1 <= GetPlayerWeaponState(playerid) <= 2) {
			if(pAmmo[playerid] != ammo) {
				for(new i = pAmmo[playerid] - ammo; i > 0; --i) {
					Shooting(playerid);
				}
				pAmmo[playerid] = ammo;
			}
		}
	}
	return true;
}

Shooting(playerid) {
	static
		Float: vZ,
		Float: cX,
		Float: cY,
		Float: cZ,
		Float: pS,
		Float: pC,
		Float: tX,
		Float: tY,
		Float: tZ,
		Float: mZ,
		bool: col
	;
	GetPlayerCameraFrontVector(playerid, vZ, vZ, vZ);
	GetPlayerCameraPos(playerid, cX, cY, cZ);
	GetPlayerFacingAngle(playerid, pC);

	vZ += 0.08;

	pS = floatsin(-pC, degrees);
	pC = floatcos(-pC, degrees);

	MapAndreas_FindZ_For2DCoord(cX, cY, mZ);

	col = (cZ < mZ);

	for(new Float: i; i < 150.0; i += 0.25) {
		tX = cX + i * pS;
		tY = cY + i * pC;
		tZ = cZ + i * vZ;

		MapAndreas_FindZ_For2DCoord(tX, tY, mZ);

		if((mZ < tZ) == col) {
			i -= 0.25;

			tX = cX + i * pS;
			tY = cY + i * pC;
			tZ = cZ + i * vZ;
			break;
		}
	}
	CreateExplosion(tX, tY, tZ, 2, 5.0);
}
*/
/*
public OnRconCommand(cmd[]) {
    if(cmd[0] == '/') {
        if(strcmp(cmd, "/asay", true, 5) == 0) {
            static
                usage[] = "[USAGE] /asay [text]"
            ;
            if(cmd[5] == EOS) {
                return !print(usage);
            }
            if(cmd[5] == ' ') {
                if(cmd[6] == EOS) {
                    return !print(usage);
                }
                static
                    replace[] = "Rcon:"
                ;
                #emit const.pri replace
                #emit load.s.alt cmd
                #emit movs 20

                return print(cmd), SendClientMessageToAll(0x00FF00, cmd);
            }
        }
    }
    return false;
}
*/
/*
nTest(3x1000000) {
	new
		Year,
		YearE = 1,
		Month,
		MonthE,
		Day,
		DayE,
		Hour,
		HourE,
		Minute,
		MinuteE
	;
	Test("Relational") {
		if(
			(Year > YearE) ||
			(Year == YearE) && (
				(Month > MonthE) ||
				(Month == MonthE) && (
					(Day > DayE) ||
					(Day == DayE) && (
						(Hour > HourE) ||
						(Hour == HourE) && (
							(Minute > MinuteE)
						)
					)
				)
			)
		) {}
	}
	Test("Arithmetic 1") {
		if((Minute + ((Hour + ((Day + ((Month + (Year * 12)) * 30)) * 24)) * 60)) >= (MinuteE + ((HourE + ((DayE + ((MonthE + (YearE * 12)) * 30)) * 24)) * 60))) {	}
	}
	Test("Arithmetic 2") {
		if((Minute * 60 + Hour * 3600 + Day * 86400 + Month * 2592000 + Year * 31104000) >= (MinuteE * 60 + HourE * 3600 + DayE * 86400 + MonthE * 2592000 + YearE * 31104000)) {	}
	}
	Test("Statements") {
		if(Year > YearE) {}
		else if(Year == YearE) {
			if(Month > MonthE) {}
			else if(Month == MonthE) {
				if(Day > DayE) {}
				else if(Day == DayE) {
					if(Hour > HourE) {}
					else if(Hour == HourE) {
						if(Minute > MinuteE) {}
					}
				}
			}
		}
	}
}
*/
/*
stock GetTextFromAddress(address) {
	#emit load.s.pri address
	#emit stor.s.pri 16
	#emit retn

	new
		tmp[1]
	;
	return tmp;
}

main() {
	new
		text[] = "Hello World",
		addr
	;
	#emit addr.pri text
	#emit stor.s.pri addr

	print(GetTextFromAddress(addr));
}
*/
/*
enum e_MEMORY_LOAD
{
    e_MEMORY_LOAD_ADDRESS[1]
}

new
    gData[32] = {100, 99, ...},
    gMemory[e_MEMORY_LOAD];

public OnFilterScriptInit()
{
    // Include the array.
    printf("Load Data", gData);
    new
        addr[1];
    for (new i = 0; i != 32; ++i)
    {
        gMemory[e_MEMORY_LOAD_ADDRESS] = i * 4;
        addr = gMemory[e_MEMORY_LOAD_ADDRESS];
        printf("%d = %d", i, addr[0]);
    }
}*/

/*
main()
{
    new
        a = 10
    ;
    while(a-- > 0) {
        printf("%d", a);
    } 
}
*/
/*
main() {
    static
        init = false,
        str1[] = "\n {FFEF0E}[LIVELLO 1:]{FFFFFF} /trova - /goto - /gethere - /spec - /specoff - /muta - /smuta - /blocca - /sblocca - /warn - /ajail - /kick - /ban - /fakeban",
        str2[] = "              /autokill - /slap - /gotobiz - /gotocasa - /gotozonagang - /gotobuilding - /bloccorapinab - /bloccorapinac - /autoclan - /fixveh - /fly",
        str3[] = "              /settaskin - /settamondovirtuale  - /settainterior - /ao - /cc - /maschere - /vehlist(2-3) - /ricaricarapine - /auto - /baseadmin - /cnnn",
        str4[] = " {FFEF0E}[LIVELLO 2:]{FFFFFF} /gotaauto - /gotoauto - /ascoltachat - /settalicenza - /trovaarmi - /rimuoviarmi - /prison - /unprison - /count",
        str5[] = " {FFEF0E}[LIVELLO 3:]{FFFFFF} /listafazioni - /respawn - /sbannaip",
        str6[] = " {FFEF0E}[LIVELLO 4:]{FFFFFF} /setta(ora, vita, armatura, prodotti, materiali, droga) - /esplodi",
        str7[] = " {FFEF0E}[LIVELLO 5:]{FFFFFF} /entraauto - /settamoneta - /settasoldi - /settaarma - /riempiautobenzina - /kickff - /kickaclan - /resettacell",
        str8[] = " {FFEF0E}[LIVELLO 6:]{FFFFFF} ",
        str9[] = " {FFEF0E}[LIVELLO 7:]{FFFFFF} /sbanna - /donatore - /settameteo - /apritutteauto - /costohq - /vendihq - /comandibizadmin - /comandicasaadmin",
        str10[] = " {FFEF0E}[LIVELLO 8:]{FFFFFF} ",
        str11[] = " {FFEF0E}[LIVELLO 9:]{FFFFFF} ",
        str12[] = " {FFEF0E}[LIVELLO 10:]{FFFFFF} /payday - /resetlotto - /evento - /regalasoldi - /kicktutti - /settameteo - /settacapofazione - /settahelper - /settaadmin",
        str13[] = "               /settastats - /gotofazione - /cambianome - /cambianumero - /accendiveicolo - /creahq - /gotohq - /creazonagang - /vendizonagang",
        str14[] = "               /comandibuildingadmin - /comandilavoriadmin - /comandifazioneadmin - /comandibizadmin - /comandiautoadmin - /comandicasaadmin",
        str15[] = "               /concessionario - /postoconcessionario - /postobanca"
    ;
    if(!init) {
        init = true;

        str1[sizeof str1 - 1] = '\n';
        str2[sizeof str2 - 1] = '\n';
        str3[sizeof str3 - 1] = '\n';
        str4[sizeof str4 - 1] = '\n';
        str5[sizeof str5 - 1] = '\n';
        str6[sizeof str6 - 1] = '\n';
        str7[sizeof str7 - 1] = '\n';
        str8[sizeof str8 - 1] = '\n';
        str9[sizeof str9 - 1] = '\n';
        str10[sizeof str10 - 1] = '\n';
        str11[sizeof str11 - 1] = '\n';
        str12[sizeof str12 - 1] = '\n';
        str13[sizeof str13 - 1] = '\n';
        str14[sizeof str14 - 1] = '\n';
        str15[sizeof str15 - 1] = EOS;
    }
	print(str1);
}
*/
/*
enum eTest {
	pString1[128],
	pString2[128]
};

new TEST[3][eTest] =
{
	{"This is a test i have named as A1", "This is a test i have named as B1"},
	{"This is a test i have named as A2", "This is a test i have named as B2"},
	{"This is a test i have named as A3", "This is a test i have named as B2"}
}

stock const TEST_ARRAY[][][] = {
	{
		"This is a test i have named as 1-A1", "This is a test i have named as 1-B1",
		"This is a test i have named as 1-A2", "This is a test i have named as 1-B2",
		"This is a test i have named as 1-A3", "This is a test i have named as 1-B2"
	}, {
		"This is a test i have named as 2-A1", "This is a test i have named as 2-B1",
		"This is a test i have named as 2-A2", "This is a test i have named as 2-B2",
		"This is a test i have named as 2-A3", "This is a test i have named as 2-B2"
	}, {
		"This is a test i have named as 3-A1", "This is a test i have named as 3-B1",
		"This is a test i have named as 3-A2", "This is a test i have named as 3-B2",
		"This is a test i have named as 3-A3", "This is a test i have named as 3-B2"
	}
};

main()
{

        // This works at expected
	for (new i=0; i<sizeof(TEST_ARRAY); i++) {
 		printf("%s <--> %s", TEST[i][pString1], TEST[i][pString2]);
	}
	
	printf("----");
	printf("");
	printf("----");

       // In this prints strings are not completes :S Why?
	for(new i, j; i < sizeof TEST_ARRAY; ++i) {
	    for(j = 0; j < sizeof TEST_ARRAY[]; j += 2) {
	        printf("%s <--> %s", TEST_ARRAY[i][j], TEST_ARRAY[i][j + 1]);
	    }
	}
}
*/
/*
#define COLOR_RED 0xFF0000FF

stock
    PlayerText3D: gPlayerVehicleLabel[MAX_PLAYERS][MAX_VEHICLES + 1]
;
public OnVehicleStreamIn(vehicleid, forplayerid) {
    new
        tmp[16],
        Float: health
    ;
    GetVehicleHealth(vehicleid, health);
    format(tmp, sizeof tmp, "%.0f", health);
    gPlayerVehicleLabel[forplayerid][vehicleid] = CreatePlayer3DTextLabel(forplayerid, tmp, COLOR_RED, 0.0, 0.0, 0.0, 50, INVALID_PLAYER_ID, vehicleid, 0);
    gPlayerVehicleLabel[forplayerid][0]++;
    return true;
}
public OnVehicleStreamOut(vehicleid, forplayerid) {
    DeletePlayer3DTextLabel(forplayerid, gPlayerVehicleLabel[forplayerid][vehicleid]);
    gPlayerVehicleLabel[forplayerid][vehicleid] = PlayerText3D: INVALID_3DTEXT_ID;
    gPlayerVehicleLabel[forplayerid][0]--;
    return true;
}
main() {
// OnGameModeInit
    SetTimer("UpdatePVLabel", 1000, true);

    for(new i, v; i != sizeof gPlayerVehicleLabel; ++i) {
        gPlayerVehicleLabel[i][0] = PlayerText3D: 0;

        for(v = 1; v != sizeof gPlayerVehicleLabel[]; ++v) {
            gPlayerVehicleLabel[i][v] = PlayerText3D: INVALID_3DTEXT_ID;
        }
    }
}
forward UpdatePVLabel();
public UpdatePVLabel() {
    new
        i,
        v,
        tmp[16],
        Float: health
    ;
    for(; i != sizeof gPlayerVehicleLabel; ++i) {
        if(gPlayerVehicleLabel[i][0]) {
            for(v = 1; v != sizeof gPlayerVehicleLabel[]; ++v) {
                if(gPlayerVehicleLabel[i][v] != PlayerText3D: INVALID_3DTEXT_ID) {
                    GetVehicleHealth(v, health);
                    format(tmp, sizeof tmp, "%.0f", health);
                    UpdatePlayer3DTextLabelText(i, gPlayerVehicleLabel[i][v], COLOR_RED, tmp);
                }
            }
        }
    }
}
*/
/*
public OnRconCommand(cmd[]) {
	#define SendClientMessage(%0,%1,%2) !print(%2)

    if(strcmp("/tcolor", cmd, true, 7) == 0) {
        static const
            sUsage[] = "USE: /tcolour [COLOR(Example. 0xFFFF00AA)]"
        ;
        if(cmd[7] == EOS) {
            return SendClientMessage(playerid, 0xE6000055, sUsage);
        }
        if(cmd[7] == ' ') {
            if(sscanf(cmd[8], "x", cmd)) {
                return SendClientMessage(playerid, 0xE6000055, sUsage);
            }
			printf("0x%x", cmd[0]);
			return true;
//            return SetPlayerColor(playerid, cmdtext[0]);
        }
    }
	return false;
}
*/
/*
new
	Global[128]
;

nTest(3x10000000) {
	Test("Global") {
		format(Global, sizeof Global, "Hello World");
		format(Global, sizeof Global, "Hello World");
	}
	Test("Local") {
		new
			Local[128]
		;
		format(Local, sizeof Local, "Hello World");
		format(Local, sizeof Local, "Hello World");
	}
}
*/
/*
main() {
	enum PIENUM { pVIP }
	new PlayerInfo[1][PIENUM], playerid;

	new Float: InterestRate;
	//Interest Rates
	if(PlayerInfo[playerid][pVIP] == 0)
	{
		InterestRate = 0.01;
	}
	else if(PlayerInfo[playerid][pVIP] == 1)
	{
		InterestRate = 0.015;
	}
	else if(PlayerInfo[playerid][pVIP] == 2)
	{
		InterestRate = 0.02;
	}
	else if(PlayerInfo[playerid][pVIP] == 3)
	{
		InterestRate = 0.03;
	}
	else
	{
		InterestRate = 0.01;
	}
	printf("Interest1: %.3f", InterestRate);  
}*/

/*
stock dcmd_stats(playerid, params[]) {
    #pragma unused params

    static const
        YesNo[][] = { "Yes", "No" },
        form[] = "\
            Army: %s\n\
            CIA: %s\n\
            Regular Player: %s\n\
            Admin Level: %d\n\
            Jailtime: %d\n\
            Wanted Level: %d\n\
            C4 Packs: %d\n\
            Ropes: %d\n\
            Cash: $%d\n\
            BankCash: $%d\n\
            Rob Level: %d\n\
            Terrorist Level: %d\n\
            Heroin Injections: %d\ n\
            Weed Grams: %d"
    ;
    new
        string[512]
    ;
    format(string, sizeof string, form
        , YesNo[(CanUseArmy[playerid] == 1337)]
        , YesNo[(CanUseCIA[playerid] == 1337)]
        , YesNo[(IsRegularPlayer[playerid] == 1337)]
        , AdminLevel[playerid]
        , JailTime[playerid]
        , GetPlayerWantedLevel(playerid)
        , HasC4[playerid]
        , HasRope[playerid]
        , GetPlayerMoney(playerid)
        , BankCash[playerid]
        , RobSkill[playerid]
        , TerroristSkill[playerid]
        , HasHeroin[playerid]
        , HasWeed[playerid]
    );
    return ShowPlayerDialog(playerid, DIALOG_COMMANDS, DIALOG_STYLE_MSGBOX, "Status", string, "Close", "");
}

main() {
	dcmd_stats(0, "Hello");
}
*/
/*
#define GameTextForPlayer(%0,%1, printf(%1,%0,

forward CountDownRobbery(playerid, time, & timer);
public CountDownRobbery(playerid, time, & timer) {
    if(time < 1) {
        GameTextForPlayer(playerid, "~r~Robbery complete", 2500, 1);
    } else {
        new
            str[128]
        ;
        format(str, sizeof str, "%d seconds remaining~n~~r~Do not move until the~n~Robbery is completed", time);
        GameTextForPlayer(playerid, str, 1000, 1);

        new
            address
        ;
        #emit load.s.pri timer
        #emit stor.s.pri address

        timer = SetTimerEx("CountDownRobbery", 1000, false, "iii", playerid, --time, address);
    }
}

public OnRconCommand(cmd[]) {
	if(strcmp("/rob", cmd, true) == 0) {
		static
			MyTimer = -1
		;
		if(MyTimer == -1) {
			CountDownRobbery(0, 30, MyTimer);
		} else {
			KillTimer(MyTimer);
			MyTimer = -1;
		}
		return true;
	}
	return false;
}
*/
/*
stock const VehicleNames[][] = {  "Landstalker", "Bravura", "Buffalo" };

stock IsValidVehicleName(vehicleid) {
    if((vehicleid = GetVehicleModel(vehicleid))) {
        return VehicleNames[vehicleid - 400];
    }
    static Empty[1] = EOS;

    return Empty;
}

main() {
	GetVehicleName(0);
}
*/

/*
stock rocketVeh[7] = { 0, 1, 2, 3, ... };

stock GetRocketVehIDv1(vehicleid) {
    for(new i = 0; i != sizeof rocketVeh; i++) {
        if(vehicleid == rocketVeh[i]) {
            return i;
        }
    }
    return -1;
}

stock GetRocketVehIDv2(vehicleid) {
    new
        i = sizeof rocketVeh
    ;
    while(i--) {
        if(vehicleid == rocketVeh[i]) {
            break;
        }
    }
    return i;
}

nTest(4x10000000) {
	static
		count,
		id[] = { 0, (sizeof rocketVeh / 2), (sizeof rocketVeh - 1), -1 }
	;
	new vehicleid = id[count++];

	printf("vehicleid %d", vehicleid);

	Test("GetRocketVehIDv1") {
		GetRocketVehIDv1(vehicleid);
	}
	Test("GetRocketVehIDv2") {
		GetRocketVehIDv2(vehicleid);
	}
}
*/
/*
// %0 - array | %1 - bits | %2 - index
#define NF_Array:%0<%1,%2> %0[NF_ArrayIdx(%1,%2)]
// %0 - bits | %1 - slot
#define NF_ArraySlot(%0,%1) ((%1)/(cellbits/(%0)))
// %0 - bits | %1 - slot |
#define NF_ArrayMask(%0,%1) (((%1)&((cellbits/(%0))-1))*(%0))
// %0 - bits | %1 - index
#define NF_ArrayIdx(%0,%1) (((%1)+(cellbits/(%0))-1)/(cellbits/(%0)))
// %0 - bits | %1 - slot | %2 - value
//#define NF_ArrayCheck(%0,%1,%2) (((%2)<<((cellbits-(%0))-NF_ArrayMask(%0,%1)))>>>(cellbits-(%0))) // dual shift
#define NF_ArrayCheck(%0,%1,%2) (((%2)>>>NF_ArrayMask(%0,%1))&((1<<(%0))-1)) // ryder's methode :)
// %0 - bits | %1 - array | %2 - slot | %3 - value | Around 3.2x slower than normal arrays
#define NF_ArraySet(%0,%1,%2,%3) (%1[NF_ArraySlot(%0,%2)]=(%1[NF_ArraySlot(%0,%2)]&~(NF_ArrayGet(%0,%1,%2)<<NF_ArrayMask(%0,%2)))|(NF_ArrayCheck(%0,0,%3)<<NF_ArrayMask(%0,%2)))
// %0 - bits | %1 - array | %2 - slot | Similar speed to normal arrays
#define NF_ArrayGet(%0,%1,%2) NF_ArrayCheck(%0,%2,%1[NF_ArraySlot(%0,%2)])

new NF_Array: bitArray<4, 200>;

main() {
	NF_ArraySet(4, bitArray, 2, 13);

	printf("%d", NF_ArrayGet(4, bitArray, 2));
}
*/
/*
stock VAR = 1;
const CONST = 2;
#define DEF 3

stock fByValue(var) {
	#pragma unused var

	#emit retn
}
stock fByReference(...) {
	#emit retn
}

nTest(3x100000000) {
	new
		var
	;
	#pragma unused var

	Test("const") {
		var = CONST;
	}
	Test("var") {
		var = VAR;
	}
	Test("def") {
		var = DEF;
	}
	Test("const by value") {
		fByValue(CONST);
	}
	Test("var by value") {
		fByValue(VAR);
	}
	Test("def by value") {
		fByValue(DEF);
	}
	Test("const by reference") {
		fByReference(CONST);
	}
	Test("var by reference") {
		fByReference(VAR);
	}
	Test("def by reference") {
		fByReference(DEF);
	}
}
*/
/*
native Freeze(playerid, bool: toggle = false) = TogglePlayerControllable;
native UnFreeze(playerid, bool: toggle = true) = TogglePlayerControllable;

public OnPlayerCommandText(playerid, cmdtext[]) {
	if(strcmp("/freeze", cmdtext, true) == 0) {
		return Freeze(playerid);
	}
	if(strcmp("/unfreeze", cmdtext, true) == 0) {
		return UnFreeze(playerid);
	}
	return false;
}
*/

/*
new
    arr1[3],
    arr2[4];

stock SetCell(array[], cell, value) {
	return (array[cell] = value);
}

main()
{
	arr2[0] = 0;

	SetCell(arr1, 3, 5);

	printf("%d", arr2[0]);
}
*/
/*
nTest(3x1000000) {
	new
		ret,
		r1 = random(2),
		r2 = random(2)
	;
	Test("Ternary") {
		ret = (r1 == r2) ? 1 : -1;
    }
	Test("if statment") {
		if(r1 == r2) {
			ret = 1;
		} else {
			ret = -1;
		}
    }
}
*/

/*
stock SetEOS(const array[], const delimiter = EOS, const size = sizeof array) {
	#emit load.s.pri size
	#emit add.c 0xFFFFFFFF
	#emit load.s.alt array
	#emit idxaddr
	#emit move.alt
	#emit load.s.pri delimiter
	#emit stor.i
}

stock const
	MyText1[] = "\
        9mm's - $250\n\
        Silenced 9mm - $500\n\
        SawnOff - $30000\n\
        Combat Shotgun - $1500\n\
        Micro UZIs - $2000\n\
        MP5 - $2500\n\
        AK47 - $3000\n\
        Country Rifle - $5000\n\
        Sniper Rifle - $15000\n\
        Armour - $20000\n\
        Flamethrower - $700000\n\
        Spraycan - $10000\n\
        Katana - $500\n\
        Tec9 - $400\n\
        Dildo - $5",
	MyText2[] = "\
        Baseball Bat - $1000\n\
        Flowers - $30\n\
        Satchel Charges - $300000\n\
        Grenades - $100000\n\
        Chainsaw - $15000\n\
        Fire Extinguisher - $15000\n\
        Rocket Launcher - $200000\n\
        Minigun - $500000"
;

main() {
	SetEOS(MyText1, '\n');
	SetEOS(MyText2);

	print(MyText1);	
}
*/

/*
main() {
    ShowPlayerDialog(0, 1, DIALOG_STYLE_LIST, "Weapon-Menu",
        "\
        9mm's - $250\n\
        Silenced 9mm - $500\n\
        SawnOff - $30000\n\
        Combat Shotgun - $1500\n\
        Micro UZIs - $2000\n\
        MP5 - $2500\n\
        AK47 - $3000\n\
        Country Rifle - $5000\n\
        Sniper Rifle - $15000\n\
        Armour - $20000\n\
        Flamethrower - $700000\n\
        Spraycan - $10000\n\
        Katana - $500\n\
        Tec9 - $400\n\
        Dildo - $5\n\
        Baseball Bat - $1000\n\
        Flowers - $30\n\
        Satchel Charges - $300000\n\
        Grenades - $100000\n\
        Chainsaw - $15000\n\
        Fire Extinguisher - $15000\n\
        Rocket Launcher - $200000\n\
        Minigun - $500000"
	, "OKAY", "CANCEL");

	ShowPlayerDialog(0, 1, DIALOG_STYLE_LIST, "Weapon-Menu",
		"9mm's - $250\nSilenced 9mm - $500\nSawnOff - $30000\nCombat Shotgun - $1500\nMicro UZIs - $2000\nMP5 - $2500\nAK47 - $3000\nCountry Rifle - $5000\nSniper Rifle - $15000\nArmour - $20000\nFlamethrower - $700000\nSpraycan - $10000\nKatana - $500\nTec9 - $400\nDildo - $5\nBaseball Bat - $1000\nFlowers - $30\nSatchel Charges - $300000\nGrenades - $100000\nChainsaw - $15000\nFire Extinguisher - $15000\nRocket Launcher - $200000\nMinigun - $500000"
	, "OKAY", "CANCEL");
}
*/

/*
enum pInfo
{
     ContactNumber[15], // 15 int variables made
     ContactName[15], // 15 string variables, (30 is lenght of string) but.. i get error(This is line 386)
}; //Line 387
new PlayerInfo[50][pInfo];

enum cInfo {
     ContactNumber,
     ContactName[30]
};
new ContactInfo[sizeof PlayerInfo][15][cInfo];

#define MAX_CONTACTS (sizeof ContactInfo[])

main() {
	printf("%d - %s", ContactInfo[0][0][ContactNumber], ContactInfo[0][0][ContactName]);
}*/

/*
stock GetClosestVehicle(playerid, & Float: distance = Float: 0x7F800000) {
    new
        i = GetPlayerVehicleID(playerid)
    ;
    if(i) {
        distance = 0.0;
        return i;
    }
    new
        Float: X,
        Float: Y,
        Float: Z
    ;
    if(GetPlayerPos(playerid, X, Y, Z)) {
        new
            Float: dis,
            closest = INVALID_VEHICLE_ID
        ;
        while(i != MAX_VEHICLES) {
            if(0.0 < (dis = GetVehicleDistanceFromPoint(++i, X, Y, Z)) < distance) {
                distance = dis;
                closest = i;
            }
        }
        return closest;
    }
    return INVALID_VEHICLE_ID;
}

stock GetClosestVehicleWithinRange(playerid, Float: range = Float: 0x7F800000, & Float: distance = 0.0) {
    return GetClosestVehicle(playerid, (distance = range, distance));
}

main() {
	GetClosestVehicleWithinRange(0);
}*/

/*
stock Float: GetPlayerDistanceFromPlayer(playerid, target) {
    new
        Float: X,
        Float: Y,
        Float: Z
    ;
    return GetPlayerPos(target, X, Y, Z) ? GetPlayerDistanceFromPoint(playerid, X, Y, Z) : 0.0;
}

stock Float: CheckTagFunc(Float: var) return var;

main() {
	CheckTagFunc(GetPlayerDistanceFromPlayer(0, 1));
}
*/

/*

native gpci (playerid, serial [], len); // this is the native.

public OnPlayerConnect(playerid) {
	new
		tmp[128]
	;
	GetPlayerIp(playerid, tmp, sizeof tmp);
	printf("%d - \"%s\"", strlen(tmp), tmp);
	gpci(playerid, tmp, sizeof tmp);
	printf("%d - \"%s\"", strlen(tmp), tmp);
	return true;
}
*/

/*
stock trim(text[]) {
	new
		i = strlen(text)
	;
	while(0 < --i) {
		if(' ' < text[i]) {
			for(text[i + 1] = EOS, i = 0; text[i] <= ' '; ++i) {}

			break;
		}
	}
	#emit stack 4

	#emit load.s.pri i
	#emit load.s.alt text
	#emit idxaddr
	#emit stor.s.pri 16
	#emit retn

	return text;
}

main() {
	new
		text[] = "    Hello World  \n\r  "
	;
	print(trim(text)); // correct
	print(text); // only the end cut off
}
*/
/*
#include <sscanf2>
#include <YSI\y_commands>

stock nCmd(const pattern[]) {
	if(pattern[0] != EOS) {
	}
	return 0;
}

#define TYPE(%0) _:TYPE_0:TYPE_1(%0)
#define TYPE_0:TYPE_1(%0[]) %0
#define TYPE_1(%0) %0

#define nCmd[%0]->%1(%2) stock d%1[] = %0; YCMD:%1(%2,params[],help) if(help) return h%1(%2); else if(sizeof d%1)) return i%1(%2); else
#define help[]->%0(%1) stock h%0(%1)
#define info[]->%0(%1) stock i%0(%1)

help[]->help(playerid) {
	return SendClientMessage(playerid, 0xFF0000FF, "<> Help");
}

info[]->help(playerid) {
	return SendClientMessage(playerid, 0xFF0000FF, "<> Help");
}

nCmd[""]->help(playerid) {
	return SendClientMessage(playerid, 0xFF0000FF, "<> Syntax: /slap [player name/id] [height] [reason]");
}
*/

/*
nCmd["uis(20)"]->slap(playerid, success, targetid, height, reason[20], help)
{
    height=10;
    reason="None";
    targetid=-1;
    if(!success)
    {
        if(targetid == -1)
        {
            return SendClientMessage(playerid, 0xFF0000FF, "<> Syntax: /slap [player name/id] [height] [reason]");
        }
    }
    new Float:X,Float:Y,Float:Z;
    GetPlayerPos(targetid,X,Y,Z);
    SetPlayerPos(targetid,X,Y,Z+height);
    return 1;
}
*/
/*
main() {
	new
		iID,
		szReason[64],
		params[] = "0 test"
	;
	if(!(sscanf(params, #us[64], iID, szReason))) {
		printf("%d - %s", iID, szReason);
	}
}*/
/*
// global
enum Team {
    BlueberryArmy,
    MontgomeryArmy,
    DillimoreArmy
}
stock
    Team: gTeam[MAX_PLAYERS] = {Team, ...}
;

// OnPlayerRequestClass
public OnPlayerRequestClass(playerid, classid) {
    switch(classid) {
        case 0..2: gTeam[playerid] = BlueberryArmy;
        case 3..5: gTeam[playerid] = MontgomeryArmy;
        case 6..8: gTeam[playerid] = DillimoreArmy;
    }
	return true;
}

// OnPlayerRequestSpawn
public OnPlayerRequestSpawn(playerid) {
    new
        i,
		tie,
        Team: biggest,
        count[Team + Team: 1]
    ;
    for( ; i != MAX_PLAYERS; ++i) {
        count[gTeam[i]]++;
    }
    for(i = 1; i < _: Team; ++i) {
		if((tie = count[biggest] / count[Team: i]) == 0) {
			biggest = Team: i;
		} else {
			tie = (count[biggest] == count[Team: i]);
		}
    }
    if((tie == 0) && (gTeam[playerid] == biggest)) {
        return !SendClientMessage(playerid, 0xFF0000FF, "[ERROR] Team full. Choose another team!");
    }
    return true;
}

// OnPlayerDisconnect
public OnPlayerDisconnect(playerid, reason) {
	gTeam[playerid] = Team;
	return true;
}
*/

/*
main() {
	new playerid, red, COLOR_YELLOW, params[1];
	#define isnull(%0) playerid

    static const
        Float: teleData[][] = {
            { -1935.985, 231.728, 34.1546 },
            { -2709.731, 217.423, 4.179 },
            { 2386.802, 1036.320, 10.280 },
            { 2644.976, -2030.903, 13.554 }
        }
    ;
    new
        tele
    ;
    if(isnull(params) || !(1 <= (tele = strval(params)) <= sizeof teleData)) {
        return
            SendClientMessage(playerid, red, " Usage: /tune [1-4] "),
            SendClientMessage(playerid, red, " FUNCTION: To Teleport To The Tune Garages ")
        ;
    }
    new
        tmp[128]
    ;
    GetPlayerName(playerid, tmp, MAX_PLAYER_NAME);
    format(tmp, sizeof tmp, "%s has just teleported to Tune %d /Tune %d", tmp, tele, tele);
    SendClientMessageToAll(COLOR_YELLOW, tmp);

    format(tmp, sizeof tmp, "~B~Welcome To ~r~Tune %d", tele);
    GameTextForPlayer(playerid, tmp, 3000, 4);

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
        SetVehiclePos(GetPlayerVehicleID(playerid), teleData[tele - 1][0], teleData[tele - 1][1], teleData[tele - 1][2]);
    } else {
        SetPlayerPos(playerid, teleData[tele - 1][0], teleData[tele - 1][1], teleData[tele - 1][2]);
    }
    return true;
}
*/
/*
public OnPlayerUpdate(playerid) {
    new
       vehicleid = GetPlayerVehicleID(playerid)
    ;
    if(vehicleid) {
        new
            tmp[32],
            Float: fDet,
            Float: fMul,
            Float: fPosX,
            Float: fPosY,
            Float: fPosZ
        ;
        GetVehicleVelocity(vehicleid, fPosX, fPosY, fPosZ);

        fDet = (fPosX * fPosX) + (fPosY * fPosY) + (fPosZ * fPosZ);
        fMul = floatpower((100.0 / 150.0), 2.0);

        if(fMul < fDet) {
            fMul /= fDet;

            SetVehicleVelocity(vehicleid, (fPosX * fMul), (fPosY * fMul), (fPosZ * fMul));
        }
        format(tmp, sizeof tmp, "Speed: %f", (150.0 * floatsqroot(fDet)));
        GameTextForPlayer(playerid, tmp, 500, 4);
    }
    return true;
}
*/
/*
main() {
	floatadd(0.0, 0.0);
	printf("", 0, 0, 0);

	new
		Float: var1 = 2.0,
		Float: var2 = 2.0
	;
	#emit push.s var1
	#emit push.s var2
	#emit push.c 8
	#emit sysreq.c floatadd
	#emit stack 12
	// print the value
	static const
		text[] = "%f - %d - 0b%b - 0x%x"
	;
	#emit move.alt
	#emit lctrl 4 // stack
	#emit push.alt

	#emit push.pri
	#emit push.pri
	#emit push.pri
	#emit push.pri
	#emit push.c text
	#emit push.c 20
	#emit sysreq.c printf
	#emit stack 28
}*/
/*
#include <pointers>

stock catstr(const delimiter, ...) {
	new
		arg
	;
	#emit load.s.pri	8
	#emit stor.s.pri	arg

	if(4 < arg) {
		if(8 < arg) { // alt = arg
			new
				first
			;
			#emit addr.pri		8
			#emit add
			#emit stor.s.pri	arg

			#emit addr.pri		16
			#emit stor.s.pri	first

			while(arg != first) {
				#emit lref.s.pri	arg
				#emit add.c			0xFFFFFFFC // -4
				#emit move.alt
				#emit load.s.pri	delimiter
				#emit stor.i

				arg -= 4;
			}
		}
		#emit stack			4
		#emit load.s.pri	16
		#emit retn
	}
	return -1;
}

main() {
	new address = catstr('\n',
		"Johnsons House (/cj)",
		"Madd Dogg's Mansion (/mansion)",
		"Abandones AC tower (/at)",
		"Denise Bedroom (/denise)",
		"Ryder's House (/ryder)",
		"Brothel House (/brothel)",
		"Torreno's Ranch (/torreno)",
		"Jefferson's Motel (/jeff)",
		"Millie's Bedroom (/millie)",
		"Michelle Love Nest (/mich)",
		"Safe House (/safe)",
		"Safe House 2 (/safe2)",
		"Unused Safe House (/unsafe)",
		"Big Smoke Palace (/bigsmoke)",
		"Colonel Furhbers (/colonel)"
	);
	printf(@ptr[address]);
}
*/
/*
new
    g_Test[] = {123, 456, 789}
;

public OnGameModeInit() {
    new address = GetVariableAddress(g_Test);
   
    // Change the 2nd value
    @ptr[address][1] = 444;
   
    // Print out the values
    printf("%d, %d, %d", @ptr[address][0], @ptr[address][1], @ptr[address][2]);
}*/

/*
stock catstr(pointer[][], delimiter, ...) {
	new
		arg
	;
	#emit load.s.pri	8
	#emit stor.s.pri	arg

	if(8 < arg) {
		if(12 < arg) { // alt = arg
			new
				first
			;
			#emit addr.pri		8
			#emit add
			#emit stor.s.pri	arg

			#emit addr.pri		20
			#emit stor.s.pri	first

			while(arg != first) {
				#emit lref.s.pri	arg
				#emit add.c			0xFFFFFFFC // -4
				#emit move.alt
				#emit load.s.pri	delimiter
				#emit stor.i

				arg -= 4;
			}
		}
		// @ PointerByAddress by Slice
		#emit load.s.alt	pointer
		#emit load.s.pri	20
		#emit sub
		#emit stor.i
	}
}

#define createPointer(%0) stock %0[1][1]
#define Pointer<%0> %0[0][0]

createPointer(MyPointer[1]);

main() {
	catstr(MyPointer[0], '\n',
		"Johnsons House (/cj)",
		"Madd Dogg's Mansion (/mansion)",
		"Abandones AC tower (/at)",
		"Denise Bedroom (/denise)",
		"Ryder's House (/ryder)",
		"Brothel House (/brothel)",
		"Torreno's Ranch (/torreno)",
		"Jefferson's Motel (/jeff)",
		"Millie's Bedroom (/millie)",
		"Michelle Love Nest (/mich)",
		"Safe House (/safe)",
		"Safe House 2 (/safe2)",
		"Unused Safe House (/unsafe)",
		"Big Smoke Palace (/bigsmoke)",
		"Colonel Furhbers (/colonel)"
	);
	print(Pointer<MyPointer[0]>);
}
*/


/*
// Operator called when an untagged variable is assigned to a value tagged with Pointer
stock Pointer:operator=(value) {
    static addr;
   
    // Get return address
    #emit LOAD.S.alt 4
   
    // Add COD
    #emit LCTRL     0
    #emit ADD
    #emit MOVE.alt
   
    // Subtract DAT
    #emit LCTRL     1
    #emit SUB.alt
   
    // Read the first opcode's parameter
    #emit ADD.C     4
    #emit STOR.pri  addr
    #emit LREF.pri  addr
    #emit STOR.pri  addr
   
    // Is this address relative to the previous frame?
    if (addr <= 0) {
        // Add the previous frame to make it absolute
        #emit LOAD.S.pri  0
        #emit LOAD.alt    addr
        #emit ADD
       
        // Load it and store it
        #emit LOAD.I
        #emit STOR.pri    addr
    } else {
        // Load it and store it
        #emit LOAD.pri  addr
        #emit LOAD.I
        #emit STOR.pri  addr
    }
   
    // Store the new value there
    if (addr) {
        #emit LOAD.S.pri  value
        #emit LOAD.alt    addr
        #emit STOR.I
    }
   
    // Add 8 to the return address (to skip the assignment)
    #emit LOAD.S.pri 4
    #emit ADD.C      8
    #emit STOR.S.pri 4
   
    // Return the same value the pointer was
    return Pointer:0;
}


stock Pointer:PointerToVar(...) {
    #emit LOAD.S.pri  12
    #emit RETN
   
    return Pointer:0;
}

main() {
	new variable = 200;
	new Pointer:ptr = PointerToVar(variable);

	ptr = 123;

	printf("%d", variable);
	// Output: 123
}
*/

/*
stock MyName() {
	new
		name[MAX_PLAYER_NAME] = "Franz"
	;
	return name;
}

stock assignArray(dest[], source[]) {
	
}

main() {
	new
		name[MAX_PLAYER_NAME],
		source[MAX_PLAYER_NAME]
	;
	name = MyName();
	name = source;

	Func(MyName());

}

stock Func(...) {
	#emit push.adr 12
	#emit push.c 4
	#emit sysreq.c print
	#emit stack 8
}
*/
/*
#define MAX_WEAPONS 5

enum wData
{
    wSetID,
    wSetName[32],
    wWeapons[MAX_WEAPONS]
};

stock const WeaponSet[][wData] =
{
    {1, "Test Kit #1", {WEAPON_MINIGUN, WEAPON_GRENADE}},
    {1, "Test Kit #23", {WEAPON_MINIGUN, WEAPON_GRENADE}}
// etc...
};


new WeaponSet[][][] =
{
    {
		1,
		"Test Kit #1",
		{WEAPON_MINIGUN, WEAPON_GRENADE}
	}, {
		2,
		"Test Kit #23",
		{WEAPON_MINIGUN, WEAPON_GRENADE}
	}
// etc...
};

main() {
	for(new i, j; i != sizeof WeaponSet; i++) {
		printf("getSize(WeaponSet, %d) %d", i, getSize(WeaponSet, i));

		for(j = 0; j != sizeof WeaponSet[]; j++) {
			printf("getSize(WeaponSet, %d, %d) %d", i, j, getSize(WeaponSet, i, j));
		}
	}
}

stock getSize({Float, _}: ...) {
	new
		arg = 1,
		args = numargs() - 1
	;
	while(arg < args) {
		getarg(arg);

		#emit smul.c 4
		#emit load.s.alt 12
		#emit add
		#emit move.alt
		#emit load.i
		#emit add
		#emit stor.s.pri 12

		arg++;
	}
	args = getarg(arg) * 4;

	#emit load.s.alt 12
	#emit add
	#emit move.alt
	#emit load.i
	#emit add
	#emit stor.s.pri arg

	#emit load.s.pri args
	#emit add.c 4
	#emit load.s.alt 12
	#emit add
	#emit move.alt
	#emit load.i
	#emit add
	#emit stor.s.pri args

	return (args - arg) / 4;
}
*/
/*
#define function%0(%1) forward%0(%1); public%0(%1)

stock sscanfDef(const form[], size = sizeof form) {
	sscanf(form, form);

	new
		addr,
		count = (size -= 1) * 4 + 8
	;
	#emit load.s.pri count
	#emit add.c 4
	#emit load.s.alt 8
	#emit add
	#emit stor.s.pri 8

	#emit load.s.pri 4
	#emit add.c 16
	#emit stor.s.pri 4

	#emit load.s.pri size
	#emit shl.c.pri 2
	#emit load.s.alt 0
	#emit add
	#emit add.c 8
	#emit stor.s.pri addr

	while(--size != -1) {
		switch(form[size]) {
			case 'z', 'Z', 's', 'S', 'a', 'A', 'e', 'E': {
				#emit lref.s.pri addr
				#emit push.pri
			}
			default: {
				#emit push.s addr
			}
		}
		addr -= 4;
	}
	#emit push.s form
	#emit lref.s.pri 0
	#emit add.c 16 // cmdtext
	#emit push.pri
	#emit push.s count
	#emit sysreq.c sscanf

	#emit retn

	return 1;
}

#define nCmd[%2]->%0(%1) forward public cmd@%0(%1); public cmd@%0(%1) if(sscanfDef(%2)) {} else

nCmd["ifs"]->mycommand(playerid, success, banid, Float: time, reason[]) {
	printAssembly();
}

main() {
	new
		pPointer,
		nPointer,
		data,
		code,
		addr,
		cell
	;
	#emit lctrl 0 // cod
	#emit stor.s.pri code
	#emit lctrl 1 // dat
	#emit neg
	#emit stor.s.pri data
	#emit add.c 36
	#emit stor.s.pri nPointer // natives
	#emit lref.s.alt nPointer
	#emit stor.s.alt nPointer
	#emit add.c 0xFFFFFFFC // -4
	#emit stor.s.pri pPointer // publics
	#emit lref.s.pri pPointer
	#emit add.c 4 // name field
	#emit stor.s.pri pPointer

	pPointer += data; // always from the start of the data section
	nPointer += data;

	while(pPointer < nPointer) {
		#emit lref.s.pri pPointer
		#emit load.s.alt data // add data offset
		#emit add
		#emit stor.s.pri addr
		#emit lref.s.pri addr
		#emit stor.s.pri cell

		if(cell == ('@' << 24 | 'd' << 16 | 'm' << 8 | 'c')) {
			addr = pPointer - 4;

			#emit push.c 0
			#emit lctrl 6
			#emit add.c 28
			#emit push.pri
			#emit lref.s.pri addr
			#emit sctrl 6

			// changing address
//			#emit lref.s.pri addr
//			#emit add.c 48
//			#emit sref.s.pri addr
			// adding offset
//			#emit stor.s.pri cell

//			addr += code - data;
//			cell += code - data;

		}
		pPointer += 8;
	}
}
*/
/*
forward MyFunc();
public MyFunc() {
	print("Func");
}

main() {
	print("1");
	CallLocalFunction("MyFunc", "");
	printf("%d", funcidx("MyFunc"));
	print("2");
	CallLocalFunction("MyFun", "");
	printf("%d", funcidx("MyFun"));

	new
		c,
		idx,
		dat,
		name[32]
	;
	// public offset
	#emit lctrl 1
	#emit neg
	#emit move.alt
	#emit stor.s.pri dat
	#emit add.c 32
	#emit stor.s.pri idx
	#emit lref.s.pri idx
	#emit add
	#emit stor.s.pri idx
	// funcidx
	idx = (funcidx("MyFunc") << 3) + 4 + idx;
	// loading array
	#emit lref.s.pri idx
	#emit load.s.alt dat
	#emit add
	#emit stor.s.pri idx
	// encrypting
	for(dat = 1; dat; idx++, c++) {
		#emit lref.s.pri idx
		#emit addr.alt dat
		#emit strb.i 1

		name[c] = dat;
	}
	print(name);
	// changing the name
	idx -= 2;

	#emit lref.s.pri idx
	#emit const.alt 0xFFFFFF00
	#emit and
	#emit sref.s.pri idx
	// rereading the name	
	for(idx -= c - 2, c = 0, dat = 1; dat; idx++, c++) {
		#emit lref.s.pri idx
		#emit addr.alt dat
		#emit strb.i 1

		name[c] = dat;
	}
	print(name);

	print("1");
	CallLocalFunction("MyFunc", "");
	printf("%d", funcidx("MyFunc"));
	print("2");
	CallLocalFunction("MyFun", "");
	printf("%d", funcidx("MyFun"));
}*/

stock printAssembly(bool: fromStart = true, breakOpCode = 48, extra = 0) { // windows only
	static const opcodes[][] = {
		"LOAD.pri", "address", "PRI = [address]", // 1
		"LOAD.alt", "address", "ALT = [address]", // 2
		"LOAD.S.pri", "offset", "PRI = [FRM + offset]", // 3
		"LOAD.S.alt", "offset", "ALT = [FRM + offset]", // 4
		"LREF.pri", "address", "PRI = [ [address] ]", // 5
		"LREF.alt", "address", "ALT = [ [address] ]", // 6
		"LREF.S.pri", "offset", "PRI = [ [FRM + offset] ]", // 7
		"LREF.S.alt", "offset", "ALT = [ [FRM + offset] ]", // 8
		"LOAD.I", "", "PRI = [PRI] (full cell)", // 9
		"LODB.I", "number", "PRI = “number” bytes from [PRI] (read 1/2/4 bytes)", // 10
		"CONST.pri", "value", "PRI = value", // 11
		"CONST.alt", "value", "ALT = value", // 12
		"ADDR.pri", "offset", "PRI = FRM + offset", // 13
		"ADDR.alt", "offset", "ALT = FRM + offset", // 14
		"STOR.pri", "address", "[address] = PRI", // 15
		"STOR.alt", "address", "[address] = ALT", // 16	
		"STOR.S.pri", "offset", "[FRM + offset] = PRI", // 17
		"STOR.S.alt", "offset", "[FRM + offset] = ALT", // 18
		"SREF.pri", "address", "[ [address] ] = PRI", // 19
		"SREF.alt", "address", "[ [address] ] = ALT", // 20
		"SREF.S.pri", "offset", "[ [FRM + offset] ] = PRI", // 21
		"SREF.S.alt", "offset", "[ [FRM + offset] ] = ALT", // 22
		"STOR.I", "", "[ALT] = PRI (full cell)", // 23
		"STRB.I", "number", "“number” bytes at [ALT] = PRI (write 1/2/4 bytes)", // 24
		"LIDX", "", "PRI = [ ALT + (PRI × cell size) ]", // 25
		"LIDX.B", "shift", "PRI = [ ALT + (PRI << shift) ]", // 26
		"IDXADDR", "", "PRI = ALT + (PRI × cell size) (calculate indexed address)", // 27
		"IDXADDR.B", "shift", "PRI = ALT + (PRI << shift) (calculate indexed address)", // 28
		"ALIGN.pri", "number", "Little Endian: PRI ˆ= cell size- number", // 29
		"ALIGN.alt", "number", "Little Endian: ALT ˆ= cell size- number", // 30
		"LCTRL", "index", "PRI = (0=COD, 1=DAT, 2=HEA, 3=STP, 4=STK, 5=FRM, 6=CIP (of the next instruction))", // 31
		"SCTRL", "index", "(2=HEA, 4=STK, 5=FRM, 6=CIP) = PRI", // 32
		"MOVE.pri", "", "PRI=ALT", // 33
		"MOVE.alt", "", "ALT=PRI", // 34
		"XCHG", "", "Exchange PRI and ALT", // 35
		"PUSH.pri", "", "[STK] = PRI, STK = STK - cell size", // 36
		"PUSH.alt", "", "[STK] = ALT, STK = STK - cell size", // 37
		"PICK", "offset", "PRI = [STK + offset]", // 38
		"PUSH.C", "value", "[STK] = value, STK = STK - cell size", // 39
		"PUSH", "address", "[STK] = [address], STK = STK - cell size", // 40
		"PUSH.S", "offset", "[STK] = [FRM + offset], STK = STK - cell size", // 41
		"POP.pri", "", "STK = STK + cell size, PRI = [STK]", // 42
		"POP.alt", "", "STK = STK + cell size, ALT = [STK]", // 43
		"STACK", "value", "ALT = STK, STK = STK + value", // 44
		"HEAP", "value", "ALT = HEA, HEA = HEA + value", // 45
		"PROC", "", "[STK] = FRM, STK = STK - cell size, FRM = STK", // 46
		"RET", "", "STK = STK + cell size, FRM = [STK], STK = STK + cell size, CIP = [STK]", // 47
		"RETN", "", "STK = STK + cell size, FRM = [STK], STK = STK + cell size, CIP = [STK], STK = STK + [STK]", // 48
		"CALL", "offset", "[STK] = CIP + 5, STK = STK - cell size, CIP = CIP + offset", // 49
		"CALL.pri", "", "[STK] = CIP + 1, STK = STK - cell size, CIP = PRI", // 50
		"JUMP", "offset", "CIP = CIP + offset", // 51
		"JREL", "offset", "obsolete", // 52
		"JZER", "offset", "if PRI == 0 then CIP = CIP + offset", // 53
		"JNZ", "offset", "if PRI != 0 then CIP = CIP + offset", // 54
		"JEQ", "offset", "if PRI == ALT then CIP = CIP + offset", // 55
		"JNEQ", "offset", "if PRI != ALT then CIP = CIP + offset", // 56
		"JLESS", "offset", "if PRI < ALT then CIP = CIP + offset (unsigned)", // 57
		"JLEQ", "offset", "if PRI <= ALT then CIP = CIP + offset (unsigned)", // 58
		"JGRTR", "offset", "if PRI > ALT then CIP = CIP + offset (unsigned)", // 59
		"JGEQ", "offset", "if PRI >= ALT then CIP = CIP + offset (unsigned)", // 60
		"JSLESS", "offset", "if PRI < ALT then CIP = CIP + offset (signed)", // 61
		"JSLEQ", "offset", "if PRI <= ALT then CIP = CIP + offset (signed)", // 62
		"JSGRTR", "offset", "if PRI > ALT then CIP = CIP + offset (signed)", // 63
		"JSGEQ", "offset", "if PRI >= ALT then CIP = CIP + offset (signed)", // 64
		"SHL", "", "PRI = PRI << ALT", // 65
		"SHR", "", "PRI = PRI >> ALT (without sign extension)", // 66
		"SSHR", "", "PRI = PRI >> ALT with sign extension", // 67
		"SHL.C.pri", "value", "PRI = PRI << value", // 68
		"SHL.C.alt", "value", "ALT = ALT << value", // 69
		"SHR.C.pri", "value", "PRI = PRI >> value (without sign extension)", // 70
		"SHR.C.alt", "value", "ALT = ALT >> value (without sign extension)", // 71
		"SMUL", "", "PRI = PRI * ALT (signed multiply)", // 72
		"SDIV", "", "PRI = PRI / ALT (signed divide), ALT = PRI mod ALT", // 73
		"SDIV", "", ".alt PRI = ALT / PRI (signed divide), ALT = ALT mod PRI", // 74
		"UMUL", "", "PRI = PRI * ALT (unsigned multiply)", // 75
		"UDIV", "", "PRI = PRI / ALT (unsigned divide), ALT = PRI mod ALT", // 76
		"UDIV", "", ".alt PRI = ALT / PRI (unsigned divide), ALT = ALT mod PRI", // 77
		"ADD", "", "PRI = PRI + ALT", // 78
		"SUB", "", "PRI = PRI - ALT", // 79
		"SUB", "", ".alt PRI = ALT - PRI", // 80
		"AND", "", "PRI = PRI & ALT", // 81
		"OR", "", "PRI = PRI |ALT", // 82
		"XOR", "", "PRI = PRI ˆ ALT", // 83
		"NOT", "", "PRI = !PRI", // 84
		"NEG", "", "PRI = -PRI", // 85
		"INVERT", "", "PRI = ~PRI", // 86
		"ADD.C", "value", "PRI = PRI + value", // 87
		"SMUL.C", "value", "PRI = PRI * value", // 88
		"ZERO.pri", "", "PRI = 0", // 89
		"ZERO.alt", "", "ALT = 0", // 90
		"ZERO", "address", "[address] = 0", // 91
		"ZERO.S", "offset", "[FRM + offset] = 0", // 92
		"SIGN.pri", "", "sign extent the byte in PRI to a cell", // 93
		"SIGN.alt", "", "sign extent the byte in ALT to a cell", // 94
		"EQ", "", "PRI = PRI == ALT ? 1 : 0", // 95
		"NEQ", "", "PRI = PRI != ALT ? 1 : 0", // 96
		"LESS", "", "PRI = PRI < ALT ? 1 : 0 (unsigned)", // 97
		"LEQ", "", "PRI = PRI <= ALT ? 1 : 0 (unsigned)", // 98
		"GRTR", "", "PRI = PRI > ALT ? 1 : 0 (unsigned)", // 99
		"GEQ", "", "PRI = PRI >= ALT ? 1 : 0 (unsigned)", // 100
		"SLESS", "", "PRI = PRI < ALT ? 1 : 0 (signed)", // 101
		"SLEQ", "", "PRI = PRI <= ALT ? 1 : 0 (signed)", // 102
		"SGRTR", "", "PRI = PRI > ALT ? 1 : 0 (signed)", // 103
		"SGEQ", "", "PRI = PRI >= ALT ? 1 : 0 (signed)", // 104
		"EQ.C.pri", "value", "PRI = PRI == value ? 1 : 0", // 105
		"EQ.C.alt", "value", "PRI = ALT == value ? 1 : 0", // 106
		"INC.pri", "", "PRI = PRI + 1", // 107
		"INC.alt", "", "ALT = ALT + 1", // 108
		"INC", "address", "[address] = [address] + 1", // 109
		"INC.S", "offset", "[FRM + offset] = [FRM + offset] + 1", // 110
		"INC.I", "", "[PRI] = [PRI] + 1", // 111
		"DEC.pri", "", "PRI = PRI - 1", // 112
		"DEC.alt", "", "ALT = ALT - 1", // 113
		"DEC", "address", "[address] = [address] - 1", // 114
		"DEC.S", "offset", "[FRM + offset] = [FRM + offset] - 1", // 115
		"DEC.I", "", "[PRI] = [PRI] - 1", // 116
		"MOVS", "number", "Copy number of bytes from [PRI] to [ALT]", // 117
		"CMPS", "number", "Compare number of bytes at [PRI] and [ALT]", // 118
		"FILL", "number", "Fill number of bytes at [ALT] with value in [PRI]", // 119
		"HALT", "0", "Abort execution (exit value in PRI), parameters other than 0 have a special meaning", // 120
		"BOUNDS", "value", "Abort execution if PRI > value or if PRI < 0", // 121
		"SYSREQ.pri", "", "call system service, service number in PRI", // 122
		"SYSREQ.C", "value", "call system service", // 123
		"FILE", "size ord name", "obsolete", // 124
		"LINE", "line ord", "obsolete", // 125
		"SYMBOL", "size offset flag name", "obsolete", // 126
		"SRANGE", "level size", "obsolete", // 127
		"JUMP.pri", "", "CIP = PRI (indirect jump)", // 128
		"SWITCH", "offset", "Compare PRI to the values in the case table", // 129
		"CASETBL", "...", "A variable number of case records follows this opcode", // 130
		"SWAP.pri", "", "[STK] = PRI and PRI = [STK]", // 131
		"SWAP.alt", "", "[STK] = ALT and ALT = [STK]", // 132
		"PUSH.ADR", "offset", "[STK] = FRM + offset, STK = STK - cell size", // 133
		"NOP", "", "no-operation, for code alignment", // 134
		"SYSREQ.N", "addr n", "macro: PUSH.C n; SYSREQ.C adr; STACK n+4", // 135
		"SYMTAG", "value", "obsolete", // 136
		"BREAK", "", "conditional breakpoint —see appendix E", // 137
		"PUSH2.C", "c1 c2", "macro: replaces two PUSH.C opcodes", // 138
		"PUSH2", "a1 a2", "macro: replaces two PUSH opcodes", // 139
		"PUSH2.S", "o1 o2", "macro: replaces two PUSH.S opcodes", // 140
		"PUSH2.ADR", "o1 o2", "macro: replaces two PUSH.ADR opcodes", // 141
		"PUSH3.C", "c1 – c3", "macro: replaces three PUSH.C opcodes", // 142
		"PUSH3", "a1 – a3", "macro: replaces three PUSH opcodes", // 143
		"PUSH3.S", "o1 – o3", "macro: replaces three PUSH.S opcodes", // 144
		"PUSH3.ADR", "o1 – o3", "macro: replaces three PUSH.ADR opcodes", // 145
		"PUSH4.C", "c1 – c4", "macro: replaces four PUSH.C opcodes", // 146
		"PUSH4", "a1 – a4", "macro: replaces four PUSH opcodes", // 147
		"PUSH4.S", "o1 – o4", "macro: replaces four PUSH.S opcodes", // 148
		"PUSH4.ADR", "o1 – o4", "macro: replaces four PUSH.ADR opcodes", // 149
		"PUSH5.C", "c1 – c5", "macro: replaces five PUSH.C opcodes", // 150
		"PUSH5", "a1 – a5", "macro: replaces five PUSH opcodes", // 151
		"PUSH5.S", "o1 – o5", "macro: replaces five PUSH.S opcodes", // 152
		"PUSH5.ADR", "o1 – o5", "macro: replaces five PUSH.ADR opcodes", // 153
		"LOAD.both", "a1 a2", "PRI = [a1], ALT = [a2]", // 154
		"LOAD.S.both", "o1 o2", "PRI = [FRM + o1], ALT = [FRM + o2]", // 155
		"CONST", "adr val", "[adr] = val", // 156
		"CONST.S", "off val", "[FRM + off] = val" // 157
	};

	new
		i,
		idx,
		code,
		data,
		value,
		opcode,
		tmp[144]
	;
	#emit load.s.alt 4
	#emit lctrl 0
	#emit stor.s.pri code
	#emit add
	#emit move.alt
	#emit lctrl 1
	#emit stor.s.pri data
	#emit sub.alt
	#emit stor.s.pri idx

	if(fromStart) {
		for(idx -= 20; ; ) {
			#emit lref.s.pri idx
			#emit stor.s.pri opcode

			if(opcode == 46) { // proc
				idx -= 4;

				#emit lref.s.pri idx
				#emit stor.s.pri opcode

				if(opcode == 48) { // retn
					idx += 4;
					break;
				}
				if(opcode == 0) { 
					idx -= 4;

					#emit lref.s.pri idx
					#emit stor.s.pri opcode

					if(opcode == 120) { // halt
						idx += 8;
						break;
					}
				}
			}
			idx -= 4;
		}
	}
	for(breakOpCode = (breakOpCode * 3 - 3); idx != extra; idx += 4) {
		#emit lref.s.pri idx
		#emit smul.c 3
		#emit add.c 0xFFFFFFFD // -3
		#emit stor.s.pri opcode

		format(tmp, sizeof tmp, "%d. %s", idx - 4 + data - code, opcodes[opcode]);

		if(opcodes[opcode + 1][0]) {
			switch(opcode) {
				case (130 * 3 - 3): { // CASETBL
					idx += 4;

					#emit lref.s.pri idx
					#emit stor.s.pri value
					#emit shl.c.pri 3
					#emit add.c 4
					#emit load.s.alt idx
					#emit add
					#emit stor.s.pri i

					format(tmp, sizeof tmp, "%s %d", tmp, value);

					while(idx < i) {
						idx += 4;

						#emit lref.s.pri idx
						#emit stor.s.pri value

						format(tmp, sizeof tmp, "%s %d", tmp, value);
					}
				}
				default: {
					i = -1;

					do {
						i++;
						idx += 4;

						#emit lref.s.pri idx
						#emit stor.s.pri value

						format(tmp, sizeof tmp, "%s %d", tmp, value);
					} while((i = strfind(opcodes[opcode + 1][0], " ", false, i)) != -1);
				}
			}
		}
		print(tmp);

		if(opcode == breakOpCode) {
			extra = extra * 4 + idx + 4;
			break;
		}
	}
}

/*
// stupid
#define Dynamic(%0,%1) aSetSize(%1); new %0[2500]

main() {
	new
		rand = random(25)
	;
	Dynamic(array, rand);

	printf("%d", rand);

	for(new i; i != rand; ++i) {
		printf("rand = %d, array[%d] = %d", rand, i, array[i]);
	}
}
// unfinished - offset
stock aSetSize(size) {
	new
		address,
		offset
	;
	#emit lctrl 1
	#emit move.alt
	#emit lctrl 0
	#emit sub
	#emit stor.s.pri offset
	// changing pointer
	#emit load.s.pri 4
	#emit add.c 28
	#emit stor.s.pri 4
	// fetching address
	#emit lctrl 6
	#emit move.alt
	#emit lctrl 0
	#emit add
	#emit move.alt
	#emit lctrl 1
	#emit sub.alt
	#emit add.c X
	// stack index
	#emit load.s.alt size
	#emit stor.s.pri size
	#emit sref.s.alt size
	// reading address
	#emit add.c 12
	#emit stor.s.pri size
	#emit lref.s.pri size
	// fill index
	#emit add.c 20
	#emit stor.s.pri size
	#emit move.pri
	#emit neg
	#emit sref.s.pri size

	#emit stack ffffd8f0
	#emit zero.pri
	#emit addr.alt ffffd8ec
	#emit fill 2710

	return 0;
}
*/
/*
main() { // include offset
	new
		nCount[32],
		opcode,
		start,
		end
	;
	#emit lctrl 1 // dat
	#emit move.alt
	#emit lctrl 0 // cod
	#emit stor.s.pri end
	#emit sub // cod - dat
	#emit stor.s.pri start

	while(start != end) {
		#emit lref.s.pri start
		#emit stor.s.pri opcode

		if(opcode == 123) { // sysreq.c
			opcode = start - 8;

			#emit lref.s.pri opcode
			#emit stor.s.pri opcode

			if(opcode == 39) { // push.c
				start += 4;

				#emit lref.s.pri start
				#emit stor.s.pri opcode

				if(sizeof nCount <= opcode) {
					printf("%d <= %d", sizeof nCount, opcode);
				} else {
					if(opcode < 0) {} else {
						nCount[opcode]++;
					}
				}
			}
		}
		start += 4;
	}
	for(start = 0; (start != sizeof nCount) && nCount[start]; ++start) {
		printf("%s (%d). %d", getNativeName(start), start, nCount[start]);
	}
}*/

/*
main() { // cod + cip - dat
	new
		var
	;
	#emit nop
	#emit lctrl 6 // cip
	#emit move.alt
	#emit lctrl 0 // cod
	#emit add
	#emit move.alt
	#emit lctrl 1 // dat
	#emit sub.alt
	#emit add.c 0xFFFFFFF4 // -12
	#emit stor.s.pri var
	#emit lref.s.pri var
	#emit stor.s.pri var

	printf("NOP = %d", var); // 134
}
*/
/*
stock const TRUE = true;

#define sscanf(%0) TRUE
#define RED 0xFF0000FF

public OnPlayerCommandText(playerid, cmdtext[]) {
// OnPlayerCommandText
    if(strcmp(cmdtext, "/skin", true, 5) == 0) {
        static const
            Usage[] = "Usage: /Skin [ID]",
            Invalid[] = "Wrong Skin ID"
        ;
        if(cmdtext[5] == EOS)
            return SendClientMessage(playerid, RED, Usage);
        if(cmdtext[5] == ' ') {
            if(sscanf(cmdtext[6], "d", cmdtext[0]))
                return SendClientMessage(playerid, RED, Usage);
            if(!(0 <= cmdtext[0] <= 299) || (cmdtext[0] == 74))
                return SendClientMessage(playerid, RED, Invalid);
            return SetPlayerSkin(playerid, cmdtext[0]);
        }
    }
// OnPlayerCommandText
    if(strcmp(cmdtext, "/skin", true, 5) == 0) {
        static const
            Usage[] = "Usage: /Skin [ID]",
            Invalid[] = "Wrong Skin ID"
        ;
        if(cmdtext[5] == EOS)
            return SendClientMessage(playerid, 0xFF0000AA, Usage);
        if(cmdtext[5] == ' ') {
            if(sscanf(cmdtext[6], "d", cmdtext[0]))
                return SendClientMessage(playerid, 0xFF0000AA, Usage);
            if(!(0 <= cmdtext[0] <= 299) || (cmdtext[0] == 74))
                return SendClientMessage(playerid, RED, Invalid);
            return SetPlayerSkin(playerid, cmdtext[0]);
        }
    }
	return false;
}
*/
/*
main() {
	new test[20] = {4, ...};

	memset(test, sizeof(test), 1234);

	for (new i = 0; i < sizeof(test); i++) {
		printf("test[%d] = %d", i, test[i]);
	}
}

stock memset(variable[], cells, value) { // Slice - forum.sa-mp.com/showpost.php?p=1974747&postcount=3330
    #emit LCTRL			6
    #emit MOVE.alt
    #emit LCTRL			0
    #emit ADD
    #emit MOVE.alt
    #emit LCTRL			1
    #emit SUB.alt
    #emit ADD.C			92
    #emit LOAD.S.alt	cells
    #emit SHL.C.alt		2
	#emit STOR.S.pri	cells
    #emit SREF.S.alt	cells
   
    #emit LOAD.S.alt	variable
    #emit LOAD.S.pri	value
    #emit FILL			0
}
*/
/*
stock Float: frandom(Float: min, Float: max = 0.0, fractional = 1000) {
	if(max < min) {
		max ^= min;
		min ^= max;
		max ^= min;
	}
	return (min + floatdiv(random(floatround((max - min) * fractional)), fractional));
}

main() {
	if(!IsPlayerNPC(0)) {
		SendRconCommand("maxnpc 1");
		ConnectNPC("NPC", "npcidle");
		return ;
	}
//	SpawnPlayer(0);
	DestroyVehicle(1);
	new
		Float: X = frandom(-3000.0, 3000.0),
		Float: Y = frandom(-3000.0, 3000.0),
		Float: Z = 10.0
	;
	AddStaticVehicle(500, X, Y, Z, 0.0, -1, -1);
	SetPlayerPos(0, X, Y - 3.0, Z);

	printf("NPC %d, Vehicle %d, %f %f %f", IsPlayerNPC(0), !!GetVehicleModel(1), X, Y, Z);
}

nTest(3x10000) {
	new
		v1,
		v2
	;
	Test("IsPlayerBehindVehicle1") {
		v1 = IsPlayerBehindVehicle1(0, 1);
	}
	Test("IsPlayerBehindVehicle2") {
		v2 = IsPlayerBehindVehicle2(0, 1);
	}
	printf("%d %d", v1, v2);
}

stock IsPlayerBehindVehicle1(playerid,veh)
{
	new Float:vcoord[3]; GetVehiclePos(veh,vcoord[0],vcoord[1],vcoord[2]);
	new Float:vangle; GetVehicleZAngle(veh,vangle);
	new Float:vinfo[3]; GetVehicleModelInfo(GetVehicleModel(veh),VEHICLE_MODEL_INFO_SIZE,vinfo[0],vinfo[1],vinfo[2]);
	new Float:lenge = floatdiv(vinfo[1],2.0);
	new Float:radius = floatdiv(vinfo[0],2.0);
   	vcoord[0] = floatadd(vcoord[0],(-lenge * floatsin(-vangle,degrees)));
  	vcoord[1] = floatadd(vcoord[1],(-lenge * floatcos(-vangle,degrees)));
	if(IsPlayerInRangeOfPoint(playerid,radius,vcoord[0],vcoord[1],vcoord[2])){return 1;}
	else{return 0;}
}

stock IsPlayerBehindVehicle2(playerid, vehicleid, Float: distance = 5.0) {
    new
        Float: vA
    ;
    if(GetVehicleZAngle(vehicleid, vA)) {
        new
            Float: pX,
            Float: pY,
            Float: pZ
        ;
        if(GetPlayerPos(playerid, pX, pY, pZ)) {
            new
                Float: vX,
                Float: vY,
                Float: vZ,
                Float: vW, //Wide
                Float: vL, //Lenth
                Float: vH //High
            ;
            GetVehiclePos(vehicleid, vX, vY, vZ);
            GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, vW, vL, vH);
            if(vZ <= pZ <= (vZ + vH)) {
                pZ = floatcos(vA, degrees);
                vZ = floatsin(vA, degrees);
                vA = vX + ((vL / 2) * vZ) - ((vW / 2) * pZ); // X1
                vH = vY - ((vL / 2) * pZ) - ((vW / 2) * vZ); // Y1
                vX = vA + (vW * pZ); // X2
                vY = vH + (vW * vZ); // Y2
                vW = vA + (distance * vZ); // X3
                vL = vH - (distance * pZ); // Y3
                vZ = vX + (distance * vZ); // X4
                pZ = vY - (distance * pZ); // Y4
				vehicleid = 0;

				if((vH < pY <= vL) || (vL < pY <= vH)) { // 1 - 3
					if(((pY - vL) * (vA - vW) / (vH - vL) + vW) <= pX) {
						vehicleid++;
					}
				}
				if((vL < pY <= pZ) || (pZ < pY <= vL)) { // 3 - 4
					if(((pY - pZ) * (vW - vZ) / (vL - pZ) + vZ) <= pX) {
						vehicleid++;
					}
				}
				if((pZ < pY <= vY) || (vY < pY <= pZ)) { // 4 - 2
					if(((pY - vY) * (vZ - vX) / (pZ - vY) + vX) <= pX) {
						vehicleid++;
					}
				}
				if((vY < pY <= vH) || (vH < pY <= vY)) { // 2 - 1
					if(((pY - vH) * (vX - vA) / (vY - vH) + vA) <= pX) {
						vehicleid++;
					}
				}
				return (vehicleid & 0x1);
			}
		}
	}
	return false;
}
*/
/*
nTest(3x100000) {
	new
		Float: vX,
		Float: vY,
		Float: vZ,
		Float: cX = float(random(1000)) / 1000,
		Float: cY = float(random(1000)) / 1000,
		Float: cZ = float(random(1000)) / 1000
	;
	vX = cX, vY = cY, vZ = cZ;
	Test("AdjustVector1") {
		AdjustVector1(vX, vY, vZ, 0.016204, 0.009899, 0.047177);
	}
	printf("%f %f %f", vX, vY, vZ);
	vX = cX, vY = cY, vZ = cZ;
	Test("AdjustVector2") {
		AdjustVector2(vX, vY, vZ, 0.016204, 0.009899, 0.047177);
	}
	printf("%f %f %f", vX, vY, vZ);
}

stock AdjustVector1(& Float: vX, & Float: vY, & Float: vZ, Float: oX, Float: oY, const Float: oZ) {
	static
		Float: Angle;
	Angle = -atan2(vX, vY);
	if(45.0 < Angle) {
		oX ^= oY;
		oY ^= oX;
		oX ^= oY;
		if(90.0 < Angle) {
			oX *= -1;
			if(135.0 < Angle) {
				oX *= -1;
				oX ^= oY;
				oY ^= oX;
				oX ^= oY;
				oX *= -1;
			}
		}
	} else if(Angle < 0.0) {
		oY *= -1;
		if(Angle < -45.0) {
			oX *= -1;
			oX ^= oY;
			oY ^= oX;
			oX ^= oY;
			oX *= -1;
			if(Angle < -90.0) {
				oX *= -1;
				if(Angle < -135.0) {
					oX ^= oY;
					oY ^= oX;
					oX ^= oY;
				}
			}
		}
	}
	vX += oX,
	vY += oY;
	vZ += oZ;
	return false;
}

stock AdjustVector2(& Float: vX, & Float: vY, & Float: vZ, const Float: oX, const Float: oY, const Float: oZ) {
	switch(floatround(atan2(vX, vY) / 45.0, floatround_floor)) {
		case -1:	vX += oX, vY += oY, vZ += oZ;
		case -2:	vX += oY, vY += oX, vZ += oZ;
		case -3:	vX -= oY, vY += oX, vZ += oZ;
		case -4:	vX -= oX, vY += oY, vZ += oZ;
		case 0:		vX += oX, vY -= oY, vZ += oZ;
		case 1:		vX += oY, vY -= oX, vZ += oZ;
		case 2:		vX -= oY, vY -= oX, vZ += oZ;
		case 3:		vX -= oX, vY -= oY, vZ += oZ;
	}
	return false;
}
*/
/*
main() {
//	printf("ucharmax %d", ucharmax);
	date("d");
	date("d");
}

stock date(form[], output[128] = "") {
	static const days[] = {
		"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
	};
	new
		i,
		c,
		
	;
	if(form[0] < ucharmax) {
		for(output[0] = EOS; form[i]; ++i) {
			switch(form[i]) {
//				case 'd': {
//					form{c++} = 'd';
//					strcat(output, "%02d");
//				}
				case 'j': {
					form{c++} = 'j';
					strcat(output, "%d");
				}
			}
		}
		if((i * 4) <= ((((c + 5) / 4) * 4) + strlen(output))) {
			return ;
		}
		do {
			form{c++} = EOS;
		} while((c % 4) != 0);

		strpack(form[c / 4], output, 
		for(i = 0; output[i]; ++i) {
			form{c++} = output[i];
		}
		form{c++} = EOS;
	}
	getdate(output[0], output[1], output[2]);
	gettime(output[3], output[4], output[5]);

//	print(form);

	c = 1;
	i = sizeof output;

	for(i = 0; i != 3; ++i) {
		printf("%d - %c - %s", i, form[i], form[i]);
	}

	#emit load.s.pri form
	#emit load.s.alt c
	#emit shl.c.alt 2
	#emit add
	#emit push.pri
	#emit push.c 4
	#emit sysreq.c print
	#emit stack 8

	#emit load.s.pri output
	#emit add.c 8
	#emit push.pri
	#emit load.s.pri form
	#emit load.s.alt c
	#emit add
	#emit push.pri
	#emit push.s i
	#emit push.s output
	#emit push.c 16
	#emit sysreq.c format
	#emit stack 20

	return output;
}
*/
/*
public OnRconCommand(cmd[]) {
    static const replace[][] = {
        "hi", "hello"
    };
    new
        tmp[256],
        len,
        idx,
        i
    ;
    memcpy(tmp, cmd, 0, strlen(cmd) * cellbits / charbits);

    for( ; i < sizeof replace; i += 2) {
        for(len = strlen(replace[i]); (idx = strfind(tmp, replace[i], true)) != -1; ) {
            strdel(tmp, idx, idx + len);
            strins(tmp, replace[i + 1], idx);
        }
    }
    if(tmp[127] != EOS) {
        for(i = 126; (i < 96) && (tmp[i] != ' '); --i) {}

		if(tmp[i] != ' ') {
			strins(tmp, ".......", (i = 124));
		} else {
			tmp[i] = '.';
			strins(tmp, "......", i);
		}
		tmp[i + 3] = EOS;
		print(tmp);
		print(tmp[i + 4]);
    } else {
        print(tmp);
    }
    return false;
}
*/
/*
new
    myQuery[] = "UPDATE `PlayerData` SET Score='%d', Ip='%s', PlayerLevel='%d', StatsMetersDriven='%d', StatsTruckerJobs='%d', StatsConvoyJobs='%d', StatsBusDriverJobs='%d',",
    myQuery1[] = "StatsPilotJobs='%d', StatsMafiaJobs='%d', StatsMafiaStolen='%d', StatsPoliceFined='%d', StatsPoliceJailed='%d', StatsAssistance='%d',",
    myQuery2[] = "StatsCourierJobs='%d', StatsRoadworkerJobs='%d', Money='%d', OFWarns='%d' WHERE `Name`='%s'"
;

main() {
	// lets replace the EOS with a space
	myQuery[sizeof myQuery - 1] = myQuery1[sizeof myQuery1 - 1] = ' ';
	// we need to use myQuery2 at least once otherwise the compiler will remove it because it gets never used
	myQuery2[sizeof myQuery2 - 1] = EOS;
	// now if you want to test it
	print(myQuery);
}
*/
/*
// md-sort.inc by Slice
//
// SortDeepArray(array[][], sort_index, .order = SORT_ASC, .ignorecase = false)

#include <a_samp>

#define SortDeepArray(%1,%2, _SortDeepArray(%1,sizeof(%1),(_:%2),tagof(%2),

enum E_SORT_ORDER {
	SORT_ASC,
	SORT_DESC
};

stock SortDeepArray_Entry(array[][], offset, type, E_SORT_ORDER: order = SORT_ASC, size = sizeof array, bool:ignorecase = false) {
	if(order == SORT_ASC) {
		switch(type) {
			case 'f': {
				new
					stack,
					left = 0,
					right = size - 1,
					pivot = ((left + right) / 2)
				;
				#emit lctrl 4
				#emit stor.s.pri stack

				do {
					#emit push.s left
					#emit push.s right

					#emit load.s.pri pivot

					#emit push.s left
					#emit add.c 0xFFFFFFFF
					#emit push.pri

					#emit add.c 2
					#emit push.pri
					#emit push.s right
				} while(1 < pivot);


				while(1 < pivot) {
					
				}
				
				do {
					#emit lctrl 4
				} while(stack != pivot);
				
				new
					l_hold = 0,
					r_hold = size - 1,
					Float: pivot = array[(left + right) / 2][offset]
				;
				while(l_hold <= r_hold) {
					while(Float: array[l_hold][offset] < pivot) l_hold++;
					while(pivot < Float: array[r_hold][offset]) r_hold--;

					if(l_hold < r_hold) {
						ExchangeArraySlots(array, l_hold++, r_hold--);
					} else {
						break;
					}
				}
				
				if (left < right_hold) _SortDeepArray(array, left, right_hold);
				if (left_hold < right) _SortDeepArray(array, left_hold, right);
			}
			case 's': {}
			case 'i': {}
			default: {
				return ;
			}
		}
	} else {
	}
}

stock ExchangeArraySlots(array[][], slot1, slot2) {
	new
		addr1,
		addr2;
	
	// Get the pointer and its address for slot1
	#emit LOAD.S.pri  array
	#emit LOAD.S.alt  slot1
	#emit SHL.C.alt   2
	#emit ADD
	#emit MOVE.alt
	
	#emit STOR.S.pri  slot1
	#emit LOAD.I
	#emit ADD
	#emit STOR.S.pri  addr1
	
	// Get the pointer and its address for slot2
	#emit LOAD.S.pri  array
	#emit LOAD.S.alt  slot2
	#emit SHL.C.alt   2
	#emit ADD
	#emit MOVE.alt
	
	#emit STOR.S.pri  slot2
	#emit LOAD.I
	#emit ADD
	#emit STOR.S.pri  addr2
	
	// Swap them
	#emit LOAD.S.pri  addr2
	#emit LOAD.S.alt  slot1
	#emit SUB
	#emit STOR.I
	
	#emit LOAD.S.pri  addr1
	#emit LOAD.S.alt  slot2
	#emit SUB
	#emit STOR.I
}

enum myEnum {
	iVar,
	Float: fVar,
	sVar[32]
}

stock dataArray[][myEnum] = {
	{0, 3.0, "Hello"},
	{2, 1.0, "World"}
};

main() {
	SortDeepArray(dataArray, fVar);
	SortDeepArray(dataArray, string: sVar);

//	Func(dataArray[0][(fVar)], dataArray[0][(fVar - fVar)], (_: fVar));
}

stock Func({Float, _}: ...) {
	new
		form[] = "%d - %d"
	;
	#emit push.adr 12
	#emit push.adr 16
	#emit push.adr form
	#emit push.c 12
	#emit sysreq.c printf

	#emit load.s.pri 12
	#emit load.s.alt 16
	#emit sub
	#emit shr.c.pri 2
	#emit heap 4
	#emit stor.i
	#emit push.alt
	#emit push.s 20
	#emit push.adr form
	#emit push.c 12
	#emit sysreq.c printf

	#emit stack 32
	#emit heap 0xFFFFFFFC
}
*/
/*
nTest(3x100000) {
	new
		Float: X,
		Float: Y,
		Float: Z,
		Float: A = float(random(360)) + (float(random(100)) / 100.0),
		Float: oX = float(random(10)),
		Float: oY = float(random(10)),
		Float: oZ = float(random(10))
	;
	Test("GetRelativePosition1") {
		GetRelativePosition1(X, Y, Z, A, oX, oY, oZ);
	}
	Test("GetRelativePosition2") {
		GetRelativePosition2(X, Y, Z, A, oX, oY, oZ);
	}
	Test("GetRelativePosition3") {
		GetRelativePosition3(X, Y, Z, A, oX, oY, oZ);
	}
	Test("GetRelativePosition4") {
		GetRelativePosition4(X, Y, Z, A, oX, oY, oZ);
	}
}

stock GetRelativePosition1(& Float: X, & Float: Y, & Float: Z, Float: A, const Float: oX, const Float: oY, Float: oZ) {
    Z += oZ;
    oZ = floatcos(A, degrees);
    A = floatsin(A, degrees);
    X += oZ * oX - A * oY;
    Y += A * oX + oZ * oY;
}

stock GetRelativePosition2(& Float: X, & Float: Y, & Float: Z, Float: A, const Float: oX, const Float: oY, const Float: oZ) {
    X += floatcos(A, degrees) * oX - floatsin(A, degrees) * oY;
    Y += floatsin(A, degrees) * oX + floatcos(A, degrees) * oY;
    Z += oZ;
}

stock GetRelativePosition3(& Float: X, & Float: Y, & Float: Z, Float: A, const Float: oX, const Float: oY, Float: oZ) {
    X += floatcos(A, degrees) * oX;
    Y += floatsin(A, degrees) * oX;
	X -= floatsin(A, degrees) * oY;
	Y += floatcos(A, degrees) * oY;
    Z += oZ;
}

stock GetRelativePosition4(& Float: X, & Float: Y, & Float: Z, Float: A, const Float: oX, const Float: oY, const Float: oZ) {
	new
		Float: cos = floatcos(A, degrees),
		Float: sin = floatsin(A, degrees)
	;
    X += cos * oX - sin * oY;
    Y += sin * oX + cos * oY;
    Z += oZ;
}
*/

/*
new
	gStack[64]
;

// Working
forward WakeEx(count, offset, address);
public WakeEx(count, offset, address) {
	// storing current frame
	new
		frame
	;
	// recreating stack
	while(count--) {
		#emit const.alt gStack
		#emit load.s.pri count
		#emit lidx
		#emit push.pri
	}
	// getting first frame
	#emit lctrl 4 // stack
	#emit load.s.alt offset
	#emit add
	#emit stor.s.pri frame
	#emit stor.s.pri count
	// setting the frame pointer to the new stack
	for( ; ; ) {
		#emit lref.s.pri count
		#emit stor.s.pri offset

		if(offset == 0) {
			break;
		} else {
			#emit load.s.pri offset
			#emit load.s.alt count
			#emit add
			#emit stor.i
			#emit stor.s.pri count
		}
	}
	// setting the pointers
	#emit load.s.alt count
	#emit lctrl 5 // frame
	#emit stor.i
	#emit const.pri 4
	#emit add
	#emit move.alt
	#emit lctrl 6 // cip
	#emit add.c 48 // 12
	#emit stor.i
	// setting new frame and jumping back into the code
	#emit load.s.pri frame
	#emit load.s.alt address
	#emit sctrl 5 // frame
	#emit move.pri
	#emit sctrl 6 // cip
	// code will return here
}

stock wait(time) {
	new
		current,
		offset,
		count,
		end
	;
	// getting the stack value before this function
	#emit lctrl 4 // stack
	#emit add.c 32 // 4 vars + 2 pointers + byte + 1 parameter
	#emit stor.s.pri current
	// getting the frame offset
	#emit load.s.alt 0
	#emit sub.alt
	#emit stor.s.pri offset
	// prepare loop
	#emit load.s.pri 0
	#emit stor.s.pri count
	// looping through the frames
	for( ; ; ) {
		// saving the byte offset
		#emit load.s.pri count
		#emit stor.s.pri end
		#emit load.i
		#emit stor.s.pri count

		if(count == 0) {
			break;
		} else {
			#emit load.s.pri count
			#emit load.s.alt end
			#emit sub
			#emit stor.i
		}
	}
	// adding the parameters
	#emit load.s.pri end
	#emit add.c 8
	#emit move.alt
	#emit load.i
	#emit add
	#emit add.c 4
	#emit stor.s.pri end
	// storing the whole stack into the heap
	while(current < end) {
		#emit const.pri gStack
		#emit load.s.alt count
		#emit shl.c.alt 2
		#emit add
		#emit move.alt
		#emit lref.s.pri current
		#emit stor.i

		current += 4;
		count++;
	}
	// getting the return
	#emit load.s.pri 4
	#emit stor.s.pri current
	// resetting stack
	#emit load.s.pri end
	#emit sctrl 4 // stack
	// calling the timer
	SetTimerEx("WakeEx", time, false, "iii", count, offset, current);
	// change to pointers to zero
	#emit zero.pri
	#emit sctrl 5 // frame
	#emit sctrl 6 // cip
	// end
}
*/
/*
main() {
	new
		var = 3,
		parm = 7
	;
	TestFunc(parm);

	printf("%d %d", var, parm);
}

TestFunc(parm) {
	new
		stack,
		frame
	;
	#emit lctrl 4
	#emit stor.s.pri stack
	#emit lctrl 5
	#emit stor.s.pri frame

	printf("%d %d %d", stack, frame, parm);

	SetTimer("MyFunc", 0, false);

	wait(2500);

	#emit lctrl 4
	#emit stor.s.pri stack
	#emit lctrl 5
	#emit stor.s.pri frame

	printf("%d %d %d", stack, frame, parm);
}

forward public MyFunc();
public MyFunc() {
	new
		stack,
		frame
	;
	#emit lctrl 4
	#emit stor.s.pri stack
	#emit lctrl 5
	#emit stor.s.pri frame

	printf("%d %d", stack, frame);
}

#if 0
	native wait(time);
#endif

forward public PreloadNative();
public PreloadNative() {
	SetTimer("", 0, false);
	SetTimerEx("", 0, false, "");
}

forward WakeEx(stack, frame, address);
public WakeEx(stack, frame, address) {
	// setting the pointers
	#emit load.s.pri stack
	#emit sctrl 4
	#emit load.s.pri frame
	#emit load.s.alt address
	#emit sctrl 5
	#emit move.pri
	#emit sctrl 6
	// end
}

stock wait(time) {
	// getting stack before this function
	new
		addr,
		frame,
		stack
	;
	#emit load.s.pri 4
	#emit stor.s.pri addr
	#emit load.s.pri 0
	#emit stor.s.pri frame
	#emit addr.pri time
	#emit add.c 4
	#emit stor.s.pri stack
	// calling the timer
	SetTimerEx("WakeEx", time, false, "iii", stack, frame, addr);
	// resetting stack
	#emit addr.pri stack
	#emit sctrl 4 // stack
	// change to pointers to zero
	#emit zero.pri
	#emit sctrl 5 // frame
	#emit sctrl 6 // cip
	// end
}
*/
/*
forward WakeEx(stack[], count, offset, address);
public WakeEx(stack[], count, offset, address) {
	// storing current frame
	new
		frame
	;
	// recreating stack
	while(count-- != 1) {
		#emit load.s.alt stack
		#emit load.s.pri count
		#emit shl.c.pri 2
		#emit add
		#emit stor.s.pri frame
		#emit lref.s.pri frame
		#emit push.pri
	}
	// getting first frame
	#emit lctrl 4 // stack
	#emit load.s.alt offset
	#emit add
	#emit stor.s.pri frame
	#emit stor.s.pri count
	// setting the frame pointer to the new stack
	for( ; ; ) {
		#emit lref.s.pri count
		#emit stor.s.pri offset

		if(offset == 0) {
			break;
		} else {
			#emit load.s.pri offset
			#emit load.s.alt count
			#emit add
			#emit stor.i
			#emit stor.s.pri count
		}
	}
	// setting the pointers
	#emit load.s.alt count
	#emit lctrl 5 // frame
	#emit stor.i
	#emit const.pri 4
	#emit add
	#emit move.alt
	#emit lctrl 6 // cip
	#emit add.c 48 // 12
	#emit stor.i
	// setting new frame and jumping back into the code
	#emit load.s.pri frame
	#emit load.s.alt address
	#emit sctrl 5 // frame
	#emit move.pri
	#emit sctrl 6 // cip
	// code will return here
}

stock wait(time) {
	new
		current,
		offset,
		count,
		end
	;
	// getting the stack value before this function
	#emit lctrl 4 // stack
	#emit add.c 32 // 4 vars + 2 pointers + byte + 1 parameter
	#emit stor.s.pri current
	// getting the frame offset
	#emit load.s.alt 0
	#emit sub.alt
	#emit stor.s.pri offset
	// prepare loop
	#emit load.s.pri 0
	#emit stor.s.pri count
	// looping through the frames
	for( ; ; ) {
		// saving the byte offset
		#emit load.s.pri count
		#emit stor.s.pri end
		#emit load.i
		#emit stor.s.pri count

		if(count == 0) {
			break;
		} else {
			#emit load.s.pri count
			#emit load.s.alt end
			#emit sub
			#emit stor.i
		}
	}
	// getting last value to save
	#emit load.s.pri end
	#emit add.c 8
	#emit move.alt
	#emit load.i
	#emit add
	#emit add.c 4
	#emit stor.s.pri end
	// getting count
	#emit load.s.alt current
	#emit sub
	#emit shr.c.pri 2
	#emit stor.s.pri count
	// static
	static const
		func[] = "WakeEx",
		form[] = "aiii"
	;
	// pushing one more cell
	// because the first cell always gets changed to 1000
	// but it doesnt happen within this function, checked
	count += 1;
	current -= 4;
	// calling the timer
	#emit push.adr 4
	#emit push.adr offset
	#emit push.adr count
	#emit push.s current
	#emit push.c form
	#emit push.c 0
	#emit push.s time
	#emit push.c func
	#emit push.c 32
	#emit sysreq.c SetTimerEx
	// resetting stack
	#emit load.s.pri end
	#emit sctrl 4 // stack
	// change to pointers to zero
	#emit zero.pri
	#emit sctrl 5 // frame
	#emit sctrl 6 // cip
	// end
}
*/
/*
forward WakeEx(stack[], count, offset, address);
public WakeEx(stack[], count, offset, address) {
	// storing current frame
	new
		frame
	;
	// recreating stack
	while(count-- != 1) {
		#emit load.s.alt stack
		#emit load.s.pri count
		#emit shl.c.pri 2
		#emit add
		#emit stor.s.pri frame
		#emit lref.s.pri frame
		#emit push.pri
	}
	// getting first frame
	#emit lctrl 4 // stack
	#emit load.s.alt offset
	#emit add
	#emit stor.s.pri frame
	#emit stor.s.pri count
	// setting the frame pointer to the new stack
	for( ; ; ) {
		#emit lref.s.pri count
		#emit stor.s.pri offset

		if(offset == 0) {
			break;
		} else {
			#emit load.s.pri offset
			#emit load.s.alt count
			#emit add
			#emit stor.i
			#emit stor.s.pri count
		}
	}
	// setting the pointers
	#emit load.s.alt count
	#emit lctrl 5 // frame
	#emit stor.i
	#emit const.pri 4
	#emit add
	#emit move.alt
	#emit lctrl 6 // cip
	#emit add.c 48 // 12
	#emit stor.i
	// setting new frame and jumping back into the code
	#emit load.s.pri frame
	#emit load.s.alt address
	#emit sctrl 5 // frame
	#emit move.pri
	#emit sctrl 6 // cip
	// code will return here
}

stock wait(time) {
	new
		current,
		offset,
		count,
		end
	;
	// getting the stack value before this function
	#emit lctrl 4 // stack
	#emit add.c 32 // 4 vars + 2 pointers + byte + 1 parameter
	#emit stor.s.pri current
	// getting the frame offset
	#emit load.s.alt 0
	#emit sub.alt
	#emit stor.s.pri offset
	// prepare loop
	#emit load.s.pri 0
	#emit stor.s.pri count
	// looping through the frames
	for( ; ; ) {
		// saving the byte offset
		#emit load.s.pri count
		#emit stor.s.pri end
		#emit load.i
		#emit stor.s.pri count

		if(count == 0) {
			break;
		} else {
			#emit load.s.pri count
			#emit load.s.alt end
			#emit sub
			#emit stor.i
		}
	}
	// getting last value to save
	#emit load.s.pri end
	#emit add.c 8
	#emit move.alt
	#emit load.i
	#emit add
	#emit add.c 4
	#emit stor.s.pri end
	// getting count
	#emit load.s.alt current
	#emit sub
	#emit shr.c.pri 2
	#emit stor.s.pri count
	// static
	static const
		func[] = "WakeEx",
		form[] = "aiii"
	;
	// pushing one more cell
	// because the first cell always gets changed to 1000
	// but it doesnt happen within this function, checked
	count += 1;
	current -= 4;
	// calling the timer
	#emit push.adr 4
	#emit push.adr offset
	#emit push.adr count
	#emit push.s current
	#emit push.c form
	#emit push.c 0
	#emit push.s time
	#emit push.c func
	#emit push.c 32
	#emit sysreq.c SetTimerEx
	// resetting stack
	#emit load.s.pri end
	#emit sctrl 4 // stack
	// change to pointers to zero
	#emit zero.pri
	#emit sctrl 5 // frame
	#emit sctrl 6 // cip
	// end
}
*/

/*
nTest(3x1000000) {
	new
		text1[] = "[iP]HelloWorld",
		text2[] = "Hello[iP]World",
		text3[] = "HelloWorld[iP]",
		search[] = "[iP]"
	;
	Test("strfind - beginning") {
		strfind(text1, search, false, 0);
	}
	Test("strcmp - beginning") { // same
		strcmp(text1, search, false, sizeof search - 1);
	}
	Test("strfind - middle") {
		strfind(text2, search, false, 0);
	}
	Test("strcmp - middle") { // faster
		strcmp(text2, search, false, sizeof search - 1);
	}
	Test("strfind - end") {
		strfind(text3, search, false, 0);
	}
	Test("strcmp - end") { // faster
		strcmp(text3, search, false, sizeof search - 1);
	}
}
*/
/*
#include <phys_memory>

stock GetAmxBase2() {
	#emit LCTRL 1 // dat
	#emit MOVE.alt
	#emit LCTRL 0 // cod
	#emit SUB // code start = cod - dat
	#emit MOVE.alt
	#emit LOAD.S.pri 4 // return address
	#emit ADD.C 0xFFFFFFFC // return address - 4
	#emit ADD // relocated address pointer = code start + return address - 4
	#emit STOR.S.pri 0xFFFFFFFC // relocated address pointer
	#emit LREF.S.pri 0xFFFFFFFC // relocated address
	#emit CONST.alt GetAmxBase // function address
	#emit SUB // relocated address - function address
	#emit MOVE.alt
	#emit LCTRL 0 // cod
	#emit SUB.alt // relocated address - function address - cod
	#emit RETN

	return 0;
}

main() OnFilterScriptInit();

public OnFilterScriptInit() {
	new
		string[24]
	;
	for(new i = 4; i != 1000; i += 4) {
		ReadPhysMemory(0x004AB8CC, string);
		AlignCellArray(string);
		print(string); // prints "SA-MP Dedicated Server" on SA-MP 0.3d R2
	}
}
*/
/*
main() {
	new
		text[] = "Hello World"
	;
	printf("%d", MyFunc(0, text, 13.5));

	printf("%d", CallLocalFunction("MyFunc", "isf", 1, text, 13.5));
	printf("%d", CallLocalFunction2("MyFunc", "isf", 2, text, 13.5));
	printf("%d", CallLocalFunction3("MyFunc2", 3, text, 13.5));
	printf("%d", CallLocalFunction4("MyFunc", "isf", 4, text, 13.5));
}
*/

/*
main() {
	new
		Int = random(10),
		text[] = "Hello"
	;
	printAssembly(true);
	fCallLocalFunctionRemove("MyFunc", 0b010101, 5, "Hi", Int, text, gFloat, gText);
	printAssembly(true);
}
*/
/*
forward MyFunc(playerid, text[], int, ttext[], Float: fvar, array[]);
public MyFunc(playerid, text[], int, ttext[], Float: fvar, array[]) {
//	printf("%d - \"%s\" - %d - \"%s\" - %f - \"%s\"", playerid, text, int, ttext, fvar, array);

	return playerid;
}

forward MyFunc2(& playerid, text[], & int, ttext[], & Float: fvar, array[]);
public MyFunc2(& playerid, text[], & int, ttext[], & Float: fvar, array[]) {
//	printf("%d - \"%s\" - %d - \"%s\" - %f - \"%s\"", playerid, text, int, ttext, fvar, array);

	return playerid;
}

stock 
	gText[] = "World",
	Float: gFloat = 13.5
;

#include <nTest>

nTest(3x100000) {
	new
		Int = 5,
		text[] = "Hello"
	;

	Test("CallLocalFunction") {
		CallLocalFunction("MyFunc", "isisfs", 3, "Hi", Int, text, gFloat, gText);
	}
	Test("CallLocalFunction2") {
		CallLocalFunction2("MyFunc", "isisfs", 4, "Hi", Int, text, gFloat, gText);
	}
	Test("CallLocalFunction3.1") {
		CallLocalFunction31("MyFunc2", 5, "Hi", Int, text, gFloat, gText);
	}
	Test("CallLocalFunction3.2") {
		CallLocalFunction3("MyFunc2", 5, "Hi", Int, text, gFloat, gText);
	}
	Test("CallLocalFunction4") {
		CallLocalFunction4("MyFunc", "isisfs", 5, "Hi", Int, text, gFloat, gText);
	}
	Test("CallLocalFunction5") {
		CallLocalFunctionRemove("MyFunc2", 5, "Hi", Int, text, gFloat, gText);
	}
	Test("CallLocalFunction6") {
//		printAssembly(false);
		fCallLocalFunctionRemove("MyFunc", 0b010101, 5,  "Hi", Int, text, gFloat, gText);
	}
	Test("CallLocalFunctionByIdx") {
		CallLocalFunctionByIdx(funcidx("MyFunc2"), 5,  "Hi", Int, text, gFloat, gText);
	}
	Test("CallLocalFunctionByIdx2") {
		CallLocalFunctionByIdx2(funcidx("MyFunc"), 0b010101, 5,  "Hi", Int, text, gFloat, gText);
	}
}

stock CallLocalFunctionByIdx2(idx, const form, {Float, _}: ...) {
	if(idx != -1) {
		static const
			offset
		;
		if(offset == 0) {
			#emit lctrl 1 // dat
			#emit neg
			#emit move.alt
			#emit add.c 32 // public
			#emit stor.pri offset
			#emit lref.pri offset
			#emit add
			#emit stor.pri offset
		} {}
		new
			end,
			start,
			power = 1
		;
		#emit addr.pri 16
		#emit stor.s.pri start

		#emit load.s.pri 8
		#emit addr.alt 8
		#emit add
		#emit stor.s.pri end

		while(start < end) {
			if((form & power) == 0) {
				#emit lref.s.pri end
				#emit load.i
				#emit sref.s.pri end
			}
			power <<= 1;
			end -= 4;
		}
		idx = idx * 8 + offset;

		#emit stack 32
		#emit lref.s.alt idx
		#emit load.s.pri 8
		#emit add.c 0xFFFFFFF8
		#emit push.pri
		#emit push.s 4
		#emit load.s.pri 0
		#emit sctrl 5
		#emit move.pri
		#emit sctrl 6
	}
	return 0;
}

stock CallLocalFunctionByIdx(idx, {Float, _}: ...) {
	if(idx != -1) {
		static const
			offset
		;
		if(offset == 0) {
			#emit lctrl 1 // dat
			#emit neg
			#emit move.alt
			#emit add.c 32 // public
			#emit stor.pri offset
			#emit lref.pri offset
			#emit add
			#emit stor.pri offset
		}
		idx = idx * 8 + offset;
		// Resetting the stack (pointer (8) + numargs (4) + params (4))
		#emit stack 16
		// Loading the address
		#emit lref.s.alt idx
		// Pushing data
		#emit load.s.pri 8 // Num Arguments
		#emit add.c 0xFFFFFFFC // -4
		#emit push.pri
		#emit push.s 4 // Return Address
		// Setting the old frame
		#emit load.s.pri 0
		#emit sctrl 5
		// Function call
		#emit move.pri
		#emit sctrl 6
		// End
	}
	return 0;
}

stock CallLocalFunction31(const szFunction[], {Float, _}:...) { // passes all arguments as reference - fastest
	new
		iIndex = funcidx(szFunction)
	;
	if(iIndex != -1) {
		// Resetting the stack (local variable (4) + pointer (8) + numargs (4) + szFunction (4))
		#emit STACK 20
		// Pushing data
		#emit LOAD.S.pri 8 // Num Arguments
		#emit ADD.C 0xFFFFFFFC // -4
		#emit PUSH.pri
		#emit PUSH.S 4 // Return Address
		// Loading the address
		#emit LCTRL 1
		#emit NEG
		#emit MOVE.alt
		#emit ADD.C 32
		#emit STOR.S.pri 4 // 4 isnt needed anymore
		#emit LREF.S.pri 4
		#emit ADD
		#emit LOAD.S.alt iIndex
		#emit SHL.C.alt 3
		#emit ADD
		#emit STOR.S.pri iIndex
		#emit LREF.S.alt iIndex
		// Setting the old frame
		#emit LOAD.S.pri 0
		#emit SCTRL 5
		// Function call
		#emit MOVE.pri
		#emit SCTRL 6
		// End
	}
	return 0;
}

stock CallLocalFunction3(const func[], {Float, _}:...) { // passes all arguments as reference - fastest
	new
		idx = funcidx(func)
	;
	if(idx != -1) {
		static const
			offset
		;
		if(offset == 0) {
			#emit lctrl 1
			#emit neg
			#emit move.alt
			#emit add.c 32
			#emit stor.pri offset
			#emit lref.pri offset
			#emit add
			#emit stor.pri offset
		} {}
		// Resetting the stack
		#emit stack 20
		// Pushing data
		#emit load.s.pri 8
		#emit add.c 0xFFFFFFFC // -4
		#emit push.pri
		#emit push.s 4
		// Loading the address
		idx = idx * 8 + offset;

		#emit lref.s.alt idx
		// Setting old frame
		#emit load.s.pri 0
		#emit sctrl 5
		// Function call
		#emit move.pri
		#emit sctrl 6
		// End
	}
	return 0;
}


//	Changing the parameter by the type (binar, by value - by reference)
//	Calling another function which only passes the parameter

stock fCallLocalFunctionRemove(const func[], const form, {Float, _}:...) {
	#pragma unused func

	static
		address
	;
	new
		idx,
		heap,
		opcode,
		args = numargs() - 2,
		power = 1 << args
	;
	// Fetching position in code
	#emit load.s.alt 4
	#emit lctrl 0
	#emit add
	#emit move.alt
	#emit lctrl 1
	#emit sub.alt
	#emit add.c 0xFFFFFFFC // -4
	#emit stor.s.pri idx
	#emit add.c 8
	#emit stor.s.pri heap
	// Calculating the real address
	if(address == 0) {
		#emit lref.s.pri idx
		#emit const.alt fCallLocalFunctionRemove
		#emit sub
		#emit add.c CallLocalFunction3
		#emit stor.pri address
	} {}
	// Setting new address
	#emit load.pri address
	#emit sref.s.pri idx
	// Changing bytes value
	#emit load.s.pri idx
	#emit add.c 0xFFFFFFF8 // -8
	#emit stor.s.pri idx
	#emit lref.s.pri idx
	#emit add.c 0xFFFFFFFC // -4
	#emit sref.s.pri idx
	// Removing the unused parameter
	#emit const.alt 134 // nop
	#emit load.s.pri idx
	#emit add.c 0xFFFFFFF0 // -16
	#emit stor.s.pri idx
	#emit sref.s.alt idx
	#emit add.c 0xFFFFFFFC // -4
	#emit stor.s.pri idx
	#emit sref.s.alt idx
	// Changing push opcode's
	while(args--) {
		idx -= 8;
		power >>= 1;

		if((form & power) == 0) {
			#emit lref.s.pri idx
			#emit stor.s.pri opcode

			switch(opcode) {
				case 39: { // push.c
					#emit const.pri 40 // push
					#emit sref.s.pri idx
				}
				case 133: { // push.adr
					#emit const.pri 41 // push.s
					#emit sref.s.pri idx
				}
				case 23: { // stor.i
					#emit const.alt 134 // nop
					#emit sref.s.alt idx
					#emit load.s.pri idx
					#emit add.c 4
					#emit stor.s.pri idx
					#emit sref.s.alt idx
					#emit add.c 0xFFFFFFF8 // -8
					#emit stor.s.pri idx
					#emit sref.s.alt idx
					#emit add.c 0xFFFFFFFC // -4
					#emit stor.s.pri idx
					#emit sref.s.alt idx
					#emit const.alt 39 // push.c
					#emit add.c 0xFFFFFFF8 // -8
					#emit stor.s.pri idx
					#emit sref.s.alt idx
					// fixing heap
					#emit lref.s.pri heap
					#emit stor.s.pri opcode

					if(opcode == -4) {
						#emit const.alt 134 // nop
						#emit sref.s.alt heap
						#emit load.s.pri heap
						#emit add.c 0xFFFFFFFC // -4
						#emit stor.s.pri opcode
						#emit sref.s.alt opcode
					} else {
						#emit load.s.pri opcode
						#emit add.c 4
						#emit sref.s.pri heap
					}
				}
			}
		}
	}
	// Changing return pointer
	#emit load.s.pri heap
	#emit add.c 0xFFFFFFFC // -4
	#emit load.s.alt idx
	#emit sub
	#emit load.s.alt 4
	#emit stor.s.alt idx
	#emit sub.alt
	#emit stor.s.pri 4
	#emit stor.s.pri heap

	return false;
}

stock CallLocalFunctionRemove(const func[], {Float, _}:...) {
	new
		idx = funcidx(func)
	;
	if(idx != -1) {
		// Getting address of the new function
		#emit lctrl 1
		#emit neg
		#emit move.alt
		#emit add.c 32
		#emit stor.s.pri 12
		#emit lref.s.pri 12
		#emit add
		#emit load.s.alt idx
		#emit shl.c.alt 3
		#emit add
		#emit stor.s.pri 12
		#emit lref.s.pri 12
		#emit stor.s.pri 12
		// Calculating the jump offset
		#emit load.s.alt 4
		#emit lctrl 0
		#emit add
		#emit move.alt
		#emit lctrl 1
		#emit sub.alt
		#emit add.c 0xFFFFFFFC // -4
		#emit stor.s.pri idx
		#emit lref.s.pri idx
		#emit const.alt CallLocalFunctionRemove
		#emit sub
		// Setting new address
		#emit load.s.alt 12
		#emit add
		#emit sref.s.pri idx
		// Changing bytes value
		#emit load.s.pri idx
		#emit add.c 0xFFFFFFF8 // -8
		#emit stor.s.pri idx
		#emit lref.s.pri idx
		#emit add.c 0xFFFFFFFC // -4
		#emit sref.s.pri idx
		// Removing the func parameter
		#emit const.alt 134 // nop
		#emit load.s.pri idx
		#emit add.c 0xFFFFFFF8 // -8
		#emit stor.s.pri idx
		#emit sref.s.alt idx
		#emit add.c 0xFFFFFFFC // -4
		#emit stor.s.pri idx
		#emit sref.s.alt idx
		// Calling function
		#emit stack 20
		#emit load.s.pri 0
		#emit load.s.alt 4
		#emit sctrl 5
		#emit move.pri
		#emit add.c 0xFFFFFFF0 // -16
		#emit sctrl 6
	}
	return 0;
}

stock CallLocalFunction4(const szFunction[], const szFormat[], {Float, _}:...) {
	new
		iTemp,
		iArg = strlen(szFormat),
		iIndex = funcidx(szFunction)
	;
	if(iIndex != -1) {
		// Resetting the stack (local variable (12) + pointer (8) + numargs (4) + szFunction (4) + szFormat)
		#emit STACK 32
		// Getting the last argument
		#emit LOAD.S.pri 8
		#emit ADD.C 0xFFFFFFF8 // -8
		#emit ADDR.alt 16
		#emit ADD
		#emit STOR.S.pri iTemp
		// Loading the values
		while(--iArg != -1) {
			switch(szFormat[iArg]) {
				case 's', 'a', 'v': {}
				default: {
					// Loading the address
					#emit LREF.S.pri iTemp
					// Loading the value
					#emit LOAD.I
					// Storing it into the argument
					#emit SREF.S.pri iTemp
				}
			}
			iTemp -= 4;
		}
		// Pushing data
		#emit LOAD.S.pri 8 // Num Arguments
		#emit ADD.C 0xFFFFFFF8 // -8
		#emit PUSH.pri
		#emit PUSH.S 4 // Return Address
		// Loading the address
		#emit LCTRL 1
		#emit NEG
		#emit MOVE.alt
		#emit ADD.C 32
		#emit STOR.S.pri 4 // 4 isnt needed anymore
		#emit LREF.S.pri 4
		#emit ADD
		#emit LOAD.S.alt iIndex
		#emit SHL.C.alt 3
		#emit ADD
		#emit STOR.S.pri iIndex
		#emit LREF.S.alt iIndex
		// Setting the old frame
		#emit LOAD.S.pri 0
		#emit SCTRL 5
		// Function call
		#emit MOVE.pri
		#emit SCTRL 6
		// End
	}
	return 0;
}

stock CallLocalFunction2(const szFunction[], const szFormat[], {Float, _}:...) {
    new
             iFunc,
             iIndex,
             iTemp,
             iNumArgs = strlen(szFormat),
             iArg = iNumArgs,
        bool:bPackedFormat = ispacked(szFormat)
    ;
   
    // Get the function's address
    if (-1 != (iIndex = funcidx(szFunction))) {
        // Load the, "offset", to DAT from the prefix
        #emit LCTRL        1
       
        // Invert it so we have the, "offset", to the prefix from DAT
        #emit NEG
       
        // Copy it to alt for use later
        #emit MOVE.alt
       
        // Add 32 to jump to the, "offset", containing the public function's table
        #emit ADD.C        32
       
        // Read the value there; must be done using LREF because
        // it's outside of the DAT section
        #emit STOR.S.pri   iTemp
        #emit LREF.S.pri   iTemp
       
        // Add the value we just loaded to the prefix (that we stored in alt)
        #emit ADD
       
        // Add index * 8 (each entry contains 2 cells - a pointer to the function's name
        // and a pointer to the function itself, relative to COD).
        #emit LOAD.S.alt   iIndex
        #emit SHL.C.alt    3
       
        // Add that to the offset
        #emit ADD
       
        // Now get the address it's pointing to. This seems to only work
        // using LREF (as opposed to LOAD.I, for example).
        #emit STOR.S.pri   iTemp
        #emit LREF.S.pri   iTemp
       
        // Now store it
        #emit STOR.S.pri   iFunc
    } else {
        return 0;
    }
   
    while (--iArg >= 0) {
        switch (bPackedFormat ? szFormat{iArg} : szFormat[iArg]) {
            // String, array, and variables passed by reference
            case 's', 'a', 'v': {
                // Load the frame pointer
                #emit LCTRL 5
               
                // Add 12 + (2 + iArg) * 4 to get the argument we want
                #emit LOAD.S.alt  iArg
                #emit SHL.C.alt   2
                #emit ADD
                #emit ADD.C       20
               
                // Load the address there
                #emit LOAD.I
               
                // Push that address
                #emit PUSH.pri
            }
           
            // Single-cell arguments passed by value; I used "default"
            // here because it seems that's what CallLocalFunction does.
            default: {
                // Load the frame pointer
                #emit LCTRL 5
               
                // Add 12 + (2 + iArg) * 4 to get the argument we want
                #emit LOAD.S.alt  iArg
                #emit SHL.C.alt   2
                #emit ADD
                #emit ADD.C       20
               
                // Load the address there
                #emit LOAD.I
               
                // Load the value that address points to
                #emit LOAD.I
               
                // Push that value
                #emit PUSH.pri
            }
        }
    }
   
    // Push iNumArgs * 4
    #emit LOAD.S.pri  iNumArgs
    #emit SHL.C.pri   2
    #emit PUSH.pri
   
    // Push the return address
    #emit LCTRL       6
    #emit ADD.C       28
    #emit PUSH.pri
   
    // Call the function
    #emit LOAD.S.pri  iFunc
    #emit SCTRL       6
   
    // Restore the stack
    #emit STACK       24
   
    // Return (pri is the return value, which comes from iFunc)
    #emit RETN
   
    // Never actually happens
    return 0;
}
*/
/*
stock CallLocalFunction3(const szFunction[], const szFormat[], {Float, _}:...) { // same speed as CLF2
	new
		iIndex = funcidx(szFunction),
		iArg = strlen(szFormat),
		iNum = (numargs() - 2),
		iTemp
	;
	if((iIndex != -1) && (iArg == iNum)) {
		// Resetting the stack (local variables (16) + pointer (8) + numargs (4) + szFunction (4) + szFormat (4))
		#emit STACK 36
		// Getting the last argument
		#emit LOAD.S.alt iArg
		#emit SHL.C.alt 2
		#emit ADDR.pri 16
		#emit ADD
		#emit STOR.S.pri iTemp
		#emit STOR.S.alt iNum
		// Loading the values
		while(--iArg != -1) {
			switch(szFormat[iArg]) {
				case 's', 'a', 'v': {}
				default: {
					// Loading the address
					#emit LREF.S.pri iTemp
					// Loading the value
					#emit LOAD.I
					// Storing it into the argument
					#emit SREF.S.pri iTemp
				}
			}
			iTemp -= 4;
		}
		// Pushing data
		#emit PUSH.S iNum
		#emit PUSH.S 4 // Return Address
		// Loading the address
		#emit LCTRL 1
		#emit NEG
		#emit MOVE.alt
		#emit ADD.C 32
		#emit STOR.S.pri iTemp
		#emit LREF.S.pri iTemp
		#emit ADD
		#emit LOAD.S.alt iIndex
		#emit SHL.C.alt 3
		#emit ADD
		#emit STOR.S.pri iIndex
		#emit LREF.S.alt iIndex
		// Setting the old frame
		#emit LOAD.S.pri 0
		#emit SCTRL 5
		// Function call
		#emit MOVE.pri
		#emit SCTRL 6
		// End
	}
	return 0;
}
*/
/*
forward Function();
public Function() {
	return 10;
}

public OnFilterScriptInit() {
	new
		var
	;
	#emit CONST.pri Function
	#emit STOR.S.pri var

	printf("1. %d", var);

	var = funcidx("Function");

	#emit PUSH.S var
	#emit LCTRL 1
	#emit NEG
	#emit MOVE.alt
	#emit ADD.C 32
	#emit STOR.S.pri var
	#emit LREF.S.pri var
	#emit ADD
	#emit POP.alt
	#emit SHL.C.alt 3
	#emit ADD
	#emit STOR.S.pri var
	#emit LREF.S.pri var
	#emit STOR.S.pri var

	printf("2. %d", var);

	#emit LCTRL 6
	#emit ADD.C 28
	#emit PUSH.pri
	#emit LOAD.S.pri var
	#emit SCTRL 6

	#emit STOR.S.pri var

	printf("3. %d", var);
}
*/
/*
stock GetRandomPlayer(bool: init = false) {
    static
        iCount,
        iPlayers[MAX_PLAYERS]
    ;
    if(init) {
        for((_: init) = iCount = 0; (_: init) != MAX_PLAYERS; ++init) {
            if(IsPlayerConnected(_: init)) {
                iPlayers[iCount++] = _: init;
            }
        }
    }
    if(iCount != 0) {
		new
			rand = random(iCount)
		;
		(_: init) = iPlayers[rand];
        iPlayers[rand] = iPlayers[--iCount];
        return _: init;
    }
    return INVALID_PLAYER_ID;
}

public OnFilterScriptInit() {
	print("Test");
	printf("%d", GetRandomPlayer(true));
}
*/
/*
nTest(3x10000) {
	new	const
		source[] = "this is a test to see if this works as expected!"
	;
	new
		tmp[sizeof source]
	;

	Test("strdel_ryd1") {
		strdel_ryd1((tmp = source, tmp), "this", "test", "if", "works", "expected", "!");
	}
	print(tmp);

	Test("strdel_nero") {
		strdel_nero((tmp = source, tmp), "this", "test", "if", "works", "expected", "!");
	}
	print(tmp);

	Test("strdel_words") {
		strdel_words((tmp = source, tmp), "this", "test", "if", "works", "expected", "!");
	}
	print(tmp);

	Test("strDelete") {
		strDelete((tmp = source, tmp), "this", "test", "if", "works", "expected", "!");
	}
	print(tmp);
}

stock strdel1(string[], ...) // By: SuYaNw's / Garfie
{
    new percorrer = 0;

    for(new size = strlen(string); percorrer != size; ++percorrer){
        string[percorrer] =  tolower(string[percorrer]);
    }

    percorrer = 1;
    for(new argumentos = numargs(); percorrer != argumentos; ++percorrer)
    {
        new tempstr[32];
        for(new juntar = 0; 0 != getarg(percorrer, juntar); ++juntar){
            tempstr[juntar]  = getarg(percorrer, juntar);
        }
        if(strfind(string, tempstr, true) != -1){

            new posicao = strfind(string, tempstr, true);
            strdel(string, posicao - 1, posicao + strlen(tempstr));
        }
    }
    return 1;
}

stock strdel_ryd1(szStr[], ...) {
//	printf("strdel2(\"%s\")", szStr);

    new
        szArg[128],
        iStart = 12,
        iEnd,
        iLen
    ;
    #emit LOAD.S.PRI 8
    #emit ADD.C 8
    #emit STOR.S.PRI iEnd
   
    for( ; iEnd > iStart; iEnd -= 4, szArg[0] = EOS) {
        #emit LCTRL 5
        #emit LOAD.S.ALT iEnd
        #emit ADD
        #emit LOAD.I
        #emit MOVE.ALT
       
        #emit PUSH.ALT
        #emit PUSH.C 4
        #emit SYSREQ.C strlen
        #emit INC.PRI
        #emit STOR.S.PRI iLen
       
        #emit PUSH.S iLen
        #emit PUSH.ALT
        #emit PUSH.ADR szArg
        #emit PUSH.C 12
        #emit SYSREQ.C strcat
        #emit STACK 24

//		printf("%d - %s", iLen, szArg);
       
        new
            iPos
        ;
        while((iPos = strfind(szStr, szArg, true, iPos)) != -1) {
            strdel(szStr, iPos, iPos + iLen);
        }
    }
    return 1;
}

stock strdel_nero(szStr[], ...) {
    new
		iAddress,
        iStart,
        iEnd,
        iLen,
		iPos
    ;
	#emit ADDR.pri		12
	#emit STOR.S.pri	iStart
	#emit LOAD.S.alt	8
	#emit ADD
	#emit STOR.S.pri	iEnd

    while(iStart < (iEnd -= 4)) {
		#emit LREF.S.alt	iEnd
		#emit STOR.S.alt	iAddress

        #emit PUSH.alt
        #emit PUSH.C		4
        #emit SYSREQ.C		strlen
        #emit INC.pri
		#emit STOR.S.pri	iLen

		#emit PUSH.C		0
		#emit PUSH.C		1
		#emit PUSH.S		iAddress
		#emit PUSH.S		szStr
		#emit PUSH.C		16
		#emit SYSREQ.C		strfind
		#emit STOR.S.pri	iPos

		#emit STACK			28

		while(iPos != -1) {
			#emit LOAD.S.pri	iLen
			#emit LOAD.S.alt	iPos
			#emit ADD
			#emit PUSH.pri
			#emit PUSH.alt
			#emit PUSH.S		szStr
			#emit PUSH.C		12
			#emit SYSREQ.C		strdel

			#emit PUSH.alt
			#emit PUSH.C		1
			#emit PUSH.S		iAddress
			#emit PUSH.S		szStr
			#emit PUSH.C		16
			#emit SYSREQ.C		strfind
			#emit STOR.S.pri	iPos

			#emit STACK			36
		}
    }
	return false;
}

stock strdel_words(string[], ...) {
    new pos = 0, len;
   
    for (new i = numargs() - 1; i > 0; i--) {
		PointerByArgument(i);

        len = strlen(g_aaiPointers[0][0]);
       
        while (-1 != (pos = strfind(string, g_aaiPointers[0][0], true)))
            strdel(string, pos, pos + len);
    }
}

stock strDelete(szStr[], ...) {
    new
        iStart,
        iAddr,
        iLen,
        iPos
    ;
    #emit ADDR.PRI      szStr
    #emit ADD.C         4
    #emit STOR.S.PRI    iStart
   
    for(new iEnd = iStart + ((numargs() - 1) << 2); iEnd != iStart; iStart += 4) {
        #emit LOAD.S.PRI    iStart
        #emit LOAD.I
        #emit STOR.S.PRI    iAddr
       
        #emit PUSH.S        iAddr
        #emit PUSH.C        4
        #emit SYSREQ.C      strlen
        #emit INC.PRI
        #emit STOR.S.PRI    iLen
        #emit STACK         8
       
		LOOP:

        #emit PUSH.C        0
        #emit PUSH.C        1
        #emit PUSH.S        iAddr
        #emit PUSH.S        szStr
        #emit PUSH.C        16
        #emit SYSREQ.C      strfind
        #emit STACK         20
        #emit STOR.S.PRI    iPos
           
        if(iPos != -1) {
            #emit LOAD.S.PRI    iPos
            #emit LOAD.S.ALT    iLen
            #emit ADD
            #emit DEC.PRI
            #emit PUSH.PRI
            #emit PUSH.S        iPos
            #emit PUSH.S        szStr
            #emit PUSH.C        12
            #emit SYSREQ.C      strdel
            #emit STACK         16

            goto LOOP;
        }
    }
    return 1;
}
*/
/*
stock Address: CreateLongString(delimiter, ...) {
	new
		num = numargs()
	;
	if(1 < num) {
		new
			arg
		;
		#emit ADDR.alt			12
		#emit LOAD.S.pri		num
		#emit SMUL.C			4
		#emit ADD
		#emit STOR.S.pri		num
		#emit ADDR.pri			20
		#emit STOR.S.pri		arg

		for( ; arg != num; arg += 4) {
			#emit LREF.S.pri	arg
			#emit ADD.C			0xFFFFFFFC
			#emit MOVE.alt
			#emit LOAD.S.pri	delimiter
			#emit STOR.I
		}
		#emit LOAD.S.pri		16
		#emit STACK				8
		#emit RETN
	}
	return Address: 0;
}

#define GetPointer(%0) (_: %0[0][0])
#define Pointer<%0> Pointer: %0[1][1]

stock SetPointer(Pointer: pointer[1][1], Address: address) {
	#emit LOAD.S.alt	pointer
	#emit LOAD.S.pri	address
	#emit SUB
	#emit STOR.I
}

public OnFilterScriptInit() {
	new
		Pointer<lPointer>
	;
	SetPointer(lPointer,
		CreateLongString('\n',
			"",
			"Hello World",
			"How are you?",
			"Fine thanks!",
			""
		)
	);
	print(GetPointer(lPointer));
}
*/
/*
forward CALLED();

public CALLED()
{
    strcat("", "", 0);
    printf("");
}

stock setstringarg1(iArg, const szValue[], iLength = sizeof(szValue)) {
    new
        iAddress
    ;
    // Get the address of the previous function's stack.  First get the index of
    // the argument required.
    #emit LOAD.S.pri iArg
    // Then convert that number to bytes from cells.
    #emit SMUL.C     4
    // Get the previous function's frame.
    #emit LOAD.S.alt 0
    // Add the frame pointer to the argument, "offset", in bytes.
    #emit ADD
    // Add 12 to skip over the function header.
    #emit ADD.C      12
    // Load the address stored in the specified address.
    #emit LOAD.I
    #emit STOR.S.PRI iAddress

    // Push the length (last argument first)
    #emit PUSH.S     iLength

    // Push the new value (source) szValue
    #emit PUSH.S     szValue

    // Blank out the first cell of the argument
    #emit CONST.pri  0
    #emit SREF.S.pri iAddress
   
    // Push the destination
    #emit PUSH.S     iAddress

    // Push the number of parameters passed (in bytes) to the function.
    #emit PUSH.C     12
   
    // Call the function.
    #emit SYSREQ.C   strcat
   
    // Restore the stack to its level before we called this native.
    #emit STACK      16
}

#define setstringarg2(%0,%1,%2) \
    do \
    { \
        new __i=0,ch; \
        while ((ch=%1[__i])&&__i<%2) setarg(%0,__i++,ch); \
    } \
    while (FALSE)

new
    bool:FALSE = false;

stock setstringarg3(arg, source[], maxlength = sizeof source) {
	#emit LOAD.S.pri arg
	#emit SMUL.C     4
	#emit LOAD.S.alt 0
	#emit ADD
	#emit ADD.C      12
	#emit LOAD.I
	#emit MOVE.alt
	#emit PUSH.S     maxlength
	#emit PUSH.S     source
	#emit CONST.pri  0
	#emit STOR.I
	#emit PUSH.alt
	#emit PUSH.C     12
	#emit SYSREQ.C   strcat
	#emit STACK      16
}

nTest(5)(1000000) {
	new
		str[32]
	;
	Test("setstringarg1") {
		Func1("Hello Y_Less", sizeof str, str);
	}
	print(str);
	str[0] = EOS;
	Test("setstringarg2") {
		Func2("Hello Y_Less", sizeof str, str);
	}
	print(str);
	str[0] = EOS;
	Test("setstringarg3") {
		Func3("Hello Y_Less", sizeof str, str);
	}
	print(str);
}

Func1(str[], const size, ...) {
	setstringarg1(2, str, size);
}
stock Func2(str[], const size, ...) {
	setstringarg2(2, str, size);
}
Func3(str[], const size, ...) {
	setstringarg3(2, str, size);
}
*/
/*
forward CALLED();

public CALLED()
{
    strcat("", "", 0);
    printf("");
}

getstringarg1(dest[], arg, len = sizeof (dest))
{
    // Get the address of the previous function's stack.  First get the index of
    // the argument required.
    #emit LOAD.S.pri arg
    // Then convert that number to bytes from cells.
    #emit SMUL.C     4
    // Get the previous function's frame.
    #emit LOAD.S.alt 0
    // Add the frame pointer to the argument, "offset", in bytes.
    #emit ADD
    // Add 12 to skip over the function header.
    #emit ADD.C      12
    // Load the address stored in the specified address.
    #emit LOAD.I
    // Push the length for "strcat".
    #emit PUSH.S     len
    // Push the address we just determined was the source.
    #emit PUSH.pri
    // Load the address of the destination.
    #emit LOAD.S.alt dest
    // Blank the first cell so "strcat" behaves like "strcpy".
    #emit CONST.pri  0
    // Store the loaded number 0 to the loaded address.
    #emit STOR.I
    // Push the loaded address.
    #emit PUSH.alt
    // Push the number of parameters passed (in bytes) to the function.
    #emit PUSH.C     12
    // Call the function.
    #emit SYSREQ.C   strcat
    // Restore the stack to its level before we called this native.
    #emit STACK      16
}

#define getstringarg2(%0,%1,%2) \
    do \
    { \
        new __i=0,ch; \
        while ((ch=getarg(%1,__i))&&__i<%2) %0[__i++]=ch; \
        %0[__i]='\0'; \
    } \
    while (FALSE)

new
    bool:FALSE = false;

nTest(3)(1000000) {
	new
		str[32]
	;
	Test("getstringarg1") {
		Func1(str, sizeof str, "Hello", "There", "Y_Less");
	}
	Test("getstringarg2") {
		Func2(str, sizeof str, "Hello", "There", "Y_Less");
	}
}

Func1(str[], const size, ...) {
	getstringarg1(str, 2, size);
	getstringarg1(str, 3, size);
	getstringarg1(str, 4, size);
}
Func2(str[], const size, ...) {
	getstringarg2(str, 2, size);
	getstringarg2(str, 3, size);
	getstringarg2(str, 4, size);
}
*/
/*
#include <nFile>
#include <YSI\y_ini>
#include <dFile>
#include <dini>

new
	gName[] = "Y_Less",
	Float: gHealth,
	gScore
;

#pragma unused gName, gHealth, gScore

nTest(3)(1000) {
	new
		Float: health = random(100) + 1.0,
		tmp[MAX_BUFFER_LENGTH char],
		score = random(50),
		name[] = "Y_Less"
	;
	Test("y_ini init write") {
		fremove("y_ini.ini");

		new
			INI:ini = INI_Open("y_ini.ini")
		;
		INI_SetTag(ini, "LVDM");
		INI_WriteString(ini, "NAME", name);
		INI_WriteInt(ini, "SCORE", score);
		INI_WriteFloat(ini, "HEALTH", health);
		INI_Close(ini);
	}
	Test("plain init write") {
		fremove("plain.txt");

		new
			File: gFile = fopen("plain.txt", io_write)
		;
		fwrite(gFile, name);
		fblockwrite(gFile, !"\n\r");
		valstr(tmp, score, false),
		fwrite(gFile, tmp);
		fblockwrite(gFile, !"\n\r");
		format(tmp, sizeof tmp, "%f", health);
		fwrite(gFile, tmp);
		fblockwrite(gFile, !"\n\r");
		fclose(gFile);
	}
	Test("nFile init write") {
		fremove("nfile.txt");

		new
			File: gFile = nFile::fopen("nfile.txt", io_write)
		;
		nFile::fwrite(gFile, "s[*]d[4]f[8]", sizeof name, name, score, health);
		nFile::fclose(gFile);
	}
	Test("dFile init write") {
		fremove("dfile.txt");

		dfile_Create("dfile.txt");
		dfile_Open("dfile.txt");
		dfile_WriteString("NAME", name);
		dfile_WriteInt("SCORE", score);
		dfile_WriteFloat("HEALTH", health);
		dfile_SaveFile();
		dfile_CloseFile();
	}
	Test("dini init write") {
		fremove("dini.txt");

		dini_Create("dini.txt");
		dini_Set("dini.txt", "NAME", name);
		dini_IntSet("dini.txt", "SCORE", score);
		dini_FloatSet("dini.txt", "HEALTH", health);
	}
	Test("y_ini write") {
		new
			INI:ini = INI_Open("y_ini.ini")
		;
		INI_SetTag(ini, "LVDM");
		INI_WriteString(ini, "NAME", name);
		INI_WriteInt(ini, "SCORE", score);
		INI_WriteFloat(ini, "HEALTH", health);
		INI_Close(ini);
	}
	Test("plain write") {
		new
			File: gFile = fopen("plain.txt", io_readwrite)
		;
		fwrite(gFile, name);
		fblockwrite(gFile, !"\n\r");
		valstr(tmp, score, false),
		fwrite(gFile, tmp);
		fblockwrite(gFile, !"\n\r");
		format(tmp, sizeof tmp, "%f", health);
		fwrite(gFile, tmp);
		fblockwrite(gFile, !"\n\r");
		fclose(gFile);		
	}
	Test("nFile write") {
		new
			File: gFile = nFile::fopen("nfile.txt", io_readwrite)
		;
		nFile::fwrite(gFile, "s[*]d[4]f[8]", sizeof name, name, score, health);
		nFile::fclose(gFile);
	}
	Test("dFile write") {
		dfile_Open("dfile.txt");
		dfile_WriteString("NAME", name);
		dfile_WriteInt("SCORE", score);
		dfile_WriteFloat("HEALTH", health);
		dfile_SaveFile();
		dfile_CloseFile();
	}
	Test("dini write") {
		dini_Set("dini.txt", "NAME", name);
		dini_IntSet("dini.txt", "SCORE", score);
		dini_FloatSet("dini.txt", "HEALTH", health);
	}
	Test("y_ini read") {
		INI_Load("y_ini.ini");

//		printf("\"%s\" - %d - %f", gName, gScore, gHealth);
	}
	Test("plain read") {
		new
			File: gFile = fopen("plain.txt", io_read)
		;
		while(fread(gFile, tmp)) {
//			print(tmp);
		}

		fclose(gFile);		
	}
	Test("nFile read") {
		new
			File: gFile = nFile::fopen("nfile.txt", io_read)
		;
		nFile::fread(gFile, "sdf", name, score, health);
		nFile::fclose(gFile);

//		printf("\"%s\" - %d - %f", name, score, health);
	}
	Test("dFile read") {
        dfile_Open("dfile.txt");
//		printf("\"%s\" - %d - %f", 
		dfile_ReadString("NAME"),
		dfile_ReadInt("SCORE"),
		dfile_ReadFloat("HEALTH")
//		)
		;
	}
	Test("dini read") {
//		printf("\"%s\" - %d - %f",
		dini_Get("dini.txt", "NAME"),
		dini_Int("dini.txt", "SCORE"),
		dini_Float("dini.txt", "HEALTH")
//		)
		;
	}
	fremove("y_ini.ini");
	fremove("plain.txt");
	fremove("nfile.txt");
	fremove("dfile.txt");
	fremove("dini.txt");
}

INI:y_ini[LVDM](name[], value[]) {
	INI_String("NAME", gName, sizeof gName);
	INI_Int("SCORE", gScore);
	INI_Float("HEALTH", gHealth);

	return true;
}
*/
/*
stock ProxDetector_old(Float:radi, playerid, string[], col1, col2, col3, col4, col5) {
	new
		i,
		Float: x,
		Float: y,
		Float: z,
		Float: pX,
		Float: pY,
		Float: pZ
	;
	if(GetPlayerPos(playerid, pX, pY, pZ)) {
		while(i != MAX_PLAYERS) {
			if(GetPlayerPos(i, x, y, z)) {
				x = (pX - x);
				y = (pY - y);
				z = (pZ - z);

				if((-(radi / 16) < x < (radi / 16)) && (-(radi / 16) < y < (radi / 16)) && (-(radi / 16) < z < (radi / 16))) {
					SendClientMessage(i, col1, string);
				} else if((-(radi / 8) < x < (radi / 8)) && (-(radi / 8) < y < (radi / 8)) && (-(radi / 8) < z < (radi / 8))) {
					SendClientMessage(i, col2, string);
				} else if((-(radi / 4) < x < (radi / 4)) && (-(radi / 4) < y < (radi / 4)) && (-(radi / 4) < z < (radi / 4))) {
					SendClientMessage(i, col3, string);
				} else if((-(radi / 2) < x < (radi / 2)) && (-(radi / 2) < y < (radi / 2)) && (-(radi / 2) < z < (radi / 2))) {
					SendClientMessage(i, col4, string);
				} else if((-(radi) < x < (radi)) && (-(radi) < y < (radi)) && (-(radi) < z < (radi))) {
					SendClientMessage(i, col5, string);
				}
			}
			i += 1;
		}
		return true;
	}
	return false;
}

stock ProxDetector_new(Float:radi, playerid, string[], col1, col2, col3, col4, col5) {
	new
		i,
		Float: x,
		Float: y,
		Float: z,
		Float: pX,
		Float: pY,
		Float: pZ
	;
	if(GetPlayerPos(playerid, pX, pY, pZ)) {
		while(i != MAX_PLAYERS) {
			if(GetPlayerPos(i, x, y, z)) {
				x = (pX - x);
				y = (pY - y);
				z = (pZ - z);

				if(IsPlayerInRangeOfPoint(playerid, (radi / 16), x, y, z)) {
					SendClientMessage(i, col1, string);
				} else if(IsPlayerInRangeOfPoint(playerid, (radi / 8), x, y, z)) {
					SendClientMessage(i, col2, string);
				} else if(IsPlayerInRangeOfPoint(playerid, (radi / 4), x, y, z)) {
					SendClientMessage(i, col3, string);
				} else if(IsPlayerInRangeOfPoint(playerid, (radi / 2), x, y, z)) {
					SendClientMessage(i, col4, string);
				} else if(IsPlayerInRangeOfPoint(playerid, (radi), x, y, z)) {
					SendClientMessage(i, col5, string);
				}
			}
			i += 1;
		}
		return true;
	}
	return false;
}

stock ProxDetector_double(playerid, const msg [], color, maxdistance = 50)
{
    new
        Float: x,
        Float: y,
        Float: z,
        distance,
        string [128];

    if (GetPlayerName (playerid, string, sizeof string))
    {
        format (string, sizeof string, "%s says: %s", string, playerid, msg);
        GetPlayerPos (playerid, x, y, z);
        for (new i = 0; i < MAX_PLAYERS; ++i)
        {
            if (IsPlayerConnected (i) && !IsPlayerNPC (i))
            {
                if (i == playerid)
                    SendClientMessage (i, color, string);
                else
                {
                    distance = floatround (GetPlayerDistanceFromPoint (i, x, y, z));
                    if (distance <= maxdistance)
                        SendClientMessage (i, ColorFade (color, distance, maxdistance), string);
                }
            }
        }
        return 1;
    }
    return 0;
}

stock ColorFade (color, value, maxvalue)
{
    if (0 <= value <= maxvalue)
    {
        new
            Float: ratio = float (value) / float (maxvalue);
        new
            r = max (0, min (255, floatround (float ((color >> 24) & 0xFF) * ratio))),
            g = max (0, min (255, floatround (float ((color >> 16) & 0xFF) * ratio))),
            b = max (0, min (255, floatround (float ((color >> 8) & 0xFF) * ratio)));
        return (r << 24) | (g << 16) | (b << 8) | (value & 0xFF);
    }
    return 0;
}

stock ProxDetector_Nero(const playerid, Float: radius, const text[], ...) {
    new // Nero_3D @ 11.07.2011
        num = numargs() - 1;
    if(2 < num) {
        new
            Float: pX,
            Float: pY,
            Float: pZ
		;
        if(GetPlayerPos(playerid, pX, pY, pZ)) {
            new
				i,
                Float: distance
			;
            for(radius *= radius; i != MAX_PLAYERS; ++i) { // foreach if possible
                if((distance = GetPlayerDistanceFromPoint(i, pX, pY, pZ))) {
                    if(1.0 <= (distance = (radius / (distance + 0.1)))) {
                        SendClientMessage(i, getarg(max((num - (floatround(floatlog(distance, 2.0), floatround_floor) / 2)), 3), 0), text);
                    }
                }
            }
            return true;
        }
    }
    return false;
}

public OnFilterScriptInit() {
	if(!IsPlayerNPC(0)) {
		new
			cmd[16] = "maxnpc ",
			players = GetMaxPlayers()
		;
		valstr(cmd[7], players, false); 
		SendRconCommand(cmd);

		ConNPC();
	}
	nTest_Start(0);
}

public OnPlayerConnect(playerid) {
	if(IsPlayerNPC(playerid)) {
		SetTimer("ConNPC", 1000, false);
	}
}

forward ConNPC();
public ConNPC() {
	static
		name[8] = "NPC",
		count = 0
	;
	valstr(name[3], count++, false);
	ConnectNPC(name, "npcidle");
}

nTest(3)(10000) {
	new
		string[] = "Hello World"
	;
	new const
		col1 = random(0xFFFFFF) << 8 | 0xFF,
		col2 = random(0xFFFFFF) << 8 | 0xFF,
		col3 = random(0xFFFFFF) << 8 | 0xFF,
		col4 = random(0xFFFFFF) << 8 | 0xFF,
		col5 = random(0xFFFFFF) << 8 | 0xFF,
		maxdistance = random(95) + 5,
		Float: radi = float(maxdistance)
	;

	Test("ProxDetector_old") {
		ProxDetector_old(radi, 0, string, col1, col2, col3, col4, col5);
	}
	Test("ProxDetector_new") {
		ProxDetector_new(radi, 0, string, col1, col2, col3, col4, col5);
	}
	Test("ProxDetector_double") {
		ProxDetector_double(0, string, col1, maxdistance);
	}
	Test("ProxDetector_Nero") {
		ProxDetector_Nero(0, radi, string, col1, col2, col3, col4, col5, col1, col2, col3, col4, col5, col1, col2, col3, col4, col5, col1, col2, col3, col4, col5);
	}
}
*/
/*
#define NegPos1(%0) (~(%0) + 1)
#define NegPos2(%0) (-(%0))

nTest(3, 100_000_000) {
	new
		var = random(1000)
	;
	Test("NegPos1") {
		var = NegPos1(var);
	}
	Test("NegPos2") {
		var = NegPos2(var);
	}
}
*/

/*
public OnFilterScriptInit() {
	CallLocalFunction("MiscFunc", "ii", 1, 2);

	new
		parm[5] = {0, 1, 2, ...},
		form[] = "iiiii",
		func[] = "MyFunc",
		args = (sizeof parm << 2),
		addr, i
	;
	#emit addr.pri parm
	#emit stor.s.pri addr

	for(i = (addr + args), args += 8; addr <= (i -= 4); ) {
		#emit push.s i
	}
	#emit addr.pri form
	#emit push.pri
	#emit addr.pri func
	#emit push.pri
	#emit push.s args
	#emit sysreq.c CallLocalFunction
}

forward MyFunc(v1, v2, v3, v4, v5);
public MyFunc(v1, v2, v3, v4, v5) {
	printf("%d %d %d %d %d", v1, v2, v3, v4, v5);
}
*/
/*
public OnFilterScriptInit() {
	CallLocalFunction("MiscFunc", "ii", 1, 2);

	CallLocalFunctionEx("MyFunc", "iiiii", 1, 2, 3, 4, 5);
}

stock CallLocalFunctionEx(const func[], const form[], {Float, _}: ...) {
	new
		args = ((numargs() - 2) << 2),
		addr,
		i
	;
	#emit addr.pri form
	#emit stor.s.pri addr

	for(i = (addr + args), args += 8; addr != i; i -= 4) {
		#emit load.s.pri i
		#emit load.i
		#emit push.pri
	}
	#emit push.s form
	#emit push.s func
	#emit push.s args
	#emit sysreq.c CallLocalFunction
}

forward MyFunc(v1, v2, v3, v4, v5);
public MyFunc(v1, v2, v3, v4, v5) {
	printf("%d %d %d %d %d", v1, v2, v3, v4, v5);
}*/

/*
	;$lcl cmd ffffffec
	stack ffffffec
	zero.pri
	addr.alt ffffffec
	fill 14
	; line a
	addr.pri ffffffec
	add.c 16
	push.pri
	;$par
	addr.pri ffffffec
	add.c 12
	push.pri
	;$par
	addr.pri ffffffec
	add.c 8
	push.pri
	;$par
	addr.pri ffffffec
	add.c 4
	push.pri
	;$par
	push.adr ffffffec
	;$par
	push.c 1c
	;$par
	push.c 0
	;$par
	push.c 1c
	sysreq.c 0	; CallLocalFunction
	stack 20
	;$exp
	stack 14
	zero.pri
	retn
*/

/*
public OnFilterScriptInit() {
	printf("%s", sFunction());
}

new array[] = "Hello World";

stock sFunction() {
	#emit const.pri array
	#emit load.s.alt 12
	#emit movs 48
	#emit retn

	return array;
}*/

/*
public OnFilterScriptInit() {
	new
		bool: flag = true
	;
	flag = bool: 50;
	printf("%d", _: flag);
}*/

//#include <nTest>
/*
stock func2() {
	#emit CONST.pri 1
	#emit RETN

	return 1;
}

stock func1() {
	new
		ret = func2()
	;
	#emit LOAD.S.pri ret
	#emit STACk 4
	#emit RETN

	return ret;
}

public OnFilterScriptInit()
{
	printf("Func1 %d", func1());
}
*/
/*
new
    gStrings[3][4] =
    {
        {'H',  'e',  'l', 'l'},
        {'o',  '\0', 'H', 'i'},
        {'\0', 'Y',  'o', '\0'}
    };

public OnFilterScriptInit()
{
    // Get the address of the start of the array.
    #emit CONST.pri gStrings
    // Get the address of the pointer to the second data set.
    #emit ADD.C 4
    #emit MOVE.alt
    // Load the data there.
    #emit LOAD.I
    // Add 2 cells and store the result back.
    #emit ADD.C 8
    #emit STOR.I
    // Get the third pointer.
    #emit CONST.pri 4
    #emit ADD
    #emit MOVE.alt
    #emit LOAD.I
    // Add one cell.
    #emit ADD.C     4
    #emit STOR.I
    printf("%s", gStrings[0]);
    printf("%s", gStrings[1]);
    printf("%s", gStrings[2]);
}
*/
/*
Func(a, b, ...) {
	#pragma unused a, b

	const
		args = 2
	;
	new
		i,
		j,
		n = 8
	;
    for( ; i <= n; i += 4) {
        #emit LOAD.S.alt i
        #emit LCTRL 5
        #emit ADD
		#emit STOR.S.pri j
		#emit LREF.S.pri j
		#emit STOR.S.pri j

		if(i == 8) {
			n = (i + j);
		}
		if((8 + (4 * args)) < i) {
			#emit LREF.S.pri j
			#emit STOR.S.pri j

			printf("HEA %d = %d", (i - (8 + (4 * args))), j);
		} else {
			printf("FRM %d = %d", i, j);
		}
    }
}

public OnFilterScriptInit() {
//	new
//		binary = 0b0010011011,
//		bString[33];
//	format(bString, sizeof bString, "%032b", binary);
//	print(bString);

    Func(2, 3, 4, 5, 6);
}
*/

/*
stock IsPointInPolygon(Float: point_X, Float: point_Y, { Float, _ }: ...)
{
    #define MAX_POINTS (32)
   
    new
        args_Total = numargs(),
        polygon_Sides = (args_Total - 2) / 2
    ;
    if((args_Total - 2) & 0b1 || MAX_POINTS <= polygon_Sides || polygon_Sides < 3)
        return 0;
       
    new
        Float: polygon_Data[2][MAX_POINTS],
        cross_Total
    ;
    #undef MAX_POINTS
   
    for(new i = 2, j; i < args_Total; i += 2, ++j)
    {
        polygon_Data[0][j] = Float: getarg(i);
        polygon_Data[1][j] = Float: getarg(i + 1);
    }
    for(new i, j = polygon_Sides - 1; i < polygon_Sides; j = i, ++i)
    {
        if(polygon_Data[1][i] < point_Y && polygon_Data[1][j] >= point_Y || polygon_Data[1][j] < point_Y && polygon_Data[1][i] >= point_Y)
        {
            if(polygon_Data[0][i] + (point_Y - polygon_Data[1][i]) / (polygon_Data[1][j] - polygon_Data[1][i]) * (polygon_Data[0][j] - polygon_Data[0][i]) < point_X)
            {
                cross_Total++;
            }
        }
    }
    return cross_Total & 0b1;  
}

stock IsPointInPerimeter(Float: X, Float: Y, { Float }: ...) {
	new
		vertices = 0
	;
	#emit LOAD.S.pri 8
	#emit STOR.S.pri vertices

	if(((vertices >>> 2) & 1) || (vertices < 32)) {
		return false;
	}
	new
		Float: cX,
		Float: cY,
		Float: oX,
		Float: oY,
		intersect = 0,
		v
	;
	vertices -= 8;

	#emit LOAD.S.alt vertices
	#emit LCTRL 2
	#emit STOR.S.pri v
	#emit SUB
	#emit STOR.S.pri vertices
	#emit LREF.S.alt vertices
	#emit STOR.S.alt oY
	#emit ADD.C 4
	#emit LOAD.I
	#emit STOR.S.pri oX

	const
		sub = -4
	;
	for(v -= 4; vertices <= v; v -= 8) {
		#emit LOAD.S.pri v
		#emit LREF.S.alt v
		#emit STOR.S.alt cX
		#emit ADD.C sub
		#emit LOAD.I
		#emit STOR.S.pri cY

		if((cY < Y <= oY) || (oY < Y <= cY)) {
			if((cX + ((Y - cY) * (oX - cX) / (oY - cY))) < X) {
				intersect++;
			}
		}
		oX = cX;
		oY = cY;
	}
	return (intersect & 1);
}

stock IsPlayerInPerimeterCR(Float: X, Float: Y, Float: XCoords[], Float: YCoords[], vertices = sizeof XCoords)
{
	new u = vertices-1, Intersect = 0;
	for(new v = 0; v < vertices; v++)
	{
		if((YCoords[v] < Y && YCoords[u] >= Y) || (YCoords[u] < Y && YCoords[v] >= Y))
		{
			if(XCoords[v] + (Y-YCoords[v]) / (YCoords[u] - YCoords[v]) * (XCoords[u] - XCoords[v]) < X)
			{
				Intersect++; //Even amount = out of perimeter, odd amount = in perimeter
			}
		}
		u = v;
	}
	return Intersect&1; //Even will return 0. Odd will return 1;
}

stock IsPlayerInPerimeterCRE(Float: X, Float: Y, Float: coords[], vertices = sizeof coords) {
	new
		u = (vertices - 2),
		intersect = 0,
		v = 0
	;
	while(v != vertices) {
		if((coords[v + 1] < Y <= coords[u + 1]) || (coords[u + 1] < Y <= coords[v + 1]))
		{
			if(coords[v] + (Y-coords[v + 1]) / (coords[u + 1] - coords[v + 1]) * (coords[u] - coords[v]) < X)
			{
				intersect++;
			}
		}
		u = v;
		v += 2;
	}
	return (intersect & 1);
}

stock IsPlayerInPerimeterCRE2(Float: X, Float: Y, Float: coords[], vertices = sizeof coords) {
	new
		Float: oX = coords[vertices - 2],
		Float: oY = coords[vertices - 1],
		intersect = 0,
		Float: cX,
		Float: cY,
		v = 0
	;
	while(v != vertices) {
		cX = coords[v];
		cY = coords[v + 1];

		if((cY < Y <= oY) || (oY < Y <= cY)) {
			if((cX + ((Y - cY) * (oX - cX) / (oY - cY))) < X) {
				intersect++;
			}
		}
		oX = cX;
		oY = cY;

		v += 2;
	}
	return (intersect & 1);
}

nTest(50, 1_000_000) {
	new
		result[5],
		test = (_j / 2),
		Float: point_X = float(random(6000)) - 3000.0,
		Float: point_Y = float(random(6000)) - 3000.0
	;
	static
		Float: average[sizeof result]
	;
	Test("IsPointInPolygon") { // 234.95
		result[0] =
			IsPointInPolygon(point_X, point_Y,
				 1500.0, -1500.0,
				 1500.0,  1500.0,
				-1500.0,  1500.0,
				-1500.0, -1500.0
			)
		;
	}
	average[0] = (((average[0] * test) + floatdiv(_i, (_k - _t))) / (test + 1.0));
	Test("IsPointInPerimeter") { // 298.43
		result[1] =
			IsPointInPerimeter(point_X, point_Y,
				 1500.0, -1500.0,
				 1500.0,  1500.0,
				-1500.0,  1500.0,
				-1500.0, -1500.0
			)
		;
	}
	average[1] = (((average[1] * test) + floatdiv(_i, (_k - _t))) / (test + 1.0));
	Test("IsPlayerInPerimeterCR") { // 401.68
		result[2] =
			IsPlayerInPerimeterCR(point_X, point_Y,
				Float: { 1500.0, 1500.0, -1500.0, -1500.0},
				Float: { -1500.0, 1500.0, 1500.0, -1500.0}
			)
		;
	}
	average[2] = (((average[2] * test) + floatdiv(_i, (_k - _t))) / (test + 1.0));
	Test("IsPlayerInPerimeterCRE") { // 255.93
		result[3] =
			IsPlayerInPerimeterCRE(point_X, point_Y, Float: {
				1500.0, -1500.0,
				 1500.0,  1500.0,
				-1500.0,  1500.0,
				-1500.0, -1500.0
			})
		;
	}
	average[3] = (((average[3] * test) + floatdiv(_i, (_k - _t))) / (test + 1.0));
	Test("IsPlayerInPerimeterCRE2") { // 301.98
		result[4] =
			IsPlayerInPerimeterCRE2(point_X, point_Y, Float: {
				1500.0, -1500.0,
				 1500.0,  1500.0,
				-1500.0,  1500.0,
				-1500.0, -1500.0
			})
		;
	}
	average[4] = (((average[4] * test) + floatdiv(_i, (_k - _t))) / (test + 1.0));

	print("\r");
	printf("%d. Point %4.2f %4.2f", test, point_X, point_Y);
	printf("%d. Result %d - %d - %d - %d - %d", test, result[0], result[1], result[2], result[3], result[4]);
	printf("%d. Average %f - %f - %f - %f - %f", test, average[0], average[1], average[2], average[3], average[4]);
}

stock NumargsD(...) {
	return numargs();
}

stock NumargsE(...) { // little bit faster
	#emit LOAD.S.pri 8
	#emit SHR.C.pri 2
	#emit RETN
	
	return 0;
}
*/
/*
nTest(3, 5_000_000_000) {
	new
		temp,
		time = random(1000)
	;
	printf("time %d", time);
	Test("advanced") {
		temp = (time / 60) - (60 * ((60 * (time / 60)) / 3600));
	}
	printf("%d", temp);
	Test("advanced var") {
		temp = (temp = (time / 60)) - (60 * ((60 * temp) / 3600));
	}
	printf("%d", temp);
	Test("advanced var outside") {
		temp = (time / 60);
		temp = temp - (60 * ((60 * temp) / 3600));
	}
	printf("%d", temp);
	Test("round") {
		temp = floatround((time / 60), floatround_floor); 
	}
	printf("%d", temp);
}*/

#if 1
stock const
	FilterScript_Name[] = "FS_Test"
;

public OnFilterScriptInit() {
	new
		time = gettime()
	;
	setproperty(.name = FilterScript_Name, .value = time);

	printf("Test filterscript");

//	CallRemoteFunction("OnFilterScriptLoad", "si", FilterScript_Name, time);

	#if defined Init
		Init();
	#endif
}

public OnFilterScriptExit() {
//	CallRemoteFunction("OnFilterScriptUnload", "si", FilterScript_Name, gettime());

	deleteproperty(.name = FilterScript_Name);

	#if defined Unload
		Unload();
	#endif
}
#endif