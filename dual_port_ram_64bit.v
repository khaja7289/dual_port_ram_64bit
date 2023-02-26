module dual_port_ram_64bit(
  input clk,
  input [1:0] rw,
  input [5:0] addr_a,
  input [5:0] addr_b,
  input [63:0] din_a,
  input [63:0] din_b,
  output [63:0] dout_a,
  output [63:0] dout_b
);
  
  reg [63:0] mem [63:0];

  always @(posedge clk) begin
    if (rw[0]) mem[addr_a] <= din_a;
    if (rw[1]) mem[addr_b] <= din_b;
  end

  assign dout_a = mem[addr_a];
  assign dout_b = mem[addr_b];

endmodule
