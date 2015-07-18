// Nero_3D
// http://wiki.sa-mp.com/wiki/GetVehicleRotationQuat
// http://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation

stock CrossProduct(Float: x1, Float: y1, Float: z1, Float: x2, Float: y2, Float: z2, & Float: x, & Float: y, & Float: z) {
	x = y1 * z2 - z1 * y2;
	y = z1 * x2 - x1 * z2;
	z = x1 * y2 - y1 * x2;
}

stock QuatRotateVector(Float: w, Float: i, Float: j, Float: k, Float: X, Float: Y, Float: Z, & Float: x, & Float: y, & Float: z) {
	CrossProduct(i, j, k, X, Y, Z, x, y, z);
	CrossProduct(
		i + i,
		j + j,
		k + k,
		x + w * X,
		y + w * Y,
		z + w * Z,
		x, y, z
	);
	x += X;
	y += Y;
	z += Z;
}

stock GetVehicleRelativePos(vehicleid, & Float: x, & Float: y, & Float: z, Float: oX = 0.0, Float: oY = 0.0, Float: oZ = 0.0) {
	if(GetVehiclePos(vehicleid, x, y, z) && ((_: oX != 0) || (_: oY != 0) || (_: oZ != 0))) {
		new
			Float: qW,
			Float: qX,
			Float: qY,
			Float: qZ
		;
		GetVehicleRotationQuat(vehicleid, qW, qX, qY, qZ);
		QuatRotateVector(qW, -qX, -qY, -qZ, oX, oY, oZ, qX, qY, qZ);

		x += qX;
		y += qY;
		z += qZ;
		return true;
	}
	return false;
}

stock QuatForwardVector(Float: w, Float: i, Float: j, Float: k, & Float: x, & Float: y, & Float: z) {
	x = 2.0 * (j * i - k * w);
	y = 1.0 - 2.0 * (k * k + i * i);
	z = 2.0 * (i * w + j * k);
}

stock GetVehicleForwardVector(vehicleid, & Float: x, & Float: y, & Float: z) {
	if(GetVehicleRotationQuat(vehicleid, Float: vehicleid, x, y, z)) {
		QuatForwardVector(Float: vehicleid, -x, -y, -z, x, y, z);
		return true;
	}
	return false;
}

stock QuatRightVector(Float: w, Float: i, Float: j, Float: k, & Float: x, & Float: y, & Float: z) {
	x = 1.0 - 2.0 * (j * j + k * k);
	y = 2.0 * (k * w + i * j);
	z = 2.0 * (i * k - j * w);
}

stock GetVehicleRightVector(vehicleid, & Float: x, & Float: y, & Float: z) {
	if(GetVehicleRotationQuat(vehicleid, Float: vehicleid, x, y, z)) {
		QuatRightVector(Float: vehicleid, -x, -y, -z, x, y, z);
		return true;
	}
	return false;
}

stock QuatUpVector(Float: w, Float: i, Float: j, Float: k, & Float: x, & Float: y, & Float: z) {
	x = 2.0 * (j * w + k * i);
	y = 2.0 * (k * j - i * w);
	z = 1.0 - 2.0 * (i * i + j * j);
}

stock GetVehicleUpVector(vehicleid, & Float: x, & Float: y, & Float: z) {
	if(GetVehicleRotationQuat(vehicleid, Float: vehicleid, x, y, z)) {
		QuatUpVector(Float: vehicleid, -x, -y, -z, x, y, z);
		return true;
	}
	return false;
}