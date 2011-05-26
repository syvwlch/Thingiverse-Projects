use <Thread_Library.scad>

module part(sideA=true				)// true to create side A, false to create side B
{
	height=30;
	smallSide=40;
	bigSide=65;
	
	holeRadius=3;
	countersinkRadius=6;
	countersinkDepth=3;
	
	translate([0,-height/2,24])
	rotate([-90,0,0])
	difference()
	{
		translate([0,smallSide/4,height/2])
		cube([bigSide,smallSide/2,height],true);
	
		rotate([0,0,(sideA==true ? 0 : 180)])
		trapezoidThreadNegativeSpace( 
			length=height, 			// axial length of the threaded rod
			pitch=10,				// axial distance from crest to crest
			pitchRadius=10, 			// radial distance from center to mid-profile
			threadHeightToPitch=0.5, 	// ratio between the height of the profile and the pitch
								// std value for Acme or metric lead screw is 0.5
			profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
								// std value for Acme or metric lead screw is 0.5
			threadAngle=30, 			// angle between the two faces of the thread
								// std value for Acme is 29 or for metric lead screw is 30
			RH=true, 				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
			countersunk=0.5, 		// depth of 45 degree chamfered entries, normalized to pitch
			clearance=0.1, 			// radial clearance, normalized to thread height
			backlash=0.1, 			// axial clearance, normalized to pitch
			stepsPerTurn=24 			// number of slices to create per turn
			);
	
		translate([bigSide/2-countersinkRadius*1.5,0,height/2])
		rotate([90,0,0])
		translate([0,0,-smallSide/2-1])
		{
			cylinder(h=smallSide/2+2,r1=holeRadius,r2=holeRadius,$fn=24);
		
			translate([0,0,0])
			cylinder(h=countersinkDepth+1,r1=countersinkRadius,r2=countersinkRadius,$fn=6);
		}
	
		translate([-bigSide/2+countersinkRadius*1.5,0,height/2])
		rotate([90,0,0])
		translate([0,0,-smallSide/2-1])
		{
			cylinder(h=smallSide/2+2,r1=holeRadius,r2=holeRadius,$fn=24);
		
			translate([0,0,0])
			cylinder(h=countersinkDepth+1,r1=countersinkRadius,r2=countersinkRadius,$fn=24);
		}
	}
}

translate([0,20,0])
part(true);

translate([0,-20,0])
rotate([0,0,180])
part(false);