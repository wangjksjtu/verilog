module counter #(parameter N=4) (output reg [N-1:0] count,
                                 input clk, rst_n);
                                 
    always @(posedge clk, posedge rst_n) begin
        if (rst_n) begin
            count <= 0;
        end
        else begin
            count <= count + 1;
        end
    end
endmodule

module decimal_counter #(parameter N=4) (output reg [N-1:0] count,
                                         output reg sup, inf,
                                         input clk, rst_n, load, dir,
                                         input [N-1:0] data);
                                         
    always @(posedge clk) begin
        if (~rst_n) begin
            count <= 4'd0;
            {inf, sup} <= 2'b0;
        end
        else begin
            if (load) count <= data;
            else begin
                if (~dir) begin
                    if (count < 4'd9) begin
                        count <= count + 4'd1;
                        {inf, sup} <= 2'b0;
                    end
                    else begin
                        count <= 4'd0;
                        {inf, sup} <= 2'b01;
                    end
                end
                else begin
                    if (count > 4'd0) begin
                        count <= count - 4'd1;
                        {inf, sup} <= 2'b0;
                    end
                    else begin
                        count <= 4'd9;
                        {inf, sup} <= 2'b10;
                    end
                end
            end
        end
    end
    
endmodule
