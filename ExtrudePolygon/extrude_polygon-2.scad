scale=1.1;

steps=72;

module slice(Xa, Ya, Za, Xb, Yb, Zb, radiusa, radiusb)
{	
	angleZ=atan2(Ya, Xa);
	twistZ=atan2(Yb, Xb)-atan2(Ya, Xa);

	angleXY=atan2(Za, Xa+Ya);
	twistXY=atan2(Zb, Xb+Yb)-atan2(Za, Xa+Ya);

	polyPoints=[
		[Xa,						Ya,					Za ],
		[Xa+ radiusa*cos(30+angleZ),		Ya+ radiusa*sin(30+angleZ),	Za+ radiusa*sin(angleXY) ],
		[Xa+ radiusa*cos(-30+angleZ),	Ya+ radiusa*sin(-30+angleZ),	Za+ radiusa*sin(angleXY) ],
	
		[Xb,							Yb,							Zb ],
		[Xb+ radiusb*cos(30+angleZ+twistZ),	Yb+ radiusb*sin(30+angleZ+twistZ),		Zb+ radiusb*sin(angleXY+twistXY) ],
		[Xb+ radiusb*cos(-30+angleZ+twistZ),	Yb+ radiusb*sin(-30+angleZ+twistZ),	Zb+ radiusb*sin(angleXY+twistXY)] ];
	
	polyTriangles=[
		[ 0, 2, 1 ],
	
		[ 3, 2, 0], [ 2, 3, 5],
	
		[ 4, 0, 1], [ 0, 4, 3],
	
		[ 5, 1, 2], [ 1, 5, 4],
	
		[ 3, 4, 5 ]
		 ];
	
	color([(radiusa-1)/5/scale,(radiusa-1)/5/scale,(radiusa-1)/5/scale])
	polyhedron( polyPoints, polyTriangles );
}

function 	X(i)=		scale*(1+30*i)*cos(i*180);
function 	Y(i)=		scale*(1+30*i)*sin(i*180);
function 	Z(i)=		scale*(30*i*i-10*i)*sin(i*720);

function 	size(i)=	1+5*scale*i;

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

for (i=[0:4])
{
	rotate([0,0,i*360/5])
	corkscrew();
}

rotate([180,0,0])
for (i=[0:4])
{
	rotate([0,0,i*360/5])
	corkscrew();
}