`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2024 22:38:50
// Design Name: 
// Module Name: counter_alarm
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


module counter_alarm(
input clk,reset,one_minute,load_new_c,
input [3:0] new_current_time_ms_hr,new_current_time_ms_min,new_current_time_ls_hr,new_current_time_ls_min,
output reg [3:0]current_time_ms_hr,current_time_ms_min,current_time_ls_hr,current_time_ls_min
);
always@(posedge clk or posedge reset)
begin
if(reset)
begin
current_time_ms_hr<=0;
current_time_ms_min<=0;
current_time_ls_hr<=0;
current_time_ls_min<=0;

end
else if(load_new_c)
begin
current_time_ms_hr<=new_current_time_ms_hr;
current_time_ms_min<=new_current_time_ms_min;
current_time_ls_hr<=new_current_time_ls_hr;
current_time_ls_min<=new_current_time_ls_min;

end
else if(one_minute)
begin
if(current_time_ms_hr==4'd2 && current_time_ls_hr==4'd3 && current_time_ms_min==4'd5 && current_time_ls_min==4'd9)
begin
current_time_ms_hr<=0;
current_time_ms_min<=0;
current_time_ls_hr<=0;
current_time_ls_min<=0;
end
else if(current_time_ls_hr==4'd9 && current_time_ms_min==4'd5 && current_time_ls_min==4'd9)
begin
current_time_ms_hr<=current_time_ms_hr+1;
current_time_ms_min<=0;
current_time_ls_hr<=0;
current_time_ls_min<=0;
end
else if(current_time_ms_min==4'd5 && current_time_ls_min==4'd9)
begin
current_time_ms_min<=0;
current_time_ls_hr<=current_time_ls_hr+1;
current_time_ls_min<=0;
end
else if(current_time_ls_min==4'd9)
begin
current_time_ms_min<=current_time_ms_min+1;
current_time_ls_min<=0;
end
else
current_time_ls_min<=current_time_ls_min+1;
end
end
endmodule
