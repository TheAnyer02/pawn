// Nero_3D
// Command processor based on emit
// Thats the reason why it should be / is the fastest
// Normal version only with OnPlayerCommandText hooked

#define NCMD:%1(%2) forward C%1(%2); public C%1(%2)

#if defined ncmd_OnFilterScriptInit
	forward ncmd_OnFilterScriptInit();
#endif
#if defined ncmd_OnPlayerCommandText
	forward ncmd_OnPlayerCommandText(playerid, cmdtext[]);
#endif

#tryinclude <nMain>

#if defined _inc_nMain
	Include<ncmd>;
#endif

static const
	ncmd_Public
;

static ncmd_Init() {
	// Offset to the public table
	#emit lctrl 1 // dat
	#emit neg
	#emit move.alt
	#emit add.c 32 // publics
	#emit stor.pri ncmd_Public
	#emit lref.pri ncmd_Public
	#emit add
	#emit stor.pri ncmd_Public
}

public OnFilterScriptInit() {
	#if defined ncmd_OnFilterScriptInit
		ncmd_OnFilterScriptInit();
	#endif

	ncmd_Init();
}
#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit ncmd_OnFilterScriptInit

main() {
	#if defined ncmd_main
		ncmd_main();
	#endif

	ncmd_Init();
}
#if defined _ALS_main
	#undef main
#else
	#define _ALS_main
#endif
#define main ncmd_main

public OnPlayerCommandText(playerid, cmdtext[]) {
	// Initialization code - Gets called only once
	static
		cell,
		adr
	;
	// Calls the new OnPlayerCommandText
	#if defined ncmd_OnPlayerCommandText
		if(ncmd_OnPlayerCommandText(playerid, cmdtext)) {
			return true; // Stops execution if the command already exists
		} {} // Or any other reason why you would return true :)
	#endif
	// cmdtext[0] = 'C', adr = cmdtext
	#emit load.s.alt cmdtext
	#emit stor.alt adr
	#emit const.pri 'C'
	#emit stor.i
	// Looping till EOS or Space
	do { // skipping first cell, it is always '/'
		#emit load.pri adr
		#emit add.c 4
		#emit stor.pri adr
		#emit load.i
		#emit stor.pri cell
	} while(cell > ' ');
	// Replacing Space with EOS and adr += 4
	if(cell) {
		#emit load.alt adr
		#emit zero.pri
		#emit stor.i
		#emit const.pri 4
		#emit add
		#emit stor.pri adr
	} // Getting funcidx of command
	if((cell = funcidx(cmdtext)) != -1) {
		// Overwritting address of cmdtext
		#emit load.pri adr
		#emit stor.s.pri cmdtext
		// Calling command
		#emit load.pri cell
		#emit shl.c.pri 3
		#emit load.alt ncmd_Public
		#emit add
		#emit stor.pri cell
		#emit lref.pri cell
		#emit add.c 4
		#emit sctrl 6
	} // Return false if no command was found
	return false;
}
// ALS macros
#if defined _ALS_OnPlayerCommandText
	#undef OnPlayerCommandText
#else
	#define _ALS_OnPlayerCommandText
#endif
#define OnPlayerCommandText ncmd_OnPlayerCommandText