// Nero_3D, 14.3.2016, licence free

#include <a_samp>

enum BigInt {}

/*
	native BigIntegerPrint(BigInt: int[], size = sizeof int);
	native BigIntegerGetString(BigInt: int[], tmp[], size = sizeof int, length = sizeof tmp);
	native BigIntegerSetBig(BigInt: int[], BigInt: value[], isize = sizeof int, vsize = sizeof value);
	native BigIntegerSet(BigInt: int[], value, size = sizeof int);
	native BigIntegerSetString(BigInt: int[], value[], isize = sizeof int, vsize = sizeof value);
	native BigIntegerAddBig(BigInt: int[], BigInt: value[], isize = sizeof int, vsize = sizeof value);
	native BigIntegerAdd(BigInt: int[], value, size = sizeof int);
	native BigIntegerShiftLeft(BigInt: int[], shl, size = sizeof int);
	native BigIntegerShiftRightL(BigInt: int[], shr, size = sizeof int);
	native BigIntegerShiftRight(BigInt: int[], shr, size = sizeof int);
	native BigIntegerNeg(BigInt: int[], size = sizeof int);
	native BigIntegerMulBig(BigInt: int[], BigInt: value[], isize = sizeof int, vsize = sizeof value);
	native BigIntegerMul(BigInt: int[], value, size = sizeof int);
	native BigIntegerDivBig(BigInt: int[], BigInt: value[], isize = sizeof int, vsize = sizeof value);
	native BigIntegerDiv(BigInt: int[], value, size = sizeof int);
	native ();
	native BigIntegerMulS(BigInt: int[], value, size = sizeof int);
	native BigIntegerDivS(BigInt: int[], value, size = sizeof int);
	native ();
	native _BigIntegerNormBCD(& bcd);
	native _BigIntegerAdd(& BigInt: int, value);
*/

stock BigIntegerPrint(BigInt: int[], size = sizeof int) {
	printf("BigInteger: [");

	while(size-- > 0) {
		printf("\t%032b - %d", _: int[size], _: int[size]);
	}
	printf("]");
}

static stock _BigIntegerNormBCD(& bcd) {
	const
		cMax = 1000000000
	;
	if(cMax <= bcd) {
		#emit lref.s.pri bcd
		#emit const.alt cMax
		#emit sdiv
		#emit sref.s.alt bcd
		#emit retn
	}
	return false;
}

stock BigIntegerGetString(BigInt: int[], tmp[], size = sizeof int, length = sizeof tmp) {
	const
		cStart = 1 << 29,
		cMax = 1000000000,
		cMask = cStart - 1,
		cNeg = 1 << (cellbits - 1)
	;
	new
		i,
		j,
		k,
		idx,
		pow,
		negative,
		bcd = --length
	;
	if((negative = (_: int[--size] & cNeg))) {
		int[size] &= BigInt: (cNeg - 1);
	}
	tmp[bcd] = _: int[0] & cMask;
	tmp[pow] = cStart >>> 1;

	for(j = cStart; i <= size; ++i, j = 1) {
		for(idx = _: int[i]; j; j <<= 1) {
			tmp[(k = pow)] *= 2;

			if((tmp[k + 1] = _BigIntegerNormBCD(tmp[k]))) {
				if((length - ++pow) < bcd) {
					tmp[length - pow] = 0;
				}
			}
			while(--k >= 0) {
				tmp[k] *= 2;
				tmp[k + 1] += _BigIntegerNormBCD(tmp[k]);
			}
			if(idx & j) {
				for(k = 0; k < pow; ++k) {
					tmp[length - k] += tmp[k];
					tmp[length - k - 1] += _BigIntegerNormBCD(tmp[length - k]);
				}
				tmp[(bcd = length - pow)] += tmp[pow];

				if((tmp[bcd - 1] = _BigIntegerNormBCD(tmp[bcd]))) {
					bcd--;
				}
			}
		}
	}
	if(negative) {
		for(k = 0; k <= pow; ++k) {
			i = tmp[k] - tmp[length - k];

			if(i & cNeg) {
				i += cMax + cMax;
			}
			tmp[length - k - 1] += _BigIntegerNormBCD(i);
			tmp[length - k] = i;
		}
		int[size] |= BigInt: cNeg;
		bcd = length - pow;

		while(tmp[bcd] == 0) {
			bcd++;
		}
		tmp[0] = '-';
		tmp[1] = EOS;
	} else {
		tmp[0] = EOS;
	}
	format(tmp, bcd, "%s%d", tmp, tmp[bcd]);

	while(++bcd <= length) {
		format(tmp, bcd, "%s%09d", tmp, tmp[bcd]);
	}
}

