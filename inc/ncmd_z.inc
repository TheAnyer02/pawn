// Nero_3D
// Command processor based on emit
// Thats the reason why it should be / is the fastest
// Zcmd version with OnPlayerCommandReceived and OnPlayerCommandPerformed

#define NCMD:%1(%2) forward C%1(%2); public C%1(%2)

#if defined ncmdz_OnFilterScriptInit
	forward ncmdz_OnFilterScriptInit();
#endif
#if defined ncmdz_OnGameModeInit
	forward ncmdz_OnGameModeInit();
#endif
#if defined ncmdz_OnPlayerCommandText
	forward ncmdz_OnPlayerCommandText(playerid, cmdtext[]);
#endif

#tryinclude <nMain>

#if defined _inc_nMain
	Include<ncmd_z>;
#endif

#if defined OnPlayerCommandReceived
	forward OnPlayerCommandReceived(playerid, cmdtext[]);
#endif
#if defined OnPlayerCommandPerformed
	forward OnPlayerCommandPerformed(playerid, cmdtext[], success);
#endif

static const
	ncmdz_Public
;
#if defined OnPlayerCommandPerformed
	static
		ncmdz_OPCP
	;
#endif

static ncmdz_Init() {
	// Offset to the public table
	#emit lctrl 1 // dat
	#emit neg
	#emit move.alt
	#emit add.c 32 // publics
	#emit stor.pri ncmdz_Public
	#emit lref.pri ncmdz_Public
	#emit add
	#emit stor.pri ncmdz_Public

	#if !defined OnPlayerCommandPerformed
		return ;
	#else
		funcidx(#OnPlayerCommandPerformed);
	#endif

	#emit shl.c.pri 3
	#emit load.alt ncmdz_Public
	#emit add
	#emit stor.pri ncmdz_Public
	#emit lref.pri ncmdz_Public
	#emit add.c 4
	#emit stor.pri ncmdz_Public

	#if defined OnPlayerCommandPerformed
		ncmdz_OPCP = ncmdz_Public;
	#endif

	#emit stor.alt ncmdz_Public
}

public OnFilterScriptInit() {
	#if defined ncmdz_OnFilterScriptInit
		ncmdz_OnFilterScriptInit();
	#endif

	ncmdz_Init();
}
#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit ncmdz_OnFilterScriptInit

public OnGameModeInit() {
	#if defined ncmdz_OnGameModeInit
		ncmdz_OnGameModeInit();
	#endif

	ncmdz_Init();
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit ncmdz_OnGameModeInit

static stock ncmdz_CallOPCPerformed(playerid, addr, cell) {
	#pragma unused playerid, addr

	static
		idx
	;
	// Removing EOS from cmdtext
	const
		m4 = -4
	;
	#emit load.s.pri addr
	#emit add.c m4
	#emit move.alt
	#emit const.pri ' '
	#emit stor.i
	// Preparing to call command
	#emit load.s.pri cell
	#emit shl.c.pri 3
	#emit load.alt ncmdz_Public
	#emit add
	#emit stor.pri idx
	// Moving old frame down
	#emit load.s.alt 0
	#emit const.pri 4
	#emit sub.alt
	#emit stor.s.pri 0
	#emit xchg
	#emit movs 20
	// Fixing param count #1
	#emit const.pri 8
	#emit stor.s.pri 8
	// Overwritting return addr
	#emit lctrl 6
	#emit add.c 40
	#emit stor.s.pri 4
	// Calling command
	#emit lref.pri idx
	#emit add.c 4
	#emit sctrl 6
	// Return here - setting success
	#emit stor.s.pri 20
	// Fixing param count #2
	#emit const.pri 12
	#emit stor.s.pri 8
	// Fixing cmdtext[0] = '/'
	#emit load.s.alt 16
	#emit const.pri '/'
	#emit stor.i
	// Calling OnPlayerCommandPerformed
	#emit load.pri ncmdz_OPCP
	#emit sctrl 6
	// END
}

public OnPlayerCommandText(playerid, cmdtext[]) {
	// Initialization code - Gets called only once
	static
		cell,
		addr
	;
	// Calls OnPlayerCommandReceived
	#if defined OnPlayerCommandReceived
		if(!OnPlayerCommandReceived(playerid, cmdtext)) {
			return true; // Stops execution if the command already exists
		} {} // Or any other reason why you would return true :)
	#endif
	// cmdtext[0] = 'C', addr = cmdtext
	#emit load.s.alt cmdtext
	#emit stor.alt addr
	#emit const.pri 'C'
	#emit stor.i
	// Looping till EOS or Space
	do { // skipping first cell, it is always '/'
		#emit load.pri addr
		#emit add.c 4
		#emit stor.pri addr
		#emit load.i
		#emit stor.pri cell
	} while(cell > ' ');
	// Replacing Space with EOS and addr += 4
	if(cell) {
		#emit load.alt addr
		#emit zero.pri
		#emit stor.i
		#emit const.pri 4
		#emit add
		#emit stor.pri addr
	} {} // Getting funcidx of command
	if((cell = funcidx(cmdtext)) != -1) {
		#if defined OnPlayerCommandPerformed
			ncmdz_CallOPCPerformed(playerid, addr, cell);
		#endif

		// Overwritting address of cmdtext
		#emit load.pri addr
		#emit stor.s.pri cmdtext
		// Calling command
		#emit load.pri cell
		#emit shl.c.pri 3
		#emit load.alt ncmdz_Public
		#emit add
		#emit stor.pri cell
		#emit lref.pri cell
		#emit add.c 4
		#emit sctrl 6
		// END
	}
	// Return false if no command was found
	return false;
}
// ALS macros
#if defined _ALS_OnPlayerCommandText
	#undef OnPlayerCommandText
#else
	#define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText ncmdz_OnPlayerCommandText