use <Thread_Library.scad>

length=60;
pitch=10;
pitchRadius=20; 

difference()
{
	cylinder(h=2*pitch, r1=2*pitchRadius, r2=2*pitchRadius,$fn=6);

	translate([0,0,-length/2])
	trapezoidThread(
		length=length, 			// axial length of the threaded rod 
		pitch=pitch, 			// axial distance from crest to crest
		pitchRadius=pitchRadius, 	// radial distance from center to mid-profile
		threadHeightToPitch=0.5, 	// ratio between the height of the profile and the pitch 
							// std value for Acme or metric lead screw is 0.5
		profileRatio=0.5, 			// ratio between the lengths of the raised part of the profile and the pitch
							// std value for Acme or metric lead screw is 0.5
		RH=true, 				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
		clearance=-0.1, 			// radial clearance, normalized to thread height
		backlash=-0.1, 			// axial clearance, normalized to pitch
		stepsPerTurn=24 			// number of slices to create per turn
			);
}

difference()
{
	translate([0,0,-0.5*pitch])
	cylinder(h=0.5*pitch, r1=2*pitchRadius, r2=2*pitchRadius,$fn=6);

	translate([0,0,-0.5*pitch])
	cylinder(h=0.5*pitch, r1=pitchRadius+0.5*pitch, r2=pitchRadius+0.5*pitch*0.5,$fn=24);
}

difference()
{
	translate([0,0,2*pitch])
	cylinder(h=0.5*pitch, r1=2*pitchRadius, r2=2*pitchRadius,$fn=6);

	translate([0,0,2*pitch])
	cylinder(h=0.5*pitch, r1=pitchRadius+0.5*pitch*0.5, r2=pitchRadius+0.5*pitch,$fn=24);
}