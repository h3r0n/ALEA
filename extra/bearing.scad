include <../config.scad>


module bearing (od,id,l,center=false) {
	
		color(bearing_outside)
			linear_extrude(height=l, center=center)
				difference() {
					circle(d=od);
					circle(d=od-1.2*2);
				}
				
		color(bearing_inside)
			linear_extrude(height=l, center=center)
				difference() {
					circle(d=od-1.2*2);
					circle(d=id);
				}
}

bearing(od=15, id=8, l=24, center=true);
