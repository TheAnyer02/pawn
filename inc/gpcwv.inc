/*--------------------------------------------------------------------------------------------------
	Function:
		GetPlayerCameraWeaponVector
	Params:
		playerid - Player to get the weapon vector of
		& Float: vX - x Vector variable
		& Float: vY - y Vector variable
		& Float: vZ - z Vector variable
	Return:
		If the player is connected
	Notes:
		Gets the weapon vector of the player

native GetPlayerCameraWeaponVector(playerid, & Float: vX, & Float: vY, & Float: vZ);
--------------------------------------------------------------------------------------------------*/

stock GetPlayerCameraWeaponVector(playerid, & Float: vX, & Float: vY, & Float: vZ) {
	// version 3 - http://forum.sa-mp.com/showthread.php?t=276490
	if(GetPlayerCameraFrontVector(playerid, vX, vY, vZ)) {
		switch(GetPlayerWeapon(playerid)) {
			case WEAPON_SNIPER, WEAPON_ROCKETLAUNCHER, WEAPON_HEATSEEKER: {
				return true;
			}
			case WEAPON_RIFLE: {
				new
					Float: angle = -(atan2(vX, vY) + 15.642194)
				;
				vX += floatcos(angle, degrees) * 0.019619;
				vY += floatsin(angle, degrees) * 0.019619;
				vZ = floatsin(asin(vZ) + 2.7, degrees);
				return true;
			}
			case WEAPON_AK47, WEAPON_M4: {
				new
					Float: angle = -(atan2(vX, vY) + 15.135845)
				;
				vX += floatcos(angle, degrees) * 0.028902;
				vY += floatsin(angle, degrees) * 0.028902;
				vZ = floatsin(asin(vZ) + 4.0, degrees);
				return true;
			}
			case WEAPON_COLT45 .. WEAPON_MP5, WEAPON_TEC9, WEAPON_FLAMETHROWER, WEAPON_MINIGUN: {
				new
					Float: angle = -(atan2(vX, vY) + 11.652412)
				;
				vX += floatcos(angle, degrees) * 0.042624;
				vY += floatsin(angle, degrees) * 0.042624;
				vZ = floatsin(asin(vZ) + 6.0, degrees);
				return true;
			}
		}
	}
	return false;
}