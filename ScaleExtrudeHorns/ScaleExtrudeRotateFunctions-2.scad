scale=1.5;

large=5*scale;
height=24*scale;

steps=1024;

maxScale=1;

function scaleFunction(i)=maxScale*(0.8*abs(sin(i/(steps-1)*180))+0.2);

maxXrot=90;
maxYrot=90;
maxZrot=90;

function XrotFunction(i)=maxXrot*sin(i/(steps-1)*180);
function YrotFunction(i)=maxYrot*cos(i/(steps-1)*360);
function ZrotFunction(i)=maxZrot*sin(i/(steps-1)*720);

radius=3*large;

function XtranFunction(i)=radius*cos(i/(steps-1)*720);
function YtranFunction(i)=radius*sin(i/(steps-1)*720);
function ZtranFunction(i)=radius*sin(i/(steps-1)*360);

module horn()
{
	union()
	{
		for (i=[0:steps-1])
		{
			translate([XtranFunction(i),YtranFunction(i),ZtranFunction(i)])
			rotate([XrotFunction(i),YrotFunction(i),ZrotFunction(i)])
			linear_extrude(
				height = 12*(height/steps), 
				center = true, 
				convexity = 10,
				twist = 0)
			scale(scaleFunction(i))
			child(0);
		}
	}
}

module shape()
{
	translate([3*scale,3*scale,0])
	square(large);
}


translate([0,0,0])
horn()
union()
{
	rotate([0,0,0])
	shape();

	rotate([0,0,180])
	shape();
}