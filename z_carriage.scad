include <config.scad>


module z_carriage() {
	
	rotate([0,180,0])
	
	difference() {	
		union() {
			for(i=[-1,1])
				translate([z_shaft_distance/2*i,0,0]) {
					hull() {			//long arm
						press_fit(d=z_d+wall*2, h=z_l/2*2);
						translate([0,-(z_carriage_arm+bed_y/2),0])
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
						press_fit(d=z_d+wall*2, h=z_l/2);
						
			cylinder(d=22+wall*2, h=z_l/2);	
			hull() {					//body rivet
				cylinder(d=22+wall*2*2, h=wall*2);
				cylinder(d=22+wall*2, h=wall*2*2);
			}
		}
		
		for(i=[-1,1])					//bearing holes
			translate([z_shaft_distance/2*i,0,-e/2])
				press_fit(d=z_d, h=z_l+e);
		
		translate([0,0,-e/2])			//central hole
			cylinder(d=22, h=z_l/2+e);
			
		translate([0,-(z_carriage_arm+bed_y/2),z_l])
			scale([1, (z_carriage_arm+bed_y/2-z_d/2-wall)/50, (z_l-wall*2)/50])
				rotate([0,90,0])
					cylinder(d=100, h=z_shaft_distance+z_d+wall*2+e, center=true);
					
		for(i=[-1,1]) {					//slim down
			translate([z_shaft_distance/2*i,-(z_carriage_arm+bed_y/2)/4,-e/2])
				hull()
					for(j=[-1,1])
						translate([0,(z_carriage_arm+bed_y/2)/4-z_d-wall*2,0]*j)
							press_fit(d=z_d, h=z_l+e);
			translate([z_shaft_distance/2*i,-(z_carriage_arm+bed_y/2)/4*3,-e/2])
				hull()
					for(j=[-1,1])
						translate([0,(z_carriage_arm+bed_y/2)/4-z_d-wall*2,0]*j)
							press_fit(d=z_d, h=z_l+e);
		}
		
		for(i=[-1,1])					
			translate([z_shaft_distance/2*i, -(z_carriage_arm+bed_y/2)/2, wall*2]) {
				press_fit(d=z_d, h=z_l);
				translate([0,-(z_carriage_arm+bed_y/2)/2,0])
					press_fit(d=z_d, h=z_l);
			}
	}
}

z_carriage();


