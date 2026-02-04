class mem_env;
  mem_agent agn;
  mem_scb scb;
  task run();
    $display("environment functionality will be happened");
    agn=new();
    scb=new();
    fork
      agn.run();
      scb.run();
    join
  endtask
endclass
