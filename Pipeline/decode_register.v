module decode_register(
    input clock,
    input [3:0] f_icode,f_ifun,f_ra,f_rb,
    input [63:0] f_valc,f_valp,
    input [1:0] f_status,
    input D_stall,D_bubble,
    output reg[1:0] D_status,
    output reg[3:0] D_icode,D_ifun,D_ra,D_rb,
    output reg[63:0] D_valc,D_valp
);

always@(posedge clock)
begin 
    if(D_stall==1)
    begin

    end

    else if(D_bubble==1)
    begin
        D_icode<=4'd1;
        D_ifun<=4'd0;
    end

    else
    begin
        D_icode<=f_icode;
        D_ifun<=f_ifun;
        D_ra<=f_ra;
        D_rb<=f_rb;
        D_valc<=f_valc;
        D_valp<=f_valp;
        D_status<=f_status;
    end
end

endmodule