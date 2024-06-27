module memory_register(
    input M_bubble,
    input clock, e_cnd,
    input [1:0] e_status,
    input [3:0] e_icode,e_dste,e_dstm,
    input [63:0] e_vala,e_vale,
    output reg [1:0] M_status,
    output reg M_cnd,
    output reg [63:0] M_vala,M_vale,
    output reg [3:0] M_dste,M_dstm,M_icode
);

always@(posedge clock)
begin
    if (M_bubble == 1'b0)
    begin
        M_status <= e_status;
        M_icode <= e_icode;
        M_dste <= e_dste;
        M_dstm <= e_dstm;
        M_vale <= e_vale;
        M_vala <= e_vala;
        M_cnd <= e_cnd;
    end

    else
    begin
        M_icode = 4'd1;
    end
end

endmodule