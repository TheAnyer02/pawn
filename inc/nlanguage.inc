//#include <a_samp>

#define AddTextPointer() enum NL_language
#define AddLanguage(%0) stock const %0[NL_language][] =

enum NL_language {}

stock static
	gLanguage[MAX_PLAYERS]
;

stock SetPlayerLanguage(playerid, const language[NL_language][]) {
	new
		addr
	;
	#emit load.s.pri language
	#emit stor.s.pri addr

	return (gLanguage[playerid] = addr);
}

stock GetPlayerLanguage(playerid) {
	return gLanguage[playerid];
}

stock static etext[] = "empty";

stock GetLanguageText(playerid, const NL_language: pointer) {
	playerid = gLanguage[playerid];

	#emit move.alt
	#emit load.s.pri pointer
	#emit idxaddr
	#emit move.alt
	#emit load.i
	#emit add
	#emit stor.s.pri 20
	#emit retn

	static
		tmp[1] // default scm size
	;
	return etext;
}

#if 0

AddTextPointer() {
	gt_Welcome,
};

AddLanguage(English) {
	"Welcome to my server!"
};

AddLanguage(German) {
	"Willkommen auf meinem Server!"
};

public OnFilterScriptInit() {
	new
		tmp[144]
	;
	SetPlayerLanguage(0, German);
	tmp = GetLanguageText(0, gt_Welcome);
	print(GetLanguageText(0, gt_Welcome));
}

#endif