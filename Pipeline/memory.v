module memory(
    input clock,
    input [3:0] M_icode,M_dste,M_dstm,
    input [63:0] M_vala,M_vale,
    input [1:0] M_status,
    output reg [1:0] m_status,
    output reg [3:0] m_icode,m_dste,m_dstm,
    output reg memory_block_error,
    output reg [63:0] m_vale,m_valm,written_mem
);


reg [63:0] memory_register [0:1023];

initial begin
    memory_block_error=0;
    //modif
   // m_valm=0;
end

always@(*)
begin
    if(M_icode==4'd5) //mrmovq
    begin
        if(M_vale>1023)
            memory_block_error=1;
        else
            m_valm=memory_register[M_vale];
    end

    if(M_icode==4'd9) //return
    begin
        if(M_vala>1023)
            memory_block_error=1;
        else
            m_valm=memory_register[M_vala];
    end

    if(M_icode==4'd11) //popq
    begin
        if(M_vala>1023)
            memory_block_error=1;
        else
            m_valm=memory_register[M_vala];
    end

end

// always@(*)
// begin
// end

// always@(negedge clock)
always@(*)
begin
    if(M_vale>1023)
        memory_block_error=1;
    else
    begin
        if(M_icode==4'd4) //rmmovq
        begin
            memory_register[M_vale]=M_vala;
            written_mem=memory_register[M_vale];
        end
        
        if(M_icode==4'd8) //call
        begin
            memory_register[M_vale]=M_vala;
            written_mem=memory_register[M_vale];
        end

        if(M_icode==4'd10) //pushq
        begin
            memory_register[M_vale]=M_vala;
            written_mem=memory_register[M_vale];
        end
    end
end

always@(*)begin
    m_vale=M_vale;
    m_icode=M_icode;
    m_dste=M_dste;
    m_dstm=M_dstm;
end

always@(*)
begin
    if(memory_block_error==1)
        m_status=3;
    else 
        m_status=M_status;
end

endmodule