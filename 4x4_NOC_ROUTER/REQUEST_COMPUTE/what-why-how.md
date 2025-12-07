# Route Compute (RC)

## Why RC exists
Packets arriving at a router carry a destination in the header.  
RC decides **which output port** (N, S, E, W, Local) the packet must take next — the essential first step for forwarding.

## What RC does
- Monitors the **header flit** at the head of the input FIFO.  
- Extracts destination (coords / ID) from that header.  
- Compares destination with the router's own coordinates/ID.  
- Emits a **single routing decision** (one-hot direction) and holds it for the packet lifetime.  
- Produces a request entry for the Request Matrix (input → desired output).

## How RC works (conceptual steps)
1. **Header ready** — when FIFO presents the header flit, RC reads its destination field.  
2. **Compare** — evaluate destination vs. local coordinates:  
   - if `dest_x > curr_x` → `EAST`  
   - else if `dest_x < curr_x` → `WEST`  
   - else if `dest_y > curr_y` → `NORTH`  
   - else if `dest_y < curr_y` → `SOUTH`  
   - else → `LOCAL`  
3. **Request** — assert `req[input][direction] = 1` (one-hot) and keep it asserted until the packet's tail passes.  
4. **Hold** — RC’s decision must persist for all body/tail flits of the same packet so allocator/crossbar use the same path.

## Notes / design constraints
- RC is **combinational**/fast: it outputs direction when header is visible (no global FSM needed).  
- RC must be gated by FIFO `valid`/`not empty` — don’t run on empty FIFO.  
- For wormhole routing, RC runs only on header; subsequent flits follow the chosen route.  
- RC output feeds the Request Matrix, which the Switch Allocator reads to resolve conflicts.
