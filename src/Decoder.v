module decoder3x8 (output reg [7:0] YL,
                   input EN, C, B, A);

    always @(*) begin
        if (EN)
            case ({C, B, A})
                0: YL = 8'b1111_1110;
                1: YL = 8'b1111_1101;
                2: YL = 8'b1111_1011;
                3: YL = 8'b1111_0111;
                4: YL = 8'b1110_1111;
                5: YL = 8'b1101_1111;
                6: YL = 8'b1011_1111;
                7: YL = 8'b0111_1111;
                default: YL = 8'HFF;
            endcase
        else
            YL = 8'b1111_1111;
    end

endmodule

module decoder4x16 (output [15:0] y,
                    input d, c, b, a);
    
    wire dbar;
    assign dbar = ~d;
    decoder3x8 u1 (.YL(y[7:0]), .EN(dbar), .C(c), .B(b), .A(a)),
               u2 (.YL(y[15:8]), .EN(d), .C(c), .B(b), .A(a));
endmodule

module dec6seg (output reg [0:6] seg,
                input [3:0] code,
                input BI_L);
    
    always @(*) begin
        if (BI_L)
            case (code)
                0:  seg = 7'b111_1110;
                1:  seg = 7'b111_1110;
                2:  seg = 7'b110_1101;
                3:  seg = 7'b111_1001;
                4:  seg = 7'b011_0011;
                5:  seg = 7'b101_1011;
                6:  seg = 7'b101_1111;
                7:  seg = 7'b111_0000;
                8:  seg = 7'b111_1111;
                9:  seg = 7'b111_1011;
                default: ;
            endcase
        else seg = 7'b000_0000;
    end
    
endmodule
