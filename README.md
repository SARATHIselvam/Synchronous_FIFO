Synchronous FIFO (Verilog)

This project implements a parameterized synchronous FIFO buffer in Verilog along with a testbench and ModelSim simulation support.

📌 Features

Single clock (synchronous read & write)

Parameterized data width and depth

Circular buffer using read/write pointers

Full and Empty flag generation

Overflow and underflow protection

Testbench included

Works with ModelSim / Questa / Icarus Verilog

📁 Project Files
syncFIFO.v       → FIFO RTL design
tbsyncfifo.v     → Testbench
README.md        → Documentation

⚙️ FIFO Parameters
parameter datawidth = 8;
parameter depth     = 8;


You can change these values to adjust FIFO size.

🧠 Internal Architecture

Memory array: fifomem

Write pointer: wptr

Read pointer: rptr

Counter: count

Flags: full, empty

Count logic:

count = count + 1 → valid write only
count = count - 1 → valid read only
count unchanged   → both or none
