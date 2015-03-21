/*--------------------------------------------------------------------------------------------------
	Weapon Offset FS created by Nero_3D
--------------------------------------------------------------------------------------------------*/

#include <a_samp>

#define WO_OBJECT_X (0.0)
#define WO_OBJECT_Y (0.0)
#define WO_OBJECT_Z (3.0)

#define COMMAND "/woffset"

enum {
	WO_B_Calculated = 0x80000000,
	WO_B_Shooting = 0x40000000,
	WO_B_Playerid = 0x3FFF8000,
	WO_B_Objectid = 0x7FFF
}

enum WO_E_Data {
	WO_Objectid,
	Float: WO_oX,
	Float: WO_oY,
	Float: WO_oZ
}

stock
	WO_Data[WO_E_Data];

forward Shotting(playerid);

/*--------------------------------------------------------------------------------------------------
	Function:
		WO_Init
	Params:
		playerid - Player to teleport
		const Float: distance - The distance from the ball
	Return:
		If the function got successfully executed
	Notes:
		Creates the object and teleports the player to the testing ground
--------------------------------------------------------------------------------------------------*/

stock WO_Init(playerid, const Float: distance) {
	if(WO_Data[WO_Objectid] == 0) {
		ResetPlayerWeapons(playerid);
		SetPlayerInterior(playerid, 1);
		SetPlayerVirtualWorld(playerid, (playerid + 1));
		WO_Data[WO_Objectid] =
			(CreatePlayerObject(playerid, (2995 + random(9)), WO_OBJECT_X, WO_OBJECT_Y, WO_OBJECT_Z, 0.0, 0.0, 0.0) & WO_B_Objectid) |
			((playerid << 15) & WO_B_Playerid);
		SetPlayerPos(playerid, (WO_OBJECT_X + distance), (WO_OBJECT_Y - distance), WO_OBJECT_Z);
		GameTextForPlayer(playerid, "Shot at the ball in front of you!", 5000, 5);
		SetPlayerFacingAngle(playerid, 45.0);
		SetCameraBehindPlayer(playerid);
		return true;
	}
	return false;
}

/*--------------------------------------------------------------------------------------------------
	Function:
		WO_End
	Params:
		const bool: kill - Flag if the player should be killed
	Return:
		If the function got successfully executed
	Notes:
		Resets the data and kills the player
--------------------------------------------------------------------------------------------------*/

stock WO_End(const bool: kill) {
	if(WO_Data[WO_Objectid]) {
		new
			playerid = ((WO_Data[WO_Objectid] & WO_B_Playerid) >>> 15);
		if((WO_Data[WO_Objectid] & WO_B_Calculated) == 0) {
			DestroyPlayerObject(playerid, WO_Data[WO_Objectid] & WO_B_Objectid);
		}
		SetPlayerVirtualWorld(playerid, 0);
		if(kill) {
			SetPlayerHealth(playerid, 0.0);
		}
		WO_Data[WO_Objectid] = 0;
		return true;
	}
	return false;
}

/*--------------------------------------------------------------------------------------------------
	Function:
		WO_AdjustVector
	Params:
		& Float: vX - x Vector to adjust
		& Float: vY - y Vector to adjust
		& Float: vZ - z Vector to adjust
		Float: oX - x Offset Vector
		Float: oY - y Offset Vector
		const Float: oZ - z Offset Vector
	Return:
		-
	Notes:
		Adjust the vector with the offset
--------------------------------------------------------------------------------------------------*/

