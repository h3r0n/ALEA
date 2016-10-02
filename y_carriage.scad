include <standard.scad>		//size of standard components
include <config.scad>		//user configuration
include <math.scad>			//calculations

module y_carriage(ghosts=false) {

	difference() {
		union() {
			for(i=[-1,1])
				translate([0,0,y_shaft_distance]/2*i)
					rotate([90,0,0])
						cylinder(d=y_d+wall*2, h=y_l, center=true);

			translate([(y_d+wall*2)/2,0,0]/2)
				cube([(y_d+wall*2)/2,y_l,y_shaft_distance+x_d+wall*2], center=true);
		}
	
		for(i=[-1,1])
			translate([0,0,y_shaft_distance]/2*i) {
				rotate([90,0,0])
					cylinder(d=y_d, h=y_l+e, center=true);				//bearing holes
				translate([0,0,x_s+y_d]/-2*i)
					rotate([0,90,0])
						cylinder(d=x_s, h=y_d+wall*2+e, center=true);	//x shaft holes
			}
		
		translate([0,0,pulley_d]/2)										//idler holes   
				cube([y_d+wall*2+e, idler_d*2+idler_hk/2*3, idler_l+idler_vk], center=true);
		
		for(i=[-1,1])
			translate([idler_d,(idler_d+idler_hk)*i,0]/2)
				cylinder(d=BOLT_D[3], h=y_shaft_distance+y_d+wall*2+e, center=true);
		
		for(i=[-1,1])													//cable holes
			translate([0,0,pulley_d]/2*i)
				rotate([90,0,0])
					cylinder(d=idler_l+idler_vk, h=y_l+e, center=true);
	}
	
	if (ghosts)
		%translate([0,0,x_shaft_distance/2])
			rotate([0,90,0])
				cylinder(d=y_s, h=f_x-(f_t+y_sp)*2);
	
}

y_carriage();

