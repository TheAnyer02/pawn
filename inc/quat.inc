// Nero_3D
// http://wiki.sa-mp.com/wiki/GetVehicleRotationQuat
// http://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation

stock DotProduct(Float: x1, Float: y1, Float: z1, Float: x2, Float: y2, Float: z2, & Float: x, & Float: y, & Float: z) {
	x = y1 * z2 - z1 * y2;
	y = z1 * x2 - x1 * z2;
	z = x1 * y2 - y1 * x2;
}

stock QuatRotateVector(Float: w, Float: i, Float: j, Float: k, Float: X, Float: Y, Float: Z, & Float: x, & Float: y, & Float: z) {
	DotProduct(i, j, k, X, Y, Z, x, y, z);
	DotProduct(
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