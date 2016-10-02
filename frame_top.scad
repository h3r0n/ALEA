include <config.scad>;

use <x_carriage.scad>
use <y_carriage.scad>

//$t=.35;
x=50*cos($t*360);
y=35;//*sin($t*360);

module frame(ghosts=false) {

	difference() {
	
		cube([f_x, f_y, f_z], center=true);		//body
	
	
		cube([f_x-f_t*2, f_y-f_t*2, f_z+e], center=true);
		
		for(i=[-1,1]) for (j=[-1,1])	//threaded rods holes z
			translate([(f_x-f_t)*i,(f_y-f_t)*j]/2)
				cylinder(d=BOLT_D[f_tr],h=f_z+e,center=true);
		
		for(i=[-1,1]) for (k=[-1,1])	//y keepout
			translate([(f_x/2-f_t-y_sp)*i, -f_y/2+f_t, y_shaft_distance*k/2])
				rotate([-90,0,0])
					cylinder(d=y_d+wall*2+fy_ko*2, h=f_y-f_t*2-NEMA_F[ab_motor]);
		
		for(i=[-1,1]) for (k=[-1,1])	//y shaft holes
			translate([(f_x/2-f_t-y_sp)*i, 0, y_shaft_distance*k/2])
				rotate([-90,0,0])
					cylinder(d=y_s, h=f_y+e, center=true);
					
		for(i=[-1,1]) for (j=[-1,1])				//pulley holes
			translate([(f_x/2-f_t-y_sp-idler_d/2)*i, -(f_y-f_t)/2, pulley_d/2*j])
				cube([idler_d+idler_hk, f_t+e, idler_l+idler_vk], center=true);
		
		for(i=[-1,1])					//pulley holes
			translate([(f_x/2-f_t-y_sp-idler_d/2)*i, -(f_y-f_t)/2, 0])
				cylinder(d=BOLT_D[3], h=f_z+e, center=true);
				
		for(j=[-1,1])					//cable holes
			translate([0,f_y,pulley_d*j]/-2)
				rotate([0,90,0])
					cylinder(d=idler_l+idler_vk, h=f_x-f_t*2-y_sp*2, center=true);
	}
	
	color(alpha=.9)
	%if (ghosts) {
	
		for(i=[-1,1]) for (k=[-1,1])	//y shafts
			translate([(f_x/2-f_t-y_sp)*i, 0, y_shaft_distance*k/2])
				rotate([-90,0,0])
					cylinder(d=y_s, h=f_y+e, center=true);
	
		for(i=[-1,1])					//y shafts
			translate([(f_x/2-f_t-y_sp)*i, y, 0])
				scale([-i,1,i])
					y_carriage(ghosts);
	
		translate([x,y,0])
			x_carriage(ghosts=true);
			
		for(i=[-1,1]) 					//ab motors
			translate([(f_x/2-f_t-ab_motor_l/2-y_sp-y_d/2-wall)*i, f_y/2-f_t-NEMA_F[17]/2+(NEMA_F[17]-NEMA_H[17]*2-BOLT_D[3])/2+(f_t-f_tr)/2, 0])
				cube([ab_motor_l, NEMA_F[17], NEMA_F[17]], center=true);
		
		translate([0, f_y/2-f_t-NEMA_F[17]/2+5, 0])
			cube([NEMA_F[17], NEMA_F[17], z_motor_l], center=true);
		
	}
}

frame(ghosts=true);

