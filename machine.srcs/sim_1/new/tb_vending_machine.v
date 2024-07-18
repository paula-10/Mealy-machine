`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2024 10:02:37 AM
// Design Name: 
// Module Name: tb_vending_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_vending_machine;

    // Testbench signals
    reg clk;
    reg reset;
    reg [1:0] coin;
    reg request_product;
    reg request_change;
    wire dispense_product;
    wire [1:0] dispense_change;
    wire [3:0] total_money;

    // Instantiate the vending machine
    vending_machine uut (
        .clk(clk),
        .reset(reset),
        .coin(coin),
        .request_product(request_product),
        .request_change(request_change),
        .dispense_product(dispense_product),
        .dispense_change(dispense_change),
        .total_money(total_money)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units period
    end

    // Test sequence
    initial begin
        // Initialize signals
        reset = 1;
        coin = 2'b00;
        request_product = 0;
        request_change = 0;

        // Reset the system
        #10 reset = 0;
        
        // Insert 10 lei
        #10 coin = 2'b11;
        #10 coin = 2'b00;  // Reset coin to ensure it gets processed correctly

        // Make a drink request
        #10 request_product = 1;
        #10 request_product = 0;
        
        #10 request_product = 1;
        #10 request_product = 0;
        
        #10 request_change = 1;

        // Finish simulation
        #100 $finish;
    end

    // Monitor the outputs
    initial begin
        $monitor("Time: %0d, State: %b, Coin: %b, Request Product: %b, Request Change: %b, Dispense Product: %b, Dispense Change: %b, Total Money: %d",
                 $time, uut.current_state, coin, request_product, request_change, dispense_product, dispense_change, total_money);
    end
endmodule