stock BigIntegerSetBig(BigInt: int[], BigInt: value[], isize = sizeof int, vsize = sizeof value) {
	const
		cNeg = 1 << (cellbits - 1)
	;
	new
		i,
		size = min(isize, vsize)
	;
	while(i < size) {
		int[i] = value[i], i++;
	}
	if(_: value[vsize - 1] & cNeg) {
		while(i < isize) {
			int[i] = BigInt: -1, i++;
		}
	} else {
		while(i < isize) {
			int[i] = BigInt: 0, i++;
		}
	}
}

stock BigIntegerSet(BigInt: int[], value, size = sizeof int) {
	new
		BigInt: tmp[1]
	;
	tmp[0] = BigInt: value;
	BigIntegerSetBig(int, tmp, size);
}

stock BigIntegerSetString(BigInt: int[], value[], isize = sizeof int, vsize = sizeof value) {
	new
		count
	;
	BigIntegerSet(int, 0, isize);

	for(vsize--; vsize >= 9; count++) {
		vsize -= 9;

		value[vsize + 1] = strval(value[vsize]);
		value[vsize] = EOS;
	}
	if(vsize) {
		BigIntegerAdd(int, strval(value), isize);

		if(count) {
			BigIntegerMul(int, 1_000_000_000, isize);
		}
	}
	for(vsize++; --count > 0; vsize += 9) {
		BigIntegerAdd(int, value[vsize], isize);
		BigIntegerMul(int, 1_000_000_000, isize);
	}
	BigIntegerAdd(int, value[vsize], isize);
}

static stock _BigIntegerAdd(& BigInt: int, value) {
	const
		cShift = cellbits / 2,
		cMask = (1 << cShift) - 1
	;
	new // looking for a better way to get the carry bit
		ret = ((value >>> cShift) + (_: int >>> cShift) + (((value & cMask) + (_: int & cMask)) >>> cShift)) >>> (cellbits - cShift)
	;
	int += BigInt: value;
	return ret;
}

stock BigIntegerAddBig(BigInt: int[], BigInt: value[], isize = sizeof int, vsize = sizeof value) {
	const
		cNeg = 1 << (cellbits - 1)
	;
	new
		i,
		tmp,
		size = min(isize, vsize)
	;
	while(i < size) {
		tmp = _BigIntegerAdd(int[i], tmp) + _BigIntegerAdd(int[i], _: value[i]), i++;
	}
	if(_: value[vsize - 1] & cNeg) {
		while(i < isize) {
			tmp = _BigIntegerAdd(int[i], tmp) + _BigIntegerAdd(int[i], -1), i++;
		}
	} else {
		while(i < isize) {
			tmp = _BigIntegerAdd(int[i], tmp), i++;
		}
	}
}

stock BigIntegerAdd(BigInt: int[], value, size = sizeof int) {
	if(value) {
		new
			BigInt: tmp[1]
		;
		tmp[0] = BigInt: value;
		BigIntegerAddBig(int, tmp, size);
	}
}

stock BigIntegerShiftLeft(BigInt: int[], shl, size = sizeof int) {
	if(shl > 0) {
		if(shl >= cellbits) {
			BigIntegerShiftLeft(int, cellbits - 1, size);
			BigIntegerShiftLeft(int, shl - cellbits + 1, size);
		} else {
			new
				shr = cellbits - shl
			;
			while(--size > 0) {
				int[size] = (int[size] << BigInt: shl) | (int[size - 1] >>> BigInt: shr);
			}
			int[0] <<= BigInt: shl;
		}
	}
}

stock BigIntegerShiftRightL(BigInt: int[], shr, size = sizeof int) {
	if(shr > 0) {
		if(shr >= cellbits) {
			BigIntegerShiftLeft(int, cellbits - 1, size);
			BigIntegerShiftLeft(int, shr - cellbits + 1, size);
		} else {
			new
				i,
				shl = cellbits - shr
			;
			size--;

			while(i < size) {
				int[i] = (int[i] >>> BigInt: shr) | (int[i + 1] << BigInt: shl), i++;
			}
			int[size] >>>= BigInt: shr;
		}
	}
}

stock BigIntegerShiftRight(BigInt: int[], shr, size = sizeof int) {
	if(shr > 0) {
		if(shr >= cellbits) {
			BigIntegerShiftLeft(int, cellbits - 1, size);
			BigIntegerShiftLeft(int, shr - cellbits + 1, size);
		} else {
			new
				i,
				shl = cellbits - shr
			;
			size--;

			while(i < size) {
				int[i] = (int[i] >>> BigInt: shr) | (int[i + 1] << BigInt: shl), i++;
			}
			int[size] >>= BigInt: shr; // the only difference is one less > here :S
		}
	}
}

