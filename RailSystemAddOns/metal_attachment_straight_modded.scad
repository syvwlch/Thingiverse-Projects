joinfactor = 0.125;
goldenratio = 1.61803399;

gMaterialThickness = 1/8*25.4;
gMaterialWidth = 3/4*25.4;

gSleeveLength = 1/2*25.4;

gMountRadius = 2;
gMountWidth = gMountRadius*2*goldenratio*goldenratio;
gMountThickness = 4;

//MountTab(gMountThickness, gMountWidth, gSleeveLength, gMountRadius);
//StraightBlank(gMaterialThickness, gMaterialWidth, 1/2*25.4);
//StraightMount(gMaterialThickness, gMaterialWidth, 1/2*25.4, mountgap=3);
//StraightSlipFit(gMaterialThickness, gMaterialWidth, 1/2*25.4, mountgap=3);
//StraightCap(gMaterialThickness, gMaterialWidth, 1/2*25.4, mountgap=3);

//StraightClip(gMaterialThickness, gMaterialWidth, 1/2*25.4, mountgap=3,clipratio=0.5);
StraightRail(gMaterialThickness, gMaterialWidth, 1/2*25.4, mountgap=3,clipratio=0.5);

//=====================================
// Modules
//=====================================

module MountTab(thickness, width, length, radius)
{
	difference()
	{
		cube(size=[thickness, width, length]);
		
		translate([-joinfactor, width/2, length/2])
		rotate([0, 90, 0])
		cylinder(r=radius, h=thickness+2*joinfactor, $fn=8);
	}
}

module StraightBlank(thickness, width, length)
{
	cube(size=[thickness, width, length]);
}

module StraightMount(thickness, width, length, mountgap=3)
{
	InnerThickness = thickness*1.1;
	InnerWidth = width * 1.02;

	OuterThickness = InnerThickness*goldenratio;
	wallthickness = (OuterThickness - InnerThickness);
	OuterWidth = InnerWidth +wallthickness*2;


	union()
	{
		StraightBlank(OuterThickness, OuterWidth, length);
	
		// Add a straight gap that presses against the wall
		translate([-gMountThickness, -joinfactor, 0])
		cube(size=[gMountThickness, OuterWidth+2*joinfactor, length]);
	
		// Add the mounting tabs
		translate([-gMountThickness, OuterWidth, 0])
		MountTab(gMountThickness, gMountWidth, gSleeveLength, gMountRadius);
	
		translate([-gMountThickness, -gMountWidth, 0])
		MountTab(gMountThickness, gMountWidth, gSleeveLength, gMountRadius);
	}
}

module StraightSlipFit(thickness, width, length, mountgap=3)
{
	InnerThickness = thickness*1.1;
	InnerWidth = width * 1.05;

	OuterThickness = InnerThickness*goldenratio;
	wallthickness = (OuterThickness - InnerThickness);
	OuterWidth = InnerWidth +wallthickness*2;


	difference()
	{
		StraightMount(thickness, width, length, mountgap);

		translate([0, wallthickness, -joinfactor])
		StraightBlank(InnerThickness, InnerWidth, length+2*joinfactor);
	}
}

module StraightCap(thickness, width, length, mountgap=3)
{
	InnerThickness = thickness*1.05;
	InnerWidth = width * 1.05;

	OuterThickness = InnerThickness*goldenratio;
	wallthickness = (OuterThickness - InnerThickness);
	OuterWidth = InnerWidth +wallthickness*2;


	difference()
	{
		StraightMount(thickness, width, length, mountgap);

		translate([0, wallthickness, wallthickness])
		StraightBlank(InnerThickness, InnerWidth, length+2*joinfactor);
	}
}

module StraightClip(thickness, width, length, mountgap=3, clipratio=0.5)
{
	InnerThickness = thickness*1.1;
	InnerWidth = width * 1.05;

	OuterThickness = InnerThickness*goldenratio;
	wallthickness = (OuterThickness - InnerThickness);
	OuterWidth = InnerWidth +wallthickness*2;


	difference()
	{
		StraightMount(thickness, width, length, mountgap);

			translate([0, wallthickness, -joinfactor])
			StraightBlank(InnerThickness, InnerWidth, length+2*joinfactor);

			translate([0, wallthickness+InnerWidth*clipratio, -joinfactor])
			StraightBlank(2*InnerThickness, InnerWidth, length+2*joinfactor);
	}
}

module StraightRail(thickness, width, length, mountgap=3, clipratio=0.5)
{
	InnerThickness = thickness*1.1;
	InnerWidth = width * 1.05;

	OuterThickness = InnerThickness*goldenratio;
	wallthickness = (OuterThickness - InnerThickness);
	OuterWidth = InnerWidth +wallthickness*2;

	union()
	{
		difference()
		{
			StraightMount(thickness, width, length, mountgap);
	
				translate([0, wallthickness, -joinfactor])
				StraightBlank(InnerThickness, InnerWidth, length+2*joinfactor);
	
				translate([-2*thickness, wallthickness+InnerWidth*clipratio, -joinfactor])
				StraightBlank(2*InnerThickness+2*thickness,2* InnerWidth, length+2*joinfactor);
		}
	
		translate([0, 0, width/2])
		difference()
		{
			StraightMount(thickness, width, length, mountgap);
	
				translate([0, wallthickness, -joinfactor])
				StraightBlank(InnerThickness, InnerWidth, length+2*joinfactor);
	
				translate([-2*thickness, wallthickness+InnerWidth*clipratio, -joinfactor])
				StraightBlank(2*InnerThickness+2*thickness,2* InnerWidth, length+2*joinfactor);
		}
	}
}