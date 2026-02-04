module mem_assert(clk,res,wr_rd,addr,wdata,rdata,valid,ready);
	input clk,res,valid,ready,wr_rd;
	input[`addr_width-1:0]addr;
	input[`width-1:0]wdata,rdata;
	property reset;
		@(posedge clk)(res==1)|->(wr_rd==0 && addr==0 && wdata==0 && rdata==0 && valid==0 && ready==0);
	endproperty
	RESET:assert property(reset);
	property preset;
		@(posedge clk)(res==0)|->(!($isunknown(wr_rd))&&(!($isunknown(addr)))&&(!($isunknown(wdata)))&&(!($isunknown(rdata)))&&(!($isunknown(valid)))&&(!($isunknown(ready))));

	endproperty
	PRESET:assert property(preset);
	property handshak;
		@(posedge clk)(valid==1)|=>(ready==1);
	endproperty
	HANDSHAK:assert property(handshak);
	property writes;
		@(posedge clk)(wr_rd==1)|->(!($isunknown(addr))&&(!($isunknown(wdata))));
	endproperty
	WRITES:assert property(writes);
	property reads;
		@(posedge clk)disable iff(res==1)(wr_rd==0)|->(!($isunknown(addr))&&(!($isunknown(rdata))));
	endproperty
	READS:assert property(reads);
endmodule










