include <config.scad>		//user configuration


module pulley() {

color(abs)

difference() {

	union() {
	
		cylinder(d=pulley_d, h=pulley_h, center=true);
		for (i=[-1,1]) 
			translate([0,0,pulley_h+pulley_rivet]/2*i) {
				scale([1,1,i])
					cylinder(d1=pulley_d, d2=pulley_diameter, h=pulley_rivet, center=true);
				translate([0,0,pulley_rivet]*i)
					cylinder(d=pulley_diameter, h=pulley_rivet, center=true);
			}

		translate([0,0,pulley_h+4*pulley_rivet]/-2)	scale([1,1,-1])
			cylinder(d=pulley_diameter, h=NUT_D[3]);
	
	}
	
	translate(-[0,0,pulley_h/2+pulley_rivet*2+NUT_D[3]+e/2]) {
		difference() {
			cylinder(d=NEMA_S[ab_motor], h=pulley_length+e);
			if (pulley_flat_shaft)
				translate([NEMA_S[ab_motor]/2-.5, -NEMA_S[ab_motor]/2, 0])
					cube([NEMA_S[ab_motor], NEMA_S[ab_motor], pulley_length+e]);
		}
	
		hull()
			for(i=[0,1])
				translate([NEMA_S[ab_motor]/2,0,NUT_D[3]/2*i])
					rotate([0,90,0])
						cylinder(d=NUT_D[3], h=NUT_H[3], $fn=6);
		
		translate([0,0,NUT_D[3]/2])
			rotate([0,90,0])
				cylinder(d=BOLT_D[3], h=pulley_diameter/2+e);
	}
}

}
pulley();



