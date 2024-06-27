`include "control.v"
`include "fetch.v"
`include "fetch_register.v"
`include "decode.v"
`include "decode_register.v"
`include "execute.v"
`include "execute_register.v"
`include "memory.v"
`include "memory_register.v"
`include "predict_pc.v"
`include "select_pc.v"
`include "writeback.v"
`include "writeback_register.v"

module processor;

reg clock;
wire[63:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14;
wire F_stall,D_stall,D_bubble,E_bubble,M_bubble,W_stall,set_cc;

wire [3:0] f_icode,f_ifun,f_ra,f_rb;
wire[63:0] f_valc,f_valp;
wire[1:0] f_status;
// wire instruction_valid,imem_error,halt;

wire[63:0] predict_pc,F_predpc,f_pc;

wire [1:0] D_status;
wire [3:0] D_icode,D_ifun,D_ra,D_rb;
wire [63:0] D_valc,D_valp;
wire[3:0] d_dste,d_dstm,d_srca,d_srcb,d_icode,d_ifun;
wire[63:0] d_vala,d_valb,d_valc;
wire [1:0] d_status;

wire [1:0] E_status;
wire [3:0] E_icode,E_ifun,E_srca,E_srcb,E_dste,E_dstm;
wire [63:0] E_vala,E_valb,E_valc;
wire [63:0] e_vale,e_vala;
wire [1:0] e_status;
wire [3:0] e_dste,e_icode,e_dstm;
wire e_cnd;
wire overflow_flag,sign_flag,zero_flag;

wire [1:0] M_status;
wire M_cnd;
wire [63:0] M_vala,M_vale;
wire [3:0] M_dste,M_dstm,M_icode;
wire [3:0] m_icode,m_dste,m_dstm;
wire [63:0] m_vale,m_valm,written_mem;
wire memory_block_error;
wire [1:0] m_status;

wire [1:0] W_status;
wire [3:0] W_icode,W_dste,W_dstm;
wire [63:0] W_vale,W_valm;

fetch_register freg(
    .clock(clock),
    .predict_pc(predict_pc),
    .F_stall(F_stall),
    .F_predpc(F_predpc)
);

fetch f0(
    .clock(clock),
    .f_pc(f_pc),
    .f_icode(f_icode),
    .f_ifun(f_ifun),
    .f_ra(f_ra),
    .f_rb(f_rb),
    .f_valc(f_valc),
    .f_valp(f_valp),
    .f_status(f_status)
);

predict_pc predpcmod(
    .f_icode(f_icode),
    .f_valc(f_valc),
    .f_valp(f_valp),
    .predict_pc(predict_pc)
);

select_pc selpcmod(
    .clock(clock),
    .M_cnd(M_cnd),
    .M_icode(M_icode),
    .W_icode(W_icode),
    .M_vala(M_vala),
    .m_valm(m_valm),
    .F_predpc(F_predpc),
    .f_pc(f_pc)
);

decode_register decreg(
    .clock(clock),
    .f_icode(f_icode),
    .f_ifun(f_ifun),
    .f_ra(f_ra),
    .f_rb(f_rb),
    .f_valc(f_valc),
    .f_valp(f_valp),
    .f_status(f_status),
    .D_stall(D_stall),
    .D_bubble(D_bubble),
    .D_status(D_status),
    .D_icode(D_icode),
    .D_ifun(D_ifun),
    .D_ra(D_ra),
    .D_rb(D_rb),
    .D_valc(D_valc),
    .D_valp(D_valp)
);

decode dec0(
    .clock(clock),
    .D_icode(D_icode),
    .D_ifun(D_ifun),
    .D_ra(D_ra),
    .D_rb(D_rb),
    .D_status(D_status),
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
    .e_vale(e_vale),
    .m_valm(m_valm),
    .M_vale(M_vale),
    .W_valm(W_valm),
    .W_vale(W_vale),
    .e_dste(e_dste),
    .M_dstm(M_dstm),
    .M_dste(M_dste),
    .W_dstm(W_dstm),
    .W_dste(W_dste),
    .D_valp(D_valp),
    .D_valc(D_valc),
    .d_vala(d_vala),
    .d_valb(d_valb),
    .d_valc(d_valc),
    .d_status(d_status),
    .d_dste(d_dste),
    .d_dstm(d_dstm),
    .d_srca(d_srca),
    .d_srcb(d_srcb),
    .d_icode(d_icode),
    .d_ifun(d_ifun)
);

execute_register execreg0(
    .clock(clock),
    .d_status(d_status),
    .E_bubble(E_bubble),
    .d_icode(d_icode),
    .d_ifun(d_ifun),
    .d_srca(d_srca),
    .d_srcb(d_srcb),
    .d_dste(d_dste),
    .d_dstm(d_dstm),
    .d_vala(d_vala),
    .d_valb(d_valb),
    .d_valc(d_valc),
    .E_icode(E_icode),
    .E_ifun(E_ifun),
    .E_srca(E_srca),
    .E_srcb(E_srcb),
    .E_dste(E_dste),
    .E_dstm(E_dstm),
    .E_vala(E_vala),
    .E_valb(E_valb),
    .E_valc(E_valc),
    .E_status(E_status)
);

execute exec0(
    .clock(clock),
    .set_cc(set_cc),
    .E_icode(E_icode),
    .E_ifun(E_ifun),
    .E_dste(E_dste),
    .E_dstm(E_dstm),
    .E_status(E_status),
    .E_vala(E_vala),
    .E_valb(E_valb),
    .E_valc(E_valc),
    .e_icode(e_icode),
    .e_status(e_status),
    .e_vale(e_vale),
    .e_vala(e_vala),
    .e_dste(e_dste),
    .e_dstm(e_dstm),
    .e_cnd(e_cnd),
    .overflow_flag(overflow_flag),
    .sign_flag(sign_flag),
    .zero_flag(zero_flag)
);

memory_register memreg0(
    .clock(clock),
    .M_bubble(M_bubble),
    .e_cnd(e_cnd),
    .e_status(e_status),
    .e_icode(e_icode),
    .e_dste(e_dste),
    .e_dstm(e_dstm),
    .e_vala(e_vala),
    .e_vale(e_vale),
    .M_status(M_status),
    .M_cnd(M_cnd),
    .M_vala(M_vala),
    .M_vale(M_vale),
    .M_dste(M_dste),
    .M_dstm(M_dstm),
    .M_icode(M_icode)
);

memory mem0(
    .clock(clock),
    .M_icode(M_icode),
    .M_dste(M_dste),
    .M_dstm(M_dstm),
    .M_vala(M_vala),
    .M_vale(M_vale),
    .m_icode(m_icode),
    .m_dste(m_dste),
    .m_dstm(m_dstm),
    .memory_block_error(memory_block_error),
    .m_valm(m_valm),
    .m_vale(m_vale),
    .written_mem(written_mem),
    .M_status(M_status),
    .m_status(m_status)
);

writeback_register wbreg0(
    .clock(clock),
    .W_stall(W_stall),
    .m_status(m_status),
    .memory_block_error(memory_block_error),
    .m_icode(m_icode),
    .m_dste(m_dste),
    .m_dstm(m_dstm),
    .m_valm(m_valm),
    .m_vale(m_vale),
    .W_status(W_status),
    .W_icode(W_icode),
    .W_dste(W_dste),
    .W_dstm(W_dstm),
    .W_vale(W_vale),
    .W_valm(W_valm)
);

writeback wb0(
    .clock(clock),
    .W_dste(W_dste),
    .W_dstm(W_dstm),
    .W_icode(W_icode),
    .W_vale(W_vale),
    .W_valm(W_valm),
    .W_status(W_status),
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
    .r14(r14)
);

control cont0(
    .clock(clock),
    .e_cnd(e_cnd),
    .m_status(m_status),
    .W_status(W_status),
    .D_icode(D_icode),
    .E_icode(E_icode),
    .M_icode(M_icode),
    .E_dstm(E_dstm),
    .d_srca(d_srca),
    .d_srcb(d_srcb),
    .F_stall(F_stall),
    .D_stall(D_stall),
    .D_bubble(D_bubble),
    .E_bubble(E_bubble),
    .M_bubble(M_bubble),
    .W_stall(W_stall),
    .set_cc(set_cc)
);

always@(*)begin
    if(D_status!=0 & E_status!=0 & M_status!=0 & W_status!=0)
        $finish;
end

initial begin
    clock=0;
    forever begin
        #10 clock=~clock;
    end
end

initial begin
  // $monitor("clk = %b, f_pc = %d, f_icode = %h, f_ifun = %h, f_rA = %d, f_rB = %d, D_icode = %h, D_ifun = %h, D_rA = %d, D_rB = %d, D_valP = %d, d_icode = %h, d_ifun = %h, d_valA = %d, d_valB = %d, d_valC = %d, d_srcA = %d, d_srcB = %d, d_dstM = %d, d_dstE = %d, E_icode = %h, E_ifun = %h, E_valA = %d, E_valB = %d, E_valC = %d, E_srcA = %d, E_srcB = %d, E_dstM = %d, E_dstE = %d, e_valE = %d , reg[0] = %d, reg[1] = %d, reg[2] = %d, reg[3] = %d, reg[4] = %d, reg[6] = %d, reg[7] = %d", 
   //     clock, f_pc, f_icode, f_ifun, f_ra, f_rb, D_icode, D_ifun, D_ra, D_rb, D_valp, d_icode, d_ifun, d_vala, d_valb, d_valc, d_srca, d_srcb, d_dstm, d_dste, E_icode, E_ifun, E_vala, E_valb, E_valc, E_srca, E_srcb, E_dstm, E_dste, e_vale,
    //    r0, r1, r2, r3, r4, r6, r7);

   $monitor("clock=%d, f_pc=%d, f_icode = %d, f_ifun = %d, f_rA = %d, f_rB = %d, f_status=%d, D_icode = %d, D_ifun = %d, D_rA = %d, D_rB = %d, D_valp=%d, D_valc=%d, D_status=%d, E_icode=%d, E_ifun=%d, E_srca=%d, E_srcb=%d, E_dste=%d, E_dstm=%d, E_vala=%d, E_valb=%d, E_valc=%d, E_status=%d, e_cnd=%d, M_icode=%d, M_status=%d, M_cnd=%d, M_vale=%d, M_vala=%d, M_dste=%d, M_dstm=%d, W_icode=%d, D_bubble=%d r0=%d",clock,f_pc,f_icode,f_ifun,f_ra,f_rb,f_status,D_icode,D_ifun,D_ra,D_rb,D_valp,D_valc,D_status,E_icode,E_ifun,E_srca,E_srcb,E_dste,E_dstm,E_vala,E_valb,E_valc,E_status,e_cnd,M_icode,M_status, M_cnd, M_vale, M_vala, M_dste, M_dstm,W_icode,
            D_bubble,r0);
  // $monitor("set_cc=%d zero_flag=%d F_stall=%d D_status=%d E_status=%d M_status=%d W_status=%d d_valc=%d clock=%d e_vale=%d d_vala=%d d_valb=%d r0=%d r1=%d r2=%d r3=%d r4=%d r5=%d r6=%d r7=%d r8=%d r9=%d r10=%d r11=%d r12=%d r13=%d r14=%d f_pc=%d, predict_pc=%d F_predpc=%d f_icode=%d f_ifun=%d f_ra=%d f_rb=%d f_valc=%d f_valp=%d D_status=%d D_icode=%d D_ifun=%d D_ra=%d D_rb=%d D_valc=%d D_valp=%d E_icode=%d E_ifun=%d E_srca=%d E_srcb=%d E_dste=%d E_dstm=%d E_vala=%d E_valb=%d E_valc=%d E_status=%d e_cnd=%d M_status=%d M_icode=%d M_cnd=%d M_vala=%d M_vale=%d M_dste=%d M_dstm=%d W_status=%d W_icode=%d W_dste=%d W_dstm=%d W_vale=%d W_valm=%d \n",set_cc,zero_flag,F_stall,D_status, E_status, M_status, W_status, d_valc,clock,e_vale,d_vala,d_valb,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,f_pc,predict_pc,F_predpc,f_icode,f_ifun,f_ra,f_rb,f_valc,f_valp,D_status,D_icode,D_ifun,D_ra,D_rb,D_valc,D_valp,E_icode,E_ifun,E_srca,E_srcb,E_dste,E_dstm,E_vala,E_valb,E_valc,E_status,e_cnd,M_status,M_icode,M_cnd,M_vala,M_vale,M_dste,M_dstm,W_status,W_icode,W_dste,W_dstm,W_vale,W_valm);
end




endmodule