#include <a_samp>

stock MoveBall(objectid, Float: ScreenX, Float: ScreenY) {
	new
		Float: cX,
		Float: cY,
		Float: cZ,
		Float: oX,
		Float: oY,
		Float: oZ,
		Float: vX,
		Float: vY,
		Float: vZ,
		Float: distance
	;
	ScreenToWorld(0, ScreenX, ScreenY, vX, vY, vZ);

	GetPlayerCameraPos(0, cX, cY, cZ);
	GetObjectPos(objectid, oX, oY, oZ);

	distance = floatabs((cZ - oZ) / vZ);

	oX = cX + vX * distance;
	oY = cY + vY * distance;

	StopObject(objectid);
	MoveObject(objectid, oX, oY, oZ, 1000.0);
}

public OnPlayerSpawn(playerid) {
	SetPlayerPos(playerid, 0.65342, 1741.12512, 20.24046);
}

// Players Move Speed
#define MOVE_SPEED              100.0
#define ACCEL_RATE              0.03

// Players Mode
#define CAMERA_MODE_NONE    	0
#define CAMERA_MODE_FLY     	1

// Key state definitions
#define MOVE_FORWARD    		1
#define MOVE_BACK       		2
#define MOVE_LEFT       		3
#define MOVE_RIGHT      		4
#define MOVE_FORWARD_LEFT       5
#define MOVE_FORWARD_RIGHT      6
#define MOVE_BACK_LEFT          7
#define MOVE_BACK_RIGHT         8

// Enumeration for storing data about the player
enum noclipenum
{
	cameramode,
	flyobject,
	mode,
	lrold,
	udold,
	lastmove,
	Float:accelmul
}
new noclipdata[MAX_PLAYERS][noclipenum];

new gMoveObject = 0;
new obj;
new CursorOX, CursorOY,
	CursorX, CursorY,
	ScreenWidth, ScreenHeight;

native GetVirtualKeyState(key);
native GetScreenSize(&Width, &Height);
native GetMousePos(&X, &Y);

#define VK_KEY_A	0x41
#define VK_KEY_B	0x42
#define VK_KEY_C	0x43
#define VK_KEY_D	0x44
#define VK_KEY_E	0x45
#define VK_KEY_F	0x46
#define VK_KEY_G	0x47
#define VK_KEY_H	0x48
#define VK_KEY_I	0x49
#define VK_KEY_J	0x4A
#define VK_KEY_K	0x4B
#define VK_KEY_L	0x4C
#define VK_KEY_M	0x4D
#define VK_KEY_N	0x4E
#define VK_KEY_O	0x4F
#define VK_KEY_P	0x50
#define VK_KEY_Q	0x51
#define VK_KEY_R	0x52
#define VK_KEY_S	0x53
#define VK_KEY_T	0x54
#define VK_KEY_U	0x55
#define VK_KEY_V	0x56
#define VK_KEY_W	0x57
#define VK_KEY_X	0x58
#define VK_KEY_Y	0x59
#define VK_KEY_Z	0x5A
#define VK_LBUTTON	0x01
#define VK_MBUTTON	0x04
#define VK_RBUTTON	0x02
#define VK_UP		0x26
#define VK_DOWN		0x28
#define VK_LEFT		0x25
#define VK_RIGHT	0x27
#define VK_LSHIFT	0xA0
#define VK_RSHIFT	0xA1
#define VK_SPACE    0x20

enum
	E_KEY_STRUCT
{
	bool:KEY_PRESSED,
	KEY_CODE,
};

new VirtualKeys[36][E_KEY_STRUCT];

