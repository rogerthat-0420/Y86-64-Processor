`include "execute.v"
`include "fetch.v"
`include "decode.v"
module execute_tb;

    reg clock;
    reg [63:0] pc_counter;
    reg[63:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14;
    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] ra;
    wire [3:0] rb; 
    wire [63:0] valc;
    wire [63:0] valp;
    wire [63:0] vala;
    wire [63:0] valb;
    wire [63:0] vale;
    wire condition_cnd, overflow_flag, sign_flag, zero_flag;
    wire instruction_valid,imem_error,halt;

    fetch fexec(
        .clock(clock),
        .pc_counter(pc_counter),
        .valc(valc),
        .valp(valp),
        .ra(ra),
        .rb(rb),
        .icode(icode),
        .ifun(ifun),
        .instruction_valid(instruction_valid),
        .imem_error(imem_error),
        .halt(halt)
    );

    decode dexec(
        .clock(clock),
        .icode(icode),
        .ra(ra),
        .rb(rb),
        .r0(r0),
        .r1(r1),
        .r2(r2),
        .r3(r3),
        .r4(r4),
        .r5(r5),
        .r6(r6),
        .r7(r7),
        .r8(r8),
        .r9(r9),
        .r10(r10),
        .r11(r11),
        .r12(r12),
        .r13(r13),
        .r14(r14),
        .vala(vala),
        .valb(valb)
    );
    
    execute execute0(
        .clock(clock),
        .vala(vala),
        .valb(valb),
        .valc(valc),
        .icode(icode),
        .ifun(ifun),
        .vale(vale),
        .condition_cnd(condition_cnd),
        .overflow_flag(overflow_flag),
        .sign_flag(sign_flag),
        .zero_flag(zero_flag)
    );

    initial begin

        r0 = 64'd12;
        r1 = 64'd25;
        r2 = 64'd38;
        r3 = 64'd87;
        r4 = 64'd10;
        r5 = 64'd45;
        r6 = 64'd33;
        r7 = 64'd145;
        r8 = 64'd345;
        r9 = 64'd420;
        r10 = 64'd1034;
        r11 = 64'd44;
        r12 = 64'd3;
        r13 = 64'd11;
        r14 = 64'd7;

        clock=0;
        #10

        clock=~clock;
        pc_counter=64'd0;
        #10
        $display("icode=%b ifun=%b valc=%d valp=%d ra=%b rb=%b vala=%d valb=%d cnd=%d vale=%d\n",icode,ifun,valc,valp,ra,rb,vala,valb,condition_cnd,vale);
        clock=~clock;
        #10

        clock=~clock;
        pc_counter=valp;
        #10
        $display("icode=%b ifun=%b valc=%d valp=%d ra=%b rb=%b vala=%d valb=%d cnd=%d vale=%d\n",icode,ifun,valc,valp,ra,rb,vala,valb,condition_cnd,vale);
        clock=~clock;
        #10

        clock=~clock;
        pc_counter=valp;
        #10
        $display("icode=%b ifun=%b valc=%d valp=%d ra=%b rb=%b vala=%d valb=%d cnd=%d vale=%d\n",icode,ifun,valc,valp,ra,rb,vala,valb,condition_cnd,vale);
        clock=~clock;
        

    end
    


endmodule

