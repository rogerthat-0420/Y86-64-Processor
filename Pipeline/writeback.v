module writeback(
    input clock,
    input [3:0] W_dste,W_dstm,W_icode,
    input [63:0] W_vale,W_valm,
    input [1:0] W_status,
    output reg [63:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14
);

reg[63:0] register_file[0:14];

// always@(negedge clock)
always@(posedge clock)
begin
    if(W_status==0)
    begin
        if(W_dste != 15) register_file[W_dste] = W_vale;
        if(W_dstm != 15) register_file[W_dstm] = W_valm;
    end

    r0=register_file[0];
    r1=register_file[1];
    r2=register_file[2];
    r3=register_file[3];
    r4=register_file[4];
    r5=register_file[5];
    r6=register_file[6];
    r7=register_file[7];
    r8=register_file[8];
    r9=register_file[9];
    r10=register_file[10];
    r11=register_file[11];
    r12=register_file[12];
    r13=register_file[13];
    r14=register_file[14];
end




endmodule