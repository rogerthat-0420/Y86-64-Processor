module fetch
(
    input clock,
    input [63:0] pc_counter,
    output reg [3:0] icode, ifun, ra, rb,
    output reg [63:0] valc, valp,
    output reg instruction_valid, imem_error, halt
);

reg [7:0] instruction_memory[0:1023];
reg [0:79] current_instruction ;

initial begin
    $readmemb("2.txt", instruction_memory);
end


always@(posedge clock)
// always@(*)
begin

    current_instruction[0 :7]=instruction_memory[pc_counter];
    current_instruction[8:15]=instruction_memory[pc_counter+1];
    current_instruction[16:23]=instruction_memory[pc_counter+2];
    current_instruction[24:31]=instruction_memory[pc_counter+3];
    current_instruction[32:39]=instruction_memory[pc_counter+4];
    current_instruction[40:47]=instruction_memory[pc_counter+5];
    current_instruction[48:55]=instruction_memory[pc_counter+6];
    current_instruction[56:63]=instruction_memory[pc_counter+7];
    current_instruction[64:71]=instruction_memory[pc_counter+8];
    current_instruction[72:79]=instruction_memory[pc_counter+9];

    icode=current_instruction[0:3];
    ifun=current_instruction[4:7];
    instruction_valid=1'b1;

    halt=1'b0;

    if(pc_counter>1023)
    begin
        imem_error=1'b1;
    end
    else 
    begin
        imem_error=1'b0;
    end

    if(icode==4'd0 && ifun==4'd0) //halt
    begin
        halt=1'b1;
        valp=pc_counter+64'd1;
    end

    else if(icode==4'd1 && ifun==4'd0) //nop
    begin
        valp=pc_counter+64'd1;
    end

    else if(icode==4'd2 && (ifun==4'd0 || ifun==4'd1 || ifun==4'd2 || ifun==4'd3 || ifun==4'd4 || ifun==4'd5 ||
            ifun==4'd6)) //cmovxx
    begin
        ra=current_instruction[8:11];
        rb=current_instruction[12:15];
        valp=pc_counter+64'd2;
    end

    else if(icode==4'd3 && ifun==4'd0) //irmovq
    begin
        ra=current_instruction[8:11];
        rb=current_instruction[12:15];
        valc={
            current_instruction[72:79],
            current_instruction[64:71],
            current_instruction[56:63],
            current_instruction[48:55],
            current_instruction[40:47],
            current_instruction[32:39],
            current_instruction[24:31],
            current_instruction[16:23]
        };
        valp=pc_counter+64'd10;
    end
    
    else if(icode==4'd4 && ifun==4'd0) //rmmovq
    begin
        ra=current_instruction[8:11];
        rb=current_instruction[12:15];
        valc={
            current_instruction[72:79],
            current_instruction[64:71],
            current_instruction[56:63],
            current_instruction[48:55],
            current_instruction[40:47],
            current_instruction[32:39],
            current_instruction[24:31],
            current_instruction[16:23]
        };
        valp=pc_counter+64'd10; 
    end

    else if(icode==4'd5 && ifun==4'd0) //mrmovq
    begin
        ra=current_instruction[8:11];
        rb=current_instruction[12:15];
        valc={
            current_instruction[72:79],
            current_instruction[64:71],
            current_instruction[56:63],
            current_instruction[48:55],
            current_instruction[40:47],
            current_instruction[32:39],
            current_instruction[24:31],
            current_instruction[16:23]
        };
        valp=pc_counter+64'd10;
    end    

    else if(icode==4'd6 && (ifun==4'd0 || ifun==4'd1 || ifun==4'd2 || ifun==4'd3)) // opq
    begin
        ra=current_instruction[8:11];
        rb=current_instruction[12:15];
        valp=pc_counter+64'd2;
    end

    else if(icode==4'd7 && (ifun==4'd0 || ifun==4'd1 || ifun==4'd2 || ifun==4'd3 || ifun==4'd4 || ifun==4'd5 ||
            ifun==4'd6 )) // jump
    begin
                valc={
            current_instruction[64:71],
            current_instruction[56:63],
            current_instruction[48:55],
            current_instruction[40:47],
            current_instruction[32:39],
            current_instruction[24:31],
            current_instruction[16:23],
            current_instruction[8:15]
        };
        valp=pc_counter+64'd9;
    end

    else if(icode==4'd8 && ifun==4'd0) // call
    begin
                valc={
            current_instruction[64:71],
            current_instruction[56:63],
            current_instruction[48:55],
            current_instruction[40:47],
            current_instruction[32:39],
            current_instruction[24:31],
            current_instruction[16:23],
            current_instruction[8:15]
        };
        valp=pc_counter+64'd9;
    end

    else if(icode==4'd9 && ifun==4'd0) //return
    begin
         valp=pc_counter+64'd1;
    end

    else if(icode==4'd10 && ifun==4'd0) // pushq
    begin
        ra=current_instruction[8:11];
        rb=current_instruction[12:15];
        valp=pc_counter+64'd2;
    end

    else if(icode==4'd11 && ifun==4'd0) //popq
    begin
        ra=current_instruction[8:11];
        rb=current_instruction[12:15];
        valp=pc_counter+64'd2;
    end

    else
    begin
        instruction_valid=1'b0;
    end

end
    



endmodule