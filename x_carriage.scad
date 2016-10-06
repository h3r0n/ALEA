include <config.scad>		//user configuration

use <x_mount.scad>
use <extra/bearing.scad>
use <extra/fan.scad>
use <extra/blower.scad>

module x_carriage(assembly=false) {
	
	color(abs)
	difference() {
												//body
		cube([x_l,x_d+wall*2,x_shaft_distance+x_d+wall*2], center=true);
	
	
		for(i=[-1,1])							//bearing holes
			translate([0,0,x_shaft_distance]/2*i)
				rotate([0,90,0])
					press_fit(d=x_d, h=x_l+e, center=true);

		scale([x_l-wall*2, 10, pulley_d]/10)	//middle hole
			rotate([90,0,0])
				press_fit(d=10, h=x_d+wall*2+e, center=true);
	
		for(i=[-1,1])	for(j=[-1,1])			//cable holes
			translate([0,(idler_d+idler_hk)*j,pulley_d*i]/2)
				rotate([0,90,0])
					cylinder(d=4, h=x_l+e, center=true);
	
	}
	
	if(assembly)
		for(k=[-1,1])
			translate([0,0,x_shaft_distance/2*k])
				rotate([0,90,0])
					bearing(id=x_s, od=x_d, l=x_l, center=true);
	
	translate([0,-(x_d+x_fan)/2-wall,-(x_shaft_distance+x_d+wall*2)/2+x_fan/2]) {
		color(abs)
		difference() {
			union() {
				cube([x_l, x_fan, x_fan], center=true);		//body
			
				translate([-x_l+x_shroud_t,x_blower-x_fan,-x_blower]/2)		//shroud connector
					cube([x_shroud_t, x_blower, x_blower-x_fan], center=true);
			
				difference() {
			
					translate([-(x_l/2)-(x_shroud+x_shroud_t)/2+x_shroud_t, 0, -(x_blower-x_fan/2+x_shroud/2)])
						cube([x_shroud+x_shroud_t, x_fan, x_shroud], center=true);		//fan shroud
				
					translate([-(x_l)/2,0,-(x_blower-x_fan/2)])
						hull() {
							scale([(x_shroud*2-x_shroud_w)/10, (x_fan-x_shroud_w)/10, (x_shroud*2)/10])
								sphere(d=10);
							translate([x_shroud_t,0,0])
								scale([(x_shroud*2-x_shroud_w)/10, (x_fan-x_shroud_w)/10, (x_shroud*2+x_shroud_w)/10])
									sphere(d=10);
						}
				}
			}
		
			translate([0,0,x_fan-x_blower]/2)
				cylinder(d=23, h=e+x_blower, center=true);	//heatsink hole
		
			translate([x_l/2,0,0])				//hotend fan duct
				difference() {
					sphere(d=x_fan_duct);
					for(i=[-1,1])
						translate([0,0,x_fan/2*i])
							cube([x_l,x_fan,x_fans_m], center=true);
				}
		
			for(i=[-1,1]) for(j=[-1,1])			//fan mount holes
				translate([x_l+e, (x_fan-x_fans_m)*i, (x_fan-x_fans_m)*j]/2)
					rotate([0,-90,0])
						press_fit(d=BOLT_D[3], h=15/2);
			
			translate([-x_l/2,x_blower/2-x_fan/2,-(x_blower/2-x_fan/2)])
				sphere(d=x_blower_duct);		//blower duct
		
			for(i=[-1,1]) for(j=[-1,1])			//blower mount holes
				translate([-x_l-e, x_blower-x_fan+(x_blower-x_fans_m)*i, -(x_blower-x_fan)+(x_blower-x_fans_m)*j]/2)	
					rotate([0,90,0])
						press_fit(d=BOLT_D[3], h=15/2);
		
			translate ([0,-x_fan/2+.4,-x_fan*1/3])
				rotate([90,0,0])
					linear_extrude(height = .8)
						text("ALEA", font="FreeSerif", size=6.5, halign="center", valign="center");
		}
		
		if (assembly) {
				translate([0,0,x_fan+9]/2)
					x_mount(assembly=true);
				translate([x_l+10,0,0]/2)
					rotate([0,90,0])
						fan(x_fan, 10, x_fan-x_fans_m);
				translate([x_l+10,x_fan-x_blower,x_blower-x_fan]/-2)
					rotate([-90,0,-90])
						blower(x_blower,10);
				
		}	
	}
		
	color(abs)
	translate([0,-(x_d+x_fan)/2-wall,(x_shaft_distance+x_d+wall*2)/2-ms_h/2])
		difference() {
			cube([x_l,x_fan,6], center=true);
			cylinder(d=10, h=6+e);
			translate([0,0,-6/2-e/2])
				cylinder(d1=17, d2=16, h=6+e);
		
			for(i=[-1,1]) for(j=[-1,1])
				translate([(x_l-NUT_D[3])/2*i,(x_fan-NUT_D[3])/2*j,-9/2-e/2])
					cylinder(d=4, h=9+e);
				
			translate([0,-(x_fan-6+e/2)/2,0]) {
				cube([13,6+e/2,6+e], center=true);
				for(j=[-1,1])
					translate([6.5/2*j,0,0])
						rotate([90,0,0])
					 		press_fit(d=2, h=15, center=true);
			}
		}
}

x_carriage(assembly=true);


