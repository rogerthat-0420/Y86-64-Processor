module subt(a,b,out,enable,cin,cout);

input a,b,cin,enable;
output out,cout;

wire bxor,out_temp,cout_temp;

XOR xor0
(
    .a(b),
    .b(enable),
    .out(bxor),
    .enable(enable)
);

fulladder adder1
(
    .w(a),
    .y(bxor),
    .c(cin),
    .sum(out_temp),
    .cout(cout_temp)
);

and(out,out_temp,enable);
and(cout,cout_temp,enable);

endmodule