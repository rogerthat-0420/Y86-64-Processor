module decoder(control1,control0,out0,out1,out2,out3);

input control0,control1;
output out0,out1,out2,out3;

wire control0not,control1not;

not(control0not,control0);
not(control1not,control1);

and(out0,control0not,control1not);
and(out1,control1not,control0);
and(out2,control1,control0not);
and(out3,control0,control1);


endmodule