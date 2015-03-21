/*
 *	nFile @ 29.04.2012 by Nero_3D
 *
 */

#define nFile:: nF_

#if !defined MAX_BUFFER_LENGTH
	#define MAX_BUFFER_LENGTH (128)
#endif

forward nF_unused();
public nF_unused() {
	strcat("", "", 0);
	strunpack("", "", 0);
}

// Adjust the size allocated within the file
stock static nF_FixOutput(string[], & length, buffer[], size, offset = 2) {
	new
		count,
		rest = ((size - length + offset) & 0x3)
	;
	if(rest) {
		if(length < (rest = (4 - rest))) {
			return nF_FixOutput(string, length, buffer, size, 0);
		} else {
			for(count = rest; rest != 0; --rest) {
				buffer{count - rest} = string[length - rest];
			}
			string[length - count] = EOS;
		}
	}
	for(length -= size; ++length != 1; ++count) {
		buffer{count} = EOS;
	}
	buffer{count++} = '\r';
	buffer{count++} = '\n';

	for(length = (count / 4), count = 0; count != length; ++count) {
		buffer[count] =
			((buffer[count] >>> (charbits * 3))) |
			((buffer[count] >> charbits) & (((1 << charbits) - 1) << charbits)) |
			((buffer[count] & (((1 << charbits) - 1) << charbits)) << charbits) |
			((buffer[count] << (charbits * 3)))
		;
	}
	return offset;
}

stock static nF_getstringarg(dest[], arg, maxlength = sizeof dest) {
	#emit load.s.pri 0
	#emit add.c 12
	#emit load.s.alt arg
	#emit shl.c.alt 2
	#emit add
	#emit load.i
	#emit stor.s.pri arg

	#emit zero.pri
	#emit sref.s.pri dest

	#emit stack 8
	#emit sysreq.c strcat
	#emit stack 0xFFFFFFF8
}

stock static nF_setstringarg(arg, source[], maxlength = sizeof source) {
	#emit load.s.pri 0
	#emit add.c 12
	#emit load.s.alt arg
	#emit shl.c.alt 2
	#emit add
	#emit load.i
	#emit move.alt
	#emit zero.pri
	#emit stor.i
	#emit stor.s.alt arg

	#emit stack 8
	#emit sysreq.c strcat
	#emit stack 0xFFFFFFF8 // -8
}
// get the correct offset
#define nF_cells(%0) (_:nF_fs_loop:nF_fs_stop:nF_fseek_loop<%0>)
// nF_fseek_loop to get the correct offset for our file
#define nF_fs_loop:nF_fs_stop:nF_fseek_loop<%0,%1> nF_fs_loop:nF_fs_stop:nF_fseek_loop<%1> + nF_fs_stop:nF_fseek_loop<%0>
#define nF_fs_stop:nF_fseek_loop<%0> ((%0) + 2)
// there are only macros for the natives which actually could be used with nFile
#define nF_fopen( fopen(
#define nF_fclose(%0) (fclose(%0),(%0)=File:0)
#define nF_fremove( fremove(
#define nF_fseek(%0,%1,%3,%2) fseek((%0),0%3nF_cells(%2),(%1))
#define nF_flength( flength(
#define nF_fexist( fexist(
#define nF_flines(%0,%1) (flength(%0) / nF_cells(%1))
// debug macros, they get undefined at the end
#define nF_warning(%0) printf("nF_warning: " %0)
#define nF_error(%0) return (printf("nF_error: " %0), false)

