# 4×4 Network-on-Chip (NoC) — Compact Overview

## What
A Network-on-Chip (NoC) is a packet-switched communication fabric inside a chip.  
This project implements a 4×4 2D mesh where each tile connects to a 5-port router  
(North, South, East, West, Local).

## Why
Traditional interconnects do not scale:
- Buses = bottleneck
- Crossbars = O(N^2) area
- Point-to-point = wiring explosion  
NoCs provide scalable, modular, parallel communication with predictable routing  
and better area/power/timing behavior.

## How (Data Flow)
1. Incoming flit enters an input FIFO.  
2. Routing unit (XY routing) chooses output port based on destination.  
3. Arbiter resolves multiple requests for the same output.  
4. Crossbar connects selected input to output.  
5. Flow control (credit or valid/ready) ensures buffers never overflow.  
Flits hop router-to-router until reaching the local port of the destination.

## Components
- Input FIFOs (one per port)  
- Routing Computation (XY)  
- Switch Allocator / Arbiter  
- 5×5 Crossbar  
- Flow Control Logic  
- Mesh interconnect (16 routers)

## Packet Format (Example)
Header flit:
DEST_X (2b), DEST_Y (2b), TYPE (2b), PAYLOAD  
Body flits carry remaining data.

## Requirements
- Correct packet delivery  
- Deadlock-free routing (XY)  
- Fair arbitration  
- Efficient flow control  
- Area/power balanced buffers  
- Scalable timing and routing on chip

## Suggested Directory Structure
/rtl -> router, fifo, routing, arbiter, crossbar, mesh_top  
/tb  -> router_tb, mesh_tb  
/docs -> diagrams, README

## Verification Checklist
- FIFO behavior  
- Single-hop and multi-hop routing  
- Arbitration fairness  
- Flow control correctness  
- Stress and saturation traffic tests
