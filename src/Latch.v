module SRLatch(output reg q, qbar,
               input s, r);
    always @(*) begin
        case ({s, r})
            2'b01: {q, qbar} <= 2'b01;
            2'b10: {q, qbar} <= 2'b10;
            2'b11: {q, qbar} <= 2'bx;
            default ;
    end
endmodule

module DLatch(output reg q, output qbar,
               input d, input ctl);
    always @(*) begin
        if (ctl)
            q <= d;
    end
    assign qbar = ~q;
endmodule
