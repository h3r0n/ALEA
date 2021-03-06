include <config.scad>

use <frame_top.scad>
use <frame_bottom.scad>
use <z_carriage.scad>
use <extra/leadscrew.scad>

module assembly() {

	translate([0,0,f_z/2+z_h/2+z_h_extra])
		frame_top(assembly=true);
	
	color(th_rods)
	for(i=[-1,1]) for(j=[-1,1])	
		translate([(f_x-f_t)/2*i, (f_y-f_t)/2*j, z_h_extra/2])
			cylinder(d=BOLT_D[f_tr], h=z_h+z_h_extra, center=true);
	
	translate([0,ab_motor_ypos,z])
		z_carriage(assembly=true);
	
	translate([0,0,-(z_l+f_t)/2-z_h/2]) {
		frame_bottom(assembly=true);
		
	color(shaft)
		for(i=[-1,1]) 
			translate([z_shaft_distance/2*i,ab_motor_ypos,-(z_l+f_t)/2])
				cylinder(d=z_s, h=z_h+z_h_extra+f_t*2+z_l);
				
	translate([0,ab_motor_ypos,-(z_l+f_t)/2])
		leadscrew(d=8, d_rod=7, pitch=8, start=4, l=z_h+z_h_extra+f_t*2+z_l);
	
	}
}

assembly();