public OnFilterScriptInit()
{
    SetTimer("OnEditorUpdate", 25, true);

	obj = CreateObject(1946, 0.0, 0.0, 0.0, 0.00000, 0.00000, 0.00000);

    VirtualKeys[0][KEY_CODE] = VK_KEY_A;
    VirtualKeys[1][KEY_CODE] = VK_KEY_B;
    VirtualKeys[2][KEY_CODE] = VK_KEY_C;
    VirtualKeys[3][KEY_CODE] = VK_KEY_D;
    VirtualKeys[4][KEY_CODE] = VK_KEY_E;
    VirtualKeys[5][KEY_CODE] = VK_KEY_F;
    VirtualKeys[6][KEY_CODE] = VK_KEY_G;
    VirtualKeys[7][KEY_CODE] = VK_KEY_H;
    VirtualKeys[8][KEY_CODE] = VK_KEY_I;
    VirtualKeys[9][KEY_CODE] = VK_KEY_J;
    VirtualKeys[10][KEY_CODE] = VK_KEY_K;
    VirtualKeys[11][KEY_CODE] = VK_KEY_L;
    VirtualKeys[12][KEY_CODE] = VK_KEY_M;
    VirtualKeys[13][KEY_CODE] = VK_KEY_N;
    VirtualKeys[14][KEY_CODE] = VK_KEY_O;
    VirtualKeys[15][KEY_CODE] = VK_KEY_P;
    VirtualKeys[16][KEY_CODE] = VK_KEY_Q;
    VirtualKeys[17][KEY_CODE] = VK_KEY_R;
    VirtualKeys[18][KEY_CODE] = VK_KEY_S;
    VirtualKeys[19][KEY_CODE] = VK_KEY_T;
    VirtualKeys[20][KEY_CODE] = VK_KEY_U;
    VirtualKeys[21][KEY_CODE] = VK_KEY_V;
    VirtualKeys[22][KEY_CODE] = VK_KEY_W;
    VirtualKeys[23][KEY_CODE] = VK_KEY_X;
    VirtualKeys[24][KEY_CODE] = VK_KEY_Y;
    VirtualKeys[25][KEY_CODE] = VK_KEY_Z;
    VirtualKeys[26][KEY_CODE] = VK_LBUTTON;
    VirtualKeys[27][KEY_CODE] = VK_MBUTTON;
    VirtualKeys[28][KEY_CODE] = VK_RBUTTON;
    VirtualKeys[29][KEY_CODE] = VK_LEFT;
    VirtualKeys[30][KEY_CODE] = VK_RIGHT;
	VirtualKeys[31][KEY_CODE] = VK_UP;
    VirtualKeys[32][KEY_CODE] = VK_DOWN;
    VirtualKeys[33][KEY_CODE] = VK_LSHIFT;
    VirtualKeys[34][KEY_CODE] = VK_RSHIFT;
    VirtualKeys[35][KEY_CODE] = VK_SPACE;
	return 1;
}

public OnFilterScriptExit() {
	for(new x; x<MAX_PLAYERS; x++)
	{
		if(noclipdata[x][cameramode] == CAMERA_MODE_FLY) CancelFlyMode(x);
	}
	DestroyObject(obj);
}

public OnPlayerConnect(playerid)
{
	// Reset the data belonging to this player slot
	noclipdata[playerid][cameramode] 	= CAMERA_MODE_NONE;
	noclipdata[playerid][lrold]	   	 	= 0;
	noclipdata[playerid][udold]   		= 0;
	noclipdata[playerid][mode]   		= 0;
	noclipdata[playerid][lastmove]   	= 0;
	noclipdata[playerid][accelmul]   	= 0.0;
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/flymode", true))
	{
	    // Place the player in and out of edit mode
		if(GetPVarType(playerid, "FlyMode")) CancelFlyMode(playerid);
		else FlyMode(playerid);
		return 1;
	}
	if (strcmp("/st", cmdtext, true, 10) == 0)
	{
		if(gMoveObject == 0)
		{
			gMoveObject = 1;
			SelectTextDraw(playerid, -1);

			new Float: X, Float: Y, Float: Z, Float: A;
			GetPlayerPos(playerid, X, Y, Z);
			GetPlayerFacingAngle(playerid, A);

			SetObjectPos(obj, X - floatsin(A, degrees) * 5.0, Y + floatcos(A, degrees) * 5.0, Z);
		}
		else
		{
			CancelSelectTextDraw(playerid);
			gMoveObject = 0;
		}
	    return 1;
	}
	return 0;
}


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

#define CountRange(%0,%1)       for (new c = %0; c < %1; c++)

forward OnEditorUpdate();
public OnEditorUpdate()
{
	CountRange(0, sizeof VirtualKeys)
	{
		if(GetVirtualKeyState(VirtualKeys[c][KEY_CODE]) & 0x8000)
		{
		    if(!VirtualKeys[c][KEY_PRESSED])
		    {
		        CallLocalFunction("OnVirtualKeyDown", "d", VirtualKeys[c][KEY_CODE]);
		        VirtualKeys[c][KEY_PRESSED] = true;
		    }
		}
		else if(VirtualKeys[c][KEY_PRESSED])
		{
		    CallLocalFunction("OnVirtualKeyRelease", "d", VirtualKeys[c][KEY_CODE]);
		    VirtualKeys[c][KEY_PRESSED] = false;
		}
	}
	GetScreenSize(ScreenWidth, ScreenHeight);
	GetMousePos(CursorX, CursorY);

	if(CursorOX != CursorX || CursorOY != CursorY)
	{
	    CallLocalFunction("OnCursorPositionChange", "dd", CursorX, CursorY);
	    CursorOX = CursorX;
	    CursorOY = CursorY;
	}
}

