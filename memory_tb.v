module memory_tb;

  // Inputs
  reg we;
  reg rst;
  reg clk;
  reg enable_mem;
  reg [31:0] addr;
  reg [31:0] data_in;

  // Outputs
  wire [31:0] data;

  // Instantiate the memory module
  memory uut (
    .we(we), 
    .rst(rst), 
    .clk(clk), 
    .data(data), 
    .addr(addr), 
    .enable_mem(enable_mem)
  );

  // Assign data to inout port
  assign data = (we && enable_mem) ? data_in : 32'bZ;

  // Clock generation
  always begin
    #5 clk = ~clk; // Clock toggles every 5 time units
  end

  // Test cases
  initial begin
    // Initialize Inputs
    we = 0;
    rst = 0;
    clk = 0;
    enable_mem = 0;
    addr = 0;
    data_in = 32'h0;

    // Reset memory
    #10;
    rst = 1;
    #10;
    rst = 0;

    // Enable memory, write some data
    enable_mem = 1;
    we = 1;
    addr = 32'h00000002;
    data_in = 32'hABCD1234;
    #10;

    // Disable write, read the data
    we = 0;
    #10;

    // Change address, and write more data
    addr = 32'h00000004;
    data_in = 32'hDEADBEEF;
    we = 1;
    #10;
    
    // Disable write, and read again
    we = 0;
    #10;

    // End simulation
    $finish;
  end

endmodule

