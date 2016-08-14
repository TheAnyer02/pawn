/*
 * Rotations.inc by Nero_3D (C) 2016
 * 
 * Contact:
 *     E-Mail: shiska@gmx.de
 *     SA-MP forum: http://forum.sa-mp.com/member.php?u=9765
 *
 * Licence: MPL 2.0
 *     This Source Code Form is subject to the terms of the Mozilla Public
 *     License, v. 2.0. If a copy of the MPL was not distributed with this
 *     file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Version:
 *   1.0 (14.08.2016)
 *     - Release
 */
 
#if !defined _inc_a_samp
	#error Cant be compiled without a_samp
#endif

// Reference
// https://en.wikipedia.org/wiki/Euler_Angles#Rotation_matrix
// https://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation
// https://en.wikipedia.org/wiki/Axis%E2%80%93angle_representation
// http://www.euclideanspace.com/maths/geometry/rotations/index.htm
// https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles

enum eulermode {
	// Proper / Classic Euler angles
	euler_xzx,
	euler_xyx,
	euler_yxy,
	euler_yzy,
	euler_zyz,
	euler_zxz,
	// Tait-Bryan angles
	euler_xzy,
	euler_xyz,
	euler_yxz,
	euler_yzx,
	euler_zyx, // pitch roll yaw
	euler_zxy // sa-mp
}

const eulermode: euler_default = euler_zxy;

/*
native 
native GetRotationMatrixFromQuat(Float: matrix[][], Float: w, Float: x, Float: y, Float: z)
native GetRotationMatrixFromEuler(Float: matrix[][], Float: rX, Float: rY, Float: rZ, eulermode: mode = euler_default)
native GetRotationMatrixFromAxisAngle(Float: matrix[][], Float: angle, Float: aX, Float: aY, Float: aZ)
native GetQuatFromMatrix(Float: matrix[][], & Float: w, & Float: x, & Float: y, & Float: z)
native GetQuatFromEuler(Float: rX, Float: rY, Float: rZ, & Float: w, & Float: x, & Float: y, & Float: z, eulermode: mode = euler_default)
native GetQuatFromAxisAngle(Float: angle, Float: aX, Float: aY, Float: aZ, & Float: w, & Float: x, & Float: y, & Float: z)
native GetEulerFromMatrix(Float: matrix[][], & Float: rX, & Float: rY, & Float: rZ, eulermode: mode = euler_default)
native GetEulerFromQuat(Float: w, Float: x, Float: y, Float: z, & Float: rX, & Float: rY, & Float: rZ, eulermode: mode = euler_default)
native GetEulerFromEuler(Float: oX, Float: oY, Float: oZ, eulermode: omode, & Float: rX, & Float: rY, & Float: rZ, eulermode: mode = euler_default)
native GetEulerFromAxisAngle(Float: angle, Float: aX, Float: aY, Float: aZ, & Float: rX, & Float: rY, & Float: rZ, eulermode: mode = euler_default)
native GetAxisAngleFromMatrix(Float: matrix[3][3], & Float: angle, & Float: aX, & Float: aY, & Float: aZ)
native GetAxisAngleFromQuat(Float: w, Float: x, Float: y, Float: z, & Float: angle, & Float: aX, & Float: aY, & Float: aZ)
native GetAxisAngleFromEuler(Float: rX, Float: rY, Float: rZ, & Float: angle, & Float: aX, & Float: aY, & Float: aZ, eulermode: mode = euler_default)
native MatrixRotate(Float: matrix[][], Float: oX, Float: oY, Float: oZ, & Float: X, & Float: Y, & Float: Z)
native QuatRotate(Float: w, Float: x, Float: y, Float: z, Float: oX, Float: oY, Float: oZ, & Float: X, & Float: Y, & Float: Z)
native EulerRotate(Float: rX, Float: rY, Float: rZ, Float: oX, Float: oY, Float: oZ, & Float: X, & Float: Y, & Float: Z, eulermode: mode = euler_default)
native AxisAngleRotate(Float: angle, Float: aX, Float: aY, Float: aZ, Float: oX, Float: oY, Float: oZ, & Float: X, & Float: Y, & Float: Z)
native
*/

stock GetRotationMatrixFromQuat(Float: matrix[][], Float: w, Float: x, Float: y, Float: z) {
	new
		Float: x2 = x * x,
	 	Float: y2 = y * y,
	 	Float: z2 = z * z,
		Float: w2 = w * w,
	 	Float: xy = 2.0 * x * y,
	 	Float: xz = 2.0 * x * z,
		Float: yz = 2.0 * y * z,
		Float: wx = 2.0 * w * x,
		Float: wy = 2.0 * w * y,
		Float: wz = 2.0 * w * z;

	matrix[0][0] = w2 + x2 - y2 - z2;
	matrix[0][1] = xy + wz;
	matrix[0][2] = xz - wy;
	matrix[1][0] = xy - wz;
	matrix[1][1] = w2 - x2 + y2 - z2;
	matrix[1][2] = yz + wx;
	matrix[2][0] = xz + wy;
	matrix[2][1] = yz - wx;
 	matrix[2][2] = w2 - x2 - y2 + z2;
}