new
	OffsetX,
	OffsetY
;

forward OnVirtualKeyDown(key);
public OnVirtualKeyDown(key)
{
	if(gMoveObject == 1 && key == VK_LBUTTON) {
		gMoveObject = 2;

		new
			Float: oX,
			Float: oY,
			Float: oZ,
			Float: tX,
			Float: tY
		;
		GetObjectPos(obj, oX, oY, oZ);
		GetMousePos(CursorX, CursorY);
		WorldToScreen(0, oX, oY, oZ, tX, tY);

		OffsetX = CursorX - floatround(tX * ScreenWidth / cOnScreenX);
		OffsetY = CursorY - floatround(tY * ScreenHeight / cOnScreenY);
	}
}

forward OnVirtualKeyRelease(key);
public OnVirtualKeyRelease(key)
{
	if(gMoveObject == 2 && key == VK_LBUTTON) {
		gMoveObject = 1;
	}
}

forward OnCursorPositionChange(NewX, NewY);
public OnCursorPositionChange(NewX, NewY)
{
	if(gMoveObject == 2)
	{
		MoveBall(obj,
			(NewX - OffsetX) * cOnScreenX / ScreenWidth,
			(NewY - OffsetY) * cOnScreenY / ScreenHeight
		);
	}
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid) {
	if(_: clickedid == INVALID_TEXT_DRAW) {
		gMoveObject = 0;
	}
	return true;
}

forward Float:GetDistance(Float:x1,Float:y1,Float:z1, Float:x2,Float:y2,Float:z2);
stock Float:GetDistance(Float:x1,Float:y1,Float:z1, Float:x2,Float:y2,Float:z2)
{
	return VectorSize(x2 - x1, y2 - y1, z2 - z1);
}

public OnPlayerUpdate(playerid)
{
	if(noclipdata[playerid][cameramode] == CAMERA_MODE_FLY)
	{
		new keys,ud,lr;
		GetPlayerKeys(playerid,keys,ud,lr);

		if(noclipdata[playerid][mode] && (GetTickCount() - noclipdata[playerid][lastmove] > 100))
		{
		    // If the last move was > 100ms ago, process moving the object the players camera is attached to
		    MoveCamera(playerid);
		}

		// Is the players current key state different than their last keystate?
		if(noclipdata[playerid][udold] != ud || noclipdata[playerid][lrold] != lr)
		{
			if((noclipdata[playerid][udold] != 0 || noclipdata[playerid][lrold] != 0) && ud == 0 && lr == 0)
			{   // All keys have been released, stop the object the camera is attached to and reset the acceleration multiplier
				StopPlayerObject(playerid, noclipdata[playerid][flyobject]);
				noclipdata[playerid][mode]      = 0;
				noclipdata[playerid][accelmul]  = 0.0;
			}
			else
			{   // Indicates a new key has been pressed

			    // Get the direction the player wants to move as indicated by the keys
				noclipdata[playerid][mode] = GetMoveDirectionFromKeys(ud, lr);

				// Process moving the object the players camera is attached to
				MoveCamera(playerid);
			}
		}
		noclipdata[playerid][udold] = ud; noclipdata[playerid][lrold] = lr; // Store current keys pressed for comparison next update
		return 0;
	}
	return 1;
}

//--------------------------------------------------

stock GetMoveDirectionFromKeys(ud, lr)
{
	new direction = 0;

    if(lr < 0)
	{
		if(ud < 0) 		direction = MOVE_FORWARD_LEFT; 	// Up & Left key pressed
		else if(ud > 0) direction = MOVE_BACK_LEFT; 	// Back & Left key pressed
		else            direction = MOVE_LEFT;          // Left key pressed
	}
	else if(lr > 0) 	// Right pressed
	{
		if(ud < 0)      direction = MOVE_FORWARD_RIGHT;  // Up & Right key pressed
		else if(ud > 0) direction = MOVE_BACK_RIGHT;     // Back & Right key pressed
		else			direction = MOVE_RIGHT;          // Right key pressed
	}
	else if(ud < 0) 	direction = MOVE_FORWARD; 	// Up key pressed
	else if(ud > 0) 	direction = MOVE_BACK;		// Down key pressed

	return direction;
}

