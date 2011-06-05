
function norm(vector) = sqrt(vector[0]*vector[0]+vector[1]*vector[1]+vector[2]*vector[2]); 

function unitVector(vector) = vector / norm ( vector );

function barycenter(vector1, vector2, ratio) = (vector1*ratio + vector2*(1-ratio) );

module slice( 
	AShaftBottom,
	AShaftTop,
	BShaftBottom,
	BShaftTop,
	ABottom,
	ATop,
	BBottom,
	BTop,
	AThreadDepth,
	AThreadRatio=0.5,
	AThreadPosition=0.5,
	AThreadAngle=20,
	BThreadDepth,
	BThreadRatio=0.5,
	BThreadPosition=0.5,
	BThreadAngle=20,
	showVertices=false
	)
{ 
	polyPoints=[
		AShaftBottom,
		AShaftTop,
		ATop,
		barycenter(ATop,ABottom,AThreadPosition+AThreadRatio/2) + unitVector(ATop-ABottom)*AThreadDepth/2*tan(AThreadAngle),
		barycenter(ATop,ABottom,AThreadPosition+AThreadRatio/2) - unitVector(ATop-ABottom)*AThreadDepth/2*tan(AThreadAngle) + unitVector(ATop-AShaftTop)*AThreadDepth,
		barycenter(ATop,ABottom,AThreadPosition),
		barycenter(ATop,ABottom,AThreadPosition-AThreadRatio/2) + unitVector(ATop-ABottom)*AThreadDepth/2*tan(AThreadAngle) + unitVector(ATop-AShaftTop)*AThreadDepth,
		barycenter(ATop,ABottom,AThreadPosition-AThreadRatio/2) - unitVector(ATop-ABottom)*AThreadDepth/2*tan(AThreadAngle),
		ABottom,
		BTop,
		barycenter(BTop,BBottom,BThreadPosition+BThreadRatio/2) + unitVector(BTop-BBottom)*BThreadDepth/2*tan(BThreadAngle),
		barycenter(BTop,BBottom,BThreadPosition+BThreadRatio/2) - unitVector(BTop-BBottom)*BThreadDepth/2*tan(BThreadAngle) + unitVector(BTop-BShaftTop)*BThreadDepth,
		barycenter(BTop,BBottom,BThreadPosition),
		barycenter(BTop,BBottom,BThreadPosition-BThreadRatio/2) + unitVector(BTop-BBottom)*BThreadDepth/2*tan(BThreadAngle) + unitVector(BTop-BShaftTop)*BThreadDepth,
		barycenter(BTop,BBottom,BThreadPosition-BThreadRatio/2) - unitVector(BTop-BBottom)*BThreadDepth/2*tan(BThreadAngle),
		BBottom,
		BShaftBottom,
		BShaftTop
			];

	polyTriangles=[
		[ 0,1,5], [1,2,3], [1,3,5], [0,5,7], [0,7,8], 			//A side of shaft
		[1,0,12], [1,10,9], [1,12,10], [0,14,12], [0,15,14], 	// B side of shaft
		[0,8,15], 								// bottom of shaft
		[1,9,2], 								// top of shaft
		[3,2,10], [2,9,10], [4,3,10], [10,11,4], 			// top of thread
		[6,4,11], [11,13,6], 						// tip of thread
		[7,6,13], [13,14,7], [8,7,14], [14,15,8], 			// bottom of thread
		[3,4,5], [5,4,6], [5,6,7], 					// A side of thread
		[11,10,12], [11,12,13], [12,14,13] 				// B side of thread
			];
	
	if (showVertices==true) for (i=[0:15]) translate(polyPoints[i]) color([1,0.5,0.5]) cube(0.25,true);
	
	polyhedron( polyPoints, polyTriangles );
}

