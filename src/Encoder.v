module encoder8x3 (output reg idle,
                   output reg [2:0] code,
                   input [7:0] data,
                   input en);

    always @(*) begin
        if (!en) begin
            code = 3'bx;
            idle = 1'b1;
        end
        else begin
            if (data[7] == 1'b1) code = 7; else
            if (data[7:6] == 2'b01) code = 6; else
            if (data[7:5] == 3'b001) code = 5; else
            if (data[7:4] == 4'b0001) code = 4; else
            if (data[7:3] == 5'b0000_1) code = 3; else
            if (data[7:2] == 6'b0000_01) code = 2; else
            if (data[7:1] == 7'b0000_001) code = 1; else
            if (data[7:0] == 8'b0000_0001) code = 0; else code = 3'bx;
            
            idle = 1'b0;
        end
    end

endmodule
