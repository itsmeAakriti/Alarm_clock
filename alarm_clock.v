`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2024 00:32:52
// Design Name: 
// Module Name: alarm_clock
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


module alarm_clock(
input clk,reset,one_second,time_button,alarm_button,
input[3:0]key,
output load_new_a,show_a,show_new_time,load_new_c,shift,reset_count

    );
    reg [2:0]pr_state,nxt_state;
    wire time_out;
    reg [3:0]count1,count2;
    
     parameter SHOW_TIME       = 3'b000;
     parameter KEY_ENTRY      = 3'b001;
     parameter KEY_STORED     = 3'b010;
     parameter SHOW_ALARM     = 3'b011;
     parameter SET_ALARM_TIME = 3'b100;
     parameter SET_CUR_TIME   = 3'b101;
     parameter KEY_WAITED     = 3'b110;
     parameter NO_KEY         = 10 ;
  
     always @(posedge clk or posedge reset)
     begin
     if(reset)
     count1<=4'd0;
     else if(!pr_state==KEY_ENTRY)
     count1<=0;
     else if(count1==4'd9)
     count1<=0; 
     else if(one_second)
     count1 <=count1+ 1'b1;
     
     end
       always @(posedge clk or posedge reset)
        begin
        if(reset)
        count2<=4'd0;
        else if(!pr_state==KEY_WAITED)
        count2<=0;
        else if(count1==4'd9)
        count2<=0; 
        else if(one_second)
        count2 <=count1+ 1'b1;
        
        end
       always@(posedge clk or posedge reset)
       begin
       if(reset)
       pr_state<=SHOW_TIME;
       else
       pr_state<=nxt_state;
       end
       always@(pr_state or key or alarm_button or time_button or time_out)
       begin
       case(pr_state)
       SHOW_TIME: 
           begin
           if(alarm_button)
           nxt_state=SHOW_ALARM;
           else if(key!=NO_KEY)
           nxt_state=KEY_STORED;
           else
           nxt_state=SHOW_TIME;
           end
       KEY_STORED:
           begin
           nxt_state=KEY_WAITED;
           end
       KEY_WAITED:
           begin
           if(key==NO_KEY)
           nxt_state=KEY_ENTRY;
           else if(time_out==0)
           nxt_state=SHOW_TIME;
           else
           nxt_state=KEY_WAITED;
           end
       KEY_ENTRY:
           begin
           if(alarm_button)
           nxt_state=SET_ALARM_TIME;
           else if(time_button)
           nxt_state=SET_CUR_TIME;
           else if(!time_out)
           nxt_state=SHOW_TIME;
           else if(key!=NO_KEY)
           nxt_state=KEY_STORED;
           else
           nxt_state=KEY_ENTRY;
           
           end
       SHOW_ALARM:
           begin
           if(!alarm_button)
           nxt_state=SHOW_TIME;
           else
           nxt_state=SHOW_ALARM;
           end
      SET_ALARM_TIME:
           begin
           nxt_state=SHOW_TIME;
           end
      SET_CUR_TIME:
           begin
           nxt_state=SHOW_TIME;
           end
      default:nxt_state=SHOW_TIME;
       endcase
       end
     assign show_new_time=(pr_state==KEY_ENTRY||pr_state==KEY_STORED||pr_state==KEY_WAITED)?1:0;
     assign load_new_a=(pr_state==SET_ALARM_TIME )?1:0;
     assign show_a=(pr_state==SHOW_ALARM)?1:0;
     assign load_new_c=(pr_state==SET_CUR_TIME )?1:0;
     assign reset_count=(pr_state==SET_CUR_TIME )?1:0;
     assign shift=(pr_state==KEY_STORED )?1:0;
     
     
       
    
endmodule
