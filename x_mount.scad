include <config.scad>

module x_mount(assembly=false) {
	
	color(pla)
	
	difference() {

		cube([x_l,x_fan,9], center=true);			//body
	
		hull()										//clamp
			for(i=[[0,0,0],-[x_l/2+0,-x_fan/2+0,0]]) 
				translate([0,0,-9/2-e]+i)
					cylinder(d=16, h=3+e);
		hull()										//groovemount
			for(i=[[0,0,0],-[x_l/2,-x_fan/2+0,0]]) 
				translate([0,0,-9/2+3-e/2]+i)
					cylinder(d=12, h=6+e);
		
		for(i=[-1,1]) for(j=[-1,1])					//mounting screws
			translate([(x_l-NUT_D[3])/2*i,(x_fan-NUT_D[3])/2*j,-9/2-e/2]) {
				cylinder(d=NUT_D[3], h=NUT_H[3]+e/2, $fn=6);
				press_fit(d=BOLT_D[3], h=9+e);
			}
	
		translate([0,12+BOLT_D[3],0]/2)				//clamp
			rotate([0,90,0])
				press_fit(d=BOLT_D[3], h=x_fan+e, center=true);
	}

	if(assembly) {	
		
		color(e3d)
		
		translate([-5,3.4,-3-6.9])
			rotate([0,0,180])
				import("extra/E3D_v6.stl");
	}
}

x_mount(assembly=true);


