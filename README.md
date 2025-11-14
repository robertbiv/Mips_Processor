# MIPS Processor

A single-cycle MIPS processor implementation in Verilog, designed as part of CMPEN 331 coursework at Penn State University.

## Project Overview

This project implements a simplified MIPS (Microprocessor without Interlocked Pipelined Stages) processor using Verilog HDL. The processor is designed to execute a subset of MIPS instructions and is synthesized using Xilinx Vivado.

**Author:** Robert Bennethum IV  
**Course:** CMPEN 331 - Computer Organization and Design  
**Institution:** Penn State University  
**Semester:** Spring 2023

## Features

- Single-cycle MIPS processor architecture
- Support for R-type, I-type, and J-type instructions
- Instruction memory with pre-loaded test programs
- Data memory with word-addressable storage
- Control unit for instruction decoding and control signal generation
- ALU (Arithmetic Logic Unit) for computational operations
- Full testbench for simulation and verification

## Supported Instructions

The processor supports the following MIPS instructions:

### R-Type Instructions
- `add` - Addition
- `sub` - Subtraction
- `and` - Bitwise AND
- `or` - Bitwise OR
- `slt` - Set on less than
- `sll` - Shift left logical
- `srl` - Shift right logical
- `jr` - Jump register

### I-Type Instructions
- `addi` - Add immediate
- `andi` - AND immediate
- `ori` - OR immediate
- `lw` - Load word
- `sw` - Store word
- `beq` - Branch if equal
- `bne` - Branch if not equal
- `slti` - Set on less than immediate

### J-Type Instructions
- `j` - Jump
- `jal` - Jump and link

## Project Structure

```
Mips_Processor/
├── lab3/                          # Vivado project directory
│   ├── lab3.srcs/
│   │   ├── sources_1/new/         # Main source files
│   │   │   ├── MIPSmachine.v      # Top-level MIPS machine module
│   │   │   ├── sccpu.v            # Single-cycle CPU with control unit
│   │   │   ├── scinstmem.v        # Instruction memory module
│   │   │   ├── scdatamem.v        # Data memory module
│   │   │   └── ConnectionBoard.v  # Module connections and integration
│   │   └── sim_1/new/             # Simulation files
│   │       └── testbench.v        # Testbench for processor verification
│   ├── lab3.xpr                   # Vivado project file
│   └── [other Vivado directories]
├── Project_CMPEN_331_Spring_2023.pdf  # Project specification
└── README.md                      # This file
```

## Module Descriptions

### ConnectionBoard.v
Top-level module that connects all processor components together. Provides clock and reset signals to the system and outputs PC (Program Counter), instruction, and ALU results.

### sccpu.v
Contains the control unit and main CPU logic:
- **Control Unit**: Decodes instructions and generates control signals (pcsrc, aluc, shift, wreg, wmem, regrt, jal, m2reg, aluimm, sext)
- Manages instruction execution flow
- Coordinates data path operations

### scinstmem.v (instrMem)
Instruction memory module:
- Stores program instructions in byte-addressable memory
- Fetches 32-bit instructions based on PC address
- Pre-loaded with test programs for simulation

### scdatamem.v (DataMem)
Data memory module:
- 32-word data memory array
- Word-addressable (aligned to 4-byte boundaries)
- Supports load word (lw) and store word (sw) operations
- Synchronous write, asynchronous read

### testbench.v
Simulation testbench:
- Generates clock signal (20ns period)
- Provides reset control
- Monitors PC, instruction, and ALU outputs

## Getting Started

### Prerequisites

- Xilinx Vivado Design Suite (tested with version compatible with Spring 2023)
- Basic understanding of Verilog HDL
- Familiarity with MIPS assembly language

### Running Simulations

1. Open the Vivado project:
   ```
   Open lab3/lab3.xpr in Vivado
   ```

2. Run behavioral simulation:
   - In Vivado, navigate to Flow Navigator → Simulation → Run Simulation → Run Behavioral Simulation
   - The testbench will execute and display waveforms

3. Observe the outputs:
   - Monitor the `pc` signal to track program execution
   - Watch the `inst` signal to see fetched instructions
   - Check the `alu` signal for ALU operation results

### Synthesis and Implementation

1. Run Synthesis:
   ```
   Flow Navigator → Synthesis → Run Synthesis
   ```

2. Run Implementation:
   ```
   Flow Navigator → Implementation → Run Implementation
   ```

3. Generate Bitstream (if targeting FPGA):
   ```
   Flow Navigator → Program and Debug → Generate Bitstream
   ```

## Design Details

### Clock and Reset
- Clock period: 20ns (50 MHz)
- Active-high reset (clrn signal)

### Data Path
- 32-bit instruction width
- 32-bit data width
- 32 general-purpose registers (standard MIPS register file)
- Word-aligned memory access

### Control Signals
- `pcsrc[1:0]`: PC source selection (sequential, branch, jump)
- `aluc[3:0]`: ALU operation code
- `shift`: Shift operation enable
- `wreg`: Register write enable
- `wmem`: Memory write enable
- `regrt`: Register target selection
- `jal`: Jump and link enable
- `m2reg`: Memory to register data selection
- `aluimm`: ALU immediate operand selection
- `sext`: Sign extension enable

## Testing

The processor includes pre-loaded test programs in the instruction memory. Example test cases include:
- Arithmetic operations (add, sub, addi)
- Logical operations (and, or, andi, ori)
- Shift operations (sll, srl)
- Memory operations (lw, sw)
- Branch and jump instructions

You can modify the instruction memory initialization in `scinstmem.v` to test additional programs.

## Documentation

For detailed project specifications and requirements, refer to:
- `Project_CMPEN_331_Spring_2023.pdf` - Complete project documentation and specifications

## License

This project was created for educational purposes as part of university coursework.

## Acknowledgments

- Course: CMPEN 331 - Computer Organization and Design
- Institution: Penn State University
- Semester: Spring 2023