stock GetRotationMatrixFromEuler(Float: matrix[][], Float: rX, Float: rY, Float: rZ, eulermode: mode = euler_default) {
	new // could be done with matrix multiplication but would be slower
		Float: cosX = floatcos(rX, degrees),
		Float: cosY = floatcos(rY, degrees),
		Float: cosZ = floatcos(rZ, degrees),
		Float: sinX = floatsin(rX, degrees),
		Float: sinY = floatsin(rY, degrees),
		Float: sinZ = floatsin(rZ, degrees);

	switch(mode) { // Proper Euler angles - 1(rX), 2(rY), 3(rZ)
		case euler_xzx: {
			matrix[0][0] = cosY;
			matrix[0][1] = -cosZ * sinY;
			matrix[0][2] = sinY * sinZ;
			matrix[1][0] = cosX * sinY;
			matrix[1][1] = cosX * cosY * cosZ - sinX * sinZ;
			matrix[1][2] = -cosZ * sinX - cosX * cosY * sinZ;
			matrix[2][0] = sinX * sinY;
			matrix[2][1] = cosX * sinZ + cosY * cosZ * sinX;
			matrix[2][2] = cosX * cosZ - cosY * sinX * sinZ;
		}
		case euler_xyx: {
			matrix[0][0] = cosY;
			matrix[0][1] = sinY * sinZ;
			matrix[0][2] = cosZ * sinY;
			matrix[1][0] = sinX * sinY;
			matrix[1][1] = cosX * cosZ - cosY * sinX * sinZ;
			matrix[1][2] = -cosX * sinZ - cosY * cosZ * sinX;
			matrix[2][0] = -cosX * sinY;
			matrix[2][1] = cosZ * sinX + cosX * cosY * sinZ;
			matrix[2][2] = cosX * cosY * cosZ - sinX * sinZ;
		}
		case euler_yxy: {
			matrix[0][0] = cosX * cosZ - cosY * sinX * sinZ;
			matrix[0][1] = sinX * sinY;
			matrix[0][2] = cosX * sinZ + cosY * cosZ * sinX;
			matrix[1][0] = sinY * sinZ;
			matrix[1][1] = cosY;
			matrix[1][2] = -cosZ * sinY;
			matrix[2][0] = -cosZ * sinX - cosX * cosY * sinZ;
			matrix[2][1] = cosX * sinY;
			matrix[2][2] = cosX * cosY * cosZ - sinX * sinZ;
		}
		case euler_yzy: {
			matrix[0][0] = cosX * cosY * cosZ - sinX * sinZ;
			matrix[0][1] = -cosX * sinY;
			matrix[0][2] = cosZ * sinX + cosX * cosY * sinZ;
			matrix[1][0] = cosZ * sinY;
			matrix[1][1] = cosY;
			matrix[1][2] = sinY * sinZ;
			matrix[2][0] = -cosX * sinZ - cosY * cosZ * sinX;
			matrix[2][1] = sinX * sinY;
			matrix[2][2] = cosX * cosZ - cosY * sinX * sinZ;
		}
		case euler_zyz: {
			matrix[0][0] = cosX * cosY * cosZ - sinX * sinZ;
			matrix[0][1] = -cosZ * sinX - cosX * cosY * sinZ;
			matrix[0][2] = cosX * sinY;
			matrix[1][0] = cosX * sinZ + cosY * cosZ * sinX;
			matrix[1][1] = cosX * cosZ - cosY * sinX * sinZ;
			matrix[1][2] = sinX * sinY;
			matrix[2][0] = -cosZ * sinY;
			matrix[2][1] = sinY * sinZ;
			matrix[2][2] = cosY;
		}
		case euler_zxz: {
			matrix[0][0] = cosX * cosZ - cosY * sinX * sinZ;
			matrix[0][1] = -cosX * sinZ - cosY * cosZ * sinX;
			matrix[0][2] = sinX * sinY;
			matrix[1][0] = cosZ * sinX + cosX * cosY * sinZ;
			matrix[1][1] = cosX * cosY * cosZ - sinX * sinZ;
			matrix[1][2] = -cosX * sinY;
			matrix[2][0] = sinY * sinZ;
			matrix[2][1] = cosZ * sinY;
			matrix[2][2] = cosY;
		} // Tait-Bryan angles - X(rX), Y(rY), Z(rZ)
		case euler_xzy: {
			matrix[0][0] = cosZ * cosY;
			matrix[0][1] = -sinZ;
			matrix[0][2] = cosZ * sinY;
			matrix[1][0] = sinX * sinY + cosX * cosY * sinZ;
			matrix[1][1] = cosX * cosZ;
			matrix[1][2] = cosX * sinZ * sinY - cosY * sinX;
			matrix[2][0] = cosY * sinX * sinZ - cosX * sinY;
			matrix[2][1] = cosZ * sinX;
			matrix[2][2] = cosX * cosY + sinX * sinZ * sinY;
		}
		case euler_xyz: {
			matrix[0][0] = cosY * cosZ;
			matrix[0][1] = -cosY * sinZ;
			matrix[0][2] = sinY;
			matrix[1][0] = cosX * sinZ + cosZ * sinX * sinY;
			matrix[1][1] = cosX * cosZ - sinX * sinY * sinZ;
			matrix[1][2] = -cosY * sinX;
			matrix[2][0] = sinX * sinZ - cosX * cosZ * sinY;
			matrix[2][1] = cosZ * sinX + cosX * sinY * sinZ;
			matrix[2][2] = cosX * cosY;
		}
		case euler_yxz: {
			matrix[0][0] = cosY * cosZ + sinY * sinX * sinZ;
			matrix[0][1] = cosZ * sinY * sinX - cosY * sinZ;
			matrix[0][2] = cosX * sinY;
			matrix[1][0] = cosX * sinZ;
			matrix[1][1] = cosX * cosZ;
			matrix[1][2] = -sinX;
			matrix[2][0] = cosY * sinX * sinZ - cosZ * sinY;
			matrix[2][1] = cosY * cosZ * sinX + sinY * sinZ;
			matrix[2][2] = cosY * cosX;
		}
		case euler_yzx: {
			matrix[0][0] = cosY * cosZ;
			matrix[0][1] = sinY * sinX - cosY * cosX * sinZ;
			matrix[0][2] = cosX * sinY + cosY * sinZ * sinX;
			matrix[1][0] = sinZ;
			matrix[1][1] = cosZ * cosX;
			matrix[1][2] = -cosZ * sinX;
			matrix[2][0] = -cosZ * sinY;
			matrix[2][1] = cosY * sinX + cosX * sinY * sinZ;
			matrix[2][2] = cosY * cosX - sinY * sinZ * sinX;
		}
		case euler_zyx: { // pitch roll yaw
			matrix[0][0] = cosZ * cosY;
			matrix[0][1] = cosZ * sinY * sinX - cosX * sinZ;
			matrix[0][2] = sinZ * sinX + cosZ * cosX * sinY;
			matrix[1][0] = cosY * sinZ;
			matrix[1][1] = cosZ * cosX + sinZ * sinY * sinX;
			matrix[1][2] = cosX * sinZ * sinY - cosZ * sinX;
			matrix[2][0] = -sinY;
			matrix[2][1] = cosY * sinX;
			matrix[2][2] = cosY * cosX;
		}
		case euler_zxy: { // sa-mp
			matrix[0][0] = cosZ * cosY - sinZ * sinX * sinY;
			matrix[0][1] = -sinZ * cosX;
			matrix[0][2] = cosZ * sinY + sinZ * sinX * cosY;
			matrix[1][0] = sinZ * cosY + cosZ * sinX * sinY;
			matrix[1][1] = cosZ * cosX;
			matrix[1][2] = sinZ * sinY - cosZ * sinX * cosY;
			matrix[2][0] = -cosX * sinY;
			matrix[2][1] = sinX;
			matrix[2][2] = cosX * cosY;
		}
	}
}

