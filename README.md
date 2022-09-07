Design of a simple Convolution Accelerator in VHDL.

What is a dataflow ? refer to https://people.csail.mit.edu/emer/papers/2017.05.ieee_micro.dnn_dataflow.pdf

Contains A ~100KB on-chip BRAM global buffer memory, a highly flexible NoC based on microswitches, sourced from: https://synergy.ece.gatech.edu/tools/microswitch-noc/

Uses 4x4 PE Bank (Processing Elements). Each PE contains a DSP-instanced Multiply-Accumulate unit and ~1KB register file as an acting scratchpad memory. The current configuration supports a maximum of 16x16 Convolution Kernels for spatial mapping / Parallel execution (As per weight stationary dataflow) or 4x4 Conv Kernels with 7x7 Input feature maps (As per Row stationary dataflow). Bigger Conv and IFM sizes can be computed simply by tiling them onto the existing resources and/or temporally schedueling them. Matrix Multiplications are also supported.

This architecture is intended to be used with an automated mapper/compiler.

This is still work-in-progress, further explanation will be provided as it progresses. Currently working on: Controller design.

WIP...


