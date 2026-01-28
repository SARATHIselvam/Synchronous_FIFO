`timescale 1ns/1ps
module tbsyncfifo;
    parameter datawidth=8;
    parameter depth=8;

    reg clk;
    reg rst;
    reg wen;
    reg ren;
    reg [datawidth-1:0]din;
    wire[datawidth-1:0]dout;
    wire full;
    wire empty;

    syncFIFO #(datawidth,depth) dut (.clk(clk), .rst(rst), .wen(wen), .ren(ren), .din(din), .dout(dout), .full(full), .empty(empty));

    always #5 clk = ~clk;

    initial begin


        clk =0;
        rst=1;
        wen=0;
        ren=0;
        din=0;

        #40;

        rst =0;

        repeat (6) begin
            @(posedge clk);
            wen = 1;
            ren = 0;
            din = din + 8'h11;
        end

        @(posedge clk);
        wen =0;

        repeat (6) begin
            @(posedge clk);
            wen = 0;
            ren = 1;
        end

        @(posedge clk);
        ren = 0;

        #50;
        $finish;
    end

    
endmodule

