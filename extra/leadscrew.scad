include <../config.scad>

module leadscrew(l, d, pitch, d_rod, start, center=false) {
	
	twist=360*l/pitch;
	
	rotate([0,0,z*360*start/pitch])
	color(leadscrew) {
	
		for(i=[1:1:start])
			rotate([0,0,360/start*i])
				linear_extrude(height = l, center = center, twist = twist)  
					translate([d/2-(d-d_rod)/4,0,0])
						square([(d-d_rod)/2,e], center=true);
	
		cylinder(d=d_rod, h=l, center=center);
	}
}

leadscrew(l=200, d=8, d_rod=7, pitch=4, d_rod=7, start=2, center=true);
