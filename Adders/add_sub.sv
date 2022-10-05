module AdderSubtractor #(parameter WIDTH=8)(
    input signed [WIDTH-1:0] a,b,
    input sub,

    output [WIDTH-1:0] s,
    output overflow
);

    RippleCarryAdder #(WIDTH) adder(
        a, b^{WIDTH{sub}}, sub,
        s, overflow
    );

endmodule