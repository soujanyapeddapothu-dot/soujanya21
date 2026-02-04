class mem_cov;
  mem_tx tx;
  covergroup CG;
   option.per_instance=1;
   option.name="mem_coverage";
  WR_RD:coverpoint tx.wr_rd{
  	 option.weight=1; 
     option.at_least=15;
    bins writes={1'b1};
    bins reads={1'b0};
	option.comment="memory wr_rd signal coverpoint";
  }
  ADDR:coverpoint tx.addr{
  	 option.weight=2;
      option.comment="memory address signal coverpoint";
      option.goal=20;
    bins addr0={4'b0000};
    bins addr1={4'b0001};
    bins addr2={4'b0010};
    bins addr3={4'b0011};
    bins addr4={4'b0100};
    bins addr5={4'b0101};
    bins addr6={4'b0110};
    bins addr7={4'b0111};
    bins addr8={4'b1000};
    bins addr9={4'b1001};
    bins addr10={4'b1010};
    bins addr11={4'b1011};
    bins addr12={4'b1100};
    bins addr13={4'b1101};
    bins addr14={4'b1110};
    bins addr15={4'b1111};
  }
   CROSS_WR_RD_ADDR:cross WR_RD,ADDR{
      bins SAMPLE=binsof(WR_RD.writes);
      bins SAMPLE1=binsof(WR_RD.reads);
     // bins SAMPLE=binsof(ADDR)intersect{[2:9]};  
    }
  
endgroup
  function new();
    CG=new();
  endfunction
  task run();
  //  $display("coverage functionality will be happened");
    forever begin
      mem_common::mon2cov.get(tx);
      CG.sample();
      tx.print("mem_cov");
    end
  endtask
endclass

