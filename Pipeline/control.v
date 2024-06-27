module control(
    input clock,
    input e_cnd,
    input [1:0] m_status, W_status,
    input [3:0] D_icode, E_icode, M_icode, E_dstm, d_srca, d_srcb,
    output reg F_stall,D_stall,D_bubble,E_bubble,M_bubble,W_stall,set_cc
);

initial begin
    F_stall=0;
    D_stall=0;
    D_bubble=0;
    E_bubble=0;
    M_bubble=0;
    W_stall=0;
    set_cc=0;
end

always @(*) begin

    if(((E_icode == 4'd5 || E_icode == 4'd11) && (E_dstm == d_srca || E_dstm == d_srcb)) || (D_icode == 4'd9 || E_icode == 4'd9 || M_icode == 4'd9))
    begin
        F_stall = 1;
    end
    else
    begin
        F_stall = 0;
    end

    if((E_icode == 4'd5 || E_icode == 4'd11) && (E_dstm == d_srca || E_dstm == d_srcb))
    begin
        D_stall = 1;
    end
    else
    begin
        D_stall = 0; 
    end

    if((E_icode == 4'd7 && !e_cnd) || (!((E_icode == 4'd5 || E_icode == 4'd11) && (E_dstm == d_srca || E_dstm == d_srcb)) && (D_icode == 4'd9 || E_icode == 4'd9 || M_icode == 4'd9)))
    begin
        D_bubble = 1;
    end
    else
    begin
        D_bubble = 0;
    end

    //E_bubble conditions
    if((E_icode == 4'd7 && !e_cnd)|| ((E_icode == 4'd5 || E_icode == 4'd11)&& (E_dstm == d_srca || E_dstm == d_srcb)))
    begin
        E_bubble = 1;
    end
    else
    begin
        E_bubble = 0;
    end

    //M_bubble conditions 
    if((m_status == 1 || m_status == 2 || m_status == 3) || (W_status == 1 || W_status == 2 || W_status == 3))
    begin
        M_bubble = 1;
    end
    else
    begin
        M_bubble = 0; 
    end
    //W_stall conditions 
    if(W_status == 1 || W_status == 2 || W_status == 3)
    begin
        W_stall = 1;
    end
    else
    begin
        W_stall = 0;
    end
    //set_cc conditions 
    if((E_icode == 4'd6) && !(m_status!=0) && !(W_status != 0))
    begin
        set_cc = 1;
    end
    else
    begin
        set_cc = 0;
    end
end
endmodule
