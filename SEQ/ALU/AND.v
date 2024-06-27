module AND(A,B,out,enable);

input A,B;
output out;
input enable;

wire out0;

and(out0,A,B);

and(out,out0,enable);

endmodule
