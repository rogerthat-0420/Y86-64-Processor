`include "decode.v"
`include "fetch.v"
module decode_tb;

    // reg clock;
    reg[3:0] icode_dec,ra_dec,rb_dec;
    reg[63:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14;
    wire [63:0] vala,valb;

// taken from fetch testbench
    reg clock;
    reg [63:0] pc_counter;

    wire[63:0] valc,valp;
    wire[3:0] icode,ifun,ra,rb;
    wire instruction_valid,imem_error,halt;
//

    fetch f1(
        .clock(clock),
        .pc_counter(pc_counter),
        .valc(valc),
        .valp(valp),
        .ra(ra),
        .rb(rb),
        .icode(icode),
        .ifun(ifun),
        .instruction_valid(instruction_valid),
        .imem_error(imem_error),
        .halt(halt)

    );

    decode d0(
        .clock(clock),
        .icode(icode_dec),
        .ra(ra_dec),
        .rb(rb_dec),
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
        .vala(vala),
        .valb(valb)
    );

    initial begin

        r0 = 64'd12;
        r1 = 64'd25;
        r2 = 64'd38;
        r3 = 64'd87;
        r4 = 64'd10;
        r5 = 64'd45;
        r6 = 64'd33;
        r7 = 64'd145;
        r8 = 64'd345;
        r9 = 64'd420;
        r10 = 64'd1034;
        r11 = 64'd44;
        r12 = 64'd3;
        r13 = 64'd11;
        r14 = 64'd7;

        clock=0;
        #10 
        clock=~clock;
        pc_counter=64'd0;
        #10
        #10
        clock=~clock; 
        #10
        clock=~clock;
        icode_dec=icode;
        ra_dec=ra;
        rb_dec=rb;
        #10
        $display("pc=%d, icode=%b, icode_dec=%b, ra=%b, ra_dec=%d, rb=%b, rb_dec=%d, valA=%d, valB=%d\n",pc_counter,icode,icode_dec,ra,ra_dec,rb,rb_dec,vala,valb);
        #10
        clock=~clock;

        #10 
        clock=~clock;
        pc_counter=valp;
        #10
        #10
        clock=~clock; 
        #10
        clock=~clock;
        icode_dec=icode;
        ra_dec=ra;
        rb_dec=rb;
        #10
        $display("pc=%d, icode=%b, icode_dec=%b, ra=%b, ra_dec=%d, rb=%b, rb_dec=%d, valA=%d, valB=%d\n",pc_counter,icode,icode_dec,ra,ra_dec,rb,rb_dec,vala,valb);
        #10
        clock=~clock;

        #10 
        clock=~clock;
        pc_counter=valp;
        #10
        #10
        clock=~clock; 
        #10
        clock=~clock;
        icode_dec=icode;
        ra_dec=ra;
        rb_dec=rb;
        #10
        $display("pc=%d, icode=%b, icode_dec=%b, ra=%b, ra_dec=%d, rb=%b, rb_dec=%d, valA=%d, valB=%d\n",pc_counter,icode,icode_dec,ra,ra_dec,rb,rb_dec,vala,valb);
        #10
        clock=~clock;

        #10 
        clock=~clock;
        pc_counter=valp;
        #10
        #10
        clock=~clock; 
        #10
        clock=~clock;
        icode_dec=icode;
        ra_dec=ra;
        rb_dec=rb;
        #10
        $display("pc=%d, icode=%b, icode_dec=%b, ra=%b, ra_dec=%d, rb=%b, rb_dec=%d, valA=%d, valB=%d\n",pc_counter,icode,icode_dec,ra,ra_dec,rb,rb_dec,vala,valb);
        #10
        clock=~clock;






        // icode = 4'b0010; //cmovxx
        // ra = 4'b0101;
        // rb = 4'b1101;

        // repeat(4) begin
        //     #5 clock = ~clock;
        // end

        // $display("icode=%b, ra=%d, rb=%d, valA=%d, valB=%d\n",icode,ra,rb,vala,valb);

        // //return
        // icode = 4'b1010;
        // ra = 4'b0011;
        // rb = 4'b0111;

        // repeat(4) begin
        //     #5 clock = ~clock;
        // end

        // $display(" icode=%b, ra=%d, rb=%d, valA=%d, valB=%d\n",icode,ra,rb,vala,valb);

        // //pushq
        // icode=4'b1011;
        // ra=4'b0110;
        // rb=4'b0011;

        // repeat(4) begin
        //     #5 clock = ~clock;
        // end

        // $display("icode=%b, ra=%d, rb=%d, valA=%d, valB=%d\n",icode,ra,rb,vala,valb);

        // #20 $finish;
    end

    

endmodule