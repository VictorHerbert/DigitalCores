`define TEST(p1, p2) \
    assert (p1 === p2) \
        $display("Test %d: \033[32;1mPASSED\033[0m", test_it++); \
    else \
        $display("Test %d: \033[31;1mFAILED\033[0m\nt%0d->Expected %b got %b\n", test_it++, $time, p1, p2)        

module testbench;
    int test_it = 0;

    localparam CLK_PERIOD = 10;
    localparam CLK_HALF_PERIOD = CLK_PERIOD / 2;
    localparam TIMEOUT = 1e6*CLK_PERIOD;

    initial begin
        #(TIMEOUT)
        $display("Finish with timeout");
        $finish(2); 
    end

    logic clk = 1, reset = 0;
    initial forever #CLK_HALF_PERIOD clk = ~clk;

    task await_ticks(int ticks);
        repeat(ticks) @(posedge clk);
    endtask
    
    localparam LENGTH = 8;
    localparam LEFT = 1;

    logic [LENGTH-1:0] data_in;
    logic [$clog2(LENGTH)-1:0] shamt;
    logic [LENGTH-1:0] data_out;
    
    BarrelShift #(LENGTH, LEFT) barrel_shift(data_in, shamt, data_out);

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, barrel_shift);
    end

    initial begin
        for(int i = 0; i < 100; i++) begin
            data_in = $random;
            for(shamt = 0; shamt < LENGTH-1; shamt++) begin
                #2;
                
                `TEST(data_in << shamt, data_out);

                #5;
            end
            #5;
        end

        $display("All tests finished");

        $finish;
    end

endmodule
//https://gist.github.com/WestleyK/dc71766b3ce28bb31be54b9ab7709082
