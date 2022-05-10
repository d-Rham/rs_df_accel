Elementary design for a 2D convolution accelerator in VHDL based on the row stationary dataflow architecture.
Building block for a capstone project.

Uses 3x3 PEs (Processing Elements), each PE contains a Multiply-Accumulate unit and ~1KB register file as an acting scratchpad memory. The current configuration is fixed for 3x3 convolution kernels and parallel convolution of 5 input rows.

This architecture will change and grow as the project progresses, with reconfigurability, support for different kernel and input sizes and dimensions, and hopefully an expansion into a full-fledged CNN accelerator.

I will also add further explanation and tcl scripts to generate Vivado and Quartus project files once I figure out how to tcl.

WIP..
