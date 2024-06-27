module writeback(
    input clock,
    input [63:0]vale,valm,
    input condition_cnd,
    input[3:0] ra,rb,icode,
    output reg [63:0] register0,register1,register2,register3,register4,register5,register6,register7,register8,register9,register10,register11,register12,register13,register14
);

reg[63:0] register_file[0:14];

// always@(posedge clock)
// always@(negedge clock)
always@(negedge clock)
begin

    if(icode==4'd2)//cmovxx
        begin
            if(condition_cnd==1)
            begin
                register_file[rb]=vale;
            end
        end

    else if(icode==4'd3) //irmovq
        begin
            register_file[rb]=vale;
        end

    else if(icode==4'd5) //mrmovq
        begin
            register_file[ra]=valm;
        end

    else if(icode==4'd6) //opq
        begin
            register_file[rb]=vale;
        end
    
    else if(icode==4'd8) //call
        begin
            register_file[4]=vale;
        end
    
    else if(icode==4'd9) //return
        begin
            register_file[4]=vale;
        end
    
    else if(icode==4'd10) //pushq
        begin
            register_file[4]=vale;
        end
    
    else if(icode==4'd11) //popq
        begin
            register_file[4]=vale;
            register_file[ra]=valm;
        end

    register0=register_file[0];
    register1=register_file[1];
    register2=register_file[2];
    register3=register_file[3];
    register4=register_file[4];
    register5=register_file[5];
    register6=register_file[6];
    register7=register_file[7];
    register8=register_file[8];
    register9=register_file[9];
    register10=register_file[10];
    register11=register_file[11];
    register12=register_file[12];
    register13=register_file[13];
    register14=register_file[14];
end

endmodule