module trapezoidThread(
	length=45,				// axial length of the threaded rod
	pitch=10,				// axial distance from crest to crest
	pitchRadius=10,			// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=30,			// angle between the two faces of the thread
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	clearance=0.1,			// radial clearance, normalized to thread height
	backlash=0.1,			// axial clearance, normalized to pitch
	stepsPerTurn=24,			// number of slices to create per turn,
	showVertices=false
		)
{

	numberTurns=length/pitch-1;
		
	steps=stepsPerTurn*numberTurns;

	startLength=0.25;	// number of turns for profile to reach full height

	function 	profileRatio(i)=		profileRatio*(1-backlash);

	function	threadAngle(i)=		threadAngle;

	function	threadPosition(i)=		( profileRatio(i) + threadHeightToPitch*(1+clearance)*tan( threadAngle(i) ) )/2;

	function 	threadHeight(i)=		pitch*threadHeightToPitch*(1+clearance);

	function	pitchRadius(i)=		pitchRadius;
	function	minorRadius(i)=		pitchRadius(i)-(0.5+clearance)*pitch*threadHeightToPitch;

	function 	ShaftX(i)= 			0; 
	function 	ShaftY(i)= 			0;
	function 	ShaftZ(i)= 			pitch*numberTurns*i;
	
	function 	X(i)=				ShaftX(i)+minorRadius(i)*cos(i*360*numberTurns);
	function 	Y(i)=				ShaftY(i)+minorRadius(i)*sin(i*360*numberTurns);
	function 	Z(i)=				ShaftZ(i);

	if (RH==true)
	for (i=[0:steps-1])
	{
	slice( 
		AShaftBottom= 	[ShaftX(i/steps),				ShaftY(i/steps),				ShaftZ(i/steps)				],
		AShaftTop= 	[ShaftX((i+stepsPerTurn)/steps),	ShaftY((i+stepsPerTurn)/steps),	ShaftZ((i+stepsPerTurn)/steps)	],
		BShaftBottom= 	[ShaftX((i+1)/steps),			ShaftY((i+1)/steps),			ShaftZ((i+1)/steps)			],
		BShaftTop= 	[ShaftX((i+1+stepsPerTurn)/steps),	ShaftY((i+1+stepsPerTurn)/steps),	ShaftZ((i+1+stepsPerTurn)/steps)	],
		ABottom= 		[X(i/steps),					Y(i/steps),					Z(i/steps)					],
		ATop= 		[X((i+stepsPerTurn)/steps),		Y((i+stepsPerTurn)/steps),		Z((i+stepsPerTurn)/steps)		],
		BBottom= 		[X((i+1)/steps),				Y((i+1)/steps),				Z((i+1)/steps)				],
		BTop= 		[X((i+1+stepsPerTurn)/steps),		Y((i+1+stepsPerTurn)/steps),		Z((i+1+stepsPerTurn)/steps)		],
		
		AThreadDepth= 	min(min(i,steps-i)/stepsPerTurn/startLength,1)*threadHeight(i), 
		AThreadRatio= 	min(min(i,steps-i)/stepsPerTurn/startLength,1)*profileRatio(i),
		AThreadPosition= 	threadPosition(i),
		AThreadAngle= 	threadAngle(i),
		
		BThreadDepth= 	min(min(i+1,steps-i-1)/stepsPerTurn/startLength,1)*threadHeight(i+1),
		BThreadRatio= 	min(min(i+1,steps-i-1)/stepsPerTurn/startLength,1)*profileRatio(i+1),
		BThreadPosition= 	threadPosition(i),
		BThreadAngle= 	threadAngle(i+1),
		showVertices=showVertices
		);
	}

	if (RH==false)
	mirror([0,1,0])
	for (i=[0:steps-1])
	{
	slice( 
		AShaftBottom= 	[ShaftX(i/steps),				ShaftY(i/steps),				ShaftZ(i/steps)				],
		AShaftTop= 	[ShaftX((i+stepsPerTurn)/steps),	ShaftY((i+stepsPerTurn)/steps),	ShaftZ((i+stepsPerTurn)/steps)	],
		BShaftBottom= 	[ShaftX((i+1)/steps),			ShaftY((i+1)/steps),			ShaftZ((i+1)/steps)			],
		BShaftTop= 	[ShaftX((i+1+stepsPerTurn)/steps),	ShaftY((i+1+stepsPerTurn)/steps),	ShaftZ((i+1+stepsPerTurn)/steps)	],
		ABottom= 		[X(i/steps),					Y(i/steps),					Z(i/steps)					],
		ATop= 		[X((i+stepsPerTurn)/steps),		Y((i+stepsPerTurn)/steps),		Z((i+stepsPerTurn)/steps)		],
		BBottom= 		[X((i+1)/steps),				Y((i+1)/steps),				Z((i+1)/steps)				],
		BTop= 		[X((i+1+stepsPerTurn)/steps),		Y((i+1+stepsPerTurn)/steps),		Z((i+1+stepsPerTurn)/steps)		],
		
		AThreadDepth= 	min(min(i,steps-i)/stepsPerTurn/startLength,1)*threadHeight(i), 
		AThreadRatio= 	min(min(i,steps-i)/stepsPerTurn/startLength,1)*profileRatio(i),
		AThreadPosition= 	threadPosition(i),
		AThreadAngle= 	threadAngle(i),
		
		BThreadDepth= 	min(min(i+1,steps-i-1)/stepsPerTurn/startLength,1)*threadHeight(i+1),
		BThreadRatio= 	min(min(i+1,steps-i-1)/stepsPerTurn/startLength,1)*profileRatio(i+1),
		BThreadPosition= 	threadPosition(i),
		BThreadAngle= 	threadAngle(i+1),
		showVertices=showVertices
		);
	}

	rotate([0,0,180/stepsPerTurn])
	cylinder(
		h=pitch,
		r1=0.999*pitchRadius-(0.5+clearance)*pitch*threadHeightToPitch,
		r2=0.999*pitchRadius-(0.5+clearance)*pitch*threadHeightToPitch,$fn=stepsPerTurn);

	translate([0,0,length-pitch])
	rotate([0,0,180/stepsPerTurn])
	cylinder(
		h=pitch,
		r1=0.999*pitchRadius-(0.5+clearance)*pitch*threadHeightToPitch,
		r2=0.999*pitchRadius-(0.5+clearance)*pitch*threadHeightToPitch,$fn=stepsPerTurn);
}

