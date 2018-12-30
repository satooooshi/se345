module sl2(input logic [31:0] a,
            output logic [31:0] y);

    assign y={a[29:2], 2'b00};//a<<2
endmodule