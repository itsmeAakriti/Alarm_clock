`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2024 22:12:14
// Design Name: 
// Module Name: time_gen
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


module time_gen(
input clk,reset,reset_count,fast_watch,
output reg one_minute,one_second
    );
    reg[13:0] count;
    reg one_minute_reg;
    // for 256 hz clock , one second= 256 cycles and one minute = 256*60 cycles
    // in Fast watch mode , we take one minute= one second
    always@(posedge clk or posedge reset)
    begin
    if(reset)
    begin
    count<=0;
    one_minute_reg<=0;
    end
    else if(reset_count)
    begin
    count<=0;         
    one_minute_reg<=0;
    end
    else if(count==14'd255)
    begin
    one_minute_reg<=0;
    count<=0;
    end
    else if(count==14'd15359)
    begin
    one_minute_reg<=one_minute_reg+1;
    count<=0;
    end
    end
    
    always@(posedge clk or posedge reset)
    begin
    if(reset)
    begin
    one_second<=0;
    end
    else if(reset_count)
    begin
    one_second<=0;
    end
    else if(reset_count)
    begin
    one_second<=0;
    end
     else if(count==14'd255)
     begin
     one_second<=1'b1;
     count<=0;
     end
     else
     one_second<=0;     
     end
    always@(*)
    begin
    if(fast_watch)
    one_minute=one_second;
    else
    one_minute=one_minute_reg;
    end
    
endmodule
