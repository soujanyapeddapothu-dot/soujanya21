class mem_scb;
  mem_tx tx;
  int ass[int];
  task run();
  //  $display("scoreboard will be happened");
    forever begin
		mem_common::mon2sbd.get(tx);
		if(tx.wr_rd==1)ass[tx.addr]=tx.wdata;
		else begin
			if(ass[tx.addr]==tx.rdata) mem_common::matchings++;
			else mem_common::mismatchings++;
		end
	end
  endtask
endclass


//# test_passed
//# matchings=16,mismatchings=0