stock BigIntegerNeg(BigInt: int[], size = sizeof int) {
	for(new i; i < size; ++i) {
		if(_: int[i]) {
			int[i] *= BigInt: -1;

			while(++i < size) {
				int[i] = ~int[i]; 
			}
			return ;
		}
	}
}

stock BigIntegerMulBig(BigInt: int[], BigInt: value[], isize = sizeof int, vsize = sizeof value) {
	const // Multiplies 16 bit values and add them up - emit to speed up the code
		cNeg = 1 << (cellbits - 1)
	; // Negative values suck therefor I transform the minus to int directly
	if(_: value[vsize - 1] & cNeg) { // The problem is if value is negative and vsize < isize
		BigIntegerNeg(int, isize); // I would need to simulate not existing cells as -1 / 0xFFFF / 0b1111_1111
		BigIntegerNeg(value, vsize); // With that I probably avoided two additional loops, the code is long enough :p
	}
	new
		aint, // address of int[]
		avalue // address of value[]
	;
	#emit load.s.alt int
	#emit stor.s.alt aint
	#emit load.s.pri isize
	#emit shl.c.pri 2
	#emit add
	#emit stor.s.pri isize
	// isize = aint + 4 * isize
	#emit load.s.alt value
	#emit stor.s.alt avalue
	#emit load.s.pri vsize
	#emit shl.c.pri 2
	#emit add
	#emit stor.s.pri vsize
	// vsize = avalue + 4 * vsize
	new
		size = isize - 2,
		v = avalue,
		i = size,
		val,
		idx
	;
	#emit load.s.pri i
	#emit move.alt
	#emit lodb.i 2 // preload first cell
	#emit stor.s.pri idx
	#emit zero.pri // so we can set it to zero
	#emit strb.i 2
	// loop from last element to first (int) and vice versa for value
	while(i >= aint && v < vsize) {
		#emit load.s.pri v
		#emit load.s.alt idx
		#emit lodb.i 2 // loads 2 bytes = 16 bit, pri = [pri]
		#emit smul // signed multiply, could also be unsigned doesn't matter
		#emit move.alt
		#emit load.s.pri size
		#emit lodb.i 2 // load value of destination cell
		#emit add // add
		#emit load.s.alt size
		#emit strb.i 2 // save value to dest

		#emit load.s.pri i
		#emit add.c 0xFFFFFFFE // -2
		#emit stor.s.pri i
		#emit lodb.i 2 // load next cell
		#emit stor.s.pri idx

		v += 2;
	} // loop till we reach the first index
	while((size -= 2) >= aint) {
		v = avalue;
		// same code as above, just with carry handling from the addition
		#emit load.s.pri size
		#emit stor.s.pri int
		#emit stor.s.pri i
		#emit move.alt
		#emit lodb.i 2
		#emit stor.s.pri idx // idx = int[current_cell] (current_cell is actually the size variable)
		#emit zero.pri // int[current_cell] = 0 clear it for the sum of multiplication
		#emit strb.i 2
		// int[current_cell] = int[current_cell] * value[0] + int[current_cell - 1] * value[1] + int[current_cell - 2] * value[2] + ... + int[1] * value[current_cell - 1] + int[0] * value[current_cell]
		while(i >= aint && v < vsize) {
			#emit load.s.pri v
			#emit load.s.alt idx
			#emit lodb.i 2
			#emit smul
			#emit stor.s.pri val
			// dest + mul
			if((val = _BigIntegerAdd(int[0], val))) { // carry handling
				idx = isize - size - 4; // int_size - current_cell - 4 (because we already did one addition)

				#emit load.s.pri int
				#emit add.c 4  // switch variable + 4
				#emit stor.s.pri value
				// additional carry handling - probably only for negative numbers - which I removed at the beginning
				while(idx >= 4 && (val = _BigIntegerAdd(value[0], val))) {
					#emit load.s.pri value
					#emit add.c 4
					#emit stor.s.pri value

					idx -= 4;
				} // if the size didn't match a full cell do it manually
				if(idx == 2) { // last 16 bit reached, carry bit will be
					#emit load.s.pri value
					#emit add.c 2
					#emit push.pri
					#emit lodb.i 2
					#emit load.s.alt val
					#emit add
					#emit pop.alt
					#emit strb.i 2
				}
			}
			v += 2;

			#emit load.s.pri i
			#emit add.c 0xFFFFFFFE // -2
			#emit stor.s.pri i
			#emit lodb.i 2
			#emit stor.s.pri idx
		}
	}
}

