
difference()
{
	import_stl("LeadScrew_fixed.stl");

	translate([0,0,-10])
	cube(100);

	translate([0,0,-10])
	rotate([0,0,90])
	cube(100);
}