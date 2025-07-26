`define counter_size 2

module round_robin_arbitter_project(
    input clk,
    input rst,
    input [4:1] req,
    output reg [3:0] grant
);

parameter s0 = 3'b000,
          s1 = 3'b001,
          s2 = 3'b010,
          s3 = 3'b011,
          s4 = 3'b100;

reg [2:0] pre_state;
reg [2:0] nxt_state;
reg [`counter_size-1:0] count = 0;

// State transition on clock
always @(posedge clk) begin
    if (rst)
        pre_state <= s0;
    else
        pre_state <= nxt_state;
end

// Next state logic
always @(*) begin
    case(pre_state)
        s0: begin
            if (req[1]) nxt_state = s1;
            else if (req[2]) nxt_state = s2;
            else if (req[3]) nxt_state = s3;
            else if (req[4]) nxt_state = s4;
            else nxt_state = s0;
        end

        s1: begin
            if (req[1]) begin
                if (count == `counter_size'd3) begin
                    if (req[2]) nxt_state = s2;
                    else if (req[3]) nxt_state = s3;
                    else if (req[4]) nxt_state = s4;
                    else nxt_state = s1;
                    count = 0;
                end else begin
                    nxt_state = s1;
                    count = count + 1;
                end
            end else if (req[2]) begin
                nxt_state = s2;
                count = 0;
            end else if (req[3]) begin
                nxt_state = s3;
                count = 0;
            end else if (req[4]) begin
                nxt_state = s4;
                count = 0;
            end else begin
                nxt_state = s0;
            end
        end

        s2: begin
            if (req[2]) begin
                if (count == `counter_size'd3) begin
                    if (req[3]) nxt_state = s3;
                    else if (req[4]) nxt_state = s4;
                    else if (req[1]) nxt_state = s1;
                    else nxt_state = s2;
                    count = 0;
                end else begin
                    nxt_state = s2;
                    count = count + 1;
                end
            end else if (req[3]) begin
                nxt_state = s3;
                count = 0;
            end else if (req[4]) begin
                nxt_state = s4;
                count = 0;
            end else if (req[1]) begin
                nxt_state = s1;
                count = 0;
            end else begin
                nxt_state = s0;
            end
        end

        s3: begin
            if (req[3]) begin
                if (count == `counter_size'd3) begin
                    if (req[4]) nxt_state = s4;
                    else if (req[1]) nxt_state = s1;
                    else if (req[2]) nxt_state = s2;
                    else nxt_state = s3;
                    count = 0;
                end else begin
                    nxt_state = s3;
                    count = count + 1;
                end
            end else if (req[4]) begin
                nxt_state = s4;
                count = 0;
            end else if (req[1]) begin
                nxt_state = s1;
                count = 0;
            end else if (req[2]) begin
                nxt_state = s2;
                count = 0;
            end else begin
                nxt_state = s0;
            end
        end

        s4: begin
            if (req[4]) begin
                if (count == `counter_size'd3) begin
                    if (req[1]) nxt_state = s1;
                    else if (req[2]) nxt_state = s2;
                    else if (req[3]) nxt_state = s3;
                    else nxt_state = s4;
                    count = 0;
                end else begin
                    nxt_state = s4;
                    count = count + 1;
                end
            end else if (req[1]) begin
                nxt_state = s1;
                count = 0;
            end else if (req[2]) begin
                nxt_state = s2;
                count = 0;
            end else if (req[3]) begin
                nxt_state = s3;
                count = 0;
            end else begin
                nxt_state = s0;
            end
        end

        default: nxt_state = s0;
    endcase
end

// Output logic
always @(*) begin
    case (pre_state)
        s0: grant = 4'b0000;
        s1: grant = 4'b0001;
        s2: grant = 4'b0010;
        s3: grant = 4'b0100;
        s4: grant = 4'b1000;
        default: grant = 4'b0000;
    endcase
end

endmodule



