/**
  *	<subsection>
  *		<ul>
  *			Screen To World Include
  *			<p /><p />
  *			Legal
  *			<ul>
  *				The contents of this file are subject to the Mozilla Public License
  *				Version 1.1 (the "License"); you may not use this file except in
  *				compliance with the License. You may obtain a copy of the License at
  *				http://www.mozilla.org/MPL/
  *			</ul><ul>
  *				Software distributed under the License is distributed on an "AS IS"
  *				basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
  *				License for the specific language governing rights and limitations
  *				under the License.
  *			</ul><ul>
  *				The Original Code is Screen To World Include
  *			</ul><ul>
  *				The Initial Developer of the Original Code is Mark aka "Nero_3D".
  *				Portions created by Initial Developer are Copyright (C) 2013
  *				the Initial Developer. All Rights Reserved.
  *			</ul>
  *		</ul>
  *	</subsection>
  *
  **/

#if 0
	native ScreenToWorld(playerid, Float: screenX, Float: screenY, & Float: vX, & Float: vY, & Float: vZ);
	native WorldToScreen(playerid, Float: x, Float: y, Float: z, & Float: screenX, & Float: screenY);
#endif

/// These values were gathered by assumption of the size of the screen

#if 1 // change this to 0 if you use widescreen - or create an player array and let the player decide
	const
		Float: cInGameX = 0.7,
		Float: cInGameY = 0.525,
		Float: cOnScreenX = 640.0,
		Float: cOnScreenY = 447.0
	;
#else 
	const // Widescreen
		Float: cInGameX = 0.7,
		Float: cInGameY = 0.4,
		Float: cOnScreenX = 640.0,
		Float: cOnScreenY = 447.0
	;
#endif

///	<summary>Gets the CrossProduct of the vectors</summary>

static stock CrossProduct(& Float: x, & Float: y, & Float: z, Float: v1x, Float: v1y, Float: v1z, Float: v2x, Float: v2y, Float: v2z) {
	x = v1y * v2z - v2y * v1z;
	y = v1z * v2x - v2z * v1x;
	z = v1x * v2y - v2x * v1y;
}

///	<summary>Gets the magnitude of the vector</summary>

static stock Float: GetMagnitudeOfVector(Float: x, Float: y, Float: z) {
	return floatpower(x * x + y * y + z * z, 0.5);
}

///	<summary>Normalizes the vector</summary>

static stock NormalizeVector(& Float: x, & Float: y, & Float: z) {
	new
		Float: length = GetMagnitudeOfVector(x, y, z)
	;
	x /= length;
	y /= length;
	z /= length;
}

///	<summary>Gets and normalizes the CrossProduct of the vectors</summary>

static stock NormalizedCrossProduct(& Float: x, & Float: y, & Float: z, Float: v1x, Float: v1y, Float: v1z, Float: v2x, Float: v2y, Float: v2z) {
	CrossProduct(x, y, z, v1x, v1y, v1z, v2x, v2y, v2z);
	NormalizeVector(x, y, z);
}

/**
  *	<summary>
  *		Converts screen to world coordinates
  *	</summary>
  *
  *	<param name="playerid">
  *		The playerid
  *	</param>
  *	<param name="screenX">
  *		X coordinate of the screen (0 - 640)
  *	</param>
  *	<param name="screenY">
  *		Y coordinate of the screen (0 - 480)
  *	</param>
  *	<param name="vX">
  *		Variable to store the X vector
  *	</param>
  *	<param name="vY">
  *		Variable to store the Y vector
  *	</param>
  *	<param name="vZ">
  *		Variable to store the Z vector
  *	</param>
  *
  *	<returns>
  *		True if the coordinates are on the screen and if the player is connected
  *	</returns>
  *
  **/
stock ScreenToWorld(playerid, Float: screenX, Float: screenY, & Float: vX, & Float: vY, & Float: vZ) {
	if((0.0 <= screenX <= 640.0) && (0.0 <= screenY <= 480.0) && GetPlayerCameraFrontVector(playerid, vX, vY, vZ)) {
		new
			Float: pX = ((screenX / cOnScreenX) - 0.5) * cInGameX * 2.0,
			Float: pZ = ((screenY / cOnScreenY) - 0.5) * cInGameY * 2.0,
			Float: nXx, // vY
			Float: nYx, // -vX
			Float: nZx, // 0.0
			Float: nXz,
			Float: nYz,
			Float: nZz
		;
		NormalizedCrossProduct(nXx, nYx, nZx, vX, vY, vZ, 0.0, 0.0, 1.0); // front vector (x) z vector
		NormalizedCrossProduct(nXz, nYz, nZz, vX, vY, vZ, nXx, nYx, nZx); // front vector (x) right vector

		vX += nXx * pX + nXz * pZ;
		vY += nYx * pX + nYz * pZ;
		vZ += nZx * pX + nZz * pZ;
		
		return true;
	}
	return false;
}

/**
  *	<summary>
  *		Converts world to screen coordinates
  *	</summary>
  *
  *	<param name="playerid">
  *		The playerid
  *	</param>
  *	<param name="x">
  *		X coordinate
  *	</param>
  *	<param name="y">
  *		Y coordinate
  *	</param>
  *	<param name="z">
  *		Y coordinate
  *	</param>
  *	<param name="screenX">
  *		Variable to store the X coordinate of the screen
  *	</param>
  *	<param name="screenY">
  *		Variable to store the Y coordinate of the screen
  *	</param>
  *
  *	<returns>
  *		True if the coordinates are on the screen and if the player is connected
  *	</returns>
  *
  **/
stock WorldToScreen(playerid, Float: x, Float: y, Float: z, & Float: screenX, & Float: screenY) {
	new
		Float: vX,
		Float: vY,
		Float: vZ,
		Float: cX,
		Float: cY,
		Float: cZ,
		Float: nXx, // vY
		Float: nYx, // -vX
		Float: nZx, // 0.0
		Float: nXz,
		Float: nYz,
		Float: nZz
	;
	if(GetPlayerCameraPos(playerid, cX, cY, cZ)) {
		GetPlayerCameraFrontVector(playerid, vX, vY, vZ);

		NormalizedCrossProduct(nXx, nYx, nZx, vX, vY, vZ, 0.0, 0.0, 1.0);
		NormalizedCrossProduct(nXz, nYz, nZz, vX, vY, vZ, nXx, nYx, nZx);

		screenX = ( vX * (x - cX) + vY * (y - cY) + vZ * (z - cZ) ) / ((vX * vX) + (vY * vY) + (vZ * vZ));

		z = (((z - cZ) / screenX) - vZ) / nZz;
		x = (((x - cX) / screenX) - vX - (z * nXz)) / nXx;

		screenX = ((x / (cInGameX * 2.0)) + 0.5) * cOnScreenX;
		screenY = ((z / (cInGameY * 2.0)) + 0.5) * cOnScreenY;

		return ((0.0 <= screenX <= 640.0) && (0.0 <= screenY <= 480.0));
	}
	return false;
}