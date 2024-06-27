module fulladder(w,y,c,sum,cout);

input w,y,c;
output sum,cout;

wire G1,A1,A2;

xor(G1,w,y);
and(A1,w,y);

xor(sum,G1,c);
and(A2,G1,c);
or(cout,A2,A1);

endmodule