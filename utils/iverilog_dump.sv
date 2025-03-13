module iverilog_dump();
initial begin
    $dumpfile("$(TOPLEVEL).vcd");
    $dumpvars(0, $(TOPLEVEL));
end
endmodule