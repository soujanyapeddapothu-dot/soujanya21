module top;
  reg clk,res;
  mem_env env;
  mem_intr pif(clk,res);
mem dut(.clk(pif.clk),
 	  .res(pif.res),
	  .wr_rd(pif.wr_rd),
      .addr(pif.addr),
      .wdata(pif.wdata),
      .rdata(pif.rdata),
      .valid(pif.valid),
    .ready(pif.ready));
//mem dut(pif.design_mp);		
mem_assert uut(.clk(pif.clk),
		 .res(pif.res),
		 .wr_rd(pif.wr_rd),
		 .addr(pif.addr),
		 .wdata(pif.wdata),
		 .rdata(pif.rdata),
           .valid(pif.valid),
		 .ready(pif.ready));
//mem_assert uut(pif.asserti_mp);
always #5 clk=~clk;
initial begin
$value$plusargs("test_name=%s",mem_common::test_name);
$value$plusargs("n=%0d",mem_common::n);
//$display("memory test bench functionality will be happened");
clk=0;
res=0;
#5;
res=1;
repeat(2)@(posedge clk);
res=0; 

env=new();
env.run();
end
initial begin
#1500;
if(mem_common::matchings!=0 && mem_common::mismatchings==0)begin
	$display("test_passed");
	$display("matchings=%0d,mismatchings=%0d",mem_common::matchings,mem_common::mismatchings);
end
	else begin
		$display("test_failed");
		$display("matchings=%0d,mismatchings=%0d",mem_common::matchings,mem_common::mismatchings);
		
	end
	#2;
    $finish;
  end
endmodule



