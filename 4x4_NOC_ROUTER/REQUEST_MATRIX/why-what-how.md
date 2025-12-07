# Request Matrix (ReqMat)

## WHY
Multiple input ports may request the same output direction in the same cycle.  
A router cannot let more than one input drive a single output.  
The Request Matrix provides a clear input→output request map so the Switch Allocator can perform arbitration.

---

## WHAT
ReqMat is a 2D table:

- Rows represent input ports  
- Columns represent output directions (N, S, E, W, L)  
- A '1' means the input is requesting that output  
- A '0' means no request  

Example:

| Input \ Output | N | S | E | W | L |
|----------------|---|---|---|---|---|
| In0            | 0 | 0 | 1 | 0 | 0 |
| In1            | 0 | 0 | 1 | 0 | 0 |
| In2            | 1 | 0 | 0 | 0 | 0 |
| In3            | 0 | 0 | 0 | 1 | 0 |

---

## HOW
1. Each RC unit outputs a one-hot direction for its corresponding input FIFO.  
2. The Request Matrix collects these one-hot outputs into a 2D input-vs-output table.  
3. This matrix is passed to the Switch Allocator.  
4. The allocator examines each column (each output direction) and selects exactly one input per output using an arbitration policy.

---

## Summary
The Request Matrix organizes per-input routing decisions into a structured table that enables clean and correct arbitration in the Switch Allocator.
