rotX=0;
rotY=0;
rotZ=90;

large=40;
height=large;

steps=160;

function scaleFunction(i)=abs(1*sin(i/steps*180))+0.2;

module horn(height,rot_x,rot_y,rot_z)
{
	union()
	{
		for (i=[0:steps-1])
		{
			rotate([i*rot_x/steps,i*rot_y/steps,0])
			translate([0,0,i*height/steps])
			rotate([0,0,i*rot_z/steps])
			linear_extrude(
				height = 2.2*(height/steps+(i*height/steps)*sin(max(rot_x,rot_y)/steps)), 
				center = true, 
				convexity = 10,
				twist = -rot_z/steps)
			scale(scaleFunction(i))
			child(0);
		}
	}
}


horn(height,rotX,rotY,rotZ)
union()
{
	rotate([0,0,45])
	square(large/2,true);

	square([large,large/10]);

	rotate([0,0,90])
	square([large,large/10]);

	rotate([0,0,180])
	square([large,large/10]);

	rotate([0,0,270])
	square([large,large/10]);
}
