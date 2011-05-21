rotX=-45;
rotY=20;
rotZ=90;

large=40;
endScale=1;
height=large;

steps=40;

module horn(endScale,height,rot_x,rot_y,rot_z)
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
			scale(1-endScale*i/steps)
			child(0);
		}
	}
}

translate([0,-large*cos(rotX)/2,0])
rotate([-rotX,0,0])
union()
{
	horn(endScale,height,rotX,rotY,rotZ)
	square(large,true);
	
	mirror([0,0,1])
	horn(endScale,large/2,0,0,0)
	square(large,true);
}

translate([0,large*cos(rotX)/2,0])
rotate([-rotX,0,180])
union()
{
	horn(endScale,height,rotX,-rotY,-rotZ)
	square(large,true);

	mirror([0,0,1])
	horn(endScale,large/2,0,0,0)
	square(large,true);
}