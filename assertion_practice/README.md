# 🔍 Reset Sequence Verification and Clock Gating Testbench Suite

This repository contains SystemVerilog testbenches, design modules, and assertion interfaces to verify reset sequencing logic and conditional clock gating behavior, including dynamic assertion control.

---

## 📁 Directory Structure

```bash
.
├── assertion_interface.sv          # Assertion interface for reset sequencing
├── assert_control.sv               # Demonstration of $assertcontrol usage
├── assert_interface.sv             # Alternate interface (less comprehensive)
├── assert_practice.sv              # Practice module for assertion chaining
├── dut_clk_reset.sv                # DUT for clk + mode reset handling
├── reset_otp_seq_module.sv         # DUT implementing OTP reset sequence
├── tb_clk_adc_sch_12m.sv           # TB measuring gated ADC clock frequency
├── tb_clk_reset.sv                 # TB for dut_clk_reset.sv
├── tb_reset_otp_seq_module.sv      # TB for reset_otp_seq_module + assertions
├── filelist.f                      # File list for compilation
├── run.sh                          # Shell script to compile and run simulation
└── dump.vcd                        # (Optional) Generated VCD waveform file

## 🧪 Testbenches

### `tb_reset_otp_seq_module.sv`
- Connects `reset_otp_seq_module.sv` with `assertion_interface.sv`
- Drives `porz` and observes reset signals over time
- Verifies full reset sequence using formal assertions

### `tb_clk_adc_sch_12m.sv`
- Tests conditional clock enable behavior for ADC scheduler
- Measures actual clock frequency based on dynamic gating conditions

### `tb_clk_reset.sv`
- Provides stimulus to `dut_clk_reset.sv`
- Validates mode-driven and reset behavior

---

## ✅ Assertions

### `assertion_interface.sv`
Checks:
- `porz` transitions to `rst_otp` after 4 cycles
- `rst_otp` to `rstz_i2c_reg` + `rstz_otp_100k` after 3 cycles
- `otp_rdy` after 6 cycles
- `reset_timer_done` after 13 cycles

### `assert_control.sv`
Demonstrates how to control assertions at runtime:
```systemverilog
$assertcontrol("off");
$assertcontrol("on");
$assertcontrol("freeze");

