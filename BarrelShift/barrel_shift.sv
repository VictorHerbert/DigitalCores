module BarrelShift #(parameter LENGTH = 8, parameter LEFT = 1)(
    input [LENGTH-1:0] data_in,
    input [$clog2(LENGTH)-1:0] shamt,
    output [LENGTH-1:0] data_out
);

    logic[$clog2(LENGTH):0][LENGTH-1:0] data;

    assign data[0] = data_in;
    assign data_out = data[$clog2(LENGTH)];

    always_comb for(int i = 1; i <= $clog2(LENGTH); i++)
        data[i] = shamt[i-1] ? (LEFT ? data[i-1]<<i : data[i-1]>>i) : data[i-1];
    


endmodule