module shiftreg4b (output reg [3:0] dout,
                   input clk, reset, din);
                   
    always @(posedge clk, posedge reset) begin
        if (reset) dout <= 4'h0;
        else dout <= {dout[2:0], din};
    end
    
endmodule

module UShiftReg #(parameter N=8) (output reg [N-1:0] q,
                                   input [N-1:0] d,
                                   input [1:0] s,
                                   input Lin, Rin,
                                   input clk, rst_n);
    
    always @(posedge clk) begin
        if (~rst_n) q <= 0;
        else begin
            case (s)
                2'b01: q <= {Rin, q[N-1:1]);
                2'b10: q <= {q[N-2:0], Lin};
                2'b11: q <= d;
                default: ;
            endcase
        end
    end
    
endmodule

module filter (output reg y,
               input clk, rst_n, din);
    
    reg [3:0] q;
    always @(posedge clk) begin
        if (!rst_n) begin
            q <= 4'b0;
            y <= 1'b0;
        end
        else begin
            if (&q[3:1]) y <= 1'b1;
            else if (~|q[3:1]) y <= 1'b0;
            q <= {q[2:0], din};
        end
    end
    
endmodule
