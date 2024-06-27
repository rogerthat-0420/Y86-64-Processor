module predict_pc(
    input [3:0] f_icode,
    input [63:0] f_valc,f_valp,
    output reg [63:0] predict_pc
);

always@(*)
begin 
    if(f_icode==4'd7)
        predict_pc=f_valc;
    else if(f_icode==4'd8)
        predict_pc=f_valc;
    else 
        predict_pc=f_valp;
end

endmodule