//--------------------------------------------------

stock MoveCamera(playerid)
{
	new Float:FV[3], Float:CP[3];
	GetPlayerCameraPos(playerid, CP[0], CP[1], CP[2]);          // 	Cameras position in space
    GetPlayerCameraFrontVector(playerid, FV[0], FV[1], FV[2]);  //  Where the camera is looking at

	// Increases the acceleration multiplier the longer the key is held
	if(noclipdata[playerid][accelmul] <= 1) noclipdata[playerid][accelmul] += ACCEL_RATE;

	// Determine the speed to move the camera based on the acceleration multiplier
	new Float:speed = MOVE_SPEED * noclipdata[playerid][accelmul];

	// Calculate the cameras next position based on their current position and the direction their camera is facing
	new Float:X, Float:Y, Float:Z;
	GetNextCameraPosition(noclipdata[playerid][mode], CP, FV, X, Y, Z);
	MovePlayerObject(playerid, noclipdata[playerid][flyobject], X, Y, Z, speed);

	// Store the last time the camera was moved as now
	noclipdata[playerid][lastmove] = GetTickCount();
	return 1;
}

//--------------------------------------------------

stock GetNextCameraPosition(move_mode, Float:CP[3], Float:FV[3], &Float:X, &Float:Y, &Float:Z)
{
    // Calculate the cameras next position based on their current position and the direction their camera is facing
    #define OFFSET_X (FV[0]*6000.0)
	#define OFFSET_Y (FV[1]*6000.0)
	#define OFFSET_Z (FV[2]*6000.0)
	switch(move_mode)
	{
		case MOVE_FORWARD:
		{
			X = CP[0]+OFFSET_X;
			Y = CP[1]+OFFSET_Y;
			Z = CP[2]+OFFSET_Z;
		}
		case MOVE_BACK:
		{
			X = CP[0]-OFFSET_X;
			Y = CP[1]-OFFSET_Y;
			Z = CP[2]-OFFSET_Z;
		}
		case MOVE_LEFT:
		{
			X = CP[0]-OFFSET_Y;
			Y = CP[1]+OFFSET_X;
			Z = CP[2];
		}
		case MOVE_RIGHT:
		{
			X = CP[0]+OFFSET_Y;
			Y = CP[1]-OFFSET_X;
			Z = CP[2];
		}
		case MOVE_BACK_LEFT:
		{
			X = CP[0]+(-OFFSET_X - OFFSET_Y);
 			Y = CP[1]+(-OFFSET_Y + OFFSET_X);
		 	Z = CP[2]-OFFSET_Z;
		}
		case MOVE_BACK_RIGHT:
		{
			X = CP[0]+(-OFFSET_X + OFFSET_Y);
 			Y = CP[1]+(-OFFSET_Y - OFFSET_X);
		 	Z = CP[2]-OFFSET_Z;
		}
		case MOVE_FORWARD_LEFT:
		{
			X = CP[0]+(OFFSET_X  - OFFSET_Y);
			Y = CP[1]+(OFFSET_Y  + OFFSET_X);
			Z = CP[2]+OFFSET_Z;
		}
		case MOVE_FORWARD_RIGHT:
		{
			X = CP[0]+(OFFSET_X  + OFFSET_Y);
			Y = CP[1]+(OFFSET_Y  - OFFSET_X);
			Z = CP[2]+OFFSET_Z;
		}
	}
}
//--------------------------------------------------

stock CancelFlyMode(playerid)
{
	DeletePVar(playerid, "FlyMode");
	CancelEdit(playerid);
	TogglePlayerSpectating(playerid, false);

	DestroyPlayerObject(playerid, noclipdata[playerid][flyobject]);
	noclipdata[playerid][cameramode] = CAMERA_MODE_NONE;
	return 1;
}

//--------------------------------------------------

stock FlyMode(playerid)
{
	// Create an invisible object for the players camera to be attached to
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	noclipdata[playerid][flyobject] = CreatePlayerObject(playerid, 19300, X, Y, Z, 0.0, 0.0, 0.0);

	// Place the player in spectating mode so objects will be streamed based on camera location
	TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	AttachCameraToPlayerObject(playerid, noclipdata[playerid][flyobject]);

	SetPVarInt(playerid, "FlyMode", 1);
	noclipdata[playerid][cameramode] = CAMERA_MODE_FLY;
	return 1;
}

//--------------------------------------------------

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