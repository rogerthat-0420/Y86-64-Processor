`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
`include "writeback.v"
`include "pc_update.v"
// `include "decode_writeback.v"

module processor;

    reg clock;
    reg [63:0] pc_counter;
    wire[63:0] reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14;
    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] ra;
    wire [3:0] rb; 
    wire [63:0] valc;
    wire [63:0] valp;
    wire [63:0] vala;
    wire [63:0] valb;
    wire [63:0] vale;
    wire [63:0] valm;
    wire condition_cnd, overflow_flag, sign_flag, zero_flag;
    wire instruction_valid,imem_error,halt;
    wire[63:0] new_pc;
    wire memory_block_error;

    fetch fproc(
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

    decode dproc(
        .clock(clock),
        .icode(icode),
        .ra(ra),
        .rb(rb),
        .r0(reg0),
        .r1(reg1),
        .r2(reg2),
        .r3(reg3),
        .r4(reg4),
        .r5(reg5),
        .r6(reg6),
        .r7(reg7),
        .r8(reg8),
        .r9(reg9),
        .r10(reg10),
        .r11(reg11),
        .r12(reg12),
        .r13(reg13),
        .r14(reg14),
        .vala(vala),
        .valb(valb)
    );

    // decode_writeback dwbproc(
    //     .clock(clock),
    //     .icode(icode),
    //     .ra(ra),
    //     .rb(rb),
    //     .r0(reg0),
    //     .r1(reg1),
    //     .r2(reg2),
    //     .r3(reg3),
    //     .r4(reg4),
    //     .r5(reg5),
    //     .r6(reg6),
    //     .r7(reg7),
    //     .r8(reg8),
    //     .r9(reg9),
    //     .r10(reg10),
    //     .r11(reg11),
    //     .r12(reg12),
    //     .r13(reg13),
    //     .r14(reg14),
    //     .vala(vala),
    //     .valb(valb),
    //     .vale(vale),
    //     .valm(valm),
    //     .condition_cnd(condition_cnd)
    // );

    execute eproc(
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

    memory mproc(
        .clock(clock),
        .icode(icode),
        .vale(vale),
        .vala(vala),
        .valp(valp),
        .valm(valm),
        .memory_block_error(memory_block_error)
    );

    writeback wproc(
        .clock(clock),
        .vale(vale),
        .valm(valm),
        .condition_cnd(condition_cnd),
        .ra(ra),
        .rb(rb),
        .icode(icode),
        .register0(reg0),
        .register1(reg1),
        .register2(reg2),
        .register3(reg3),
        .register4(reg4),
        .register5(reg5),
        .register6(reg6),
        .register7(reg7),
        .register8(reg8),
        .register9(reg9),
        .register10(reg10),
        .register11(reg11),
        .register12(reg12),
        .register13(reg13),
        .register14(reg14)
    );

    pc_update pcproc(
        .clock(clock),
        .condition_cnd(condition_cnd),
        .valc(valc),
        .valp(valp),
        .valm(valm),
        .icode(icode),
        .new_pc(new_pc)
    );

integer file_id;

    // always@(*)
    // begin
    //     if(pc_counter==new_pc)
    //     begin
    //         $finish;
    //     end
    // end

    always@(negedge clock)
    begin
        if(halt==1 || instruction_valid==0 || imem_error==1 || memory_block_error==1)
        begin
            $finish;
        end
    end

    initial 
        $monitor("zero=%d sign=%d pc_counter=%d valp=%d clock=%d icode=%d ifun=%d rA=%b rB=%b valA=%d valB=%d valC=%d valE=%d valM=%d instruction_val=%d memory_err=%d cnd=%d memory_block_err=%d halt=%d r0=%d r1=%d r2=%d r3=%d r4=%d r5=%d r6=%d r7=%d r8=%d r9=%d r10=%d r11=%d r12=%d r13=%d r14=%d \n",
                    zero_flag,sign_flag,pc_counter,valp,clock,icode,ifun,ra,rb,vala,valb,valc,vale,valm,instruction_valid,imem_error,condition_cnd,memory_block_error,halt,reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14);


    initial begin

        // file_id = $fopen("processor.txt", "w");
        clock=0;
        
       pc_counter=64'd0;
        // #10 
        // clock=~clock;
        // #10;
    forever begin
        #10 
        clock=~clock;
        #10 
        clock=~clock;
        pc_counter=new_pc;
    end

    end

endmodule