stock GetRotationMatrixFromAxisAngle(Float: matrix[][], Float: angle, Float: aX, Float: aY, Float: aZ) {
	new
		Float: cos = floatcos(angle, degrees),
		Float: sin = floatsin(angle, degrees),
		Float: t = 1.0 - cos;

	matrix[0][0] = t * aX * aX + cos;
	matrix[1][1] = t * aY * aY + cos;
	matrix[2][2] = t * aZ * aZ + cos;

	cos = t * aX * aY;

	matrix[0][1] = cos - sin * aZ;
	matrix[1][0] = cos + sin * aZ;

	cos = t * aX * aZ;

	matrix[0][2] = cos + sin * aY;
	matrix[2][0] = cos - sin * aY;

	cos = t * aY * aZ;

	matrix[1][2] = cos - sin * aX;
	matrix[2][1] = cos + sin * aX;
}

// can result in NaN (1.0 + matrix[0][0] + matrix[1][1] + matrix[2][2]) could be <= 0.0
stock GetQuatFromMatrix(Float: matrix[][], & Float: w, & Float: x, & Float: y, & Float: z) {
	z = -4.0 * (w = floatsqroot(1.0 + matrix[0][0] + matrix[1][1] + matrix[2][2]) / 2.0);

	x = (matrix[2][1] - matrix[1][2]) / z;
	y = (matrix[0][2] - matrix[2][0]) / z;
	z = (matrix[1][0] - matrix[0][1]) / z;
}

