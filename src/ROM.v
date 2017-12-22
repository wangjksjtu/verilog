module ROM (output [7:0] data,
            input [3:0] address,
            input en);

    assign data = (en) ? ROM_LOC(address) : 8'bz;
    
    function [7:0] ROM_LOC (input [3:0] a);
        case (a)
            4'h0: ROM_LOC = 8'b1010_1001;
            4'h1: ROM_LOC = 8'b1111_1101;
            4'h2: ROM_LOC = 8'b1110_1001;
            4'h3: ROM_LOC = 8'b1101_1100;
            4'h4: ROM_LOC = 8'b1011_1001;
            4'h5: ROM_LOC = 8'b1100_0010;
            4'h6: ROM_LOC = 8'b1100_0101;
            4'h7: ROM_LOC = 8'b0000_0100;
            
            4'h8: ROM_LOC = 8'b1010_1001;
            4'h9: ROM_LOC = 8'b1111_1101;
            4'hA: ROM_LOC = 8'b1110_1001;
            4'hB: ROM_LOC = 8'b1101_1100;
            4'hC: ROM_LOC = 8'b1011_1001;
            4'hD: ROM_LOC = 8'b1100_0010;
            4'hE: ROM_LOC = 8'b1100_0101;
            4'hF: ROM_LOC = 8'b0000_0100;
            default: ROM_LOC = 8'bx;
        endcase
    endfunction

endmodule
