class mem_gen;
  mem_tx tx,temp,txq[$];
  
  task run();
   // $display("generator functionality  will be happened");
    case(mem_common::test_name)
      "1wr":begin
         tx=new();
        assert (tx.randomize() with{tx.wr_rd==1;})
          tx.print("mem_gen_wr");
        mem_common::gen2bfm.put(tx);
        
       end
      "1wr_1rd":begin
        tx=new();
        assert(tx.randomize()with{tx.wr_rd==1;})
          tx.print("gen_wr");
        temp=new tx;
        
        assert( tx.randomize() with{tx.wr_rd==0;addr==temp.addr;wdata==0;})
          tx.print("gen_rd"); 
          mem_common::gen2bfm.put(tx);
      end
      "5wr":begin
        tx=new();
        repeat(5)begin
          assert( tx.randomize()with {tx.wr_rd==1;})
             mem_common::gen2bfm.put(tx);
             tx.print("gen_wr"); 
        end
      end
      "5wr_5rd":begin
        tx=new();
        //writes
        repeat(5)begin
          assert(tx.randomize() with{tx.wr_rd==1;})
          temp=new tx;
          mem_common::gen2bfm.put(temp);
          txq.push_back(temp);
          tx.print("gen_wr");
          assert( tx.randomize() with{tx.wr_rd==0;addr==temp.addr;wdata==0;})
            tx.print("mem_gen_wr"); 
        end
        //for reads
        repeat(5)begin
          tx=new();
          temp=txq.pop_front();
          assert(tx.randomize() with{tx.wr_rd==0;tx.addr==temp.addr;tx.wdata==0;})
            mem_common::gen2bfm.put(tx);
          tx.print("gen_rd");
        end
      end
     "nwr_nrd": begin
       tx=new();
       //writes
       repeat(mem_common::n)begin
         assert(tx.randomize() with{tx.wr_rd==1;})
                     temp=new tx;
         txq.push_back(temp);
         mem_common::gen2bfm.put(temp);
     //    tx.print("gen_wr"); 
        end
        //for reads
       repeat(mem_common::n)begin
          tx=new();
          temp=txq.pop_front();
         assert( tx.randomize() with{tx.wr_rd==0;tx.addr==temp.addr;tx.wdata==0;})
           mem_common::gen2bfm.put(tx);
       //  tx.print("gen_rd");
      
        end
     end
	 default :$display("memtrans");
    endcase
  endtask
endclass
