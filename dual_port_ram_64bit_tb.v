module dual_port_ram_64bit_tb();
  
  reg clk;
  reg [1:0] rw;
  reg [5:0] addr_a, addr_b;
  reg [63:0] din_a, din_b;
  wire [63:0] dout_a, dout_b;
  
  dual_port_ram_64bit uut (
    .clk(clk),
    .rw(rw),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .din_a(din_a),
    .din_b(din_b),
    .dout_a(dout_a),
    .dout_b(dout_b)
  );
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Test write to both ports
    rw = 2'b01; // write to port A
    addr_a = 6'b000000;
    din_a = 64'b0101010101010101010101010101010101010101010101010101010101010101;
    #10;
    rw = 2'b10; // write to port B
    addr_b = 6'b000001;
    din_b = 64'b1010101010101010101010101010101010101010101010101010101010101010;
    #10;

    // Test read from both ports
    rw = 2'b00; // read from both ports
    addr_a = 6'b000000;
    addr_b = 6'b000001;
    #10;
    if (dout_a != 64'b0101010101010101010101010101010101010101010101010101010101010101) begin
      $display("ERROR: dout_a expected 64'b0101010101010101010101010101010101010101010101010101010101010101");
      $finish;
    end
    if (dout_b != 64'b1010101010101010101010101010101010101010101010101010101010101010) begin
      $display("ERROR: dout_b expected 64'b1010101010101010101010101010101010101010101010101010101010101010");
      $finish;
    end

    $display("Test passed");
    $finish;
  end

endmodule
