module fetch_register(
    input clock,
    input [63:0] predict_pc,
    input F_stall,
    output reg [63:0] F_predpc
);

always@(posedge clock)
begin
    if(F_stall==0)
        F_predpc=predict_pc;
end

endmodule