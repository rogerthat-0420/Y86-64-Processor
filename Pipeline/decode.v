module decode(
    input clock,
    input [3:0] D_icode, D_ifun, D_ra, D_rb,
    input [63:0] D_valp,D_valc,
    input [1:0] D_status,
    input [63:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14,
    input [63:0] e_vale, m_valm, M_vale, W_valm, W_vale,
    input [3:0] e_dste, M_dstm, M_dste, W_dstm, W_dste,
    output reg [63:0] d_vala, d_valb,d_valc,
    output reg [1:0] d_status,
    output reg [3:0] d_dste, d_dstm, d_srca, d_srcb, d_icode, d_ifun
);

reg [63:0] register_file [0:14];
reg [63:0] vala,valb;

always @(*) 
begin

        d_icode=D_icode;
        d_ifun=D_ifun;
        d_status=D_status;
        d_valc=D_valc;
    // if(clock) 
    // begin
        register_file[0] = r0;
        register_file[1] = r1;
        register_file[2] = r2;
        register_file[3] = r3;
        register_file[4] = r4;
        register_file[5] = r5;
        register_file[6] = r6;
        register_file[7] = r7;
        register_file[8] = r8;
        register_file[9] = r9;
        register_file[10] = r10;
        register_file[11] = r11;
        register_file[12] = r12;
        register_file[13] = r13;
        register_file[14] = r14;

            if(d_icode==4'd0 | d_icode==4'd1 | d_icode==4'd7) //halt,nop,jump
                begin
                    d_srca=4'd15;d_srcb=4'd15;d_dste=4'd15;d_dstm=4'd15;
                end

            else if(d_icode==4'd2 | d_icode==4'd6) // cmovxx
                begin
                    d_srca=D_ra;d_srcb=D_rb;d_dste=D_rb;d_dstm=4'd15;
                end
            
            else if(d_icode==4'd3)  //irmovq
                begin
                    d_srca=4'd15;d_srcb=D_rb;d_dste=D_rb;d_dstm=4'd15;
                end

            else if(d_icode==4'd4) // rmmovq
                begin
                    d_srca=D_ra;d_srcb=D_rb;d_dste=4'd15;d_dstm=4'd15;
                end

            else if(d_icode==4'd5) // mrmovq
                begin
                    d_srca=4'd15;d_srcb=D_rb;d_dste=4'd15;d_dstm=D_ra;
                end

            else if(d_icode==4'd8) // call
                begin
                    d_srca=4'd15;d_srcb=4;d_dste=4;d_dstm=4'd15;
                end

            else if(d_icode==4'd9) // return
                begin
                    d_srca = 4;d_srcb = 4;d_dste = 4;d_dstm = 4'd15;
                end

            else if(d_icode==4'd10) // pushq
                begin
                    d_srca = D_ra;d_srcb = 4;d_dste = 4;d_dstm = 4'd15;
                end

            else if(d_icode==4'd11) // popq
                begin
                    d_srca = 4;d_srcb = 4;d_dste = 4;d_dstm = D_ra;
                end

        if(D_icode==4'd7 | D_icode==4'd8)
            d_vala=D_valp;
        else if(d_srca!=15)
            d_vala=register_file[d_srca];
        else
            d_vala=0;
        
        if(d_srcb!=15)
            d_valb=register_file[d_srcb];
        else
            d_valb=0;

        // sel+fwd A

        if(d_srca!=15)
        begin
            if(d_srca==e_dste)
                d_vala=e_vale;
            else if(d_srca==M_dstm)
                d_vala=m_valm;
            else if(d_srca==M_dste)
                d_vala=M_vale;
            else if(d_srca==W_dste)
                d_vala=W_vale;
            else if(d_srca==W_dstm)
                d_vala=W_valm;
            else
                d_vala=vala;
        end

        //fwd B
        if(d_srcb!=15)
        begin
            if(d_srcb==e_dste)
                d_valb=e_vale;
            else if(d_srcb==M_dstm)
                d_valb=m_valm;
            else if(d_srcb==M_dste)
                d_valb=M_vale;
            else if(d_srcb==W_dste)
                d_valb=W_vale;
            else if(d_srcb==W_dstm)
                d_valb=W_valm;
            else
                d_valb=valb;
        end

    // end
end
endmodule