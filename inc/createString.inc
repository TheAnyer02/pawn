// Nero_3D, improved version from catstr

stock CreateString(...) {
    new
        last,
		first
    ;
    #emit load.s.pri 8
    #emit stor.s.pri last

	#emit addr.pri 20
	#emit stor.s.pri first

	if((last & 0x7) == 0) { // pointer variable
		#emit load.s.pri 16
		#emit load.s.alt 12
		#emit sub // pointer + offset = dest
		#emit sref.s.pri 12

		first += 4;
	} {}
	#emit load.s.pri last
	#emit addr.alt 8
	#emit add
	#emit stor.s.pri last

	while(first <= last) {
		#emit lref.s.pri first
		#emit add.c 0xFFFFFFFC // -4
		#emit move.alt
		#emit load.s.pri first
		#emit add.c 0xFFFFFFFC // -4
		#emit load.i
		#emit load.i
		#emit stor.i

		first += 8;
	}
}
/*
new gPointer[][] = {{}};

new gtmp[] = "XXX";
new Text1[] = "Hello";
new Text2[] = "World";

Init() {
	gtmp[3] = EOS;
	CreateString(Text1, ' ', Text2);
	CreateString(gPointer, "Hi", ' ', "Ho!");

	printf("%s - %s", gPointer[0], Text1);
}
*/