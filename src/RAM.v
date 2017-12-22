module RAM_sync #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8)
       (output [DATA_WIDTH-1:0] data_out,
        input [ADDR_WIDTH-1:0] address,
        input [DATA_WIDTH-1:0] data_in,
        input clk, cs, we, oe);

    // DATA_WIDTH = 8, ADDR_WIDTH = 8
    parameter RAM_DEPTH = 1 << ADDR_WIDTH;
    // Internal variables
    reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
    reg [DATA_WIDTH-1:0] data;
    
    // Output: When cs = 1, we = 0, oe = 1
    assign data_out = (cs && ~we && oe) ? data : 8'bz;
    
    // Write Operation: When cs = 1, we = 1
    always @(posedge clk) bgein : MEM_WRITE
        if (cs && we)
            mem[address] <= data_in;
    end
    
     // Read Operation: When cs = 1, we = 0, oe = 1
    always @(posedge clk) bgein : MEM_READ
        if (cs && ~we && oe)
            data <= mem[address];
    end

endmodule

module RAM_sync2 #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8)
       (output [DATA_WIDTH-1:0] data_out,
        input [ADDR_WIDTH-1:0] address,
        input [DATA_WIDTH-1:0] data_in,
        input clk, cs, we, oe);

    // DATA_WIDTH = 8, ADDR_WIDTH = 8
    parameter RAM_DEPTH = 1 << ADDR_WIDTH;
    // Internal variables
    reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
    reg [DATA_WIDTH-1:0] data;
    
    // Tri-State Buffer Control
    // Output: When cs = 1, we = 0, oe = 1
    assign data_out = (cs && ~we && oe) ? data : 8'bz;
    
    always @(posedge clk) begin
        if (cs)
            case ({we, oe})
                2'b01: data <= mem[address];
                2'b10: mem[address] <= data_in;
                default: ;
            endcase
    end

endmodule


module DualPortRAM #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8)
       (output [DATA_WIDTH-1:0] dout0,
        input [ADDR_WIDTH-1:0] address0,
        input [DATA_WIDTH-1:0] din0,
        input cs0, we0, oe0,
        ///////
        output [DATA_WIDTH-1:0] dout1,
        input [ADDR_WIDTH-1:0] address1,
        input [DATA_WIDTH-1:0] din1,
        input cs1, we1, oe1,
        ///////
        input clk;
        );

    // DATA_WIDTH = 8, ADDR_WIDTH = 8
    parameter RAM_DEPTH = 1 << ADDR_WIDTH;
    // Internal variables
    reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
    reg [DATA_WIDTH-1:0] data0;
    reg [DATA_WIDTH-1:0] data1;
    
    always @(posedge clk) begin : MEM_WRITE
        if (cs0 && we0) begin
            mem[address0] <= din0;
        end
        else if (cs1 && we1) begin
            mem[address1] <= din1;
        end
    end
    
    wire we = we0 | we1;
    assign dout0 = (cs0 && oe0 && ~we) ? data0 : 8'bz;
 
     always @(posedge clk) begin : MEM_READ_0
        if (cs0 && oe0 && ~we) begin
            data0 <= mem[address0];
        end
        else begin
            data0 <= 8'b0;
        end
    end
    
    assign dout1 = (cs1 && oe1 && ~we) ? data1 : 8'bz;
    always @(posedge clk) begin : MEM_READ_1
        if (cs1 && oe1 && ~we) begin
            data1 <= mem[address1];
        end
        else begin
            data1 <= 8'b0;
        end
    end    

endmodule
