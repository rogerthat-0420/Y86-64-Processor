// `include "decoder.v"
// `include "fulladder.v"
// `include "subt.v"
// `include "XOR.v"
// `include "adder.v"
// `include "AND.v"

module ALU (
  input c0, c1,
  input [63:0] a, b,
  output [63:0] output_alu,
  output bit_overflow
);

  wire d0, d1, d2, d3;
  wire [63:0] out_add, out_sub, out_and, out_xor;

  decoder dec0(
    .control0(c0),
    .control1(c1),
    .out0(d0),
    .out1(d1),
    .out2(d2),
    .out3(d3)
  );

  genvar i;

  // adder
  wire [64:0] c_add;
  assign c_add[0] = 1'b0;

  generate
    for (i = 0; i < 64; i=i+1) begin
      adder add0 (
        .a(a[i]),
        .b(b[i]),
        .out(out_add[i]),
        .enable(d0),
        .cin(c_add[i]),
        .cout(c_add[i + 1])
      );
    end
  endgenerate

wire overflow_add_temp,overflow_add;
xor(overflow_add_temp,c_add[64],c_add[63]);
and(overflow_add,overflow_add_temp,d0);

  // subtractor
  wire [64:0] c_sub;
  assign c_sub[0] = 1'b1;

  generate
    for (i = 0; i < 64; i=i+1) begin
      subt sub0 (
        .a(a[i]),
        .b(b[i]),
        .out(out_sub[i]),
        .enable(d1),
        .cin(c_sub[i]),
        .cout(c_sub[i + 1])
      );
    end
  endgenerate

wire overflow_subt_temp,overflow_subt;
xor(overflow_subt_temp,c_sub[64],c_sub[63]);
and(overflow_subt,overflow_subt_temp,d1);

or(bit_overflow,overflow_add,overflow_subt);
  

  // and block
  generate
    for (i = 0; i < 64; i=i+1) begin
      AND and0 (
        .A(a[i]),
        .B(b[i]),
        .out(out_and[i]),
        .enable(d2)
      );
    end
  endgenerate

  // xor block
  generate
    for (i = 0; i < 64; i=i+1) begin
      XOR xor1 (
        .a(a[i]),
        .b(b[i]),
        .out(out_xor[i]),
        .enable(d3)
      );
    end
  endgenerate

  generate
    for(i=0;i<64;i=i+1)begin
        or(output_alu[i],out_add[i],out_and[i],out_sub[i],out_xor[i]);
    end

  endgenerate

endmodule
