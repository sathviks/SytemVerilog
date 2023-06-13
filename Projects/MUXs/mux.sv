module decoder_2_to_4_df(en, a, b, D0, D1, D2, D3);
 input en, a, b;
 output D0, D1, D2, D3;

  assign D0 =(en & ~a & ~b);
  assign D1 =(en & ~a & b);
  assign D2 =(en & a & ~b);
  assign D3 =(en & a & b);
  
endmodule




interface decoder_2_to_4_df_v;
  
  bit a,b,en;
  bit D0, D1, D2, D3;
  
 
endinterface