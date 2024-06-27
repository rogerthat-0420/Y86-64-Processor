module pc_update(
    input clock,condition_cnd,
    input[63:0] valc,valp,valm,
    input [3:0] icode,
    output reg [63:0] new_pc
);

always@(*)
begin

    if(clock) begin
        if(icode==4'd0) //halt
        begin
            new_pc=64'd0;
        end

        else if(icode==4'd1 | icode==4'd2 | icode==4'd3
                | icode==4'd4 | icode==4'd5 | icode==4'd6
                | icode==4'd10 | icode==4'd11) // nop,cmovxx,irmovq,rmmovq,mrmovq,opq,pushq,popq
        begin
            new_pc=valp;
        end

        else if(icode==4'd7) //jxx
        begin
            if(condition_cnd==1'b1)
            begin
                new_pc=valc;
            end

            else
            begin
                new_pc=valp;
            end
        end

        else if(icode==4'd8) //call
        begin
            new_pc=valc;
        end

        else //return
        begin
            new_pc=valm;
        end
    end
end

endmodule