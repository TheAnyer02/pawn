#include <a_samp>

#define DEFAULT_FUEL 35.0

new
	gTimer,
	PlayerText: FuelText[MAX_PLAYERS],
    Float: Fuel[MAX_VEHICLES] = {DEFAULT_FUEL, ...},
    Float: VehicleLastCoords[MAX_PLAYERS][3]; // MAX_PLAYERS instead of MAX_VEHICLES
// we only need to save the position if a player is inside

public OnPlayerConnect(playerid) {
	printf("OnPlayerConnect(%d)", playerid);

	new PlayerText: ptext = FuelText[playerid] = CreatePlayerTextDraw(playerid, 430.0, 420.0, "_");
    PlayerTextDrawBackgroundColor(playerid, ptext, 0x33);
    PlayerTextDrawFont(playerid, ptext, 3);
    PlayerTextDrawLetterSize(playerid, ptext, 0.4, 1.7);
    PlayerTextDrawColor(playerid, ptext, -1);
    PlayerTextDrawSetShadow(playerid, ptext, 3);

	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate) {
    if(newstate == PLAYER_STATE_DRIVER) {
		new vid = GetPlayerVehicleID(playerid);
        GetVehiclePos(vid, VehicleLastCoords[playerid][0], VehicleLastCoords[playerid][1], VehicleLastCoords[playerid][2]);
        PlayerTextDrawShow(playerid, FuelText[playerid]); // moved that here
		UpdateFuel(playerid, Fuel[vid]);
    }
    if(oldstate == PLAYER_STATE_DRIVER) {
        PlayerTextDrawHide(playerid, FuelText[playerid]); // was missing
    }
    return 1;
}

public OnFilterScriptInit() {
	for(new i; i < MAX_PLAYERS; ++i) {
		if(IsPlayerConnected(i)) {
			OnPlayerConnect(i);

			if(GetPlayerState(i) == PLAYER_STATE_DRIVER) {
				OnPlayerStateChange(i, PLAYER_STATE_DRIVER, 0);
			}
		}
	}
    gTimer = SetTimer("ConsumeFuel", 1000, true); // 2 seconds instead of 10
} // otherwise the player could drive in circles and have a distance of 0

public OnFilterScriptExit() {
	for(new i; i < MAX_PLAYERS; ++i) {
		if(IsPlayerConnected(i)) {
			if(GetPlayerState(i) == PLAYER_STATE_DRIVER) {
				OnPlayerStateChange(i, 0, PLAYER_STATE_DRIVER);
			}
		}
	}
	KillTimer(gTimer);
}

public OnVehicleSpawn(vehicleid) {
	Fuel[vehicleid] = DEFAULT_FUEL;
}

UpdateFuel(playerid, Float: fuel) {
	new str[32];
	format(str, sizeof(str), "Fuel %f%%", fuel);
	PlayerTextDrawSetString(playerid, FuelText[playerid], str);
}

Float: GetVehicleSpeed(vehicleid) {
	new
		Float: vX,
		Float: vY,
		Float: vZ;

	return GetVehicleVelocity(vehicleid, vX, vY, vZ) ? VectorSize(vX, vY, vZ) * 180.0 : 0.0;
}

forward ConsumeFuel();
public ConsumeFuel() {
    new
        i,
        vid,
        Float: dist,
		Float: speed;

    for(i = 0; i < MAX_PLAYERS; i++) {
        if(GetPlayerState(i) == PLAYER_STATE_DRIVER) {
            vid = GetPlayerVehicleID(i);
			speed = GetVehicleSpeed(vid); // max speed nrg = 
            dist = GetVehicleDistanceFromPoint(vid, VehicleLastCoords[i][0], VehicleLastCoords[i][1], VehicleLastCoords[i][2]);
            GetVehiclePos(vid, VehicleLastCoords[i][0], VehicleLastCoords[i][1], VehicleLastCoords[i][2]);
			new tmp[32];
			format(tmp, sizeof tmp, "%f", speed);
			GameTextForPlayer(i, tmp, 999, 4);

            Fuel[vid] -= speed / 90.0 * dist / 1000.0 + 1.0 / 60.0; // speed / 90.0 * 1km / 1fuel + 1fuel / 1minute

            UpdateFuel(i, Fuel[vid]);
        }
    }
}  