scale=0.9;

numberTurns=5;

steps=24*numberTurns;

module slice(Xa, Ya, Za, Xb, Yb, Zb, radiusa, radiusb, tipRatioa, tipRatiob)
{	
	angleZ=atan2(Ya, Xa);
	twistZ=atan2(Yb, Xb)-atan2(Ya, Xa);

	polyPoints=[
		[Xa+ radiusa*cos(+angleZ),		Ya+ radiusa*sin(+angleZ),		Za ],
		[Xa+ radiusa*cos(+angleZ),		Ya+ radiusa*sin(+angleZ),		Za + radiusa*tipRatioa ],
		[Xa ,						Ya ,						Za+ radiusa*(tipRatioa+sin(15)) ],
		[Xa ,						Ya ,						Za ],
		[Xa ,						Ya ,						Za+ radiusa*sin(-15) ],
	
		[Xb+ radiusb*cos(angleZ+twistZ),	Yb+ radiusb*sin(angleZ+twistZ),	Zb ],
		[Xb+ radiusb*cos(angleZ+twistZ),	Yb+ radiusb*sin(angleZ+twistZ),	Zb+ radiusb*tipRatiob ],
		[Xb ,						Yb ,						Zb+ radiusb*(tipRatiob+sin(15)) ],
		[Xb ,						Yb ,						Zb ],
		[Xb ,						Yb ,						Zb+ radiusb*sin(-15)] ];
	
	polyTriangles=[
		[ 0, 6, 1 ], [ 0, 5, 6 ], 					// tip of profile
		[ 1, 6, 7 ], [ 1, 7, 2 ], 					// upper side of profile
		[ 0, 4, 5 ], [ 4, 9, 5 ], 					// lower side of profile
		[ 4, 3, 9 ], [ 9, 3, 8 ], [ 3, 2, 8 ], [ 8, 2, 7 ], 	// back of profile
		[ 0, 3, 4 ], [ 0, 2, 3 ], [ 0, 1, 2 ], 			// a side of profile
		[ 5, 9, 8 ], [ 5, 8, 7 ], [ 5, 7, 6 ]  			// b side of profile
		 ];
	
	color([(radiusa)/10/scale,(radiusa)/10/scale,(radiusa)/10/scale])
	polyhedron( polyPoints, polyTriangles );
}

function 	size(i)=	10*scale*(0.5+0.5*abs(cos(i*180)));

function 	X(i)=		2*scale*(size(i))*cos(i*360*numberTurns);
function 	Y(i)=		2*scale*(size(i))*sin(i*360*numberTurns);
function 	Z(i)=		scale*15*numberTurns*i;

function	tip(i)=	0.75*abs(cos(i*180));

module corkscrew()
{
	for (i=[0:steps-1])
	{
		slice(
			Xa=		X(i/steps),
			Ya=		Y(i/steps),
			Za=		Z(i/steps),
			Xb=		X((i+1)/steps),
			Yb=		Y((i+1)/steps), 
			Zb=		Z((i+1)/steps), 
			radiusa=	size(i/steps), 
			radiusb=	size((i+1)/steps),
			tipRatioa=	tip(i/steps),
			tipRatiob=	tip((i+1)/steps)
			);
	}
}


corkscrew();

//slice(0,10,0,10,10,5,10,10);