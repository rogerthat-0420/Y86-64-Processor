module fetch
(
    input clock,
    input [63:0] f_pc,
    output reg [3:0] f_icode, f_ifun, f_ra, f_rb,
    output reg [63:0] f_valc, f_valp,
    output reg [1:0] f_status
);

reg [7:0] instruction_memory[0:1023];
reg instruction_valid,imem_error,halt;
reg [0:79] current_instruction ;

initial begin
    $readmemb("test.txt", instruction_memory);
    f_icode=0;
    f_ifun=0;
    halt=0;
    imem_error=0;
    instruction_valid=1;
    f_ra=0;
    f_rb=0;
    f_valc=0;
    f_valp=0;
    f_status=0;
end

always@(*)
// always@(*)
begin

    current_instruction[0 :7]=instruction_memory[f_pc];
    current_instruction[8:15]=instruction_memory[f_pc+1];
    current_instruction[16:23]=instruction_memory[f_pc+2];
    current_instruction[24:31]=instruction_memory[f_pc+3];
    current_instruction[32:39]=instruction_memory[f_pc+4];
    current_instruction[40:47]=instruction_memory[f_pc+5];
    current_instruction[48:55]=instruction_memory[f_pc+6];
    current_instruction[56:63]=instruction_memory[f_pc+7];
    current_instruction[64:71]=instruction_memory[f_pc+8];
    current_instruction[72:79]=instruction_memory[f_pc+9];

    f_icode=current_instruction[0:3];
    f_ifun=current_instruction[4:7];
    // instruction_valid=1'b1;

    // halt=1'b0;

    if(f_pc>1023)
    begin
        imem_error=1'b1;
    end
    else 
    begin
        imem_error=1'b0;
    end

    if(f_icode==4'd0 && f_ifun==4'd0) //halt
    begin
        halt=1'b1;
        f_valp=f_pc+64'd1;
    end

    else if(f_icode==4'd1 && f_ifun==4'd0) //nop
    begin
        f_valp=f_pc+64'd1;
    end

    else if(f_icode==4'd2 && (f_ifun==4'd0 || f_ifun==4'd1 || f_ifun==4'd2 || f_ifun==4'd3 || f_ifun==4'd4 || f_ifun==4'd5 ||
            f_ifun==4'd6)) //cmovxx
    begin
        f_ra=current_instruction[8:11];
        f_rb=current_instruction[12:15];
        f_valp=f_pc+64'd2;
    end

    else if(f_icode==4'd3 && f_ifun==4'd0) //irmovq
    begin
        f_ra=current_instruction[8:11];
        f_rb=current_instruction[12:15];
        f_valc={
            current_instruction[72:79],
            current_instruction[64:71],
            current_instruction[56:63],
            current_instruction[48:55],
            current_instruction[40:47],
            current_instruction[32:39],
            current_instruction[24:31],
            current_instruction[16:23]
        };
        f_valp=f_pc+64'd10;
    end
    
    else if(f_icode==4'd4 && f_ifun==4'd0) //rmmovq
    begin
        f_ra=current_instruction[8:11];
        f_rb=current_instruction[12:15];
        f_valc={
            current_instruction[72:79],
            current_instruction[64:71],
            current_instruction[56:63],
            current_instruction[48:55],
            current_instruction[40:47],
            current_instruction[32:39],
            current_instruction[24:31],
            current_instruction[16:23]
        };
        f_valp=f_pc+64'd10; 
    end

    else if(f_icode==4'd5 && f_ifun==4'd0) //mrmovq
    begin
        f_ra=current_instruction[8:11];
        f_rb=current_instruction[12:15];
        f_valc={
            current_instruction[72:79],
            current_instruction[64:71],
            current_instruction[56:63],
            current_instruction[48:55],
            current_instruction[40:47],
            current_instruction[32:39],
            current_instruction[24:31],
            current_instruction[16:23]
        };
        f_valp=f_pc+64'd10;
    end    

    else if(f_icode==4'd6 && (f_ifun==4'd0 || f_ifun==4'd1 || f_ifun==4'd2 || f_ifun==4'd3)) // opq
    begin
        f_ra=current_instruction[8:11];
        f_rb=current_instruction[12:15];
        f_valp=f_pc+64'd2;
    end

    else if(f_icode==4'd7 && (f_ifun==4'd0 || f_ifun==4'd1 || f_ifun==4'd2 || f_ifun==4'd3 || f_ifun==4'd4 || f_ifun==4'd5 ||
            f_ifun==4'd6 )) // jump
    begin
                f_valc={
            current_instruction[64:71],
            current_instruction[56:63],
            current_instruction[48:55],
            current_instruction[40:47],
            current_instruction[32:39],
            current_instruction[24:31],
            current_instruction[16:23],
            current_instruction[8:15]
        };
        f_valp=f_pc+64'd9;
    end

    else if(f_icode==4'd8 && f_ifun==4'd0) // call
    begin
                f_valc={
            current_instruction[64:71],
            current_instruction[56:63],
            current_instruction[48:55],
            current_instruction[40:47],
            current_instruction[32:39],
            current_instruction[24:31],
            current_instruction[16:23],
            current_instruction[8:15]
        };
        f_valp=f_pc+64'd9;
    end

    else if(f_icode==4'd9 && f_ifun==4'd0) //return
    begin
         f_valp=f_pc+64'd1;
    end

    else if(f_icode==4'd10 && f_ifun==4'd0) // pushq
    begin
        f_ra=current_instruction[8:11];
        f_rb=current_instruction[12:15];
        f_valp=f_pc+64'd2;
    end

    else if(f_icode==4'd11 && f_ifun==4'd0) //popq
    begin
        f_ra=current_instruction[8:11];
        f_rb=current_instruction[12:15];
        f_valp=f_pc+64'd2;
    end

    else
    begin
        instruction_valid=1'b0;
    end

    if(halt==1)
        f_status=1;
    else if(instruction_valid==0 | imem_error==1)
        f_status=2;
    else
        f_status=0;

end
    



endmodule