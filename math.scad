// pulley
pulley_length = pulley_h+4*pulley_rivet+NUT_D[3];
pulley_diameter = pulley_d+pulley_rivet*2;
pulley_wire_height = pulley_h/2+pulley_rivet*2+NUT_D[3];
pulley_screw_length = (pulley_diameter-NEMA_S[17])/2;

//y
y_shaft_distance = NEMA_F[ab_motor]+y_s+y_shaft_distance_extra;

//
x_shaft_distance = y_shaft_distance-y_d-y_s;

ab_motor_xpos = f_x/2-f_t-y_sp-y_d/2-wall;
ab_motor_ypos = f_y/2-f_t-(NEMA_H[ab_motor]*2+BOLT_D[3])/2+(f_t-f_tr)/2;

//echo(x_shaft_distance);