stock GetQuatFromEuler(Float: rX, Float: rY, Float: rZ, & Float: w, & Float: x, & Float: y, & Float: z, eulermode: mode = euler_default) {
	rX /= 2.0; // could be done with multiplication but would be slower
	rY /= 2.0;
	rZ /= 2.0;

	new	Float: cosX = floatcos(rX, degrees),
		Float: cosY = floatcos(rY, degrees),
		Float: cosZ = floatcos(rZ, degrees),
		Float: sinX = floatsin(rX, degrees),
		Float: sinY = floatsin(rY, degrees),
		Float: sinZ = floatsin(rZ, degrees);

	switch(mode) {
		case euler_xzx: {
			w = sinX * cosY * sinZ - cosX * cosY * cosZ;
			x = cosX * cosY * sinZ + sinX * cosY * cosZ;
			y = cosX * sinY * sinZ - sinX * sinY * cosZ;
			z = cosX * sinY * cosZ + sinX * sinY * sinZ;		
		}
		case euler_xyx: {
			w = sinX * cosY * sinZ - cosX * cosY * cosZ;
			x = cosX * cosY * sinZ + sinX * cosY * cosZ;
			y = cosX * sinY * cosZ + sinX * sinY * sinZ;
			z = sinX * sinY * cosZ - cosX * sinY * sinZ;
		}
		case euler_yxy: {
			w = sinX * cosY * sinZ - cosX * cosY * cosZ;
			x = cosX * sinY * cosZ + sinX * sinY * sinZ;
			y = cosX * cosY * sinZ + sinX * cosY * cosZ;
			z = cosX * sinY * sinZ - sinX * sinY * cosZ;
		}
		case euler_yzy: {
			w = sinX * cosY * sinZ - cosX * cosY * cosZ;
			x = sinX * sinY * cosZ - cosX * sinY * sinZ;
			y = cosX * cosY * sinZ + sinX * cosY * cosZ;
			z = cosX * sinY * cosZ + sinX * sinY * sinZ;
		}
		case euler_zyz: {
			w = sinX * cosY * sinZ - cosX * cosY * cosZ;
			x = cosX * sinY * sinZ - sinX * sinY * cosZ;
			y = cosX * sinY * cosZ + sinX * sinY * sinZ;
			z = cosX * cosY * sinZ + sinX * cosY * cosZ;
		}
		case euler_zxz: {
			w = sinX * cosY * sinZ - cosX * cosY * cosZ;
			x = cosX * sinY * cosZ + sinX * sinY * sinZ;
			y = sinX * sinY * cosZ - cosX * sinY * sinZ;
			z = cosX * cosY * sinZ + sinX * cosY * cosZ;
		}
		case euler_xzy: {
			w = cosX * cosY * cosZ + sinX * sinY * sinZ;
			x = cosX * sinY * sinZ - sinX * cosY * cosZ;
			y = sinX * cosY * sinZ - cosX * sinY * cosZ;
			z = -(cosX * cosY * sinZ + sinX * sinY * cosZ);
		}
		case euler_xyz: {
			w = sinX * sinY * sinZ - cosX * cosY * cosZ;
			x = sinX * cosY * cosZ + cosX * sinY * sinZ;
			y = cosX * sinY * cosZ - sinX * cosY * sinZ;
			z = cosX * cosY * sinZ + sinX * sinY * cosZ;
		}
		case euler_yxz: {
			w = cosX * cosY * cosZ + sinX * sinY * sinZ;
			x = -(sinX * cosY * cosZ + cosX * sinY * sinZ);
			y = sinX * cosY * sinZ - cosX * sinY * cosZ;
			z = sinX * sinY * cosZ - cosX * cosY * sinZ;
		}
		case euler_yzx: {
			w = sinX * sinY * sinZ - cosX * cosY * cosZ;
			x = sinX * cosY * cosZ + cosX * sinY * sinZ;
			y = cosX * sinY * cosZ + sinX * cosY * sinZ;
			z = cosX * cosY * sinZ - sinX * sinY * cosZ;
		}
		case euler_zyx: {
			w = cosX * cosY * cosZ + sinX * sinY * sinZ;
			x = cosX * sinY * sinZ - sinX * cosY * cosZ;
			y = -(cosX * sinY * cosZ + sinX * cosY * sinZ);
			z = sinX * sinY * cosZ - cosX * cosY * sinZ;
		}
		case euler_zxy: {
			w = sinX * sinY * sinZ - cosX * cosY * cosZ;
			x = sinX * cosY * cosZ - cosX * sinY * sinZ;
			y = cosX * sinY * cosZ + sinX * cosY * sinZ;
			z = cosX * cosY * sinZ + sinX * sinY * cosZ;
		}
	}
}

