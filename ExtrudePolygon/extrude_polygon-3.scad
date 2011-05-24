scale=1;

numberTurns=5;

steps=24*numberTurns;

module slice(Xa, Ya, Za, Xb, Yb, Zb, radiusa, radiusb)
{	
	angleZ=atan2(Ya, Xa);
	twistZ=atan2(Yb, Xb)-atan2(Ya, Xa);

	polyPoints=[
		[Xa+ radiusa*cos(+angleZ),		Ya+ radiusa*sin(+angleZ),		Za ],
		[Xa ,						Ya ,						Za+ radiusa*sin(15) ],
		[Xa ,						Ya ,						Za+ radiusa*sin(-15) ],
	
		[Xb+ radiusb*cos(angleZ+twistZ),	Yb+ radiusb*sin(angleZ+twistZ),	Zb ],
		[Xb ,						Yb ,						Zb+ radiusb*sin(15) ],
		[Xb ,						Yb ,						Zb+ radiusb*sin(-15)] ];
	
	polyTriangles=[
		[ 0, 2, 1 ],
	
		[ 3, 2, 0], [ 2, 3, 5],
	
		[ 4, 0, 1], [ 0, 4, 3],
	
		[ 5, 1, 2], [ 1, 5, 4],
	
		[ 3, 4, 5 ]
		 ];
	
	color([(radiusa)/24/scale,(radiusa)/24/scale,(radiusa)/24/scale])
	polyhedron( polyPoints, polyTriangles );
}

function 	size(i)=	24*scale*(0.1+0.9*sin(i*180));

function 	X(i)=		scale*(size(i))*cos(i*360*numberTurns);
function 	Y(i)=		scale*(size(i))*sin(i*360*numberTurns);
function 	Z(i)=		scale*15*numberTurns*i;

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
			radiusb=	size((i+1)/steps)
			);
	}
}


corkscrew();