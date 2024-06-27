module writeback_register(
    input clock, W_stall,
    input [1:0] m_status,
    input memory_block_error,
    input [3:0] m_icode,m_dste,m_dstm,
    input [63:0] m_valm,m_vale,

    output reg [1:0] W_status,
    output reg [3:0] W_icode,W_dste,W_dstm,
    output reg [63:0] W_vale,W_valm
);

always@(posedge clock)
begin
    if(W_stall==0)
    begin
        W_icode<=m_icode;
        W_dste<=m_dste;
        W_dstm<=m_dstm;
        W_vale<=m_vale;
        W_valm<=m_valm;
        W_status<=m_status;
    end
end

endmodule