stock WO_AdjustVector(& Float: vX, & Float: vY, & Float: vZ, Float: oX, Float: oY, const Float: oZ) {
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

/*--------------------------------------------------------------------------------------------------
	Function:
		WO_Calculate
	Params:
		playerid - Player to get the data of
		& Float: oX - x Offset Vector variable
		& Float: oY - y Offset Vector variable
		& Float: oZ - z Offset Vector variable
		const Float: aX - x coordinate of the aiming point
		const Float: aY - y coordinate of the aiming point
		const Float: aZ - z coordinate of the aiming point
	Return:
		-
	Notes:
		Calculates the normalised offset vector between the front vector and the aiming point
		Some weapons got different offsets
			No Zoom - Sniper, Rocket, Heatseeker
			2x Zoom - Rifle
			1x Zoom - Ak47, M4
			0x Zoom - All other ranged weapons
		Additionally calls WO_PlotFunction
--------------------------------------------------------------------------------------------------*/

stock WO_Calculate(playerid, & Float: oX, & Float: oY, & Float: oZ, const Float: aX, const Float: aY, const Float: aZ) {
	static
		Float: vX,
		Float: vY,
		Float: vZ,
		Float: tX,
		Float: tY,
		Float: tZ,
		Float: lambda;

	GetPlayerCameraPos(playerid, oX, oY, oZ);
	GetPlayerCameraFrontVector(playerid, vX, vY, vZ);

	lambda = ( vX * (aX - oX) + vY * (aY - oY) + vZ * (aZ - oZ) ) / ((vX * vX) + (vY * vY) + (vZ * vZ));
	
	oX = ((aX - oX) / lambda) - vX;
	oY = ((aY - oY) / lambda) - vY;
	oZ = ((aZ - oZ) / lambda) - vZ;
	
	tX = vX;
	tY = vY;
	tZ = vZ;

	WO_AdjustVector(vX, vY, vZ, oX, oY, oZ);
	
	oX = vX - tX;
	oY = vY - tY;
	oZ = vZ - tZ;

	WO_PlotFunction(GetPlayerWeapon(playerid), oX, oY, oZ);
	return true;
}

#if 1 // Publics

public OnFilterScriptInit() {
	print("\r\n *** Weapon offset loaded!\r\n");
}

public OnFilterScriptExit() {
	print("\r\n *** Weapon offset loaded!\r\n");

	WO_End(true);
}

public OnPlayerCommandText(playerid, cmdtext[]) {
	if((strcmp(cmdtext, COMMAND, true) == 0) && (GetPlayerState(playerid) != PLAYER_STATE_WASTED)) {
		if(WO_Init(playerid, 15.0)) {
			GivePlayerWeapon(playerid, WEAPON_RIFLE, 0x7F800000);
		} else {
			switch(GetPlayerWeapon(playerid)) {
				case WEAPON_RIFLE: {
					WO_End(false);
					WO_Init(playerid, 10.0);
					GivePlayerWeapon(playerid, WEAPON_M4, 0x7F800000);
				}
				case WEAPON_M4: {
					WO_End(false);
					WO_Init(playerid, 5.0);
					GivePlayerWeapon(playerid, WEAPON_SILENCED, 0x7F800000);
				}
				default: {
					GameTextForPlayer(playerid, "Done~n~Check your scriptfiles", 5000, 5);
					WO_End(true);
				}
			}
		}
		return true;
	}
	return false;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(((WO_Data[WO_Objectid] & WO_B_Playerid) >>> 15) == playerid) {
		if(((newkeys & KEY_FIRE) == KEY_FIRE) && ((oldkeys & KEY_FIRE) != KEY_FIRE)) {
			if((WO_Data[WO_Objectid] & WO_B_Calculated) == 0) {
				if(WO_Calculate(playerid, WO_Data[WO_oX], WO_Data[WO_oY], WO_Data[WO_oZ], WO_OBJECT_X, WO_OBJECT_Y, WO_OBJECT_Z)) {
					GameTextForPlayer(playerid, "Test the offset~n~" COMMAND " to go on", 5000, 5);

					DestroyPlayerObject(playerid, WO_Data[WO_Objectid] & WO_B_Objectid);
					WO_Data[WO_Objectid] |= WO_B_Calculated;
				}
			} else {
				WO_Data[WO_Objectid] |= WO_B_Shooting;
				Shotting(playerid);
			}
		}
		if(((oldkeys & KEY_FIRE) == KEY_FIRE) && ((newkeys & KEY_FIRE) != KEY_FIRE)) {
			if(WO_Data[WO_Objectid] & WO_B_Shooting) {
				WO_Data[WO_Objectid] &= ~WO_B_Shooting;
			}
		}
	}
}

#endif

/*--------------------------------------------------------------------------------------------------
	Function:
		Shotting
	Params:
		playerid - Player to get the data of
	Return:
		If the function got successfully executed
	Notes:
		Creates a explosion at a certain distance along the weapon vector
--------------------------------------------------------------------------------------------------*/

public Shotting(playerid) {
	if(WO_Data[WO_Objectid] & WO_B_Shooting) {
		#define OFFSET 50.0

		static
			Float: cX,
			Float: cY,
			Float: cZ,
			Float: vX,
			Float: vY,
			Float: vZ;

		GetPlayerCameraPos(playerid, cX, cY, cZ);
		
		GetPlayerCameraFrontVector(playerid, vX, vY, vZ);
		WO_AdjustVector(vX, vY, vZ, WO_Data[WO_oX], WO_Data[WO_oY], WO_Data[WO_oZ]);
		
		CreateExplosion(
			cX + (OFFSET * vX),
			cY + (OFFSET * vY),
			cZ + (OFFSET * vZ),
			0, 5.0
		);
		
		#undef OFFSET
		
		SetTimerEx("Shotting", 250, false, "i", playerid);
		return true;
	}
	return false;
}

/*--------------------------------------------------------------------------------------------------
	Function:
		WO_PlotFunction
	Params:
		weaponid - The weapon to plot the function of
		Float: oX - The x Offset Vector
		Float: oY - The y Offset Vector
		Float: oZ - The z Offset Vector
	Return:
		If the function got successfully executed
	Notes:
		Creates a function to get the correct weapon offset into the given file
--------------------------------------------------------------------------------------------------*/

stock WO_PlotFunction(weaponid, Float: oX, Float: oY, Float: oZ) {
	static
		tmp[128],
		File: gFile,
		File: tFile;

	if(GetWeaponName(weaponid, tmp, sizeof tmp)) { // to check if its a valid one

		#define FILENAME "GetPlayerCameraWeaponVector.inc"
		#define NL "\r\n"

		if(fexist(FILENAME) && (weaponid != WEAPON_SNIPER) && (weaponid != WEAPON_ROCKETLAUNCHER) && (weaponid != WEAPON_HEATSEEKER)) {
			gFile = fopen(FILENAME, io_read);
			if(gFile) {
				tFile = fopen(FILENAME ".part", io_write);
				while(fread(gFile, tmp)) {
					fwrite(tFile, tmp);
					if(strcmp(tmp, "		switch(weapon) {" NL, false) == 0) {
						while(fread(gFile, tmp)) {
							switch(weaponid) {
								case WEAPON_RIFLE: {
									if(strcmp(tmp, "			case WEAPON_RIFLE: {" NL, false) == 0) {
										while(fread(gFile, tmp)) {
											if(strcmp(tmp, "			}" NL, false) == 0) {
												break;
											}
										}
										fread(gFile, tmp);
									}
								}
								case WEAPON_AK47, WEAPON_M4: {
									if(strcmp(tmp, "			case WEAPON_AK47, WEAPON_M4: {" NL, false) == 0) {
										while(fread(gFile, tmp)) {
											if(strcmp(tmp, "			}" NL, false) == 0) {
												break;
											}
										}
										fread(gFile, tmp);
									}
								}
								default: {
									if(strcmp(tmp, "			default: {" NL, false) == 0) {
										while(fread(gFile, tmp)) {
											if(strcmp(tmp, "			}" NL, false) == 0) {
												break;
											}
										}
										fread(gFile, tmp);
									}
								}								
							}
							if(strcmp(tmp, "		}" NL, false) == 0) {
								format(tmp, sizeof tmp,			"				AdjustVector(vX, vY, vZ, %f, %f, %f);" NL, oX, oY, oZ);
								switch(weaponid) {
									case WEAPON_RIFLE: {
										fwrite(tFile,			"			case WEAPON_RIFLE: {" NL);
										fwrite(tFile,			tmp);
										fwrite(tFile,			"			}" NL);
									}
									case WEAPON_AK47, WEAPON_M4: {
										fwrite(tFile,			"			case WEAPON_AK47, WEAPON_M4: {" NL);
										fwrite(tFile,			tmp);
										fwrite(tFile,			"			}" NL);
									}
									default: {
										fwrite(tFile,			"			default: {" NL);
										fwrite(tFile,			tmp);
										fwrite(tFile,			"			}" NL);
									}
								}
								fwrite(tFile,					"		}" NL);
								fwrite(tFile,					"		return true;" NL);
								fwrite(tFile,					"	}" NL);
								fwrite(tFile,					"	return false;" NL);
								fwrite(tFile,					"}");
								break;
							}
							fwrite(tFile, tmp);
						}
						break;
					}
				}
				fclose(tFile);
				fclose(gFile);
				gFile = fopen(FILENAME, io_write);
				tFile = fopen(FILENAME ".part", io_read);
				while(fread(tFile, tmp)) {
					fwrite(gFile, tmp);
				}
				fclose(tFile);
				fclose(gFile);
				fremove(FILENAME ".part");
				return true;
			}
		} else {
			gFile = fopen(FILENAME, io_write);
			if(gFile) {

				fwrite(gFile,					"/*--------------------------------------------------------------------------------------------------" NL);
				fwrite(gFile,					"	Include plotted by Weapon Offset FS created by Nero_3D" NL);
				fwrite(gFile,					"--------------------------------------------------------------------------------------------------*/" NL);
				fwrite(gFile,					NL);
				fwrite(gFile,					"#include <a_samp>" NL);
				fwrite(gFile,					NL);
				fwrite(gFile,					"/*--------------------------------------------------------------------------------------------------" NL);
				fwrite(gFile,					"	Function:" NL);
				fwrite(gFile,					"		AdjustVector" NL);
				fwrite(gFile,					"	Params:" NL);
				fwrite(gFile,					"		& Float: vX - x Vector to adjust" NL);
				fwrite(gFile,					"		& Float: vY - y Vector to adjust" NL);
				fwrite(gFile,					"		& Float: vZ - z Vector to adjust" NL);
				fwrite(gFile,					"		Float: oX - x Offset Vector" NL);
				fwrite(gFile,					"		Float: oY - y Offset Vector" NL);
				fwrite(gFile,					"		const Float: oZ - z Offset Vector" NL);
				fwrite(gFile,					"	Return:" NL);
				fwrite(gFile,					"		-" NL);
				fwrite(gFile,					"	Notes:" NL);
				fwrite(gFile,					"		Adjust the vector with the offset" NL);
				fwrite(gFile,					"--------------------------------------------------------------------------------------------------*/" NL);
				fwrite(gFile,					NL);
				fwrite(gFile,					"stock AdjustVector(& Float: vX, & Float: vY, & Float: vZ, Float: oX, Float: oY, const Float: oZ) {" NL);
				fwrite(gFile,					"	static" NL);
				fwrite(gFile,					"		Float: Angle;" NL);
				fwrite(gFile,					"	Angle = -atan2(vX, vY);" NL);
				fwrite(gFile,					"	if(45.0 < Angle) {" NL);
				fwrite(gFile,					"		oX ^= oY;" NL);
				fwrite(gFile,					"		oY ^= oX;" NL);
				fwrite(gFile,					"		oX ^= oY;" NL);
				fwrite(gFile,					"		if(90.0 < Angle) {" NL);
				fwrite(gFile,					"			oX *= -1;" NL);
				fwrite(gFile,					"			if(135.0 < Angle) {" NL);
				fwrite(gFile,					"				oX *= -1;" NL);
				fwrite(gFile,					"				oX ^= oY;" NL);
				fwrite(gFile,					"				oY ^= oX;" NL);
				fwrite(gFile,					"				oX ^= oY;" NL);
				fwrite(gFile,					"				oX *= -1;" NL);
				fwrite(gFile,					"			}" NL);
				fwrite(gFile,					"		}" NL);
				fwrite(gFile,					"	} else if(Angle < 0.0) {" NL);
				fwrite(gFile,					"		oY *= -1;" NL);
				fwrite(gFile,					"		if(Angle < -45.0) {" NL);
				fwrite(gFile,					"			oX *= -1;" NL);
				fwrite(gFile,					"			oX ^= oY;" NL);
				fwrite(gFile,					"			oY ^= oX;" NL);
				fwrite(gFile,					"			oX ^= oY;" NL);
				fwrite(gFile,					"			oX *= -1;" NL);
				fwrite(gFile,					"			if(Angle < -90.0) {" NL);
				fwrite(gFile,					"				oX *= -1;" NL);
				fwrite(gFile,					"				if(Angle < -135.0) {" NL);
				fwrite(gFile,					"					oX ^= oY;" NL);
				fwrite(gFile,					"					oY ^= oX;" NL);
				fwrite(gFile,					"					oX ^= oY;" NL);
				fwrite(gFile,					"				}" NL);
				fwrite(gFile,					"			}" NL);
				fwrite(gFile,					"		}" NL);
				fwrite(gFile,					"	}" NL);
				fwrite(gFile,					"	vX += oX," NL);
				fwrite(gFile,					"	vY += oY;" NL);
				fwrite(gFile,					"	vZ += oZ;" NL);
				fwrite(gFile,					"	return false;" NL);
				fwrite(gFile,					"}" NL);
				fwrite(gFile,					NL);
				fwrite(gFile,					"/*--------------------------------------------------------------------------------------------------" NL);
				fwrite(gFile,					"	Function:" NL);
				fwrite(gFile,					"		GetPlayerCameraWeaponVector" NL);
				fwrite(gFile,					"	Params:" NL);
				fwrite(gFile,					"		playerid - Player to get the weapon vector of" NL);
				fwrite(gFile,					"		& Float: vX - x Vector variable" NL);
				fwrite(gFile,					"		& Float: vY - y Vector variable" NL);
				fwrite(gFile,					"		& Float: vZ - z Vector variable" NL);
				fwrite(gFile,					"	Return:" NL);
				fwrite(gFile,					"		If the player is connected" NL);
				fwrite(gFile,					"	Notes:" NL);
				fwrite(gFile,					"		Gets the weapon vector of the player" NL);
				fwrite(gFile,					NL);
				fwrite(gFile,					"native GetPlayerCameraWeaponVector(playerid, & Float: vX, & Float: vY, & Float: vZ);" NL);
				fwrite(gFile,					"--------------------------------------------------------------------------------------------------*/" NL);
				fwrite(gFile,					NL);
				fwrite(gFile,					"stock GetPlayerCameraWeaponVector(playerid, & Float: vX, & Float: vY, & Float: vZ) {" NL);
				fwrite(gFile,					"	static" NL);
				fwrite(gFile,					"		weapon;" NL);
				fwrite(gFile,					"	if(21 < (weapon = GetPlayerWeapon(playerid)) < 39) {" NL);
				fwrite(gFile,					"		GetPlayerCameraFrontVector(playerid, vX, vY, vZ);" NL);
				fwrite(gFile,					"		switch(weapon) {" NL);
				fwrite(gFile,					"			case WEAPON_SNIPER, WEAPON_ROCKETLAUNCHER, WEAPON_HEATSEEKER: {}" NL);
				format(tmp, sizeof tmp,			"				AdjustVector(vX, vY, vZ, %f, %f, %f);" NL, oX, oY, oZ);
				switch(weaponid) {
					case WEAPON_SNIPER, WEAPON_ROCKETLAUNCHER, WEAPON_HEATSEEKER: {}
					case WEAPON_RIFLE: {
						fwrite(gFile,			"			case WEAPON_RIFLE: {" NL);
						fwrite(gFile,			tmp);
						fwrite(gFile,			"			}" NL);
					}
					case WEAPON_AK47, WEAPON_M4: {
						fwrite(gFile,			"			case WEAPON_AK47, WEAPON_M4: {" NL);
						fwrite(gFile,			tmp);
						fwrite(gFile,			"			}" NL);
					}
					default: {
						fwrite(gFile,			"			default: {" NL);
						fwrite(gFile,			tmp);
						fwrite(gFile,			"			}" NL);
					}
				}
				fwrite(gFile,					"		}" NL);
				fwrite(gFile,					"		return true;" NL);
				fwrite(gFile,					"	}" NL);
				fwrite(gFile,					"	return false;" NL);
				fwrite(gFile,					"}");

				fclose(gFile);
				return true;
			}
		}

		#undef NL
		#undef FILENAME
	}
	return false;
}