stock GetQuatFromAxisAngle(Float: angle, Float: aX, Float: aY, Float: aZ, & Float: w, & Float: x, & Float: y, & Float: z) {
	angle /= -2.0;

	w = floatsin(angle, degrees) / VectorSize(aX, aY, aZ);

	x = aX * w;
	y = aY * w;
	z = aZ * w;
	w = floatcos(angle, degrees);
}

stock GetEulerFromMatrix(Float: matrix[][], & Float: rX, & Float: rY, & Float: rZ, eulermode: mode = euler_default) {
	switch(mode) {
		case euler_xzx: {
			rY = matrix[0][0];

			if(rY > 0.9999) {
				rX = atan2(matrix[2][1], matrix[1][1]);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(matrix[2][1], matrix[1][1]);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(matrix[2][0], matrix[1][0]);
				rY = acos(rY);
				rZ = atan2(matrix[0][2], -matrix[0][1]);
			}
		}
		case euler_xyx: {
			rY = matrix[0][0];

			if(rY > 0.9999) {
				rX = atan2(matrix[2][1], matrix[1][1]);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(matrix[2][1], matrix[1][1]);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(matrix[1][0], -matrix[2][0]);
				rY = acos(rY);
				rZ = atan2(matrix[0][1], matrix[0][2]);
			}
		}
		case euler_yxy: {
			rY = matrix[1][1];

			if(rY > 0.9999) {
				rX = atan2(matrix[0][2], matrix[2][2]);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(matrix[0][2], matrix[2][2]);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(matrix[0][1], matrix[2][1]);
				rY = acos(rY);
				rZ = atan2(matrix[1][0], -matrix[1][2]);
			}
		}
		case euler_yzy: {
			rY = matrix[1][1];

			if(rY > 0.9999) {
				rX = atan2(matrix[0][2], matrix[2][2]);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(matrix[0][2], matrix[2][2]);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(matrix[2][1], -matrix[0][1]);
				rY = acos(rY);
				rZ = atan2(matrix[1][2], matrix[1][0]);
			}
		}
		case euler_zyz: {
			rY = matrix[2][2];

			if(rY > 0.9999) {
				rX = atan2(matrix[1][0], matrix[0][0]);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(matrix[1][0], matrix[0][0]);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(matrix[1][2], matrix[0][2]);
				rY = acos(rY);
				rZ = atan2(matrix[2][1], -matrix[2][0]);
			}
		}
		case euler_zxz: {
			rY = matrix[2][2];

			if(rY > 0.9999) {
				rX = atan2(matrix[1][0], matrix[0][0]);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(matrix[1][0], matrix[0][0]);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(matrix[0][2], -matrix[1][2]);
				rY = acos(rY);
				rZ = atan2(matrix[2][0], matrix[2][1]);
			}
		}
		case euler_xzy: {
			rZ = matrix[0][1];

			if(rZ < -0.9999) {
				rX = atan2(matrix[2][0], matrix[1][0]);
				rY = 0.0;
				rZ = 90.0;
			} else if(rZ > 0.9999) {
				rX = atan2(matrix[2][0], matrix[1][0]);
				rY = 0.0;
				rZ = -90.0;
			} else {
				rX = atan2(matrix[2][1], matrix[1][1]);
				rY = atan2(matrix[0][2], matrix[0][0]);
				rZ = -asin(rZ);
			}
		}
		case euler_xyz: {
			rY = matrix[0][2];

			if(rY > 0.9999) {
				rX = atan2(matrix[2][1], matrix[1][1]);
				rY = 90.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(matrix[2][1], matrix[1][1]);
				rY = -90.0;
				rZ = 0.0;
			} else {
				rX = -atan2(matrix[1][2], matrix[2][2]);
				rY = asin(rY);
				rZ = -atan2(matrix[0][1], matrix[0][0]);
			}
		}
		case euler_yxz: {
			rX = matrix[1][2];

			if(rX < -0.9999) {
				rX = 90.0;
				rY = atan2(matrix[0][1], matrix[2][1]);
				rZ = 0.0;
			} else if(rX > 0.9999) {
				rX = -90.0;
				rY = atan2(matrix[0][1], matrix[2][1]);
				rZ = 0.0;
			} else {
				rX = -asin(rX);
				rY = atan2(matrix[0][2], matrix[2][2]);
				rZ = atan2(matrix[1][0], matrix[1][1]);
			}
		}
		case euler_yzx: {
			rZ = matrix[1][0];

			if(rZ < -0.9999) {
				rX = 0.0;
				rY = atan2(matrix[0][2], matrix[2][2]);
				rZ = 90.0;
			} else if(rZ > 0.9999) {
				rX = 0.0;
				rY = atan2(matrix[0][2], matrix[2][2]);
				rZ = -90.0;
			} else {
				rX = -atan2(matrix[1][2], matrix[1][1]);
				rY = -atan2(matrix[2][0], matrix[0][0]);
				rZ = asin(rZ);
			}
		}
		case euler_zyx: { // pitch roll yaw
			rY = matrix[2][0];

			if(rY > 0.9999) {
				rX = 0.0;
				rY = 90.0;
				rZ = atan2(matrix[1][2], matrix[0][2]);
			} else if(rY < -0.9999) {
				rX = 0.0;
				rY = -90.0;
				rZ = atan2(matrix[1][2], matrix[0][2]);
			} else {
				rX = atan2(matrix[2][1], matrix[2][2]);
				rY = -asin(rY);
				rZ = atan2(matrix[1][0], matrix[0][0]);
			}
		}
		case euler_zxy: { // sa-mp
			rX = matrix[2][1]; // singularitie at rX = +- 90.0

			if(rX > 0.9999) { // ~ 89.2 degrees
				rX = 90.0;
				rY = 0.0;
				rZ = atan2(matrix[1][0], matrix[0][0]);
			} else if(rX < -0.9999) {
				rX = -90.0;
				rY = 0.0;
				rZ = atan2(matrix[1][0], matrix[0][0]);
			} else { // it does work without the singularities but it gets inaccurate
				rX = asin(rX);
				rY = -atan2(matrix[2][0], matrix[2][2]);
				rZ = -atan2(matrix[0][1], matrix[1][1]);
			}
		}
	}
}

