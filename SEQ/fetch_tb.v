`include "fetch.v"
module fetch_tb;

    reg clock;
    reg [63:0] pc_counter;

    wire[63:0] valc,valp;
    wire[3:0] icode,ifun,ra,rb;
    wire instruction_valid,imem_error,halt;

    fetch f0(
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

initial begin

        clock=0;
        #10 
        clock=~clock;
        pc_counter=64'd0;
        #10 
        $display("clock=%d, PC=%d, icode=%b, ifun=%b, rA=%b, rB=%b, valC=%d, valP=%d, instruction_valid=%d, imem_error=%d, halt=%d\n"
                ,clock,pc_counter,icode,ifun,ra,rb,valc,valp,instruction_valid,imem_error,halt);
        #10
        clock=~clock;

        repeat (4) begin
        #10 clock = ~clock;
        pc_counter = valp;
        #10
        $display("clock=%d, PC=%d, icode=%b, ifun=%b, rA=%b, rB=%b, valC=%d, valP=%d, instruction_valid=%d, imem_error=%d, halt=%d\n"
                ,clock,pc_counter,icode,ifun,ra,rb,valc,valp,instruction_valid,imem_error,halt);
        #10 clock = ~clock;
        end

    end
    
endmodule