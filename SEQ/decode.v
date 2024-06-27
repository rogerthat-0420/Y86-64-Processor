module decode (
    input clock,
    input [3:0] icode, ra, rb,
    input [63:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14,
    output reg [63:0] vala, valb
);

    reg [63:0] register_file [0:14];

    always @(*) begin

        if(clock) begin

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

        case (icode)

            4'd2: // cmovxx
                begin
                    vala = register_file[ra];
                end

            4'd4: // rmmovq
                begin
                    vala = register_file[ra];
                    valb = register_file[rb];
                end

            4'd5: // mrmovq
                begin
                    valb = register_file[rb];
                end

            4'd6: // opq
                begin
                    vala = register_file[ra];
                    valb = register_file[rb];
                end

            4'd8: // call
                begin
                    valb = register_file[4]; // rsp
                end

            4'd9: // return
                begin
                    vala = register_file[4]; // rsp
                    valb = register_file[4]; // rsp
                end

            4'd10: // pushq
                begin
                    vala = register_file[ra];
                    valb = register_file[4]; // rsp
                end

            4'd11: // popq
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
        end
    end
endmodule
