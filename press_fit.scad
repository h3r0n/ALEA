include <config.scad>

module press_fit(d=0, h=0, center=false) {

	linear_extrude(height=h, center=center)
		minkowski() {
			square([d/3,d/3], center=true);
			circle(r=d/3);
		}
}

difference() {
	press_fit(d=20, h=24, center=true);
	cylinder(d=20, h=24+e, center=true);
}
