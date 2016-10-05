include <standard.scad>

//render & print
$fs=.5;						//minimum arc segment
e=.1;						//extra length for manfold mesh (do not change)
tol=.5;						//xy compensation for small holes

//$t=.35;					//
x=50*cos($t*360);			// printhead position
y=40*sin($t*360);			//
z=50*sin($t*360);

wall=5/2;					//(some) thin wall thickness

//frame
f_t=10;						//frame thickness
f_x=200;
f_y=200;
f_z=65;
f_tr=8;						//corner threaded rods ISO diameter 
fy_ko=2;					//keepout between frame and x_carriage

//microswitch
ms_h=6;						//height
ms_l=13;					//length
ms_t=6;						//thickness

//motors
ab_motor=17;				//xy motors
ab_motor_l=47;				//xy motors length
z_motor=17;					//z motor
z_motor_l=47;				//z motor length
z_h=100;
z_h_extra=16.5;

//x
x_d=15;						//bearing diameter
x_l=24;						//bearing length
x_s=8;						//shaft diameter
x_fan=30;					//hotend fan diameter
x_blower=35;				//blower fan diameter
x_fans_m=6;					//fan and blower mount holes spacing

x_fan_duct=28;
x_blower_duct=25;
x_shroud=10;
x_shroud_t=5;
x_shroud_w=2;


//y
y_d=15;						//bearing diameter
y_l=24;						//bearing length
y_s=8;						//shaft diameter
y_shaft_distance_extra=3;	//extra distance between shafts
y_sp=6;						//shaft position (relative to frame)


//z
z_s=8;						//shaft diameter
z_l=24*2;					//bearing length
z_d=15;						//bearing diameter


//idler
idler_d=8;					//groove bearing OD
idler_l=3;					//groove bearing thickness
idler_s=3;					//groove bearing ID

idler_hk=2;					//idler horizontal keepout
idler_vk=.5;				//idler verical keepout (washer thickness?)

//pulley
pulley_d=200/PI/5;			//5 steps per mm (80 with 16x microstepping)
pulley_h=2;
pulley_rivet=1.5;
pulley_flat_shaft=true;

//bed
bed_x=100;
bed_y=100;

// ------
//  math
// ------
pulley_length = pulley_h+4*pulley_rivet+NUT_D[3];
pulley_diameter = pulley_d+pulley_rivet*2;
pulley_wire_height = pulley_h/2+pulley_rivet*2+NUT_D[3];
pulley_screw_length = (pulley_diameter-NEMA_S[17])/2;

y_shaft_distance = NEMA_F[ab_motor]+y_s+y_shaft_distance_extra;

x_shaft_distance = y_shaft_distance-y_d-y_s;

ab_motor_xpos = f_x/2-f_t-y_sp-y_d/2-wall;
ab_motor_ypos = f_y/2-f_t-(NEMA_H[ab_motor]*2+BOLT_D[3])/2+(f_t-f_tr)/2;


z_shaft_distance = bed_x/2-wall;
z_carriage_arm = NEMA_F[ab_motor]/2+y_l/2+x_d/2+wall+x_fan/2;
z_carriage_arm_max = ab_motor_ypos+f_y/2-f_t-x_fan/2;




use <press_fit.scad>

