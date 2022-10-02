module testbench;
    localparam LENGTH = 8;
    localparam LEFT = 1;

    logic [LENGTH-1:0] data_in;
    logic [$clog2(LENGTH)-1:0] shamt;
    logic [LENGTH-1:0] data_out;
    
    BarrelShift #(LENGTH, LEFT) barrel_shift(data_in, shamt, data_out);

    initial begin
        for(int i = 0; i < 20; i++) begin
            data_in <= $random();
            shamt <= $random();
            #5;
        end
    end


endmodule