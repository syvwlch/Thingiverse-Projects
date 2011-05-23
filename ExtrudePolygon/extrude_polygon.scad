scale=2.5;

steps=72;

module slice(Xa, Ya, Za, Xb, Yb, Zb, radiusa, radiusb, bend)
{	
	angleZ=atan2(Ya, Xa);
	twistZ=atan2(Yb, Xb)-atan2(Ya, Xa);

	polyPoints=[
		[Xa,						Ya,					Za ],
		[Xa+ radiusa*cos(30+angleZ),		Ya+ radiusa*sin(30+angleZ),	Za ],
		[Xa+ radiusa*cos(-30+angleZ),	Ya+ radiusa*sin(-30+angleZ),	Za ],
	
		[Xb,							Yb,							Zb ],
		[Xb+ radiusb*cos(30+angleZ+twistZ),	Yb+ radiusb*sin(30+angleZ+twistZ),		Zb+ radiusb*sin(bend) ],
		[Xb+ radiusb*cos(-30+angleZ+twistZ),	Yb+ radiusb*sin(-30+angleZ+twistZ),	Zb+ radiusb*sin(bend)] ];
	
	polyTriangles=[
		[ 0, 2, 1 ],
	
		[ 3, 2, 0], [ 2, 3, 5],
	
		[ 4, 0, 1], [ 0, 4, 3],
	
		[ 5, 1, 2], [ 1, 5, 4],
	
		[ 3, 4, 5 ]
		 ];
	
	polyhedron( polyPoints, polyTriangles );
}

function 	X(i)=		4*cos(i*360);
function 	Y(i)=		12*sin(i*180);
function 	Z(i)=		40*i;
function 	size(i)=	18*scale*cos(i*90);

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
			bend=	0
			);
	
		rotate([180,0,0])
		slice(
			Xa=		X(i/steps),
			Ya=		Y(i/steps),
			Za=		Z(i/steps),
			Xb=		X((i+1)/steps),
			Yb=		Y((i+1)/steps), 
			Zb=		Z((i+1)/steps), 
			radiusa=	size(i/steps), 
			radiusb=	size((i+1)/steps),
			bend=	0
			);
	}
}

corkscrew();