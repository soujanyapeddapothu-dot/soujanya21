interface mem_intr(input reg clk,res);
  bit wr_rd;
  bit[`addr_width-1:0]addr;
  bit[`width-1:0]wdata,rdata;
  bit valid,ready;
  clocking bfm_cb @(posedge clk);
    default input #0 output #1;
    input ready,rdata;
    output wr_rd,addr,wdata,valid;  
  endclocking
  clocking mon_cb @(posedge clk);
    default input #1;
    input wr_rd,addr,wdata,rdata,valid,ready;
  endclocking
  modport design_mp(
  	input clk,res,wr_rd,addr,wdata,valid,
	output rdata,ready);
	modport bfm_mp(
		clocking bfm_cb
	);
	modport asserti_mp(
		input clk,res,wr_rd,wdata,rdata,valid,ready);


 
endinterface
