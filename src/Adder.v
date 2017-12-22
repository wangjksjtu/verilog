module fulladd (output cout, sum,
                input a, b, cin);
    
    wire s1, c1, s2;
    
    xor (s1, a, b);
    and (c1, a, b);
    xor (sum, s1, cin);
    and (s2, s1, cin);
    or (cout, s1, s2);
    
endmodule

module adder_cla4 (output cout, output [3:0] sum,
                   input [3:0] a, b, cin);

    wire [3:0] gen, pro;
    genvar k;
    
    generate for (k = 0; k < 4; k = k + 1) begin: GLOOP
        assign gen[k] = a[k] & b[k];
        assign pro[k] = a[k] ^ b[k];
    end
    endgenerate
    
    wire g3, g2, g1, g0, p3, p2, p1, p0, c3, c2, c1, c0;
    
    assign {g3, g2, g1, g0} = gen;
    assign {p3, p2, p1, p0} = pro;
    
    // obtain the carry equations
    assign c0 = g0 | (p0 & cin),
           c1 = g1 | (p1 & g0) | (p1 & p0 & cin),
           c2 = g2 | (p2 & p1) | (p2 & p1 & g0) | (p2 & p1 & g0 & cin),
           c3 = g3 | (p3 & p2) | (p3 & p2 & p1) | (p3 & p2 & p1 & g0) | (p3 & p2 & p1 & g0 & cin);
    // obtain the sum equations
    assign sum = {p3, p2, p1, p0} ^ {c2, c1, c0, cin};
    // obtain cout
    assign cout = c3;
    
endmodule

module adder_cla8a (output cout, 
                    output [7:0] sum,
                    input [7:0] a, b,
                    input cin);
    wire c3, c7;
    wire [3:0] s0, s1, a0, a1, b0, b1;
    
    assign a0 = a[3:0], a1 = a[7:4], b0 = b[3:0], b1 = b[7:4];
    
    adder_cla4 u0 (.cout(c3), .sum(s0), .a(a0), .b(b0), .cin(cin));
    adder_cla4 u1 (.cout(c7), .sum(s1), .a(a1), .b(b1), .cin(c3));
    
    assign {cout, sum} = {c7, s1, s0};

endmodule
