//////////single port RAM verilog code/////////////

module single_port_ram(clk,rst,wrd,valid,wdata,rdata,ready,address);
  parameter w = 8;
  parameter d = 16;
  parameter addr_len = 4;
  input clk,rst,valid,wrd;
  input [w-1:0]wdata;
  input [addr_len:0]address;
  output reg [w-1:0]rdata;
  output reg ready;
  reg [w-1:0]mem[d-1:0];
  int i=0;
  always@(posedge clk) begin
    
    if(rst) begin
      ready = 0;
      rdata = 0;
       for( i = 0 ;i < d; i = i +1) begin
         mem[i]=0;
       end
      
    end else begin
      if(valid) begin
        ready = 1'b1;
        if(wrd) begin
          mem[address] = wdata;
        end else begin
          rdata = mem[address];
        end 
      end
    end
  end
endmodule
          
      
