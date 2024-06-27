module adder(
    input a,b,enable,cin,
    output out,cout
);


wire out_temp,cout_temp;

fulladder adder0(
    .w(a),
    .y(b),
    .c(cin),
    .sum(out_temp),
    .cout(cout_temp)
);

and(out,out_temp,enable);
and(cout,cout_temp,enable);


endmodule