stock nF_fwrite(File: handle, const form[], {Float, _}: ...) {
	if(!handle) {
		return false;
	}
	new
		i,
		ret,
		size,
		arg = 2,
		c = form[0],
		num = numargs(),
		buffer[MAX_BUFFER_LENGTH char],
		string[(MAX_BUFFER_LENGTH + 1)]
	;
	for( ; c != EOS; c = form[++i]) {
		if(form[++i] == '[') {
			if(form[++i] == '*') {
				if(num <= arg) {
					nF_error("nF_fwrite(%d, \"%s\", ...) Not enough arguments passed! (Char '%c')", _: handle, form, c);
				}
				size = getarg(arg);
				arg += 1;
				i += 1;
			} else {
				for(size = 0; ('0' <= form[i] <= '9'); ++i) {
					size = ((size * 10) + form[i] - '0');
				}
			}
			if(form[i] == ']') {
				if(size < 1) {
					nF_error("nF_fwrite(%d, \"%s\", ...) Size below or zero! (Char '%c')", _: handle, form, c);
				}
				if(MAX_BUFFER_LENGTH < size) {
					nF_warning("nF_fwrite(%d, \"%s\", ...) Buffer limited exceeded (%d / %d)! (Char '%c')", _: handle, form, size, MAX_BUFFER_LENGTH char, c);

					size = MAX_BUFFER_LENGTH;
				}
				ret += size;

				if(c == 'e') {
					string[0] = EOS;
				} else {
					if(num <= arg) {
						nF_error("nF_fwrite(%d, \"%s\", ...) Not enough arguments passed! (Char '%c')", _: handle, form, c);
					}
					switch(c) {
						case 'd', 'i': {
							valstr(string, getarg(arg));
						}
						case 'f': {
							format(string, sizeof string, "%.*f", sizeof string, getarg(arg));
						}
						case 's': {
							nF_getstringarg(string, arg);
						}
						case 'p': {
							nF_getstringarg(string, arg);
							size *= (cellbits / charbits);
							strunpack(string, string, sizeof string);
						}
						default: {
							nF_warning("nF_fwrite(%d, \"%s\", ...) Invalid character '%c'!", _: handle, form, c);

							continue;
						}
					}
					arg += 1;
				}
				if((c = strlen(string)) < size) {
					if(nF_FixOutput(string, c, buffer, size) == 2) {
						fwrite(handle, string);
						fblockwrite(handle, buffer, c);
					} else {
						fwrite(handle, string);
						fblockwrite(handle, buffer, c);
						fwrite(handle, "\r\n");
					}
				} else {
					string[size] = EOS;

					fwrite(handle, string);
					fwrite(handle, "\r\n");
				}
				continue;
			}
		}
		nF_error("nF_fwrite(%d, \"%s\", ...) Invalid form declaration!", _: handle, form);
	}
	return ret;
}

stock nF_fread(File: handle, const form[], {Float, _}: ...) {
	if(!handle) {
		return false;
	}
	new
		i,
		ret,
		cells,
		arg = 2,
		c = form[0],
		num = numargs(),
		buffer[(MAX_BUFFER_LENGTH + 3) char]
	;
	for( ; c != EOS; c = form[++i]) {
		ret += (cells = (fread(handle, buffer, sizeof buffer, true) - 2));

		if(cells == -2) {
			return false;
		}
		if(c == 'e') {
			continue;
		}
		if(num <= arg) {
			nF_error("nF_fread(%d, \"%s\", ...) Not enough arguments passed! (Char '%c')", _: handle, form, c);
		}
		buffer{cells} = EOS;

		switch(c) {
			case 'd', 'i': {
				setarg(arg, 0, strval(buffer));
			}
			case 'f': {
				setarg(arg, 0, _: floatstr(buffer));
			}
			case 's': {
				nF_setstringarg(arg, buffer);
				// calling strunpack
				#emit LCTRL			5
				#emit LOAD.S.alt	arg
				#emit SHL.C.alt		2
				#emit ADD
				#emit ADD.C			12
				#emit LOAD.I
				#emit PUSH.S		cells
				#emit PUSH.pri
				#emit PUSH.pri
				#emit PUSH.C		12
				#emit SYSREQ.C		strunpack
				#emit STACK			16
			}
			case 'p': {
				nF_setstringarg(arg, buffer);
			}
			default: {
				nF_warning("nF_fread(%d, \"%s\", ...) Invalid character '%c'!", _: handle, form, c);

				continue;
			}
		}
		arg += 1;
	}
	return ret;
}

#undef nF_warning
#undef nF_error