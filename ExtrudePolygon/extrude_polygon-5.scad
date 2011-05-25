scale=1.5;

numberTurns=17.5;

stepsPerTurn=24;

steps=stepsPerTurn*numberTurns;

module threadPiece(Xa, Ya, Za, Xb, Yb, Zb, radiusa, radiusb, tipRatioa, tipRatiob)
{	
	angleZ=atan2(Ya, Xa);
	twistZ=atan2(Yb, Xb)-atan2(Ya, Xa);

	threadAngleTop=15;
	threadAngleBottom=-15;

	polyPoints=[
		[Xa+ radiusa*cos(+angleZ),		Ya+ radiusa*sin(+angleZ),		Za ],
		[Xa+ radiusa*cos(+angleZ),		Ya+ radiusa*sin(+angleZ),		Za + radiusa*tipRatioa ],
		[Xa ,						Ya ,						Za+ radiusa*(tipRatioa+sin(threadAngleTop)) ],
		[Xa ,						Ya ,						Za ],
		[Xa ,						Ya ,						Za+ radiusa*sin(threadAngleBottom) ],
	
		[Xb+ radiusb*cos(angleZ+twistZ),	Yb+ radiusb*sin(angleZ+twistZ),	Zb ],
		[Xb+ radiusb*cos(angleZ+twistZ),	Yb+ radiusb*sin(angleZ+twistZ),	Zb+ radiusb*tipRatiob ],
		[Xb ,						Yb ,						Zb+ radiusb*(tipRatiob+sin(threadAngleTop)) ],
		[Xb ,						Yb ,						Zb ],
		[Xb ,						Yb ,						Zb+ radiusb*sin(threadAngleBottom)] ];
	
	polyTriangles=[
		[ 0, 1, 6 ], [ 0, 6, 5 ], 					// tip of profile
		[ 1, 7, 6 ], [ 1, 2, 7 ], 					// upper side of profile
		[ 0, 5, 4 ], [ 4, 5, 9 ], 					// lower side of profile
		[ 4, 9, 3 ], [ 9, 8, 3 ], [ 3, 8, 2 ], [ 8, 7, 2 ], 	// back of profile
		[ 0, 4, 3 ], [ 0, 3, 2 ], [ 0, 2, 1 ], 			// a side of profile
		[ 5, 8, 9 ], [ 5, 7, 8 ], [ 5, 6, 7 ]  			// b side of profile
		 ];
	
	polyhedron( polyPoints, polyTriangles );
}

