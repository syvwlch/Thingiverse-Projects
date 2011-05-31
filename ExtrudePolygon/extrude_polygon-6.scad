scale=1;

numberTurns=10;

stepsPerTurn=24;

steps=stepsPerTurn*numberTurns;

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
		[1,0,12], [1,10,9], [1,12,10], [0,14,12], [0,15,14],	// B side of shaft
		[0,8,15], 								// bottom of shaft
		[1,9,2], 								// top of shaft
		[3,2,10], [2,9,10], [4,3,10], [10,11,4],			// top of thread
		[6,4,11], [11,13,6],						// tip of thread
		[7,6,13], [13,14,7], [8,7,14], [14,15,8],			// bottom of thread
		[3,4,5], [5,4,6], [5,6,7],					// A side of thread
		[11,10,12], [11,12,13], [12,14,13]				// B side of thread
		 	];

	if (showVertices==true) for (i=[0:15]) translate(polyPoints[i]) color([1,0.5,0.5]) cube(0.25,true);

	polyhedron( polyPoints, polyTriangles );
}


function 	size(i)=	20*scale*i;

function 	ShaftX(i)=		scale*0*numberTurns*i;
function 	ShaftY(i)=		scale*0*numberTurns*i;
function 	ShaftZ(i)=		scale*10*numberTurns*i;

function 	X(i)=		ShaftX(i)+(size(i))*cos(i*360*numberTurns);
function 	Y(i)=		ShaftY(i)+(size(i))*sin(i*360*numberTurns);
function 	Z(i)=		ShaftZ(i);

module corkscrew()
{
	for (i=[0:steps-1])
	{
slice(
	AShaftBottom=	[ShaftX(i/steps),				ShaftY(i/steps),				ShaftZ(i/steps)				],
	AShaftTop=		[ShaftX((i+stepsPerTurn)/steps),	ShaftY((i+stepsPerTurn)/steps),	ShaftZ((i+stepsPerTurn)/steps)	],
	BShaftBottom=	[ShaftX((i+1)/steps),			ShaftY((i+1)/steps),			ShaftZ((i+1)/steps)			],
	BShaftTop=		[ShaftX((i+1+stepsPerTurn)/steps),	ShaftY((i+1+stepsPerTurn)/steps),	ShaftZ((i+1+stepsPerTurn)/steps)	],
	ABottom=		[X(i/steps),					Y(i/steps),					Z(i/steps)					],
	ATop=		[X((i+stepsPerTurn)/steps),		Y((i+stepsPerTurn)/steps),		Z((i+stepsPerTurn)/steps)		],
	BBottom=		[X((i+1)/steps),				Y((i+1)/steps),				Z((i+1)/steps)				],
	BTop=		[X((i+1+stepsPerTurn)/steps),		Y((i+1+stepsPerTurn)/steps),		Z((i+1+stepsPerTurn)/steps)		],

	AThreadDepth=	min(30*min(i,steps-i)/steps,3),	
	AThreadRatio=	0.5,
	AThreadPosition=	0.25,
	AThreadAngle=	20,

	BThreadDepth=	min(30*min(i+1,steps-i-1)/steps,3),
	BThreadRatio=	0.5,
	BThreadPosition=	0.25,
	BThreadAngle=	20
	);
	}
}


corkscrew();
