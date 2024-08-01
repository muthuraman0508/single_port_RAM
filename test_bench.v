///////////////singe port RAM test_bench////////////////////////

module top;
  parameter w = 8;
  parameter d = 16;
  parameter addr_len = 4;
  reg clk =0,rst,valid,wrd;
  reg [w-1:0]wdata;
  reg [addr_len:0]address;
  wire [w-1:0]rdata;
  wire ready;
  //reg [w-1:0]mem[d-1:0];
  int i=0;
  single_port_ram dut(.clk(clk),.rst(rst),.wrd(wrd),.valid(valid),.wdata(wdata),.rdata(rdata),.ready(ready),.address(address));
  always #5 clk = ~clk;
  initial begin
    rst = 1;
    rst_logic();
    repeat(2)@(posedge clk);
    rst = 0;
    wait(ready == 1)
    wrd = 1;
    write(0,d);
    wrd = 0;
    read(0,d);
  end
  initial begin
     #1000;
     $finish;
  end
    
  task write( input [addr_len - 1:0]begin_addr,input [addr_len:0] end_addr); begin
    for (int i =begin_addr;i<end_addr;i++) begin
      @(posedge clk);
      wdata = $random;
      address = i;
    end
  end
  endtask
  
  task read ( input [addr_len - 1:0]begin_addr,input [addr_len:0] end_addr); begin
    for (int i =begin_addr;i<end_addr;i++) begin
      @(posedge clk);
      address =i;
    end
  end
  endtask
  
  task rst_logic(); begin
    @(posedge clk);
    address = 0;
    wdata = 0;
    valid = 0;
    wrd = 0;
  end
  endtask
endmodule
  
  
