include <config.scad>

module frame_bottom(ghosts=true) {
	
	difference() {
		
		union() {
			cube([f_x,f_y,z_l+f_t], center=true);			
		}
		
		
		translate([0,0,f_t/2+e/2])
			intersection() {
				cube([f_x-wall*2, f_y-wall*2, z_l+e], center=true);
				cylinder(r=sqrt(pow(f_x/2,2)+pow(f_y/2,2))-f_t*sqrt(2), h=z_l+e*2, center=true);
			}
		translate([0,0,-z_l/2])
			difference() {
				intersection() {
					cube([f_x-f_t*2,f_y-f_t*2,f_t+e], center=true);
					cylinder(r=sqrt(pow(f_x/2,2)+pow(f_y/2,2))-f_t*2, h=f_t+e*2, center=true);
				}
				
				for(i=[-1,1])					//z shaft holder
				translate([z_shaft_distance/2*i, 0, 0])
					difference() {
						translate([0,f_y/2-(f_y/2-ab_motor_ypos+z_s/2+wall)/2,0])
							cube([z_s+wall*2, f_y/2-ab_motor_ypos+z_s/2+wall, (f_z-NEMA_F[ab_motor])/2], center=true);
						translate([0,ab_motor_ypos,0])
							press_fit(d=z_s, h=(f_z-NEMA_F[ab_motor])/2+e, center=true);
					}
			}
		
		for(i=[-1,1]) for (j=[-1,1])
			translate([(f_x-f_t)*i/2,(f_y-f_t)*j/2,0])
				press_fit(d=BOLT_D[f_tr], h=z_l+f_t+e, center=true);
				
		
	}
	
	%if(ghosts)
		for(i=[-1,1]) for (j=[-1,1])	//y shafts
			translate([(f_x-f_t)/2*i, (f_y-f_t)/2*j, 0])
				cylinder(d=f_tr, h=z_l+f_t, center=true);
	
}

frame_bottom(ghosts=true);


