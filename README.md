# Round-Robin-Arbiter


## Project Synopsis

Design and verification of a **4-input Round Robin Arbiter** implemented in Verilog RTL. This arbiter fairly manages multiple simultaneous requests by granting access in a **cyclic and starvation-free** manner. 

##  Functional Highlights
-  **Round Robin FSM-based Arbitration**
-  **Programmable counter-based grant holding (3 cycles)**
-  4 request inputs (`req[4:1]`) with priority rotation
-  Fair access control using state transitions and programmable counter
-  RTL design in Verilog

### Sample Test Sequence:
verilog

insert(4'b0010);     // req[2]

repeat(3) insert(4'b1001); // s4 active

insert(4'b0100);     // req[3]

compare(4'b0100);    // Expected grant = req[3]

