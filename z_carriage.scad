include <config.scad>

use <extra/bearing.scad>

module z_carriage(assembly=false) {
	
	bed_ypos = -(z_carriage_arm+(z_carriage_arm_max-z_carriage_arm)/2);
	
	
	rotate([0,180,0]) {
	
	color(abs)
	difference() {	
		union() {
			for(i=[-1,1])
				translate([z_shaft_distance/2*i,0,0]) {
					hull() {			//long arm
						press_fit(d=z_d+wall*2, h=z_l/2*2);
						translate([0,bed_ypos,0])
							press_fit(d=z_d+wall*2, h=z_l);;
					}
					hull() {			//side rivet
						press_fit(d=z_d+wall*2*2, h=wall*2);
						press_fit(d=z_d+wall*2, h=wall*4);
					}
				}
			
			hull()						//body
				for(i=[-1,1])
					translate([z_shaft_distance/2*i,0,0])
						press_fit(d=z_d+wall*2, h=z_l);
						
			press_fit(d=22+wall*2, h=z_l);	
			hull() {					//body rivet
				press_fit(d=22+wall*2*2, h=wall*2);
				press_fit(d=22+wall*2, h=wall*2*2);
			}
		}
		
		*for(i=[-1,1])					//holes
			translate([(22/2+wall+(z_shaft_distance/2-22/2-wall*2-z_d/2)/2)*i,0,z_l/2-e/4])
				#cube([(z_shaft_distance/2-22/2-wall*2-z_d/2), z_d, z_l+e], center=true);
		
		
		translate([0,0,z_l])			//central arc
			scale([z_shaft_distance-z_d-wall*2,50,z_l]/50)
				rotate([90,0,0])
					cylinder(d=50, h=22+wall*2+e, $fn=66, center=true);
		
		for(i=[-1,1])					//bearing holes
			translate([z_shaft_distance/2*i,0,-e/2])
				press_fit(d=z_d, h=z_l+e);
		
		translate([0,0,-e])			//central hole
			press_fit(d=22, h=z_l/2-wall*2-3.5+e);
		translate([0,0,z_l/2-3.5])
			press_fit(d=22, h=z_l/2);
		translate([0,0,-e/2])
			press_fit(d=10.2, h=z_l+e);
		rotate([0,0,45])
			for(i=[-1,1]) for(j=[-1,1])
				translate([16/2*i/sqrt(2),16/2*j/sqrt(2),-e])
					cylinder(d=BOLT_D[3], z_l);
		
			//arc
		translate([0,bed_ypos-z_d/2-wall,z_l])
			scale([1, -(bed_ypos)/50, (z_l-wall*2)/50])
				rotate([0,90,0])
					cylinder(d=100, h=z_shaft_distance+z_d+wall*2+e, $fn=100, center=true);
					
		for(i=[-1,1]) {					//slim down
			translate([z_shaft_distance/2*i,bed_ypos/4,-e/2])
				hull()
					for(j=[-1,1])
						translate([0,-bed_ypos/4-z_d-wall,0]*j)
							press_fit(d=z_d, h=z_l+e);
			translate([z_shaft_distance/2*i,bed_ypos/4*3,-e/2])
				hull()
					for(j=[-1,1])
						translate([0,-bed_ypos/4-z_d-wall,0]*j)
							press_fit(d=z_d, h=z_l+e);
		}
		
		for(i=[-1,1])				//screw holes				
			translate([z_shaft_distance/2*i, bed_ypos/2, wall*2]) {
				press_fit(d=z_d, h=z_l);
				translate([0,0,-wall]) {
					cylinder(d=NUT_D[3], h=wall+e, $fn=6);
					translate([0,0,-wall-e/2])
						cylinder(d=BOLT_D[3], h=wall+e);
				}
				translate([0,bed_ypos/2,0]) {
					press_fit(d=z_d, h=z_l);
					translate([0,0,-wall-e/2]) {
						cylinder(d=NUT_D[3], h=wall+e, $fn=6);
						translate([0,0,-wall-e/2])
							cylinder(d=BOLT_D[3], h=wall+e);
					}
				}
			}
	}
	
		if (assembly) {
			
			color(heatbed)
			translate([0,bed_ypos,-3-2/2])
				cube([bed_x,bed_y,2], center=true);
			
			color(mdf)
			translate([0,bed_ypos-(bed_y-(bed_y/2-bed_ypos-NEMA_F[z_motor]/2))/2,-3/2])
				cube([bed_x, bed_y/2-bed_ypos-NEMA_F[z_motor]/2, 3], center=true);
	
			for(i=[-1,1])					//bearing
				translate([z_shaft_distance/2*i,0,0])
					bearing(od=z_d, id=z_s, l=z_l);
		}
	}
}

z_carriage(assembly=true);