stock GetEulerFromQuat(Float: w, Float: x, Float: y, Float: z, & Float: rX, & Float: rY, & Float: rZ, eulermode: mode = euler_default) {
	switch(mode) {
		case euler_xzx: {
			rY = w * w + x * x - y * y - z * z;

			if(rY > 0.9999) {
				rX = atan2(2.0 * (y * z - w * x), w * w - x * x + y * y - z * z);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(2.0 * (y * z - w * x), w * w - x * x + y * y - z * z);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(x * z + w * y, x * y - w * z);
				rY = acos(rY);
				rZ = atan2(x * z - w * y, -(x * y + w * z));
			}
		}
		case euler_xyx: {
			rY = w * w + x * x - y * y - z * z;

			if(rY > 0.9999) {
				rX = atan2(2.0 * (y * z - w * x), w * w - x * x + y * y - z * z);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(2.0 * (y * z - w * x), w * w - x * x + y * y - z * z);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(x * y - w * z, -(x * z + w * y));
				rY = acos(rY);
				rZ = atan2(x * y + w * z, x * z - w * y);
			}
		}
		case euler_yxy: {
			rY = w * w - x * x + y * y - z * z;

			if(rY > 0.9999) {
				rX = atan2(2.0 * (x * z - w * y), w * w - x * x - y * y + z * z);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(2.0 * (x * z - w * y), w * w - x * x - y * y + z * z);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(x * y + w * z, y * z - w * x);
				rY = acos(rY);
				rZ = atan2(x * y - w * z, -(y * z + w * x));
			}
		}
		case euler_yzy: {
			rY = w * w - x * x + y * y - z * z;

			if(rY > 0.9999) {
				rX = atan2(2.0 * (x * z - w * y), w * w - x * x - y * y + z * z);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(2.0 * (x * z - w * y), w * w - x * x - y * y + z * z);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(y * z - w * x, -(x * y + w * z));
				rY = acos(rY);
				rZ = atan2(y * z + w * x, x * y - w * z);
			}
		}
		case euler_zyz: {
			rY = w * w - x * x - y * y + z * z;

			if(rY > 0.9999) {
				rX = atan2(2.0 * (x * y - w * z), w * w + x * x - y * y - z * z);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(2.0 * (x * y - w * z), w * w + x * x - y * y - z * z);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(y * z + w * x, x * z - w * y);
				rY = acos(rY);
				rZ = atan2(y * z - w * x, -(x * z + w * y));
			}
		}
		case euler_zxz: {
			rY = w * w - x * x - y * y + z * z;

			if(rY > 0.9999) {
				rX = atan2(2.0 * (x * y - w * z), w * w + x * x - y * y - z * z);
				rY = 0.0;
				rZ = 0.0;
			} else if(rY < -0.9999) {
				rX = atan2(2.0 * (x * y - w * z), w * w + x * x - y * y - z * z);
				rY = 180.0;
				rZ = 0.0;
			} else {
				rX = atan2(x * z - w * y, -(y * z + w * x));
				rY = acos(rY);
				rZ = atan2(x * z + w * y, y * z - w * x);
			}
		}
		case euler_xzy: {
			rZ = x * y + w * z;

			if(rZ < -0.49995) {
				rX = atan2(x * z + w * y, x * y - w * z);
				rY = 0.0;
				rZ = 90.0;
			} else if(rZ > 0.49995) {
				rX = atan2(x * z + w * y, x * y - w * z);
				rY = 0.0;
				rZ = -90.0;
			} else {
				mode = eulermode: (w * w - z * z);
				rY = x * x - y * y;

				rX = atan2(2.0 * (y * z - w * x), Float: mode - rY);
				rY = atan2(2.0 * (x * z - w * y), Float: mode + rY);
				rZ = asin(-2.0 * rZ);
			}
		}
		case euler_xyz: {
			rY = x * z - w * y;

			if(rY > 0.49995) {
				rX = atan2(w * x - y * z, x * z + w * y);
				rY = 90.0;
				rZ = 0.0;
			} else if(rY < -0.49995) {
				rX = atan2(y * z - w * x, x * z + w * y);
				rY = -90.0;
				rZ = 0.0;
			} else {
				mode = eulermode: (w * w - y * y);
				rZ = x * x - z * z;

				rX = atan2(-2.0 * (y * z + w * x), Float: mode - rZ);
				rY = asin(2.0 * rY);
				rZ = atan2(-2.0 * (x * y + w * z), Float: mode + rZ);
			}
		}
		case euler_yxz: {
			rX = y * z + w * x;

			if(rX < -0.49995) {
				rX = 90.0;
				rY = atan2(x * y + w * z, y * z - w * x);
				rZ = 0.0;
			} else if(rX > 0.49995) {
				rX = -90.0;
				rY = atan2(x * y + w * z, y * z - w * x);
				rZ = 0.0;
			} else {
				mode = eulermode: (w * w - x * x);
				rZ = y * y - z * z;

				rX = asin(-2.0 * rX);
				rY = atan2(2.0 * (x * z - w * y), Float: mode - rZ);
				rZ = atan2(2.0 * (x * y - w * z), Float: mode + rZ);
			}
		}
		case euler_yzx: {
			rZ = x * y - w * z;

			if(rZ < -0.49995) {
				rX = 0.0;
				rY = atan2(w * y - x * z, x * y + w * z);
				rZ = 90.0;
			} else if(rZ > 0.49995) {
				rX = 0.0;
				rY = atan2(x * z - w * y, x * y + w * z);
				rZ = -90.0;
			} else {
				mode = eulermode: (w * w - z * z);
				rY = x * x - y * y;

				rX = atan2(-2.0 * (y * z + w * x), Float: mode - rY);
				rY = atan2(-2.0 * (x * z + w * y), Float: mode + rY);
				rZ = asin(2.0 * rZ);
			}
		}
		case euler_zyx: { // pitch roll yaw
			rY = x * z + w * y;

			if(rY > 0.49995) {
				rX = 0.0;
				rY = 90.0;
				rZ = atan2(y * z + w * x, x * z - w * y);
			} else if(rY < -0.49995) {
				rX = 0.0;
				rY = -90.0;
				rZ = atan2(y * z + w * x, x * z - w * y);
			} else {
				mode = eulermode: (w * w - y * y);
				rZ = x * x - z * z;

				rX = atan2(2.0 * (y * z - w * x), Float: mode - rZ);
				rY = asin(-2.0 * rY);
				rZ = atan2(2.0 * (x * y - w * z), Float: mode + rZ);
			}
		}
		case euler_zxy: { // sa-mp
			rX = y * z - w * x;

			if(rX > 0.49995) {
				rY = 0.0;
				rX = 90.0;
				rZ = atan2(w * y - x * z, y * z + w * x);
			} else if(rX < -0.49995) {
				rY = 0.0;
				rX = -90.0;
				rZ = atan2(w * y - x * z, y * z + w * x);
			} else {
				mode = eulermode: (w * w - x * x);
				rZ = y * y - z * z;

				rX = asin(2.0 * rX);
				rY = atan2(-2.0 * (x * z + w * y), Float: mode - rZ);
				rZ = atan2(-2.0 * (x * y + w * z), Float: mode + rZ);
			}
		}
	}
}

