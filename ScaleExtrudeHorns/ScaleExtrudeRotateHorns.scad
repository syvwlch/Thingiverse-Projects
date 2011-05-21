rotX=-45;
rotY=20;
rotZ=90;

large=40;
small=0;
height=40;

steps=160;

module horn(large,small,height,rot_x,rot_y,rot_z)
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
			square(large-(large-small)*i/steps,true);
		}
	}
}

translate([0,-large*cos(rotX)/2,0])
rotate([-rotX,0,0])
union()
{
	horn(large,small,height,rotX,rotY,rotZ);
	
	mirror([0,0,1])
	horn(large,small,large/2,0,0,0);
}

translate([0,large*cos(rotX)/2,0])
rotate([-rotX,0,180])
union()
{
	horn(large,small,height,rotX,-rotY,-rotZ);

	mirror([0,0,1])
	horn(large,small,large/2,0,0,0);
}