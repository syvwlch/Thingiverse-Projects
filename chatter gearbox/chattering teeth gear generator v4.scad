// Copyright 2011 Cliff L. Biffle.
// This file is licensed Creative Commons Attribution-ShareAlike 3.0.
// http://creativecommons.org/licenses/by-sa/3.0/

// You can get this file from http://www.thingiverse.com/thing:3575
include <MCAD/involute_gears.scad>

// Couple handy arithmetic shortcuts
function sqr(n) = pow(n, 2);
function cube(n) = pow(n, 3);

// This was derived as follows:
// In Greg Frost's original script, the outer radius of a spur
// gear can be computed as...
function gear_outer_radius(number_of_teeth, circular_pitch) =
	(sqr(number_of_teeth) * sqr(circular_pitch) + 64800)
		/ (360 * number_of_teeth * circular_pitch);

// We can fit gears to the spacing by working it backwards.
//  spacing = gear_outer_radius(teeth1, cp)
//          + gear_outer_radius(teeth2, cp);
//
// I plugged this into an algebra system, assuming that spacing,
// teeth1, and teeth2 are given.  By solving for circular pitch,
// we get this terrifying equation:

function fit_spur_gears(n1, n2, spacing) =
	(180 * spacing * n1 * n2  +  180
		* sqrt(-(2*n1*cube(n2)-(sqr(spacing)-4)*sqr(n1)*sqr(n2)+2*cube(n1)*n2)))
	/ (n1*sqr(n2) + sqr(n1)*n2);


	n1 = 12; n2 = 6;
	p = fit_spur_gears(n1, n2, 50);
	s = 0.34;

module spring_gear() 
	{
	difference()
		{
		union()
			{	
			scale([s,s,1]) gear (circular_pitch=p,
				gear_thickness = 5,
				rim_thickness = 5,
				rim_width = 0,
				hub_thickness = 0,
				hub_diameter = 0,
				bore_diameter = 0,
			    number_of_teeth = n1);
			translate([0,0,20/2 + 5]) cylinder(20,3.3,3.3,true);
			}
		translate([0,0,2+ 4.5/2 +5]) cube([1.0,10,4.5],true); 
		translate([0,0,5/2 + 20]) cube([10,1.7,5], true);
		}
//	translate([0,0,6]) circle(26/2); 
	}

module cam_gear()
	{
	translate([gear_outer_radius(n1, p) + gear_outer_radius(n2, p),0,5])
	difference()
		{
		union()
			{
			scale([s,s,1]) gear (circular_pitch=p,
				gear_thickness = 5,
				rim_thickness = 5,
				rim_width = 0,
				bore_diameter = 0,
				hub_diameter = 0,
				number_of_teeth = n2,
				rim_width = 0);

			difference() 
				{
				translate([0,0,-2.5]) cylinder(5,15,15, true);
				translate([11.5,0,-1]) cylinder(10,1.5,1.5, true, $fn =20);
				translate([11.5,0,-1.5]) rotate([0,0,30]) hexagon(6, 3);
				translate([0,0,-15]) cylinder(30,7.2/2,7.2/2, true, $fn=15);
				}
			}
		cylinder(30,2,2, true,$fn=15);
		}
//	translate([gear_outer_radius(n1, p) + gear_outer_radius(n2, p),0,10]) circle(15/2); 
	}

	spring_gear();
	cam_gear();