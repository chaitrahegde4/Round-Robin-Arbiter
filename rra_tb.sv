//testbench for rra


module round_robin_arbitter_project_tb();
reg clk, rst;
reg [4:1] req;
wire [3:0] grant;

reg [3:0] local_grant = 4'b0000;

round_robin_arbitter_project dut(clk, rst, req, grant);

task reset();
begin
  @(negedge clk)
  rst = 1'b1;
  @(negedge clk)
  rst = 1'b0;
end
endtask

task insert(input [4:1] val);
begin
  @(negedge clk)
  req = val;
end
endtask

task compare(input [3:0] chk);
  @(posedge clk) #1;
  if (chk == grant)
    $display("DUT WORKING local_grnt:%0b grnt:%0b", chk, grant);
  else
    $display("DUT NOT WORKING local_grnt:%0b grnt:%0b", chk, grant);
endtask

initial begin
  clk = 0;
  forever #10 clk = ~clk;
end

initial begin
  reset();
  repeat(2) begin
    insert(4'b0010); 
    repeat(3) insert(4'b1001); 
    insert(4'b0100); 
    local_grant = 4'b0100;
    compare(local_grant);
  end
  #200 $finish;
end

initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1);
end

endmodule