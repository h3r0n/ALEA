include <../config.scad>


module nema(standard,length) {
	
	color(nema_plate) {
		difference() {
			linear_extrude(height=length, center=true)
				intersection() {
					square([NEMA_F[standard], NEMA_F[standard]],center=true);
					circle(d=NEMA_F[standard]*sqrt(2)-7);
				}			
			cube([NEMA_F[standard]*2, NEMA_F[standard]+e, length-8*2], center=true);
			for(i=[-1,1]) for(j=[-1,1])
				translate([NEMA_H[standard]*i,NEMA_H[standard]*j,0])
					cylinder(d=BOLT_D[3], h=length/2+e);
		}
	
		translate([0,0,length/2]) {
			cylinder(d=NEMA_H[standard]*sqrt(2), h=2);
			difference() {
				cylinder(d=NEMA_S[standard], h=NEMA_H[standard]*sqrt(2));
				rotate([0,0,10*360*$t])
					translate([NEMA_S[standard]/2-.5,-NEMA_S[standard]/2,0])
						cube([NEMA_S[standard]+e,NEMA_S[standard]+e,NEMA_H[standard]*sqrt(2)+e]);
			}
		}
	
	}
	
	color(nema_body)
		linear_extrude(height=length-8*2, center=true)
			intersection() {
				square([NEMA_F[standard], NEMA_F[standard]],center=true);
				circle(d=NEMA_F[standard]*sqrt(2)-10);
			}
}

nema(17,47);
