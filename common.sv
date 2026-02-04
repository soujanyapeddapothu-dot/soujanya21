`define width 8
`define depth 16
`define addr_width $clog2(`depth)
class mem_common;
  static string test_name;
 static int n;
 static int bfm_count;
  static mailbox gen2bfm=new();
  static mailbox mon2cov=new();
  static mailbox mon2sbd=new();
  static int matchings,mismatchings;
endclass

