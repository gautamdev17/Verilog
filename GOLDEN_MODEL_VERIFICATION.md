## 🔶 What is a Golden Model?

A **golden model** is a simple, correct, software-style reference implementation of hardware behavior used in a testbench to check whether the DUT (Design Under Test) produces the right outputs. 
Unlike a normal testbench that only drives inputs and prints waveforms, a golden-model testbench *predicts* the correct output using a clean behavioral model and compares it automatically with the DUT, failing immediately if there is a mismatch. 
It is not as heavy as UVM, but follows the same verification principle: reference model → scoreboard → automatic checking. 
It sits between simple directed tests and full UVM environments.

### 🔷 Normal Testbench (Basic)
- Drives inputs manually (wr_en, rd_en, data_in).
- User checks waveforms or monitor logs by hand.
- No automated correctness checking.
- Easy to write, low confidence.

### 🔶 Golden-Model Testbench (Medium)
- Adds a small software-like reference model (queue/array).
- Push expected values on valid writes.
- Pop and compare expected vs data_out on valid reads.
- Automatic pass/fail → no manual waveform checking.
- High confidence, still simple, no frameworks required.

### 🔵 UVM (Advanced)
- Uses driver, monitor, sequencer, scoreboard, coverage.
- Full constrained-random, coverage-driven environment.
- Very high confidence, industry standard.
- Heavy, complex, not needed for small student projects.
