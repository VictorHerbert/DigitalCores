module Increment #(parameter WIDTH)(
    input signed [WIDTH-1:0] a,b,
    input cin,

    output [WIDTH-1:0] s,
    output overflow
);

    reg [WIDTH-1:0] _cin, _cout;

    assign overflow = _cout[WIDTH-1] ^ _cout[WIDTH-2];
    assign _cin[0] = cin;

    generate
    genvar i;
        for(i = 0; i < WIDTH; i++) begin : adder_gen
           FullAdder full_adder(a[i], b[i], _cin[i], s[i], _cout[i]);
        end
    endgenerate

    always_comb for(int i = 1; i < WIDTH; i++)
        _cin[i] = _cout[i-1];
        
        

endmodule