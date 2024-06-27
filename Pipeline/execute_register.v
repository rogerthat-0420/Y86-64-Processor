module execute_register(
    input clock,
    input [1:0] d_status, 
    input [3:0] d_icode, d_ifun, d_srca, d_srcb, d_dste, d_dstm,
    input [63:0] d_vala,d_valb,d_valc,
    input E_bubble,
    output reg [3:0] E_icode, E_ifun, E_srca, E_srcb, E_dste, E_dstm,
    output reg [63:0] E_vala, E_valb, E_valc,
    output reg [1:0] E_status
);

always@(posedge clock)
begin
    if(E_bubble==0)
    begin
        E_vala<=d_vala;
        E_valb<=d_valb;
        E_valc<=d_valc;
        E_icode<=d_icode;
        E_ifun<=d_ifun;
        E_srca<=d_srca;
        E_srcb<=d_srcb;
        E_dste<=d_dste;
        E_status<=d_status;
        E_dstm<=d_dstm;
    end
    else
    begin
        E_icode<=4'd1;
    end
end

endmodule