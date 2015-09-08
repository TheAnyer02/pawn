// Nero_3D
//
// ------
//  Text
// ------

#define Include<%0>  public stock const nMi_%0; stock nMf_%0() return nMi_%0
#define Mode<%0> public stock const nMm_%0;  stock nMf_%0() return nMm_%0

static const
	nMain_NL[] = "\r\n"
;

static nMain() { // swapchars
	const
		nMi_ = 'n' | 'M' << 8 | 'i' << 16 | '_' << 24,
		nMm_ = 'n' | 'M' << 8 | 'm' << 16 | '_' << 24
	;
	new
		base,
		pubvar,
		tags
	;
	#emit lctrl 1
	#emit neg
	#emit move.alt
	#emit stor.s.pri base
	#emit add.c 44
	#emit stor.s.pri pubvar
	#emit add.c 4
	#emit stor.s.pri tags

	#emit lref.s.pri pubvar
	#emit add
	#emit stor.s.pri pubvar
	#emit lref.s.pri tags
	#emit add
	#emit add.c 0xFFFFFFFC
	#emit stor.s.pri tags

	new
		idx,
		addr,
		cell
	;
	while(pubvar < tags) {
		#emit lref.s.pri tags
		#emit load.s.alt base
		#emit add
		#emit stor.s.pri addr
		#emit lref.s.pri addr
		#emit stor.s.pri cell

		switch(cell) {
			case nMi_: {
				idx = nMainPrint(addr, " included");
			}
			case nMm_: {
				idx = nMainPrint(addr, " loaded");
			}
		}
		tags -= 8;
	}
	if(idx) {
		print(nMain_NL);
	}
}

static nMainPrint(addr, cat[]) {
	new
		idx,
		cell,
		tmp[64]
	;
	for(addr += 4; ; ++addr) {
		#emit lref.s.pri addr
		#emit addr.alt cell
		#emit strb.i 1

		switch(cell) {
			case '_': {
				tmp[idx++] = ' ';
			}
			case EOS: {
				tmp[idx++] = EOS;
				break;
			}
			default: {
				tmp[idx++] = cell;
			}
		}
	}
	print(nMain_NL);
	idx += strcat(tmp, cat);
	PrintHeader(tmp, .size = idx, .nl = false);
	return idx;
}

/*
static nMain() { // swapchars
	const
		nMi_ = 'n' | 'M' << 8 | 'i' << 16 | '_' << 24,
		nMg_ = 'n' | 'M' << 8 | 'g' << 16 | '_' << 24
	;
	new
		base,
		pubvar,
		tags
	;
	#emit lctrl 1
	#emit neg
	#emit move.alt
	#emit stor.s.pri base
	#emit add.c 44
	#emit stor.s.pri pubvar
	#emit add.c 4
	#emit stor.s.pri tags

	#emit lref.s.pri pubvar
	#emit add
	#emit add.c 4
	#emit stor.s.pri pubvar
	#emit lref.s.pri tags
	#emit add
	#emit stor.s.pri tags

	new
		idx,
		midx,
		addr,
		cell,
		mode[64],
		include[256]
	;
	while(pubvar < tags) {
		#emit lref.s.pri pubvar
		#emit load.s.alt base
		#emit add
		#emit stor.s.pri addr
		#emit lref.s.pri addr
		#emit stor.s.pri cell

		switch(cell) {
			case nMi_: {
				include[idx] = ',';
				include[++idx] = ' ';

				do {
					addr += 4;

					#emit lref.s.pri addr
					#emit stor.s.pri cell

					if((include[++idx] = (cell & 0xFF)) == EOS) break;
					if((include[++idx] = ((cell >>> 8) & 0xFF)) == EOS) break;
					if((include[++idx] = ((cell >>> 16) & 0xFF)) == EOS) break;
					if((include[++idx] = (cell >>> 24)) == EOS) break;
				} while(idx < (sizeof include - 4));
			}
			case nMg_: {
				do {
					addr += 4;

					#emit lref.s.pri addr
					#emit stor.s.pri cell

					if((mode[midx++] = (cell & 0xFF)) == EOS) break;
					if((mode[midx++] = ((cell >>> 8) & 0xFF)) == EOS) break;
					if((mode[midx++] = ((cell >>> 16) & 0xFF)) == EOS) break;
					if((mode[midx++] = (cell >>> 24)) == EOS) break;
				} while(midx < (sizeof mode - 4));
			}
		}
		pubvar += 8;
	}
	if(idx) {
		idx += strcat(include, " included") - 1;

		if(midx) {
			midx += strcat(mode, " loaded");

			PrintHeader(include[2], {'-'}, idx);
			PrintHeader(mode, {'-'}, midx, false);

			print("\r\n");
		} else {
			PrintHeader(include[2], {'-'}, idx);
		}
	} else if(midx) {
		midx += strcat(mode, " loaded");

		PrintHeader(mode, {'-'}, midx);
	}
}
*/
/*
stock aReadString(addr, str[], len = sizeof (str))
{
	new
		buffer,
		idx;
	do
	{
		// Read 4 bytes.
		#emit LREF.S.pri                addr
		#emit STOR.S.pri                buffer
		// Write PACKED strings.
		buffer = (buffer >>> 24) | (buffer >> 8 & 0x0000FF00) | (buffer << 8 & 0x00FF0000) | (buffer << 24);
		str[idx] = buffer;
		if (!(buffer & 0x000000FF && buffer & 0x0000FF00 && buffer & 0x00FF0000 && buffer & 0xFF000000))
		{
			return;
		}
		addr += 4;
	}
	while (++idx < len);
}
*/
stock static PrintHeader(mode[], const delimiter[] = '-', const size = sizeof mode, bool: nl = true) {
	const
		n4 = -4,
		n16 = -16
	;
	// (size + 1) * 4
	#emit load.s.pri size
	#emit add.c 1
	#emit shl.c.pri 2
	#emit stor.s.pri size
	// Position of the CIP
	#emit lctrl 0 //CODE
	#emit move.alt
	#emit lctrl 1 //DAT
	#emit sub.alt
	#emit move.alt
	#emit lctrl 6 //CIP
	#emit add
	// overwritting fill parameter
	#emit add.c 156
	#emit stor.s.pri n4
	#emit load.s.alt size
	#emit sref.s.alt n4
	// overwritting stack parameter
	#emit add.c n16
	#emit stor.s.pri n4
	#emit move.pri
	#emit neg
	#emit sref.s.pri n4
	// overwritting addr parameter
	#emit add.c n4
	#emit move.alt
	#emit load.s.pri n4
	#emit add.c 8
	#emit stor.s.pri n4
	#emit sref.s.alt n4
	// delimiter code
	#emit push.c 0
	#emit lref.s.pri delimiter
	#emit stor.s.alt delimiter
	// variable code
	#emit stack 0
	#emit addr.alt 0
	#emit fill 0
	// fixing delimiter address
	#emit lctrl 5
	#emit load.s.alt delimiter
	#emit add
	#emit stor.s.pri delimiter
	// Calling printf
	static
		sEmpty[] = ""
	;
	printf("%s%s\r\n %s \r\n%s%s", (nl ? nMain_NL : sEmpty), delimiter, mode, delimiter, (nl ? nMain_NL : sEmpty));
	// Resetting stack
	#emit lctrl 5
	#emit sctrl 4
}

