
rot=90;

large=40;
small=0;
height=80;

steps=160;

union()
{
	for (i=[0:steps-1])
	{
		translate([large/2,large/2,i*height/steps])
		rotate([0,0,i*rot/steps+180])
		linear_extrude(height = height/steps, center = true, convexity = 10, twist = -rot/steps)
		square(large-(large-small)*i/steps);
	}

	for (i=[0:steps-1])
	{
		translate([-large/2,-large/2,i*height/steps])
		rotate([0,0,i*rot/steps])
		linear_extrude(height = height/steps, center = true, convexity = 10, twist = -rot/steps)
		square(large-(large-small)*i/steps);
	}
}