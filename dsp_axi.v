`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2024 10:50:53
// Design Name: 
// Module Name: dsp_axi
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


module dsp_axi(
    input wire clk,
    input wire rst,
  
    input wire [7:0] s_tdata_operand_a,
    input wire s_tvalid_operand_a,
    output wire s_tready_operand_a,
    input wire s_tlast_operand_a,
   
    input wire [7:0] s_tdata_operand_b,
    input wire s_tvalid_operand_b,
    output wire s_tready_operand_b,
    input wire s_tlast_operand_b,
    
    input wire [7:0] s_tdata_operand_c,
    input wire s_tvalid_operand_c,
    output wire s_tready_operand_c,
    input wire s_tlast_operand_c,
   
    output reg [15:0] m_tdata_result,
    output reg m_tvalid_result,
    input wire m_tready_result,
    output reg m_tlast_result
    
);

    
    reg [7:0] mul_result;
    reg [15:0] add_result;
    
    reg [7:0] reg_a;
    reg [7:0] reg_b;
    reg [7:0] reg_c;
    
   
    reg s_tvalid_a;
    reg m_tready_a;
    reg s_tlast_a;
 
    
   
    reg s_tvalid_b;
    reg m_tready_b;
    reg s_tlast_b;
  
    
  
    reg s_tvalid_c;
    reg m_tready_c;
    reg s_tlast_c;
 
  
    assign s_tready_operand_a =  s_tvalid_operand_b & m_tready_result? 1: 0 ;
    assign s_tready_operand_b =  s_tvalid_operand_a & m_tready_result? 1: 0 ;       
    assign s_tready_operand_c =  s_tvalid_operand_c & m_tready_result? 1: 0 ;
   
   
    always @(posedge clk or posedge rst) begin
        if (rst) begin
           
            s_tvalid_a <= 0;
          //  s_tlast_a <= 0;     
            reg_a <= 0;
            s_tlast_a <= 0;
           
        end else if (s_tvalid_operand_a && s_tready_operand_a)begin
               reg_a <= s_tdata_operand_a;    
               s_tvalid_a <=    s_tvalid_operand_a;
               s_tlast_a <= s_tlast_operand_a;
            
         end else begin
           reg_a <= 0;
           s_tvalid_a <= 0;
           s_tlast_a <= 0;
//         
         end
    end
    
     always @(posedge clk or posedge rst) begin
        if (rst) begin           
            s_tvalid_b <= 0;            
            reg_b <= 0;
            s_tlast_b <= 0;
            
           
        end else if (s_tvalid_operand_b && s_tready_operand_b)begin
                 reg_b <= s_tdata_operand_b;
            s_tvalid_b <= s_tvalid_operand_b;         
            s_tlast_b <= s_tlast_operand_b;
         end else begin
           reg_b <= 0;
           s_tvalid_b <= 0;
           s_tlast_b <= 0;
                     
           end
      end
      
       
    always @(posedge clk or posedge rst) begin
        if (rst) begin
           
            s_tvalid_c <= 0;          
            reg_c <= 0;
            s_tlast_c <= 0;
                        
           
        end else if (s_tvalid_operand_c && s_tready_operand_c  )begin
               reg_c <= s_tdata_operand_c;
               s_tvalid_c <= s_tvalid_operand_c;         
               s_tlast_c <= s_tlast_operand_c;
         end else begin         
           s_tvalid_c <= 0;   
           s_tlast_c <= 0;   
         end
    end
      
      
  
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            m_tdata_result <= 16'h0;
            m_tvalid_result <= 1'b0;
            m_tlast_result <= 1'b0;
            
      end else if(m_tready_result ) begin       
            m_tdata_result <= (reg_a * reg_b) + reg_c;
            m_tvalid_result <= (s_tvalid_a && s_tvalid_b && s_tvalid_c);
            m_tlast_result <= (s_tlast_a && s_tlast_b && s_tlast_c);
        end else begin
            m_tdata_result <= 16'h0;
            m_tvalid_result <= 1'b0;
        end
    end

endmodule
                        