module trapezoidThreadNegativeSpace(
	length=45,				// axial length of the threaded rod
	pitch=10,				// axial distance from crest to crest
	pitchRadius=10,			// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=30,			// angle between the two faces of the thread
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0,			// depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.1,			// radial clearance, normalized to thread height
	backlash=0.1,			// axial clearance, normalized to pitch
	stepsPerTurn=24			// number of slices to create per turn
		)
{

	translate([0,0,-countersunk*pitch])	
	cylinder(
		h=2*countersunk*pitch, 
		r2=pitchRadius+clearance*pitch+0.25*pitch,
		r1=pitchRadius+clearance*pitch+0.25*pitch+2*countersunk*pitch,
		$fn=24
			);

	translate([0,0,countersunk*pitch])	
	translate([0,0,-pitch])
	trapezoidThread(
		length=length+2*pitch, 				// axial length of the threaded rod 
		pitch=pitch, 					// axial distance from crest to crest
		pitchRadius=pitchRadius+clearance*pitch, 	// radial distance from center to mid-profile
		threadHeightToPitch=threadHeightToPitch, 	// ratio between the height of the profile and the pitch 
									// std value for Acme or metric lead screw is 0.5
		profileRatio=profileRatio, 			// ratio between the lengths of the raised part of the profile and the pitch
									// std value for Acme or metric lead screw is 0.5
		threadAngle=threadAngle,			// angle between the two faces of the thread
									// std value for Acme is 29 or for metric lead screw is 30
		RH=RH, 						// true/false the thread winds clockwise looking along shaft
									// i.e.follows  Right Hand Rule
		clearance=-clearance,				// radial clearance, normalized to thread height
		backlash=-backlash, 				// axial clearance, normalized to pitch
		stepsPerTurn=stepsPerTurn 			// number of slices to create per turn
			);	

	translate([0,0,length-countersunk*pitch])
	cylinder(
		h=2*countersunk*pitch, 
		r1=pitchRadius+clearance*pitch+0.25*pitch,
		r2=pitchRadius+clearance*pitch+0.25*pitch+2*countersunk*pitch,$fn=24,
		$fn=24
			);
}

module trapezoidNut(
	length=45,				// axial length of the threaded rod
	radius=25,				// outer radius of the nut
	pitch=10,				// axial distance from crest to crest
	pitchRadius=10,			// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=30,			// angle between the two faces of the thread
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0,			// depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.1,			// radial clearance, normalized to thread height
	backlash=0.1,			// axial clearance, normalized to pitch
	stepsPerTurn=24			// number of slices to create per turn
		)
{
	difference() 
	{
		cylinder(
			h=length,
			r1=radius, 
			r2=radius,
			$fn=6
				);
		
		trapezoidThreadNegativeSpace(
			length=length, 					// axial length of the threaded rod 
			pitch=pitch, 					// axial distance from crest to crest
			pitchRadius=pitchRadius, 			// radial distance from center to mid-profile
			threadHeightToPitch=threadHeightToPitch, 	// ratio between the height of the profile and the pitch 
										// std value for Acme or metric lead screw is 0.5
			profileRatio=profileRatio, 			// ratio between the lengths of the raised part of the profile and the pitch
										// std value for Acme or metric lead screw is 0.5
			threadAngle=threadAngle,			// angle between the two faces of the thread
										// std value for Acme is 29 or for metric lead screw is 30
			RH=true, 						// true/false the thread winds clockwise looking along shaft
										// i.e.follows  Right Hand Rule
			countersunk=countersunk,			// depth of 45 degree countersunk entries, normalized to pitch
			clearance=clearance, 				// radial clearance, normalized to thread height
			backlash=backlash, 				// axial clearance, normalized to pitch
			stepsPerTurn=stepsPerTurn 			// number of slices to create per turn
				);	
	}
}