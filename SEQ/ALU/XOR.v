module XOR(a,b,out,enable);

input a,b;
output out;
input enable;

wire bnot,anot,out0,out1,out2;

not(anot,a);
not(bnot,b);
and(out0,anot,b);
and(out1,bnot,a);
or(out2,out0,out1);

and(out,out2,enable);

endmodule