module decode_writeback(
    input clock,
    input [3:0] icode, ra, rb,
    output reg [63:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14,
    output reg [63:0] vala, valb,
    input condition_cnd,
    input [63:0] vale,valm
);

reg [63:0] register_file [0:14];

// initial begin
//         register_file[0] = 0;
//         register_file[1] = 0;
//         register_file[2] = 0;
//         register_file[3] = 0;
//         register_file[4] = 0;
//         register_file[5] = 0;
//         register_file[6] = 0;
//         register_file[7] = 0;
//         register_file[8] = 0;
//         register_file[9] = 0;
//         register_file[10] = 0;
//         register_file[11] = 0;
//         register_file[12] = 0;
//         register_file[13] =0;
//         register_file[14] = 0;
// end

always @(*) begin


        case (icode)

            4'b0010: // cmovxx
                begin
                    vala = register_file[ra];
                end

            4'b0100: // rmmovq
                begin
                    vala = register_file[ra];
                    valb = register_file[rb];
                end

            4'b0101: // mrmovq
                begin
                    valb = register_file[rb];
                end

            4'b0110: // opq
                begin
                    vala = register_file[ra];
                    valb = register_file[rb];
                end

            4'b1001: // call
                begin
                    valb = register_file[4]; // rsp
                end

            4'b1010: // return
                begin
                    vala = register_file[4]; // rsp
                    valb = register_file[4]; // rsp
                end

            4'b1011: // pushq
                begin
                    vala = register_file[ra];
                    valb = register_file[4]; // rsp
                end

            4'b1100: // popq
                begin
                    vala = register_file[4]; // rsp
                    valb = register_file[4]; // rsp
                end

            // default:
            //     begin
            //         vala = 64'h0;
            //         valb = 64'h0;
            //     end

        endcase
        // r0=register_file[0];
        // r1=register_file[1];
        // r2=register_file[2];
        // r3=register_file[3];
        // r4=register_file[4];
        // r5=register_file[5];
        // r6=register_file[6];
        // r7=register_file[7];
        // r8=register_file[8];
        // r9=register_file[9];
        // r10=register_file[10];
        // r11=register_file[12];
        // r13=register_file[13];
        // r14=register_file[14];
    end

always@(negedge clock)
    begin

        if(icode==4'b0010)//cmovxx
            begin
                if(condition_cnd==1)
                begin
                    register_file[rb]=vale;
                end
            end

        else if(icode==4'b0011) //irmovq
            begin
                register_file[rb]=vale;
            end

        else if(icode==4'b0101) //mrmovq
            begin
                register_file[ra]=valm;
            end

        else if(icode==4'b0110) //opq
            begin
                register_file[rb]=vale;
            end
        
        else if(icode==4'b1000) //call
            begin
                register_file[4]=vale;
            end
        
        else if(icode==4'b1001) //return
            begin
                register_file[4]=vale;
            end
        
        else if(icode==4'b1010) //pushq
            begin
                register_file[4]=vale;
            end
        
        else if(icode==4'b1011) //popq
            begin
                register_file[4]=vale;
                register_file[ra]=valm;
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