stock BigIntegerMul(BigInt: int[], value, size = sizeof int) {
	new
		BigInt: tmp[1]
	;
	tmp[0] = BigInt: value;
	BigIntegerMulBig(int, tmp, size);
}

stock BigIntegerMulS(BigInt: int[], value, size = sizeof int) {
	const // Multiplies by left shifting - slow for non 2^n numbers
		cNeg = 1 << (cellbits - 1)
	;
	if(value & cNeg) {
		BigIntegerNeg(int, size);
		value *= -1;
	}
	new
		i,
		j,
		idx,
		var1,
		var2,
		int1,
		int2,
		count,
		shl[cellbits - 1],
		shr[cellbits - 1]
	;
	for(i = 0, j = 1; i < (cellbits - 1); ++i, j <<= 1) {
		if(value & j) {
			shr[count] = cellbits - i;
			shl[count] = i;
			count++;
		}
	}
	for(j = 0; j < size; ++j) {
		i = var1 = var2 = 0;
		idx = _: int[j];

		for( ; i < count; ++i) {
			if(shr[i] != cellbits) {
				var2 += _BigIntegerAdd(BigInt: int2, idx >>> shr[i]);
			}
			var1 += _BigIntegerAdd(BigInt: int1, idx << shl[i]);
		}
		var2 += _BigIntegerAdd(BigInt: int2, var1);

		int[j] = BigInt: int1;
		int1 = int2;
		int2 = var2;
	}
}

stock BigIntegerDivBig(BigInt: int[], BigInt: value[], isize = sizeof int, vsize = sizeof value) {
	const
		cMask = cellbits - 1,
		cNeg = 1 << cMask
	;
	new
		negative = isize,
		j = vsize,
		ilen,
		vlen,
		idx
	;
	if(_: value[vsize - 1] & cNeg) {
		BigIntegerNeg(value, vsize);
		negative |= cNeg;
	}
	while(--j >= 0) {
		vlen = 0;
		idx = _: value[j];

		if(idx & 0xFFFF0000) {
			idx >>>= 16;
			vlen += 16;
		}
		if(idx & 0xFF00) {
			idx >>>= 8;
			vlen += 8;
		}
		if(idx & 0xF0) {
			idx >>>= 4;
			vlen += 4;
		}
		if(idx & 0xC) {
			idx >>>= 2;
			vlen += 2;
		}
		if(idx & 0x2) {
			idx >>>= 1;
			vlen += 1;
		}
		if(vlen || idx) {
			if(_: int[isize - 1] & cNeg) {
				if(negative & cNeg) {
					negative &= cNeg - 1;
				} else {
					negative |= cNeg;
				}
				BigIntegerNeg(int, isize);
			}
			vlen += 1 + j * cellbits;
			j = isize;

			while(--j >= 0) {
				ilen = 0;
				idx = _: int[j];

				if(idx & 0xFFFF0000) {
					idx >>>= 16;
					ilen += 16;
				}
				if(idx & 0xFF00) {
					idx >>>= 8;
					ilen += 8;
				}
				if(idx & 0xF0) {
					idx >>>= 4;
					ilen += 4;
				}
				if(idx & 0xC) {
					idx >>>= 2;
					ilen += 2;
				}
				if(idx & 0x2) {
					idx >>>= 1;
					ilen += 1;
				}
				if(ilen || idx) { // found first bit in int
					ilen += 1 + j * cellbits;
					isize = (ilen + 1) / cellbits;
					vsize = (vlen + 1) / cellbits;

					BigIntegerShiftLeft(int, cMask - ((ilen + 1) & cMask), isize);
					BigIntegerShiftLeft(value, cMask - ((vlen + 1) & cMask), vsize);

					vlen = ilen -= vlen;
					idx = min(isize, vsize);

					for(j = 1; j <= idx; ++j) {
						if(int[isize - j] < value[vsize - j]) {
							BigIntegerShiftLeft(int, 1, isize);
							ilen--;
							break;
						}
						if(int[isize - j] > value[vsize - j]) {
							break;
						}
					}
					for(j = 1; j <= idx; ++j) {
						int[isize - j] -= value[vsize - j];
					}
					#emit push.c 1 // temp save into the stack, int is still used

					while(--ilen >= 0) {
						for(BigIntegerShiftLeft(int, (j = 1), isize); ; ++j) {
							if(j < idx) {
								if(int[isize - j] < value[vsize - j]) {
									#emit push.c 0
									break;
								}
								if(int[isize - j] > value[vsize - j]) { // greater
									for(j = 1; j <= idx; ++j) {
										int[isize - j] -= value[vsize - j];
									}
									#emit push.c 1
									break;
								}
							} else { // j == idx
								if(int[isize - j] < value[vsize - j]) {
									#emit push.c 0
								} else { // greater equal
									for(j = 1; j <= idx; ++j) {
										int[isize - j] -= value[vsize - j];
									}
									#emit push.c 1
								}
								break;
							}
						}
					}
					for(ilen = idx = j = 0; vlen >= 0; ++j, --vlen) {
						if(j == cellbits) {
							int[idx++] = BigInt: ilen;
							j -= cellbits;
							ilen = 0;
						} {} // loading stack
						#emit load.s.alt ilen
						#emit shl.c.alt 1
						#emit pop.pri
						#emit add
						#emit stor.s.pri ilen
					}
					int[idx] = BigInt: ilen;

					for(isize = negative & (cNeg - 1); ++idx < isize; ) {
						int[idx] = BigInt: 0;
					}
					if(negative & cNeg) {
						BigIntegerNeg(int, isize);
					}
					return ;
				}
			}
			return ;
		}
	}
}

