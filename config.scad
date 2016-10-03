include <standard.scad>


//render & print
$fs=.5;						//minimum arc segment
e=.1;						//extra length for manfold mesh (do not change)
tol=.5;						//xy compensation for small holes

//$t=.35;					//
x=0;//*cos($t*360);			// printhead position
y=0;//*sin($t*360);		//

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

//idler
idler_d=8;					//groove bearing OD
idler_l=3;					//groove bearing thickness
idler_s=3;					//groove bearing ID

idler_hk=2;					//idler horizontal keepout
idler_vk=.5;				//idler verical keepout (washer thickness?)

//pulley
pulley_d=200/PI/5;			//5 steps per mm (80 with 16x microstepping)
pulley_h=2;
pulley_rivet=1;
pulley_flat_shaft=true;

//hm (hotend mount)
//hm_sc_d=3+0.4*3*2;			//sliding cylinder diameter (optimized for 0.4mm nozzle)
hm_sc_d=NUT_D[3];


include <math.scad>

