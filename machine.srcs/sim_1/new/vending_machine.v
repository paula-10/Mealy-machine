module vending_machine(
    input wire clk,
    input wire reset,
    input wire [1:0] coin,
    input wire request_product,
    input wire request_change,
    output reg dispense_product,
    output reg [1:0] dispense_change,
    output reg [3:0] total_money
);

    reg [1:0] current_state, next_state;

    localparam IDLE = 2'b00, ACCEPT_MONEY = 2'b01, DISPENSE_PRODUCT = 2'b10, RETURN_CHANGE = 2'b11, DISPENSE_CHANGE = 2'b100;

    reg next_dispense_product;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            total_money <= 0;
            dispense_product <= 0;
            dispense_change <= 2'b00;
        end else begin
            current_state <= next_state;
            dispense_product <= next_dispense_product;
        end
    end

    always @(*) begin
        // Default values
        next_state = current_state;
        next_dispense_product = 0; // Default value for next_dispense_product
        dispense_change = 2'b00;

        case (current_state)
            IDLE: begin
                if (coin != 2'b00) begin
                    next_state = ACCEPT_MONEY;
                end else if (request_product && total_money >= 3) begin
                    next_dispense_product = 1;
                    total_money = total_money - 3;
                    next_state = DISPENSE_PRODUCT;
                end else if (request_change && total_money > 0) begin
                    next_state = RETURN_CHANGE;
                end
            end

            ACCEPT_MONEY: begin
                case (coin)
                    2'b01: if (total_money + 1 <= 10) total_money = total_money + 1;
                    2'b10: if (total_money + 5 <= 10) total_money = total_money + 5;
                    2'b11: if (total_money + 10 <= 10) total_money = total_money + 10;
                    default: ; // Do nothing if total_money exceeds 10
                endcase

                if (request_change && total_money > 0) begin
                    next_state = RETURN_CHANGE;
                end else if (request_product && total_money >= 3) begin
                    next_dispense_product = 1;
                    total_money = total_money - 3;
                    next_state = DISPENSE_PRODUCT;
                end else begin
                    next_state = IDLE;
                end
            end

            DISPENSE_PRODUCT: begin
                next_state = IDLE; // Transition back to IDLE after dispensing product
            end

            RETURN_CHANGE: begin
                if (total_money > 0) begin
                    next_state = DISPENSE_CHANGE;
                end else begin
                    next_state = IDLE;
                end
            end

            DISPENSE_CHANGE: begin
                if (total_money >= 5) begin
                    dispense_change = 2'b01;
                    total_money = total_money - 5;
                end else if (total_money >= 1) begin
                    dispense_change = 2'b00;
                    total_money = total_money - 1;
                end
                
                if (total_money > 0) begin
                    next_state = RETURN_CHANGE;
                end else begin
                    next_state = IDLE;
                end
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
