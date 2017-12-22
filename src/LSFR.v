// Generated Polynomial:  x^8 + x^6 + x^5 + x + 1

module LFSR (output reg [0:7] q,
             input clk, rst_n, load,
             input [0:7] din);
    
    always @(posedge clk) begin
        if (~rst_n) 
            q <= 8'b0;
        else begin
            if (load)
                q <= (|din) ? din : 8'b0000_0001;
            else begin
                q[7] <= q[6];
                q[6] <= q[5] ^ q[7];
                q[5] <= q[4] ^ q[7];
                {q[4], q[3], q[2]} <= {q[3], q[2], q[1]};
                q[1] <= q[0] ^ q[7];
                q[0] <= q[7];
            end
        end
    end
    
endmodule

module LFSR2 (output reg [1:8] q,
              input clk, rst_n, load,
              input [1:8] din);
    
    always @(posedge clk) begin
        if (~rst_n) 
            q <= 8'b0;
        else begin
            if (load)
                q <= (|din) ? din : 8'b0000_0001;
            else begin
                q[8] <= q[7];
                q[7] <= q[6] ^ q[8];
                q[6] <= q[5] ^ q[8];
                {q[5], q[4], q[3]} <= {q[4], q[3], q[2]};
                q[2] <= q[1] ^ q[8];
                q[1] <= q[8];
            end
        end
    end
    
endmodule