module shaftPiece(Xa, Ya, Za, Xb, Yb, Zb, radiusa, radiusb, tipRatioa, tipRatiob,
			Xc, Yc, Zc, Xd, Yd, Zd, radiusc, radiusd, tipRatioc, tipRatiod)
{	
	angleZ=atan2(Ya, Xa);
	twistZ=atan2(Yb, Xb)-atan2(Ya, Xa);

	threadAngleTop=15;
	threadAngleBottom=-15;

	shaftRatio=0.5;

	polyPoints1=[
		[Xa,						Ya,						Za + radiusa*sin(threadAngleBottom) ],
		[Xa,						Ya,						Za + radiusa*(tipRatioa+sin(threadAngleTop)) ],
		[Xa*shaftRatio,				Ya*shaftRatio ,				Za + radiusa*(tipRatioa+sin(threadAngleTop)) ],
		[Xa*shaftRatio ,				Ya*shaftRatio ,				Za ],
		[Xa*shaftRatio ,				Ya*shaftRatio ,				Za + radiusa*sin(threadAngleBottom) ],
	
		[Xb,						Yb,						Zb + radiusb*sin(threadAngleBottom) ],
		[Xb,						Yb,						Zb + radiusb*(tipRatiob+sin(threadAngleTop)) ],
		[Xb*shaftRatio ,				Yb*shaftRatio ,				Zb + radiusb*(tipRatiob+sin(threadAngleTop)) ],
		[Xb*shaftRatio ,				Yb*shaftRatio ,				Zb ],
		[Xb*shaftRatio ,				Yb*shaftRatio ,				Zb + radiusb*sin(threadAngleBottom) ] ];
	
	polyTriangles1=[
		[ 0, 1, 6 ], [ 0, 6, 5 ], 					// tip of profile
		[ 1, 7, 6 ], [ 1, 2, 7 ], 					// upper side of profile
		[ 0, 5, 4 ], [ 4, 5, 9 ], 					// lower side of profile
		[ 3, 4, 9 ], [ 9, 8, 3 ], [ 2, 3, 8 ], [ 8, 7, 2 ], 	// back of profile
		[ 0, 4, 3 ], [ 0, 3, 2 ], [ 0, 2, 1 ], 			// a side of profile
		[ 5, 8, 9 ], [ 5, 7, 8 ], [ 5, 6, 7 ]  			// b side of profile
		 ];
	
	polyPoints2=[
		[Xa,						Ya,						Za + radiusa*(tipRatioa+sin(threadAngleTop)) ],
		[Xc,						Yc,						Zc + radiusc*sin(threadAngleBottom) ],
		[Xc*shaftRatio ,				Yc*shaftRatio ,				Zc + radiusc*sin(threadAngleBottom) ],
		[Xa*shaftRatio ,				Ya*shaftRatio ,				Za + radiusa*(tipRatioa+sin(threadAngleTop)) ],
		[Xa*shaftRatio ,				Ya*shaftRatio ,				Za + radiusa*(tipRatioa+sin(threadAngleTop)) ],
	
		[Xb,						Yb,						Zb + radiusb*(tipRatiob+sin(threadAngleTop)) ],
		[Xd,						Yd,						Zd + radiusd*sin(threadAngleBottom) ],
		[Xd*shaftRatio ,				Yd*shaftRatio ,				Zd + radiusd*sin(threadAngleBottom) ],
		[Xb*shaftRatio ,				Yb*shaftRatio ,				Zb + radiusb*(tipRatiob+sin(threadAngleTop)) ],
		[Xb*shaftRatio ,				Yb*shaftRatio ,				Zb + radiusb*(tipRatiob+sin(threadAngleTop)) ] ];
	
	polyTriangles2=[
		[ 0, 1, 6 ], [ 0, 6, 5 ], 					// tip of profile
		[ 1, 7, 6 ], [ 1, 2, 7 ], 					// upper side of profile
		[ 0, 5, 4 ], [ 4, 5, 9 ], 					// lower side of profile
		[ 3, 4, 9 ], [ 9, 8, 3 ], [ 2, 3, 8 ], [ 8, 7, 2 ], 	// back of profile
		[ 0, 4, 3 ], [ 0, 3, 2 ], [ 0, 2, 1 ], 			// a side of profile
		[ 5, 8, 9 ], [ 5, 7, 8 ], [ 5, 6, 7 ]  			// b side of profile
		 ];

	// this is the back of the raised part of the profile
	polyhedron( polyPoints1, polyTriangles1 );

	// this is the back of the low part of the profile
	polyhedron( polyPoints2, polyTriangles2 );
}

function 	size(i)=	2*scale*(0.2+0.8*abs(cos(i*360)));

function 	X(i)=		2*scale*(size(i))*cos(i*360*numberTurns);
function 	Y(i)=		2*scale*(size(i))*sin(i*360*numberTurns);
function 	Z(i)=		3*scale*numberTurns*i;

function	tip(i)=	0.5;

module thread()
{
	for (i=[0:steps-1])
	{
		threadPiece(
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

		shaftPiece(
			Xa=		X(i/steps),
			Ya=		Y(i/steps),
			Za=		Z(i/steps),
			Xb=		X((i+1)/steps),
			Yb=		Y((i+1)/steps), 
			Zb=		Z((i+1)/steps), 
			radiusa=	size(i/steps), 
			radiusb=	size((i+1)/steps),
			tipRatioa=	tip(i/steps),
			tipRatiob=	tip((i+1)/steps),
			Xc=		X((i+stepsPerTurn)/steps),
			Yc=		Y((i+stepsPerTurn)/steps),
			Zc=		Z((i+stepsPerTurn)/steps),
			Xd=		X((i+stepsPerTurn+1)/steps),
			Yd=		Y((i+stepsPerTurn+1)/steps), 
			Zd=		Z((i+stepsPerTurn+1)/steps),
			radiusc=	size((i+stepsPerTurn)/steps), 
			radiusd=	size((i+stepsPerTurn+1)/steps),
			tipRatioc=	tip((i+stepsPerTurn)/steps),
			tipRatiod=	tip((i+stepsPerTurn+1)/steps)
			);
	}
}

translate([0,0,-Z(1)/2])
thread();