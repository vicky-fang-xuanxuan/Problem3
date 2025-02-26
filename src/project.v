/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule

module comparator_8bit (
    input  wire [7:0] ui_in,    // Dedicated inputs (A and B combined)
    output wire [7:0] uo_out,   // Dedicated outputs (C)
    input  wire [7:0] uio_in,   // IOs: Input path (not used)
    output wire [7:0] uio_out,  // IOs: Output path (not used)
    output wire [7:0] uio_oe,   // IOs: Enable path (not used)
    input  wire       ena,      // Always 1 when the design is powered (ignored)
    input  wire       clk,      // Clock (ignored for combinational logic)
    input  wire       rst_n     // Reset (ignored for combinational logic)
);

  // Extract A and B from the 8-bit input (assuming lower 8 bits are A, upper 8 bits are B)
  wire [7:0] A = ui_in;
  wire [7:0] B = uio_in;

  // Comparator Logic: If A < B, C[0] = 1; otherwise, C[0] = 0
  assign uo_out = (A < B) ? 8'b00000001 : 8'b00000000; 

  // Unused outputs set to zero
  assign uio_out = 8'b00000000;
  assign uio_oe  = 8'b00000000;

  // Prevent warnings for unused inputs
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
