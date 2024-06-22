`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2024 00:33:28
// Design Name: 
// Module Name: key_register
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


module key_register(
input [3:0]key,
input clk,reset,
output reg [3:0]key_buffer_MS_HR,key_buffer_LS_HR,key_buffer_MS_MIN,key_buffer_LS_MIN
    );
    always@(posedge clk or posedge reset)
    begin
    if(reset)
    begin
    key_buffer_MS_HR<=0;
    key_buffer_LS_HR<=0;
    key_buffer_MS_MIN<=0;
    key_buffer_LS_MIN<=0;
            
    end
    else
    begin
    key_buffer_MS_HR<= key_buffer_LS_HR;
    key_buffer_LS_HR<=key_buffer_MS_MIN;
    key_buffer_MS_MIN<=key_buffer_LS_MIN;
    key_buffer_LS_MIN<=key;            
    end
    end
endmodule
