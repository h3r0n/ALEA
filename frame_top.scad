include <config.scad>

use <x_carriage.scad>
use <y_carriage.scad>
use <pulley.scad>
use <z_carriage.scad>


module frame_top(ghosts=false) {

	difference() {
	
		union() {
		
			difference() {
				cube([f_x, f_y, f_z], center=true);		//body
				cube([f_x-f_t*2, f_y-f_t*2, f_z+e], center=true);
			}
			
			for(i=[-1,1]) for (j=[-1,1])				//ab motors mounts
				translate([(f_x/2-(f_x/2-ab_motor_xpos+ab_motor_l/3)/2)*i, ab_motor_ypos+NEMA_H[ab_motor]*j, 0]) {
					cube([f_x/2-ab_motor_xpos+ab_motor_l/3, BOLT_D[3]+wall*2, f_z], center=true);
				}
				
			translate([0, ab_motor_ypos, -z_motor_l/2]) //z motor mount
				cube([NEMA_H[z_motor]*2+wall*2, NEMA_H[z_motor]*2+wall*2, f_z-z_motor_l], center=true);
				
			for(i=[-1,1])					//z shaft holder
				translate([z_shaft_distance/2*i, f_y/2-(f_y/2-ab_motor_ypos+z_s/2+wall)/2, -f_z/2+(f_z-NEMA_F[ab_motor])/4])
					cube([z_s+wall*2, f_y/2-ab_motor_ypos+z_s/2+wall, (f_z-NEMA_F[ab_motor])/2], center=true);
		}
		
		for(i=[-1,1]) for (j=[-1,1])	//threaded rods holes z
			translate([(f_x-f_t)*i,(f_y-f_t)*j]/2)
				press_fit(d=BOLT_D[f_tr],h=f_z+e,center=true);
		
		for(i=[-1,1]) for (k=[-1,1])	//y keepout
			translate([(f_x/2-f_t-y_sp)*i, -f_y/2+f_t, y_shaft_distance*k/2])
				rotate([-90,0,0])
					press_fit(d=y_d+wall*2+fy_ko*2, h=f_y/2-f_t+ab_motor_ypos-NEMA_F[ab_motor]/2);
		
		for(i=[-1,1]) for (k=[-1,1])	//y shaft holes
			translate([(f_x/2-f_t-y_sp)*i, 0, y_shaft_distance*k/2])
				rotate([-90,0,0])
					press_fit(d=y_s, h=f_y+e, center=true);
					
		for(i=[-1,1]) for (j=[-1,1])				//pulley holes
			translate([(f_x/2-f_t-y_sp-idler_d/2)*i, -(f_y-f_t)/2, pulley_d/2*j])
				cube([idler_d+idler_hk, f_t+e, idler_l+idler_vk], center=true);
		
		for(i=[-1,1])					//pulley holes
			translate([(f_x/2-f_t-y_sp-idler_d/2)*i, -(f_y-f_t)/2, 0])
				press_fit(d=BOLT_D[3], h=f_z+e, center=true);
				
		for(j=[-1,1])					//cable holes
			translate([0,f_y,pulley_d*j]/-2)
				rotate([0,90,0])
					cylinder(d=idler_l+idler_vk, h=f_x-f_t*2-y_sp*2, center=true);
		
		for(i=[-1,1]) 						//ab motors housing
			translate([(ab_motor_xpos-ab_motor_l/2)*i, ab_motor_ypos, 0])
				hull() {
					cube([ab_motor_l, NEMA_F[ab_motor], NEMA_F[ab_motor]], center=true);
					translate([0,0,f_z/2])
						cube([ab_motor_l, NEMA_F[ab_motor], NEMA_F[ab_motor]], center=true);	
				}
		
		translate([0, ab_motor_ypos, f_z/2-z_motor_l/2])	//z motor housing
			hull() {
				cube([NEMA_F[z_motor], NEMA_F[z_motor], z_motor_l], center=true);
				translate([0,0,e])
					cube([NEMA_F[z_motor], NEMA_F[z_motor], z_motor_l], center=true);
			}
		
		for(i=[-1,1]) for (j=[-1,1]) for(k=[-1,1])			//ab mount holes
			translate([(f_x/2+e/2)*i, ab_motor_ypos+NEMA_H[ab_motor]*j, NEMA_H[ab_motor]*k])
				rotate([0,-90*i,0])
					press_fit(d=BOLT_D[3], h=f_x/2-ab_motor_xpos+e);
		
		for(i=[-1,1]) 										//pulley holes
			translate([(ab_motor_xpos-e/2)*i,ab_motor_ypos,0])
				rotate([0,90*i,0])
					cylinder(r=NEMA_H[ab_motor]/*d=pulley_diameter+wall*5*/, h=f_x/2-ab_motor_xpos+e);
					
		for(i=[-1,1]) for(k=[-1,1])							//cable holes
			translate([(f_x/2-f_t-y_sp)*i, 0, pulley_d*k/2])
				rotate([90,0,0])
					cylinder(d=3, h=ab_motor_xpos*2, center=true);
		
		translate([0, ab_motor_ypos, -z_motor_l/2]) {		//z motor mount holes
			cylinder(d=NEMA_H[z_motor]*2, h=f_z-z_motor_l+e, center=true);
			for(i=[-1,1]) for (j=[-1,1])
				translate([NEMA_H[z_motor]*i,NEMA_H[z_motor]*j,0])
					press_fit(d=BOLT_D[3], h=f_z-z_motor_l+e, center=true);
		}
		
		for(i=[-1,1])								//z shaft holes
			translate([z_shaft_distance/2*i, ab_motor_ypos, -f_z/2-e/2])
				press_fit(d=z_s, h=(f_z-NEMA_F[ab_motor])/2+e);
	}
	
	color(alpha=.9)			//ghosts
	%if (ghosts) {
	
		for(i=[-1,1]) for (k=[-1,1])	//y shafts
			translate([(f_x/2-f_t-y_sp)*i, 0, y_shaft_distance*k/2])
				rotate([-90,0,0])
					cylinder(d=y_s, h=f_y+e, center=true);
	
		for(i=[-1,1])					//y shafts
			translate([(f_x/2-f_t-y_sp)*i, y, 0])
				scale([-i,1,-i])
					y_carriage(ghosts=true);
	
		translate([x,y,0])
			x_carriage(ghosts=true);
			
		for(i=[-1,1]) 						//ab motors
			translate([(ab_motor_xpos-ab_motor_l/2)*i, ab_motor_ypos, 0])
				cube([ab_motor_l, NEMA_F[ab_motor], NEMA_F[ab_motor]], center=true);
		
		translate([0, ab_motor_ypos, f_z/2-z_motor_l/2])	//z motor
			cube([NEMA_F[z_motor], NEMA_F[z_motor], z_motor_l], center=true);
		
		for(i=[-1,1]) 						//pulleys
			translate([(f_x/2-f_t-y_sp)*i, ab_motor_ypos, 0])
				rotate([0,-90*i,0])
					pulley();
					
		translate([0,ab_motor_xpos,-f_z/2-16.5])
			z_carriage(ghosts=true);
	}
}

frame_top(ghosts=true);

