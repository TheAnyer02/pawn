#include <a_samp>
#include <screentoworld>

#include "vkeys"
#include "flymode"

native GetScreenSize(&Width, &Height);
native GetMousePos(&X, &Y);

enum {
	eNone,
	eMove
}

new
	gMode = eNone,
	gMoveObject = INVALID_OBJECT_ID,
	gObjectid1,
	gObjectid2,
	gTimerid,
	Cursor_oX,
	Cursor_oY,
	Cursor_X,
	Cursor_Y,
	ScreenWidth,
	ScreenHeight,
	Float: OffsetX,
	Float: OffsetY
;

stock MoveObjectWithCursor(objectid, Float: ScreenX, Float: ScreenY) {
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
	SetObjectPos(objectid, oX, oY, oZ);
}

public OnPlayerSpawn(playerid) {
	SetPlayerPos(playerid, 0.65342, 1741.12512, 20.24046);
}

public OnFilterScriptInit() {
	gObjectid1 = CreateObject(1946, 0.0, 0.0, 0.0, 0.00000, 0.00000, 0.00000);
	gObjectid2 = CreateObject(1946, 0.0, 0.0, 0.0, 0.00000, 0.00000, 0.00000);
}

public OnFilterScriptExit() {
	DestroyObject(gObjectid1);
	DestroyObject(gObjectid2);
	CancelSelectTextDraw(0);
	KillTimer(gTimerid);
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    if(strcmp(cmdtext, "/flymode", true) == 0) {
		if(IsPlayerUsingFlyMode(playerid)) {
			CancelFlyMode(playerid);
		} else {
			FlyMode(playerid);
		}
		return true;
	}
	if(strcmp("/st", cmdtext, true, 10) == 0) {
		if(playerid == 0) {
			new
				Float: cX,
				Float: cY,
				Float: cZ,
				Float: vX,
				Float: vY,
				Float: vZ
			;
			GetPlayerCameraPos(0, cX, cY, cZ);
			GetPlayerCameraFrontVector(0, vX, vY, vZ);

			cX += vX * 10.0;
			cY += vY * 10.0;
			cZ += vZ * 10.0;

			SetObjectPos(gObjectid2,
				cX + vY * 5.0,
				cY - vX * 5.0,
				cZ
			);
			SetObjectPos(gObjectid1,
				cX - vY * 5.0,
				cY + vX * 5.0,
				cZ
			);
			SelectTextDraw(0, -1);

			GetScreenSize(ScreenWidth, ScreenHeight);

			gMoveObject = INVALID_OBJECT_ID;
			gMode = eMove;
			return true;
		}
	}
	return false;
}

OnCursorPositionChange(NewX, NewY) {
	if(gMoveObject != INVALID_OBJECT_ID) {
		switch(gMode) {
			case eMove: {
				MoveObjectWithCursor(gMoveObject,
					(NewX * cOnScreenX / ScreenWidth) - OffsetX,
					(NewY * cOnScreenY / ScreenHeight) - OffsetY
				);
			}
		}
	}
}

forward OnEditorUpdate();
public OnEditorUpdate() {
	GetMousePos(Cursor_X, Cursor_Y);

	if(Cursor_oX != Cursor_X || Cursor_oY != Cursor_Y) {
		static
			Float: offX,
			Float: offY,
			Float: speed
		;
		offX = ((Cursor_X - Cursor_oX) * cOnScreenX / ScreenWidth);
		offY = ((Cursor_Y - Cursor_oY) * cOnScreenY / ScreenHeight);

		speed = VectorSize(offX, offY, 0.0) * 0.01;

		OffsetX -= offX * speed;
		OffsetY -= offY * speed;

		OnCursorPositionChange((Cursor_oX = Cursor_X), (Cursor_oY = Cursor_Y));
	}
}

public OnVirtualKeyDown(key) {
	if(key == VK_LBUTTON) {
		switch(gMode) {
			case eMove: {
				new
					Float: oX,
					Float: oY,
					Float: oZ,
					Float: cX,
					Float: cY,
					Float: cZ,
					Float: screenX,
					Float: screenY,
					Float: cursorX,
					Float: cursorY,
					Float: dis = Float: 0x7F800000
				;
				GetMousePos(Cursor_X, Cursor_Y);
				GetPlayerCameraPos(0, cX, cY, cZ);
				GetPlayerCameraFrontVector(0, oX, oY, oZ);

				cX += oX * 500.0;
				cY += oY * 500.0;
				cZ += oZ * 500.0;

				cursorX = Cursor_X * cOnScreenX / ScreenWidth;
				cursorY = Cursor_Y * cOnScreenY / ScreenHeight;

				for(new i = 1; i != MAX_OBJECTS; ++i) {
					if(
						GetObjectPos(i, oX, oY, oZ) &&
						VectorSize(oX - cX, oY - cY, oZ - cZ) < 500.0 &&
						WorldToScreen(0, oX, oY, oZ, screenX, screenY)
					) {
						screenX = cursorX - screenX;
						screenY = cursorY - screenY;

						if(VectorSize(screenX, screenY, 0.0) < dis) {
							dis = VectorSize(screenX, screenY, 0.0);

							gMoveObject = i;

							OffsetX = screenX;
							OffsetY = screenY;
						}
					}
				}
				if(VectorSize(OffsetX, OffsetY, 0.0) < 50.0) {
					gTimerid = SetTimer("OnEditorUpdate", 25, true);
					GetMousePos(Cursor_oX, Cursor_oY);
				} else {
					gMoveObject = INVALID_OBJECT_ID;
				}
			}
		}
	}
}

public OnVirtualKeyRelease(key) {
	if(key == VK_LBUTTON && gMoveObject != INVALID_OBJECT_ID) {
		gMoveObject = INVALID_OBJECT_ID;
		KillTimer(gTimerid);
	}
}

public OnPlayerClickTextDraw(playerid, Text:clickedid) {
	if(_: clickedid == INVALID_TEXT_DRAW) {
		gMoveObject = INVALID_OBJECT_ID;
		KillTimer(gTimerid);
		gMode = eNone;
	}
	return true;
}