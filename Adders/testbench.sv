module testbench;
    localparam WIDTH = 8;

    logic signed [WIDTH-1:0] a,b,s;
    logic sub, overflow;


    AdderSubtractor #(WIDTH) dut(
        a,b, sub,
        s, overflow
    );

    initial begin
        for(int i = 0; i < 20; i++) begin
            a = $random(); b = $random(); sub = 1;
            #5;

            if(sub)         assert(a-b == s) else $error("Subtraction error %d - %d != %d", a, b, s);
            else if(!sub)    assert(a+b == s) else $error("Addition error %d + %d != %d", a, b, s);
            // TODO test overflow
        end
    end

endmodule