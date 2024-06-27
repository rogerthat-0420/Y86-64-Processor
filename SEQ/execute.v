`include "./ALU/ALU.v"
`include "./ALU/decoder.v"
`include "./ALU/fulladder.v"
`include "./ALU/subt.v"
`include "./ALU/XOR.v"
`include "./ALU/adder.v"
`include "./ALU/AND.v"

module execute(
    input clock,
    input signed [63:0] vala, valb, valc,
    input [3:0] icode, ifun,
    output reg [63:0] vale,
    output reg condition_cnd,
    output reg overflow_flag,
    output reg sign_flag,
    output reg zero_flag
);

// i/o for alu
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
    condition_cnd = 1'b0;
end

// always @(posedge clock) begin
//     case (icode)
//         4'd6: {c1, c0} = ifun[1:0];
//         4'd2: {c1, c0} = 2'b00;
//         4'd3: {c1, c0} = 2'b00;
//         4'd4: {c1, c0} = 2'b00;
//         4'd5: {c1, c0} = 2'b00;
//         4'd9: {c1, c0} = 2'b00;
//         4'd11: {c1, c0} = 2'b00;
//         4'd8: {c1, c0} = 2'b01;
//         4'd10: {c1, c0} = 2'b01;
//         default: {c1, c0} = 2'b01;
//     endcase
// end

// always @(vala, valb, valc) begin
always @(*) begin

    if(clock==1)
    begin
        //test
        condition_cnd=0;

        case (icode)

            4'd2:
                begin 
                    {c1, c0} <= 2'b00;
                    input_A <= vala; 
                    input_B <= 64'd0; 
                    vale=output_alu;
                    if(ifun==4'd0)
                    begin
                        condition_cnd=1'b1;
                    end
                    else if(ifun==4'd1)
                    begin
                        condition_cnd=((sign_flag^overflow_flag) | zero_flag);
                    end
                    else if(ifun==4'd2)
                    begin
                        condition_cnd=(sign_flag^overflow_flag);
                    end
                    else if(ifun==4'd3)
                    begin
                        condition_cnd=zero_flag;
                    end
                    else if(ifun==4'd4)
                    begin
                        if(zero_flag==0)
                        begin
                            condition_cnd=1'b1;
                        end
                    end
                    else if(ifun==4'd5)
                    begin
                        if((sign_flag^overflow_flag)==0)
                            condition_cnd=1'b1;
                    end
                    else if(ifun==4'd6)
                    begin
                        if(((sign_flag^overflow_flag) | zero_flag)==0)
                            condition_cnd=1'b1;
                    end
                end 

            4'd3: 
                begin 
                    {c1, c0} <= 2'b00;
                    input_A <= valc; 
                    input_B <= 64'd0; 
                    vale=output_alu;
                end
            
            4'd4: 
                begin 
                    {c1, c0} <= 2'b00;
                    input_A <= valc; 
                    input_B <= valb; 
                    vale=output_alu;
                end 
            
            4'd5: 
                begin 
                    {c1, c0} <= 2'b00;
                    input_A <= valc; 
                    input_B <= valb; 
                    vale=output_alu;
                end 
            
            4'd6: 
                begin 
                    {c1, c0} = ifun[1:0];
                    input_A = valb; 
                    input_B = vala; 
                    vale=output_alu;

                    zero_flag = (output_alu==1'b0);
                    sign_flag = (output_alu[63]);
                    overflow_flag = overflow;
                end 
            
            4'd7:
                begin
                    if(ifun==4'd0)
                        condition_cnd=1'b1;
                    else if(ifun==4'd1)
                        condition_cnd=((sign_flag^overflow_flag) | zero_flag);
                    else if(ifun==4'd2)
                        condition_cnd=(sign_flag^overflow_flag);
                    else if(ifun==4'd3)
                        condition_cnd=zero_flag;
                    else if(ifun==4'd4)
                    begin
                        if(zero_flag==0)
                            condition_cnd=1'b1;
                    end
                    else if(ifun==4'd5)
                    begin
                        if((sign_flag^overflow_flag)==0)
                            condition_cnd=1'b1;
                    end
                    else if(ifun==4'd6)
                    begin
                        if(((sign_flag^overflow_flag) | zero_flag)==0)
                            condition_cnd=1'b1;
                    end
                end

            4'd8: 
                begin 
                    {c1, c0} <= 2'b01;
                    input_A <= valb; 
                    input_B <= 64'd8; 
                    vale=output_alu;
                end 

            4'd9: 
                begin 
                    {c1, c0} <= 2'b00;
                    input_A <= 64'd8; 
                    input_B <= valb; 
                    vale=output_alu;
                end 

            4'd10: 
                begin 
                    {c1, c0} <= 2'b01;
                    input_A <= valb; 
                    input_B <= 64'd8; 
                    vale=output_alu;
                end 

            4'd11: 
                begin 
                    {c1, c0} <= 2'b00;
                    input_A <= 64'd8; 
                    input_B <= valb; 
                    vale=output_alu;
                end 
            //default: begin input_A = 64'h8; input_B = 64'h0; end
        endcase
    end
end

// always @(*) begin
//     if (icode == 4'd6) begin
//         overflow_flag <= overflow;
//         sign_flag <= (vale < 0);
//         zero_flag <= (vale == 0);
//     end
// end


// always @(icode,ifun) begin
//     if (icode == 4'h2 || icode == 4'h7) begin
//         case (ifun)
            
//             4'h1: condition_cnd = (sign_flag ^ overflow_flag) | zero_flag; 
//             4'h2: condition_cnd = sign_flag ^ overflow_flag; 
//             4'h3: condition_cnd = zero_flag; 
//             4'h4: condition_cnd = ~zero_flag; 
//             4'h5: condition_cnd = ~(sign_flag ^ overflow_flag); 
//             4'h6: condition_cnd = ~(sign_flag ^ overflow_flag | zero_flag);
//             //default: condition_cnd = 1'b1;
//         endcase
//     end
// end

endmodule

