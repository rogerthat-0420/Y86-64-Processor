module select_pc(
    input clock,M_cnd,
    input [3:0] M_icode,W_icode,
    input [63:0] M_vala,m_valm,F_predpc,
    output reg [63:0] f_pc
);

initial begin
    f_pc=0;
end

always@(*)
begin
    if(M_icode==4'd7 && M_cnd!=1)
        f_pc=M_vala;
    else if(W_icode==4'd9)
        f_pc=m_valm;
    else 
        f_pc=F_predpc;
end

endmodule