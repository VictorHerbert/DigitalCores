module FIFO #(parameter WIDTH = 4, parameter DEPTH = 4)(
    input clk, reset, 
    input write_request, read_request,
    output empty, full,
    output reg[DEPTH+1:0] counter,
    input       [WIDTH-1:0] data_in,
    output reg  [WIDTH-1:0] data_out
);

    wire read_enable, write_enable;
    wire [DEPTH-1:0] write_pointer; 
    wire [DEPTH-1:0] read_pointer;
    
    wire  [DEPTH-1:0] read_addr;
    wire  [DEPTH-1:0] write_addr;
    
    FIFOController #(DEPTH) fifo_controller(
        .clk, .reset,
        .write_request, .read_request,
        .write_enable, .read_enable,
        .empty, .full, .counter,
        .write_addr, .read_addr
    );

    Memory #(DEPTH, WIDTH) memory(
        .clk, .write_enable,
        .read_addr, .write_addr,
        .data_in, .data_out
    );

endmodule;