module mem(clk,res,wr_rd,addr,wdata,rdata,valid,ready);
input clk,res,wr_rd,valid;
input [`width-1:0]wdata;
input [`addr_width-1:0]addr;
output reg[`width-1:0]rdata;
output reg ready;
reg [`width-1:0]mem[`depth-1:0];
integer i;
always @(posedge clk)begin
    if(res==1)begin
  		    rdata=0;
			ready=0;
        for(i=0;i<`depth;i=i+1)begin
 			mem[i]=0;
  	  end
  	end
  	else begin
  		if(valid==1)begin
  			ready=1;
  			if(wr_rd==1)begin
  				mem[addr]=wdata;
  			end
  			else rdata=mem[addr];
  		end
  
      	else ready=0;
     end
  end
endmodule


//`define width 8
//`define depth 16
//`define addr_width $clog2(`depth)
//module mem(mem_intr.design_mp mp);
//   reg [`width-1:0]mem[`depth-1:0];
//  integer i;
//  always @(posedge mp.clk)begin
//      if(mp.res==1)begin
//			mp.rdata=0;
//			mp.ready=0;
//          for(i=0;i<`depth;i=i+1)begin
//				mem[i]=0;
//		  end
//		end
//		else begin
//			if(mp.valid==1)begin
//				mp.ready=1;
//				if(mp.wr_rd==1)begin
//					mem[mp.addr]=mp.wdata;
//				end
//				else mp.rdata=mem[mp.addr];
//			end
//	
//	    	else mp.ready=0;
//	   end
//	end
//endmodule
//
//
//
//
