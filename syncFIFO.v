module syncFIFO #(
    parameter datawidth=8,
    parameter depth=8
) (
    input wire clk,
    input wire rst,
    input wire wen,
    input wire ren,
    input wire [datawidth-1:0]din,
    output reg [datawidth-1:0]dout,
    output wire full,
    output wire empty
);
    localparam addwidth = $clog2(depth);
    reg [datawidth-1:0] fifomem [0:depth-1] ;
    reg [addwidth:0]wptr;
    reg [addwidth:0]rptr;
    reg [addwidth:0]count;

    assign full = (count == depth);
    assign empty = (count == 0);

    always @(posedge clk ) begin
        if (rst) begin
            wptr<=0;
        end else if (wen && !full)begin
            fifomem[wptr[addwidth-1:0]]<=din;
            wptr<=wptr+1;
        end
    end
    always @(posedge clk ) begin
        if (rst) begin
            rptr<=0;
            dout<=0;
        end else if (ren && !empty)begin
            dout<=fifomem[rptr[addwidth-1:0]];
            rptr<=rptr+1;
        end
    end
    always @(posedge clk ) begin
        if (rst) begin
            count<=0;
        end else begin
            case ({wen && !full,ren && !empty})
                2'b10 : count<=count+1;
                2'b01 : count<=count-1;
                2'b11 : count<=count;
                default: count<=count;
            endcase
        end
    end

    
endmodule