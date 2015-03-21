#define D_FILTER_SCRIPT_NAME	"Dijkstra's algorithm"

#define N_INCLUDE_CARS true
#define N_INCLUDE_PEDS false

#include <a_samp>

#define DEBUG_INFO true

#define NUM_NCARS 30587
#define NUM_NPEDS 2262
#define NUM_A_WAY 50

#if N_INCLUDE_CARS == true
	#if N_INCLUDE_PEDS == true
		#define NUM_NODES (NUM_NCARS + NUM_NPEDS)
	#else
		#define NUM_NODES (NUM_NCARS)
	#endif
#elseif N_INCLUDE_PEDS == true
	#define NUM_NODES (NUM_NPEDS)
#else
	#error No Nodes included!
#endif

enum N_Data
{
	Float:D_PosX,
	Float:D_PosY,
	Float:D_PosZ,
	D_antecessor,
	bool:D_visted,
	Float:D_distance
}
new Node_Data[NUM_NODES][N_Data];

#define GetSegment(%1,%2) ((8 * floatround((((%2 < 0.0) ? (-%2) : (%2 + 3000.0)) / 750), floatround_floor)) + floatround((((%1 < 0.0) ? (-%1) : (%1 + 3000.0)) / 750), floatround_floor))

public OnFilterScriptInit()
{
	print("\r\n**** " D_FILTER_SCRIPT_NAME " ****");
	#if N_INCLUDE_CARS == true
		print("* Car Nodes included (" #NUM_NCARS ") *");
	#endif
	#if N_INCLUDE_PEDS == true
		print("* Ped  Nodes included (" #NUM_NPEDS ") *");
	#endif
	print("******************************");
	#if N_INCLUDE_CARS == true
		D_Load_Nodes(\"Nodes\cars\");
	#endif
	#if N_INCLUDE_PEDS == true
		D_Load_Nodes(\"Nodes\peds\");
	#endif
}

stock D_Load_Nodes(path[])
{
	static node_counter;
	#if DEBUG_INFO == true
		printf("\r\n* D_Load_Nodes(\"%s\")", path);
	#endif
	for(new s, tmp[128], index, File:gfile; s != 64; s++)
	{
		format(tmp, sizeof tmp, "%ssegment_%d.dnf", path, s);
		if(fexist(tmp))
		{
			gfile = fopen(tmp, io_read);
			for(index = 2; fread(gfile, tmp); index = 2, node_counter++)
			{
				D_Get_Data(tmp, D_PosX, node_counter, index);
				D_Get_Data(tmp, D_PosY, node_counter, index);
				D_Get_Data(tmp, D_PosZ, node_counter, index);
			}
			#if DEBUG_INFO == true
				printf("** Segment %d loaded! (Nodes %d)", s, node_counter);
			#endif
			fclose(gfile);
			continue;
		}
		break;
	}
	return 0;
}

stock D_Get_Data(source[], N_Data:type, counter, &index, separator = 0)
{
	source[(separator = strfind(source, "|", true, index))] = EOS;
	new point = strfind(source, ",", false, index);
	if(point == -1)
	{
		(Float:Node_Data[counter][type]) = strval(source[index]);
	} else {
		source[point] = EOS;
		(Float:Node_Data[counter][type]) = strval(source[point + 1]);
		while(Float:Node_Data[counter][type] > 1) {
			(Float:Node_Data[counter][type]) /= 10.0;
		}
		if(source[index] == '-') {
			(Float:Node_Data[counter][type]) = floatstr(source[index]) - (Float:Node_Data[counter][type]);
		} else {
			(Float:Node_Data[counter][type]) += floatstr(source[index]);
		}
		source[point] = ',';
	}
	source[separator] = '|';
	index = (separator + 1);
}

#define INVINITY (float(0x7F800000))
stock Dijkstra(start, destination)
{
	#if DEBUG_INFO == true
		printf("* Dijkstra(%d, %d)", start, destination);
	#endif
	if(start == destination) return;
	new
		n,
		Float:T_X,
		Float:T_Y,
		Float:T_Z,
		Float:tdistance;
	for( ; n != NUM_NODES; n++)
	{
		Node_Data[n][D_visted] = false;
		Node_Data[n][D_distance] = INVINITY;
	}
	Node_Data[start][D_distance] = 0;
	Node_Data[start][D_antecessor] = -1;
	for( ; ; )
	{
		Node_Data[start][D_visted] = true;
		for(n = 0; n != NUM_NODES; n++)
		{
			if(Node_Data[n][D_visted] == false)
			{
				T_X = Node_Data[start][D_PosX] - Node_Data[n][D_PosX];
				T_Y = Node_Data[start][D_PosY] - Node_Data[n][D_PosY];
				T_Z = Node_Data[start][D_PosZ] - Node_Data[n][D_PosZ];
				tdistance = Node_Data[start][D_distance] +
					(T_X * T_X) + (T_Y * T_Y) + (T_Z * T_Z);
				if(tdistance < Node_Data[n][D_distance])
				{
					Node_Data[n][D_antecessor] = start;
					Node_Data[n][D_distance] = tdistance;
				}
			}
		}
		for(n = 0, tdistance = INVINITY; n != NUM_NODES; n++)
		{
			if(	(Node_Data[n][D_visted] == false) &&
				(Node_Data[n][D_distance] < tdistance))
			{
				tdistance = Node_Data[(start = n)][D_distance];
			}
		}
		if((start == destination) || (tdistance == Node_Data[destination][D_distance]))
		{
			return;
		}
	}
}

stock ShortestPath(destination, shortest_path[NUM_A_WAY])
{
	#if DEBUG_INFO == true
		printf("* ShortestPath(%d, shortest_path[NUM_NODES])", destination);
	#endif
	shortest_path[1] = -1;
	shortest_path[0] = destination;
	for(new n, m = 2; Node_Data[destination][D_antecessor] != -1; m++) {
		for(n = m; n != 0; n--) {
		    if(n != NUM_A_WAY) {
		        return;
		    }
			shortest_path[n] = shortest_path[n - 1];
		}
		shortest_path[0] = destination = Node_Data[destination][D_antecessor];
	}
	return;
}

stock GetNearestNode(Float:X, Float:Y, Float:Z)
{
	#if DEBUG_INFO == true
		printf("* GetNearestNode(%f, %f, %f)", X, Y, Z);
	#endif
	new
		s,
		n = 1,
		d1,
		d2,
		Float:N_X,
		Float:N_Y,
		Float:N_Z;
	N_X = Node_Data[0][D_PosX] - X;
	N_Y = Node_Data[0][D_PosY] - Y;
	N_Z = Node_Data[0][D_PosZ] - Z;
	d2 = floatround((N_X * N_X) + (N_Y * N_Y) + (N_Z * N_Z));
	for( ; n != NUM_NODES; n++)
	{
		N_X = Node_Data[n][D_PosX] - X;
		N_Y = Node_Data[n][D_PosY] - Y;
		N_Z = Node_Data[n][D_PosZ] - Z;
		d1 = floatround((N_X * N_X) + (N_Y * N_Y) + (N_Z * N_Z));
		if(d1 < d2)
		{
			s = n, d2 = d1;
		}
	}
	return s;
}

new Start[MAX_PLAYERS] = {-1, ...};
new Destination[MAX_PLAYERS] = {-1, ...};

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/gps", cmdtext, true, 4) == 0)
	{
		if(Start[playerid] != -1)
		{
			Start[playerid] = -1;
			DisablePlayerRaceCheckpoint(playerid);
			GameTextForPlayer(playerid, "~r~GPS disabled!", 2000, 4);
			return 1;
		}
		new idx = strfind(cmdtext, " ", false, 5);
		if((cmdtext[4] != 32) || (idx == -1))
		{
			SendClientMessage(playerid, 0xFFFFFFAA, "Right Usage: /gps [X] [Y]");
			return 1;
		}
		new
			i,
			Float:P_X,
			Float:P_Y,
			Float:P_Z,
			string[256],
			temp[NUM_A_WAY];
		GetPlayerPos(playerid, P_X, P_Y, P_Z);
		Start[playerid] = GetNearestNode(P_X, P_Y, P_Z);
		Destination[playerid] = GetNearestNode(floatstr(cmdtext[5]), floatstr(cmdtext[idx + 1]), P_Z);
		Dijkstra(Start[playerid], Destination[playerid]);
		ShortestPath(Destination[playerid], temp);
		for( ; temp[i] != -1; i++)
		{
			format(string, sizeof string, "%s, %d", string, temp[i]);
		}
		SetPlayerRaceCheckpoint(playerid, 0,
			Node_Data[Start[playerid]][D_PosX], Node_Data[Start[playerid]][D_PosY], Node_Data[Start[playerid]][D_PosZ],
			Node_Data[temp[1]][D_PosX], Node_Data[temp[1]][D_PosY], Node_Data[temp[1]][D_PosZ], 10.0);
		format(string, sizeof string, "~r~(%d) %s (%d)", Start[playerid], string[2], Destination[playerid]);
		GameTextForPlayer(playerid, string, 5000, 4);
		return 1;
	}
	return 0;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(Start[playerid] != -1)
	{
		new
			antecessor = Destination[playerid];
		Dijkstra(Start[playerid], antecessor);
		while(Node_Data[antecessor][D_antecessor] != Start[playerid]) {
			antecessor = Node_Data[antecessor][D_antecessor];
		}
		DisablePlayerRaceCheckpoint(playerid);
		if(antecessor == Destination[playerid])
		{
			SetPlayerRaceCheckpoint(playerid, 1,
				Node_Data[antecessor][D_PosX], Node_Data[antecessor][D_PosY], Node_Data[antecessor][D_PosZ], 0.0, 0.0, 0.0, 10.0);
		} else {
			SetPlayerRaceCheckpoint(playerid, 0,
				Node_Data[Start[playerid]][D_PosX], Node_Data[Start[playerid]][D_PosY], Node_Data[Start[playerid]][D_PosZ],
				Node_Data[antecessor][D_PosX], Node_Data[antecessor][D_PosY], Node_Data[antecessor][D_PosZ], 10.0);
		}
		Start[playerid] = antecessor;
	}
}