stock static PrintDoubleHeader(include[], mode[], const delimiter[] = '-', const size = sizeof include, const msize = sizeof mode) {
	const
		n4 = -4,
		n16 = -16
	;
	// max(size, isize)
	if(size < msize) {
		#emit load.s.pri size
		#emit load.s.alt msize
		#emit stor.s.alt size
		#emit sub
		#emit stor.s.pri msize
	} else {
		#emit load.s.pri size
		#emit load.s.alt msize
		#emit sub
		#emit stor.s.pri msize
	}
	// (size + 1) * 4
	#emit load.s.pri size
	#emit add.c 1
	#emit shl.c.pri 2
	#emit stor.s.pri size
	// Position of the CIP
	#emit lctrl 0 //CODE
	#emit move.alt
	#emit lctrl 1 //DAT
	#emit sub.alt
	#emit move.alt
	#emit lctrl 6 //CIP
	#emit add
	// overwritting fill parameter
	#emit add.c 156
	#emit stor.s.pri n4
	#emit load.s.alt size
	#emit sref.s.alt n4
	// overwritting stack parameter
	#emit add.c n16
	#emit stor.s.pri n4
	#emit move.pri
	#emit neg
	#emit sref.s.pri n4
	// overwritting addr parameter
	#emit add.c n4
	#emit move.alt
	#emit load.s.pri n4
	#emit add.c 8
	#emit stor.s.pri n4
	#emit sref.s.alt n4
	// delimiter code
	#emit push.c 0
	#emit lref.s.pri delimiter
	#emit stor.s.alt delimiter
	// variable code
	#emit stack 0
	#emit addr.alt 0
	#emit fill 0
	// fixing delimiter address
	#emit lctrl 5
	#emit load.s.alt delimiter
	#emit add
	#emit stor.s.pri delimiter
	// Calling printf
	if(msize < 0) {
		printf("\r\n%s\r\n %s \r\n%s\r\n %s \r\n%s\r\n", delimiter[-msize], include, delimiter, mode, delimiter);
	} else {
		printf("\r\n%s\r\n %s \r\n%s\r\n %s \r\n%s\r\n", delimiter, include, delimiter, mode, delimiter[msize]);
	}
	// Resetting stack
	#emit lctrl 5
	#emit sctrl 4
}

#if defined nMain_OnFilterScriptInit
	forward nMain_OnFilterScriptInit();
#endif

public OnFilterScriptInit() {
	nMain();

	#if defined nMain_OnFilterScriptInit
		nMain_OnFilterScriptInit();
	#endif
}
#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit nMain_OnFilterScriptInit

main() {
	nMain();

	#if defined nMain_main
		nMain_main();
	#endif
}
#if defined _ALS_main
	#undef main
#else
	#define _ALS_main
#endif
#define main nMain_main
/*
stock const gModeName[] = "ModeName";

static PrintModeName() {
	new
		eos = EOS,
		delimiter[sizeof gModeName + 11] = { '-', ... }
	;
	#pragma unused eos

	printf("\r\n\%s\r\n %s included \r\n%s\r\n", delimiter, gModeName, delimiter);
}
*/