scale=1.5;

large=5*scale;
height=30*scale;

steps=80;

maxScale=1;
minScale=0.2;

function scaleFunction(i)=maxScale*((1-minScale)*abs(cos(i/(steps-1)*90))+minScale);

maxXrot=10;
maxYrot=10;
maxZrot=10;

function XrotFunction(i)=maxXrot*sin(i/(steps-1)*90);
function YrotFunction(i)=maxYrot*sin(i/(steps-1)*90);
function ZrotFunction(i)=maxZrot*sin(i/(steps-1)*720);

radius=0.3*large;

function XtranFunction(i)=radius*cos(i/(steps-1)*360);
function YtranFunction(i)=radius*sin(i/(steps-1)*360);
function ZtranFunction(i)=height*i/(steps-1);

module functionPlace()
{
	union()
	{
		for (i=[0:steps-1])
		{
			translate([XtranFunction(i),YtranFunction(i),ZtranFunction(i)])
			rotate([XrotFunction(i),YrotFunction(i),ZrotFunction(i)])
			scale(scaleFunction(i))
			child(0);
		}
	}
}

module shape()
{
	sphere(large);
}

module sideShape()
{
	translate([large,0,0])
	rotate([0,72,0])
	rotate_extrude(convexity = 10, $fn = 40)
	translate([2*scale, 0, 0])
	circle(r = 1*scale, $fn = 40);
}


		for (i=[10,26,42,55,65,72,77])
		{
			translate([XtranFunction(i),YtranFunction(i),ZtranFunction(i)])
			rotate([XrotFunction(i),YrotFunction(i),ZrotFunction(i)])
			scale(scaleFunction(i))
			sideShape();
		}

intersection()
{
	functionPlace()
	shape();

	translate([0,0,height])
	cube(2*height,true);
}