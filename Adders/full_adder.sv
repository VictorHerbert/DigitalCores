module FullAdder(
    input a,b,cin,
    output s,cout
);

    assign s = a^b^cin;
    assign cout = a&b | a&cin | b&cin;

    /*wire s_partial;
    wire cout0, cout1;

    HalfAdder add1(a, b, s_partial, cout0);
    HalfAdder add2(cin, s_partial, s, cout1);

    assign cout = cout0^cout1;*/

endmodule