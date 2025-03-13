module testbench;
    localparam CLK_PERIOD = 10;
    localparam CLK_HALF_PERIOD = CLK_PERIOD/2;
    localparam CLK_CYCLES = 400;

    logic clk=0, reset=0;

    initial repeat(CLK_CYCLES) #CLK_HALF_PERIOD clk = ~clk;
    task wait_ticks(integer n); repeat(n) @(posedge clk); endtask

    localparam WIDTH = 8;
    localparam DEPTH = 4;

    logic write_request=0, read_request=0;
    logic empty, full;
    logic [DEPTH+1:0] counter;

    logic  [WIDTH-1:0] data_in;
    logic  [WIDTH-1:0] data_out;

    integer count = 0;

    FIFO #(WIDTH, DEPTH) fifo(
        .clk, .reset,
        .write_request, .read_request,
        .empty, .full,
        .data_in,
        .data_out
    );

    task reset_data; begin
        reset <= 1'b1;
        count = 0;
        wait_ticks(1);
        reset <= 1'b0;
    end
    endtask

    task write_data(integer value); begin
        write_request = 1;
        data_in = value;
        wait_ticks(1);
        if(~full)
            count += 1;
        write_request = 0;
        data_in = 'x;
    end
    endtask

    task read_data; begin
        read_request = 1;
        wait_ticks(1);
        if(~empty)
            count -= 1;
        read_request = 0;
    end
    endtask

    logic read_operation, write_operation;
    integer rd;

    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars;

        reset_data();
        repeat(CLK_CYCLES) begin
            @(posedge clk)
            {read_operation, write_operation} = $random();
        end
    end

    initial begin
        wait_ticks(1);
        repeat(CLK_CYCLES) begin
            wait_ticks(1);
            if(write_operation)
                write_data($random);
        end
    end

    initial begin
        repeat(CLK_CYCLES) begin
            wait_ticks(1);
            if(read_operation)
                read_data();
        end
    end

    cover_full:     cover property(@(posedge clk) full);
    cover_empty:    cover property(@(posedge clk) empty);

    assert_empty_count:     assert property(@(posedge clk) empty |-> count==0);
    assert_full_count:      assert property(@(posedge clk) full |-> count==$pow(2,DEPTH));

endmodule