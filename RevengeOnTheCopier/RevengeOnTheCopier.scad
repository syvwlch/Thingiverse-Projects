folds=5;
angle=20;
offset=4.3;
center=8;
zadjust=1.5;

union()
for (i=[0:folds])
{
	if (i/2==floor(i/2))
	translate([0,i*offset,-i*zadjust])
	rotate( angle , [1,0,0])
	intersection()
	{
		scale([1,0.2,1.5])
		translate([0,center,0])
		import_stl("copier110504ectr_fixed.stl");
	
		translate([-50,-50,60*i/folds])
		cube([100,100,60/folds]);
	}
	
	if (i/2!=floor(i/2))
	translate([0,-i*offset,-i*zadjust])
	rotate( -angle , [1,0,0])
	intersection()
	{
		scale([1,0.2,1.5])
		translate([0,-center,0])
		import_stl("copier110504ectr_fixed.stl");
	
		translate([-50,-50,60*i/folds])
		cube([100,100,60/folds]);
	}
}