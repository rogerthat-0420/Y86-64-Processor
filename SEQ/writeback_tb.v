`include "writeback.v"

module writeback_tb;

    reg clock;
    reg [63:0] vale, valm;
    reg condition_cnd;
    reg [3:0] ra, rb, icode;

    wire [63:0] register0,register1,register2,register3,register4,register5,register6,register7,register8,register9,register10,register11,register12,register13,register14;

    writeback wb0(
        .clock(clock),
        .vale(vale),
        .valm(valm),
        .condition_cnd(condition_cnd),
        .ra(ra),
        .rb(rb),
        .icode(icode),
        .register0(register0),
        .register1(register1),
        .register2(register2),
        .register3(register3),
        .register4(register4),
        .register5(register5),
        .register6(register6),
        .register7(register7),
        .register8(register8),
        .register9(register9),
        .register10(register10),
        .register11(register11),
        .register12(register12),
        .register13(register13),
        .register14(register14)
    );
    integer file_id;

    initial begin

        file_id = $fopen("writeback_tb_output.txt", "w");
        clock = 0;

        #10 //opq , register[rb] should have vale 
        clock = ~clock;
        vale = 64'd45;
        valm = 64'd33;
        condition_cnd = 1'b0;
        ra = 4'd3;
        rb = 4'd8;
        icode = 4'd6;
        #10
        $fwrite(file_id, "Case 1:\n vale=%d\n valm=%d\n condition_cnd=%d\n ra=%d\n rb=%d\n icode=%d\n r0=%d\n r1=%d\n r2=%d\n r3=%d\n r4=%d\n r5=%d\n r6=%d\n r7=%d\n r8=%d\n r9=%d\n r10=%d\n r11=%d\n r12=%d\n r13=%d\n r14=%d\n\n",
                vale, valm, condition_cnd, ra, rb, icode, register0, register1, register2, register3, register4, register5, register6, register7, register8, register9, register10, register11, register12, register13, register14);
        #10
        clock=~clock;

        #10 // cmovxx, register[rb] should have vale when cnd is 1
        clock = ~clock;
        vale = 64'd100;
        valm = 64'd50;
        condition_cnd = 1'b1;
        ra = 4'd1;
        rb = 4'd4;
        icode = 4'd2;
        #10
        $fwrite(file_id, "Case 2:\n vale=%d\n valm=%d\n condition_cnd=%d\n ra=%d\n rb=%d\n icode=%d\n r0=%d\n r1=%d\n r2=%d\n r3=%d\n r4=%d\n r5=%d\n r6=%d\n r7=%d\n r8=%d\n r9=%d\n r10=%d\n r11=%d\n r12=%d\n r13=%d\n r14=%d\n\n",
                vale, valm, condition_cnd, ra, rb, icode, register0, register1, register2, register3, register4, register5, register6, register7, register8, register9, register10, register11, register12, register13, register14);
        #10
        clock=~clock;

        #10 //return, register[4] should have value of vale
        clock = ~clock;
        vale = 64'd20;
        valm = 64'd10;
        condition_cnd = 1'b1;
        ra = 4'd7;
        rb = 4'd11;
        icode = 4'd9;
        #10
        $fwrite(file_id, "Case 3:\n vale=%d\n valm=%d\n condition_cnd=%d\n ra=%d\n rb=%d\n icode=%d\n r0=%d\n r1=%d\n r2=%d\n r3=%d\n r4=%d\n r5=%d\n r6=%d\n r7=%d\n r8=%d\n r9=%d\n r10=%d\n r11=%d\n r12=%d\n r13=%d\n r14=%d\n\n",
                vale, valm, condition_cnd, ra, rb, icode, register0, register1, register2, register3, register4, register5, register6, register7, register8, register9, register10, register11, register12, register13, register14);
        #10
        clock=~clock;

        $fclose(file_id);

        
    end

endmodule
