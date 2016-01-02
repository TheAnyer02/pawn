//n3d @ 2016 v5 | valid for vZ > -0.6 / xRot > -36 dgerees | http://forum.sa-mp.com/showthread.php?t=276490
stock GetPlayerCameraWeaponVector(playerid, & Float: vX, & Float: vY, & Float: vZ) {
	if(GetPlayerCameraFrontVector(playerid, vX, vY, vZ)) {
		switch(GetPlayerWeapon(playerid)) {
			case WEAPON_SNIPER, WEAPON_ROCKETLAUNCHER, WEAPON_HEATSEEKER: {
				return true;
			}
			case WEAPON_RIFLE: {
				vY = atan2(vX, vY) + 5.0 * floatpower(vZ, 6.0) + 1.1;
				vZ = asin(vZ) - 0.0163 * vZ + 2.0158;

				vX = floatsin(vY, degrees) * floatcos(vZ, degrees);
				vY = floatcos(vY, degrees) * floatcos(vZ, degrees);
				vZ = floatsin(vZ, degrees);
				return true;
			}
			case WEAPON_AK47, WEAPON_M4: {
				vY = atan2(vX, vY) + 3.3 * floatpower(vZ, 4.0) + 1.6;
				vZ = asin(vZ) - 0.0582 * vZ + 3.0083;

				vX = floatsin(vY, degrees) * floatcos(vZ, degrees);
				vY = floatcos(vY, degrees) * floatcos(vZ, degrees);
				vZ = floatsin(vZ, degrees);
				return true;
			}
			case WEAPON_COLT45 .. WEAPON_MP5, WEAPON_TEC9, WEAPON_FLAMETHROWER, WEAPON_MINIGUN: {
				vY = atan2(vX, vY) + 4.25 * floatpower(vZ + 0.05, 4.0) + 2.4;
				vZ = asin(vZ) - 0.1347 * vZ + 4.5065;

				vX = floatsin(vY, degrees) * floatcos(vZ, degrees);
				vY = floatcos(vY, degrees) * floatcos(vZ, degrees);
				vZ = floatsin(vZ, degrees);
				return true;
			}
		}
	}
	return false;
}
