module dff (output reg q, output qn,
            input d, input clk);
            
    always @(posedge clk) begin
        q <= d;
    end
    assign qn = ~q;
    
endmodule

module dff_ne (output reg q, output qn,
               input d, input clk);
               
    always @(negedge clk) q <= d;
    assign qn = ~q;
    
endmodule

module dff_en (output reg q, output qn,
               input d, en, clk);
               
    always @(posedge clk) begin
        if (en)
            q <= d;
    end
    assign qn = ~q;
    
endmodule

module JKFF (output reg q, qn,
             input clk, j, k);
             
    always @(posedge clk) begin
        case ({j, k})
            2'b10: {q, qn} <= 2'b10;
            2'b01: {q, qn} <= 2'b01;
            2'b11: {q, qn} <= {qn, q};
            default ;
        endcase
    end
    
endmodule

module JKFF2 (output reg q, output qn,
             input clk, j, k);
             
    always @(posedge clk) begin
        case ({j, k})
            2'b10: q <= 1;
            2'b01: q <= 0;
            2'b11: q <= ~q;
            default ;
        endcase
    end
    assign qn = ~q;
    
endmodule

module TFF (output reg q, qn,
            input clk, rst_n, t);

    always @(posedge clk) begin
        if (~rst_n) {q, qn} <= 2'b01;
        else begin
            if (t)
                {q, qn} <= {qn, q};
        end
    end

endmodule

//Ps: The priority of RESET is higher than the priority of SET

module DFF_asr (output reg q, qn,
                input d, clk, reset, set);
    
    always @(posedge clk, posedge reset, posedge set) begin
        if (reset)
            {q, qn} <= 2'b01;
         else begin
            if (set)
                {q, qn} <= 2'b10;
            else
                {q, qn} <= {d, ~d};
         end
    end
    
endmodule

module DFFn #(parameter N=8) (output reg [N-1:0] q,
                              input [N-1:0] d,
                              input clk, rst_n);

    always @(posedge clk, negedge rst_n) begin
        if (~rst_n) q <= 0;
        else q <= d
    end

endmodule
