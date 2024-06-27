module memory(
    input clock,
    input [3:0] icode,
    input [63:0] vale,vala,valp,
    output reg [63:0] valm,
    output reg memory_block_error
);

reg [63:0] memory_register [0:1023];

always@(*)
begin
    memory_block_error=1'b0;

    if(icode==4'd4 || icode==4'd10) // rmmovq and pushq
    begin
        if(vale>1023)
        begin
            memory_block_error=1'b1;
        end
        else
        begin
            memory_register[vale]=vala;
        end
    end

    else if(icode==4'd5) // mrmovq
    begin
        if(vale>1023)
        begin
            memory_block_error=1'b1;
        end
        else
        begin
        valm=memory_register[vale];
        end
    end

    else if(icode==4'd8) // call
    begin
        if(vale>1023)
        begin
            memory_block_error=1'b1;
        end
        else
        begin
        memory_register[vale]=valp;
        end
    end

    else if(icode==4'd9 || icode==4'd11) //return and popq
    begin
        if(vala>1023)
        begin
            memory_block_error=1'b1;
        end
        else
        begin
            valm=memory_register[vala];
        end
    end

end

endmodule