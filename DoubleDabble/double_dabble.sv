module DoubleDabble #(parameter WIDTH, parameter DIGIT_COUNT)(
    input clk, write,
    output reg done,
    input       [WIDTH-1:0]             data,
    output reg  [DIGIT_COUNT-1:0][3:0]  digits
);
    
    reg[WIDTH-2:0] data_buffer;
    
    reg[4*DIGIT_COUNT-1:0] shift_reg;
    wire[4*DIGIT_COUNT-1:0] add_reg;
    reg [$clog2(WIDTH)-1:0] counter;


    assign counter_done = (counter == WIDTH-2);

    generate
    genvar i;
    for(i = 0; i < DIGIT_COUNT; i++) begin : shift_gen
        assign add_reg[(i+1)*4-1:i*4] = (
            (shift_reg[(i+1)*4-1:i*4] > 4) ?
                (shift_reg[(i+1)*4-1:i*4]+3) : shift_reg[(i+1)*4-1:i*4]
            );

        always_ff @(posedge clk)
            if(counter_done) begin
                digits[i] <= shift_reg[(i+1)*4-1:i*4];
                done <= 1;
            end
            else if(write)
                done <= 0;
    end
    endgenerate
        
    always_ff @(posedge clk) begin
        if(write) begin
            data_buffer = data[WIDTH-3:0];
            shift_reg = data[WIDTH-1:WIDTH-2];
            counter = 0;
        end
        else if(counter < WIDTH-1) begin
            data_buffer <= {data_buffer[WIDTH-3:0], 1'b0};
            shift_reg <= {add_reg[4*DIGIT_COUNT-2:0], data_buffer[WIDTH-3]};
            counter <= counter+1;
        end
    end

endmodule