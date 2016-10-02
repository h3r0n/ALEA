// pulley
pulley_length = pulley_h+4*pulley_rivet+NUT_D[3];
pulley_diameter = pulley_d+pulley_rivet*2;
pulley_wire_height = pulley_h/2+pulley_rivet*2+NUT_D[3];
pulley_screw_length = (pulley_diameter-NEMA_S[17])/2;

//y
y_shaft_distance = NEMA_F[ab_motor]+y_s+y_shaft_distance_extra;

//
x_shaft_distance = y_shaft_distance-y_d-y_s;

//echo(x_shaft_distance);
