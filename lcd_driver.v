`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.06.2024 23:33:16
// Design Name: 
// Module Name: lcd_driver
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lcd_driver(
input [3:0]current_time_ms_hr,current_time_ms_min,current_time_ls_hr,current_time_ls_min,
input [3:0]alarm_time_ms_hr,alarm_time_ms_min,alarm_time_ls_hr,alarm_time_ls_min,key_ms_hr,key_ls_hr,key_ms_min,key_ls_min,
input show_a,show_curretn_time,
output [7:0]display_ms_hr,display_ls_hr,display_ms_min,display_ls_min,
output sound_a
    );
    wire sound_a1,sound_a2,sound_a3,sound_a4;
    assign sound_a = sound_a1 & sound_a2 & sound_a3 & sound_a4;
    display_driver MS_HR(.show_a(show_a),.show_new_time(show_current_time),.alarm_time(alarm_time_ms_hr),.current_time(current_time_ms_hr),.key(key_ms_hr),.sound_alarm(sound_a1),.display_time(display_ms_hr));
    display_driver LS_HR(.show_a(show_a),.show_new_time(show_current_time),.alarm_time(alarm_time_ls_hr),.current_time(current_time_ls_hr),.key(key_ls_hr),.sound_alarm(sound_a2),.display_time(display_ls_hr));
    display_driver MS_MIN(.show_a(show_a),.show_new_time(show_current_time),.alarm_time(alarm_time_ms_min),.current_time(current_time_ms_min),.key(key_ms_min),.sound_alarm(sound_a3),.display_time(display_ms_min));
    display_driver LS_MIN(.show_a(show_a),.show_new_time(show_current_time),.alarm_time(alarm_time_ls_min),.current_time(current_time_ls_min),.key(key_ls_min),.sound_alarm(sound_a4),.display_time(display_ls_min));

endmodule
