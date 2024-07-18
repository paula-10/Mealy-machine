This project includes the design through a state diagram and the implementation in Verilog HDL of a Mealy-type vending machine for soft drinks and food products. 
The machine can dispense a product or return all remaining change upon request. The vending machine accepts 3 types of currency (one type of coin and 2 types of bills) 
as determined by the user and dispenses change only in the first 2 types of currency. The machine can give only one type of change per clock period, starting with the 
largest denomination, and only when change is requested. In that case, it will give all the remaining change and return to the initial state, accepting only one type 
of currency per clock period. Additionally, the machine can either accumulate money over a clock period, dispense a product, or return change over one or multiple clock 
periods as needed. Money can be inserted up to a maximum of 10 lei, after which a product or change must be requested. After requesting a product, more money can be inserted
for another product if there is insufficient balance, or another product can be requested if there is enough balance. Once requested, the change will be dispensed in full.
