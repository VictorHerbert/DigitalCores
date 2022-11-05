module testbench;
    localparam CLK_PERIOD = 10;
    localparam CLK_HALF_PERIOD = CLK_PERIOD/2;
    localparam WIDTH = 16;
    localparam DIGIT_COUNT = 6;

    localparam IT_COUNT = 10000;

    logic clk = 0, reset = 0, write = 0, done;
    logic[WIDTH-1:0] data;
    logic[DIGIT_COUNT-1:0][3:0] digits;

    logic[WIDTH-1:0] test_data;
    logic[DIGIT_COUNT-1:0][3:0] test_digits;


    DoubleDabble #(WIDTH, DIGIT_COUNT) dut(
        clk, write, done,
        data, digits
    );

    initial repeat(400) #CLK_HALF_PERIOD clk = ~clk;
    task wait_ticks(integer n); repeat(n) @(posedge clk); endtask
    task write_data(integer value); begin
        write = 1;
        data = value;
        wait_ticks(1);
        write = 0;
        data = 'x;
    end
    endtask

    initial begin
        wait_ticks(2);

        repeat(IT_COUNT) begin
            test_data = $random();
            write_data(test_data);
            for(int i = 0; i < DIGIT_COUNT; i++) begin
                test_digits[i] = test_data%10;
                test_data /= 10;
            end
            wait_ticks(1);
            wait(done);

            assert(test_digits == digits) else $error("Results don't match");
        end
    end

endmodule