stock BigIntegerDiv(BigInt: int[], value, size = sizeof int) {
	new
		BigInt: tmp[1]
	;
	tmp[0] = BigInt: value;
	BigIntegerDivBig(int, tmp, size);
}

stock BigIntegerDivS(BigInt: int[], value, size = sizeof int) {
	if(value & (1 << (cellbits - 1))) {
		BigIntegerNeg(int, size);
		value *= -1;
	}
	new
		i,
		j,
		idx,
		var1,
		var2,
		int1,
		int2,
		count,
		shl[cellbits - 1],
		shr[cellbits - 1]
	;
	for(i = 1, j = 2; i <= cellbits; ++i, j <<= 1) {
		if(value <= j) {
			shl[count] = cellbits - i;
			shr[count] = i;
			j -= value;
			count++;
		}
	}
	for(idx = _: int[(i = 0)]; i < count; ++i) {
		if(shr[i] != cellbits) {
			var2 += _BigIntegerAdd(BigInt: int2, idx >>> shr[i]);
		}
		var1 += _BigIntegerAdd(BigInt: int1, idx << shl[i]);
	}
	var2 += _BigIntegerAdd(BigInt: int2, var1);

	for(j = 1; j < size; ++j) {
		int1 = int2;
		int2 = var2;
		idx = _: int[j];
		i = var1 = var2 = 0;

		for( ; i < count; ++i) {
			if(shr[i] != cellbits) {
				var2 += _BigIntegerAdd(BigInt: int2, idx >>> shr[i]);
			}
			var1 += _BigIntegerAdd(BigInt: int1, idx << shl[i]);
		}
		var2 += _BigIntegerAdd(BigInt: int2, var1);

		int[j - 1] = BigInt: int1;
	}
	int[j - 1] = BigInt: int2;
}

// -------------------

stock BigInt: BigIntegerGetAddress(BigInt: ...) {
	#emit load.s.pri 12
	#emit retn

	return BigInt: 0;
}

#define BigIntegerInit(%0,%1) new BigInt: _%0_data[%1], BigInt: _%0_size = BigInt: %1, BigInt: %0 = BigIntegerGetAddress(%0, _%0_size, _%0_data)

native Float:operator*(Float:oper1, Float:oper2) = floatmul;
native Float:operator/(Float:oper1, Float:oper2) = floatdiv;
native Float:operator+(Float:oper1, Float:oper2) = floatadd;
native Float:operator-(Float:oper1, Float:oper2) = floatsub;

stock BigInt: operator=(oper) {
	printf("=%d", oper);
}

stock Float:operator++(Float:oper)
    return oper+1.0;
	
public OnFilterScriptInit() {
	new
		BigInt: x[5],
		BigInt: y[5],
		BigInt: int[3],
		tmp[128],
		value
	;
	BigIntegerInit(z, 5);

	BigIntegerSetString(x, "7612058254738945");
	BigIntegerSetString(y, "9263591128439081");
	BigIntegerMulBig(x, y);
	BigIntegerGetString(x, tmp);
	BigIntegerPrint(x);
	print(tmp);

	BigIntegerAdd(int, value);
	BigIntegerShiftLeft(int, value);
	BigIntegerShiftRightL(int, value);
	BigIntegerShiftRight(int, value);
	BigIntegerNeg(int);
	BigIntegerMul(int, value);
	BigIntegerDiv(int, value);

	BigIntegerMulS(int, value);
	BigIntegerDivS(int, value);
}
