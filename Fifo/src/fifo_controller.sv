module FIFOController #(parameter DEPTH)(
    input clk, reset, 
    input  read_request, write_request,
    output reg read_enable, write_enable, 
    output empty, full,
    output reg[DEPTH+1:0] counter,
    output [DEPTH-1:0] read_addr,
    output [DEPTH-1:0] write_addr
);

    reg [DEPTH:0] write_pointer; 
    reg [DEPTH:0] read_pointer;

    assign write_addr = write_pointer[DEPTH-1:0];
    assign read_addr = read_pointer[DEPTH-1:0];

    assign empty = write_pointer == read_pointer;
    assign full = (write_addr == read_addr) && (write_pointer[DEPTH]^read_pointer[DEPTH]);


    always_comb begin
        if(~reset) begin
            read_enable <= (read_request & ~empty);
            write_enable <= (write_request & ~full);
        end
    end

    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            write_pointer = 0;
            read_pointer = 0;
            counter = 0;
        end
        else begin
            if(read_request & ~empty) begin
                read_pointer <= read_pointer+1;
                counter = counter-1;
            end

            if(write_request & ~full) begin
                write_pointer <= write_pointer+1;
                counter = counter+1;
            end
        end
    end



endmodule