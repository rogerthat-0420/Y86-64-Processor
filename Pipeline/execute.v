`include "./ALU/ALU.v"
`include "./ALU/decoder.v"
`include "./ALU/fulladder.v"
`include "./ALU/subt.v"
`include "./ALU/XOR.v"
`include "./ALU/adder.v"
`include "./ALU/AND.v"

module execute(
    input clock,set_cc,
    input [3:0] E_icode,E_ifun,E_dste,E_dstm,
    input [1:0] E_status,
    input signed [63:0] E_vala, E_valb, E_valc,
    output reg [3:0] e_icode,
    output reg [1:0] e_status,
    output reg [63:0] e_vale,e_vala,
    output reg [3:0] e_dste,e_dstm,
    output reg e_cnd,
    // input clock,
    // input signed [63:0] vala, valb, valc,
    // input [3:0] icode, ifun,
    // output reg [63:0] vale,
    // output reg condition_cnd,
    output reg overflow_flag,
    output reg sign_flag,
    output reg zero_flag
);

reg signed [63:0] input_A, input_B;
reg c0, c1;
wire overflow;
wire signed [63:0] output_alu;

ALU alu0(
    .c0(c0),
    .c1(c1),
    .a(input_A), 
    .b(input_B), 
    .output_alu(output_alu), 
    .bit_overflow(overflow)
    );

initial begin
    overflow_flag = 1'b0;
    sign_flag = 1'b0;
    zero_flag = 1'b0;
    e_cnd = 1'b0;
end

always @(*) begin

    e_cnd=0;

    // if(clock==1)
    // begin
        //test
        // e_cnd=0;

        case (E_icode)

            4'd2:
                begin 
                    {c1, c0} = 2'b00;
                    input_A = E_vala; 
                    input_B = 64'd0; 
                    e_vale=output_alu;
                    if(E_ifun==4'd0)
                    begin
                        e_cnd=1'b1;
                    end
                    else if(E_ifun==4'd1)
                    begin
                        e_cnd=((sign_flag^overflow_flag) | zero_flag);
                    end
                    else if(E_ifun==4'd2)
                    begin
                        e_cnd=(sign_flag^overflow_flag);
                    end
                    else if(E_ifun==4'd3)
                    begin
                        e_cnd=zero_flag;
                    end
                    else if(E_ifun==4'd4)
                    begin
                        e_cnd=~zero_flag;
                    end
                    else if(E_ifun==4'd5)
                    begin
                        e_cnd=~(sign_flag^overflow_flag);
                    end
                    else if(E_ifun==4'd6)
                    begin
                        e_cnd=~((sign_flag ^ overflow_flag) | zero_flag);;
                    end

                    if(e_cnd==0)
                        e_dste=4'd15;
                    else
                        e_dste=E_dste;
                end 

            4'd3: 
                begin 
                    {c1, c0} = 2'b00;
                    input_A = E_valc; 
                    input_B = 64'd0; 
                    e_vale=output_alu;
                    e_dste=E_dste;
                end
            
            4'd4: 
                begin 
                    {c1, c0} = 2'b00;
                    input_A = E_valc; 
                    input_B = E_valb; 
                    e_vale=output_alu;
                    e_dste=E_dste;
                end 
            
            4'd5: 
                begin 
                    {c1, c0} = 2'b00;
                    input_A = E_valc; 
                    input_B = E_valb; 
                    e_vale=output_alu;
                    e_dste=E_dste;
                end 
            
            4'd6: 
                begin 
                    {c1, c0} = E_ifun[1:0];
                    input_A = E_valb; 
                    input_B = E_vala; 
                    e_vale=output_alu;
                    e_dste=E_dste;

                    if(set_cc==1)
                    begin

                        sign_flag = (output_alu[63]);
                        overflow_flag = overflow;

                        if(output_alu==64'b0)
                            zero_flag=1;
                        else 
                            zero_flag=0;
                        // zero_flag = (output_alu==64'b0);
                    end
                end 
            
            4'd7:
                begin
                    if(E_ifun==4'd0)
                        e_cnd=1'b1;
                    else if(E_ifun==4'd1)
                        e_cnd=((sign_flag^overflow_flag) | zero_flag);
                    else if(E_ifun==4'd2)
                        e_cnd=(sign_flag^overflow_flag);
                    else if(E_ifun==4'd3)
                        e_cnd=zero_flag;
                    else if(E_ifun==4'd4)
                        e_cnd=~zero_flag;
                    else if(E_ifun==4'd5)
                        e_cnd=~(sign_flag ^ overflow_flag);
                    else if(E_ifun==4'd6)
                        e_cnd=~((sign_flag ^ overflow_flag) | zero_flag);

                    e_dste=E_dste;
                end

            4'd8: 
                begin 
                    {c1, c0} = 2'b01;
                    input_A = E_valb; 
                    input_B = 64'd8; 
                    e_vale=output_alu;
                    e_dste=E_dste;
                end 

            4'd9: 
                begin 
                    {c1, c0} = 2'b00;
                    input_A = 64'd8; 
                    input_B = E_valb; 
                    e_vale=output_alu;
                    e_dste=E_dste;
                end 

            4'd10: 
                begin 
                    {c1, c0} = 2'b01;
                    input_A = E_valb; 
                    input_B = 64'd8; 
                    e_vale=output_alu;
                    e_dste=E_dste;
                end 

            4'd11: 
                begin 
                    {c1, c0} = 2'b00;
                    input_A = 64'd8; 
                    input_B = E_valb; 
                    e_vale=output_alu;
                    e_dste=E_dste;
                end 
        endcase

        e_icode=E_icode;
        e_dstm=E_dstm;
        e_status=E_status;
        e_vala=E_vala;

        // if(E_icode!=4'd2)
        //     e_dste=E_dste;
    end
// end


endmodule