stock GetEulerFromEuler(Float: oX, Float: oY, Float: oZ, eulermode: omode, & Float: rX, & Float: rY, & Float: rZ, eulermode: mode = euler_default) {
	GetQuatFromEuler(oX, oY, oZ, rX, oX, oY, oZ, omode);
	GetEulerFromQuat(rX, oX, oY, oZ, rX, rY, rZ, mode);
}

stock GetEulerFromAxisAngle(Float: angle, Float: aX, Float: aY, Float: aZ, & Float: rX, & Float: rY, & Float: rZ, eulermode: mode = euler_default) {
	new Float: matrix[3][3]; // leaving that unoptimised, see no use for it

	GetRotationMatrixFromAxisAngle(matrix, angle, aX, aY, aZ);
	GetEulerFromMatrix(matrix, rX, rY, rZ, mode);
}

stock GetAxisAngleFromMatrix(Float: matrix[3][3], & Float: angle, & Float: aX, & Float: aY, & Float: aZ) {
	aX = matrix[2][1] - matrix[1][2]; // does have untriggered singularities
	aY = matrix[0][2] - matrix[2][0];
	aZ = matrix[1][0] - matrix[0][1];

	angle = VectorSize(aX, aY, aZ);

	aX /= angle;
	aY /= angle;
	aZ /= angle;

	angle = acos((matrix[0][0] + matrix[1][1] + matrix[2][2] - 1.0) / 2.0);	
}

