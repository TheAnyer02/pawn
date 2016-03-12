#include <a_samp>
#include <zcmd>
#include <sscanf2>
// default values
#define CAMERA_POS "345.5, 308.1, 1000.0"
#define LOOK_AT "345.5, 301.0, 1000.0"
#define INTERIOR "6"

new
    Interior,
    pInterior,
    Float: pPos[3],
    Float: CameraPos[3],
    Float: CameraLookAt[3],
    Float: PosOffset[3],
    Float: LookAtOffset[3],
    gAdjust = INVALID_PLAYER_ID
;

SetCamera(playerid) {
    SetPlayerPos(playerid, CameraPos[0] + PosOffset[0], CameraPos[1] + PosOffset[1], CameraPos[2] + PosOffset[2]);
    SetPlayerCameraLookAt(playerid, CameraLookAt[0] + LookAtOffset[0], CameraLookAt[1] + LookAtOffset[1], CameraLookAt[2] + LookAtOffset[2]);
    SetPlayerCameraPos(playerid, CameraPos[0] + PosOffset[0], CameraPos[1] + PosOffset[1], CameraPos[2] + PosOffset[2]);
    return SetPlayerInterior(playerid, Interior);
}

CMD:adjust(playerid, params[]) {
    if(gAdjust == INVALID_PLAYER_ID) {
        sscanf(params, "A<f>(" CAMERA_POS ")[3]A<f>(" LOOK_AT ")[3]I(" INTERIOR ")", CameraPos, CameraLookAt, Interior);

        gAdjust = playerid;
        SetCamera(playerid);
        pInterior = GetPlayerInterior(playerid);
        TogglePlayerControllable(playerid, false);
        GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
        return SendClientMessage(playerid, -1, "Use /posoffset x y z and /lookatoffset x y z");
    }
    if(gAdjust == playerid) {
        gAdjust = INVALID_PLAYER_ID;
        SetCameraBehindPlayer(playerid);
        TogglePlayerControllable(playerid, true);
        printf("\n\
            SetPlayerPos(playerid, %f, %f, %f);\n\
            SetPlayerCameraLookAt(playerid, %f, %f, %f);\n\
            SetPlayerCameraPos(playerid, %f, %f, %f);\n\
            SetPlayerInterior(playerid, %d);\n",
            CameraPos[0] + PosOffset[0],
            CameraPos[1] + PosOffset[1],
            CameraPos[2] + PosOffset[2],
            CameraLookAt[0] + LookAtOffset[0],
            CameraLookAt[1] + LookAtOffset[1],
            CameraLookAt[2] + LookAtOffset[2],
            CameraPos[0] + PosOffset[0],
            CameraPos[1] + PosOffset[1],
            CameraPos[2] + PosOffset[2],
            Interior
        );
        SetPlayerInterior(playerid, pInterior);
        SetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
        return SendClientMessage(playerid, -1, "Adjust finished, coordinates printed to server-log.txt");
    }
    return SendClientMessage(playerid, -1, "Someone is already adjusting the camera!");
}
CMD:posoffset(playerid, params[]) {
    if(gAdjust != playerid) {
        return false;
    }
    if(sscanf(params, "a<f>[3]", PosOffset)) {
        return SendClientMessage(playerid, -1, "/posoffset x y z");
    }
    return SetCamera(playerid);
}
CMD:lookatoffset(playerid, params[]) {
    if(gAdjust != playerid) {
        return false;
    }
    if(sscanf(params, "a<f>[3]", LookAtOffset)) {
        return SendClientMessage(playerid, -1, "/lookatoffset x y z");
    }
    return SetCamera(playerid);
}
