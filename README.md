# Y86-64-Processor
A Y86-64 processor implemented using Verilog that is capable of running Y86-64 instructions. This repository contains both a sequential model as well as a 5 stage pipelined model.

## Instructions 

```bash
halt 
nop
rrmovq
vmovle
cmovl
cmove
cmovne
cmovge
cmovg
irmovq
rmmovq
mrmovq
addq
subq
andq
xorq
jmp
jle
jl
je
jne
jge
jg
call 
ret
pushq
popq
```

## Contents

The contents of the repository are as follows: -

```bash
.
├── ALU
│   ├── ALU.v
│   ├── AND.v
│   ├── XOR.v
│   ├── adder.v
│   ├── decoder.v
│   ├── fulladder.v
│   └── subt.v
├── Pipeline
│   ├── Demo.txt
│   ├── control.v
│   ├── decode.v
│   ├── decode_register.v
│   ├── execute.v
│   ├── execute_register.v
│   ├── fetch.v
│   ├── fetch_register.v
│   ├── memory.v
│   ├── memory_register.v
│   ├── predict_pc.v
│   ├── proc_out.txt
│   ├── select_pc.v
│   ├── test.txt
│   ├── writeback.v
│   ├── writeback_register.v
│   └── z_processor.v
├── README.md
├── SEQ
│   ├── 1.txt
│   ├── 1_assemblycode.txt
│   ├── 2.txt
│   ├── 2_assemblycode.txt
│   ├── 3.txt
│   ├── ALU
│   │   ├── ALU.v
│   │   ├── AND.v
│   │   ├── XOR.v
│   │   ├── adder.v
│   │   ├── decoder.v
│   │   ├── fulladder.v
│   │   └── subt.v
│   ├── Demo.txt
│   ├── decode.v
│   ├── decode_tb.v
│   ├── decode_writeback.v
│   ├── execute.v
│   ├── execute_tb.v
│   ├── fetch.v
│   ├── fetch_tb.v
│   ├── fetch_tb_output.txt
│   ├── memory.v
│   ├── pc_update.v
│   ├── proc_out.txt
│   ├── processor.v
│   ├── writeback.v
│   ├── writeback_tb.v
│   └── writeback_tb_output.txt
└── report.pdf
```

Please refer to the report for more details. The sequential design works perfectly, the pipeline design is still a work in progress.