stock GetAxisAngleFromQuat(Float: w, Float: x, Float: y, Float: z, & Float: angle, & Float: aX, & Float: aY, & Float: aZ) {
	angle = 2.0 * acos(-w);
	w = VectorSize(x, y, z); // w = floatsqroot(1.0 - w * w); // w = floatsin(angle, degrees); // |sin(angle)|

	if(w == 0.0) { // no rotation
		aX = 1.0;
		aY = 0.0;
		aZ = 0.0;

		angle = 0.0;
	} else {
		aX = x / w;
		aY = y / w;
		aZ = z / w;
	}
}

stock GetAxisAngleFromEuler(Float: rX, Float: rY, Float: rZ, & Float: angle, & Float: aX, & Float: aY, & Float: aZ, eulermode: mode = euler_default) {
	GetQuatFromEuler(rX, rY, rZ, angle, aX, aY, aZ, mode);
	GetAxisAngleFromQuat(angle, aX, aY, aZ, angle, aX, aY, aZ);	
}

stock MatrixRotate(Float: matrix[][], Float: oX, Float: oY, Float: oZ, & Float: X, & Float: Y, & Float: Z) {
	X += oX * matrix[0][0] + oY * matrix[0][1] + oZ * matrix[0][2]; // M * v | v = [oX, oY, oZ]
	Y += oX * matrix[1][0] + oY * matrix[1][1] + oZ * matrix[1][2];
	Z += oX * matrix[2][0] + oY * matrix[2][1] + oZ * matrix[2][2];
}

stock QuatRotate(Float: w, Float: x, Float: y, Float: z, Float: oX, Float: oY, Float: oZ, & Float: X, & Float: Y, & Float: Z) {
	// wikipedia suggest this formula (a x b - cross prudct)
	// v + 2*r x (r x v + w*v) | q = w,r
	// 15 muls, 15 adds, 9 saves, 42 loads
	// but I used this one because it more compact (a.b - dot product)
	// 2*((r.v)*r + (0.5 - (|r.r|^2))*v + w * (r x v)) | q = w,r
	// 22 muls, 12 adds, 5 saves, 38 loads
	new
		Float: dot = x * oX + y * oY + z * oZ,
		Float: abs = w * w - 0.5;

	X += 2.0 * (dot * x + abs * oX + w * (z * oY - y * oZ));
	Y += 2.0 * (dot * y + abs * oY + w * (x * oZ - z * oX));
	Z += 2.0 * (dot * z + abs * oZ + w * (y * oX - x * oY));
}

stock EulerRotate(Float: rX, Float: rY, Float: rZ, Float: oX, Float: oY, Float: oZ, & Float: X, & Float: Y, & Float: Z, eulermode: mode = euler_default) {
	// saddly I couldn't find a way to rotate euler angles without matrices, is there even a way?
	GetQuatFromEuler(rX, rY, rZ, Float: mode, rX, rY, rZ, mode);
	QuatRotate(Float: mode, rX, rY, rZ, oX, oY, oZ, X, Y, Z);
}

stock AxisAngleRotate(Float: angle, Float: aX, Float: aY, Float: aZ, Float: oX, Float: oY, Float: oZ, & Float: X, & Float: Y, & Float: Z) {
	new // uses Rodrigues rotation formula, similar to QuatRotate
		Float: cos = floatcos(angle, degrees),
		Float: sin = floatsin(angle, degrees),
		Float: ts = (1.0 - cos) * (aX * oX + aY * oY + aZ * oZ);
	// cos * v + sin * (e x v) + (1 - cos) * (e.v) * e | e = [aX, aY, aZ] v = [oX, oY, oZ]
	X += ts * aX + cos * oX + sin * (aY * oZ - aZ * oY);
	Y += ts * aY + cos * oY + sin * (aZ * oX - aX * oZ);
	Z += ts * aZ + cos * oZ + sin * (aX * oY - aY * oX);
}
