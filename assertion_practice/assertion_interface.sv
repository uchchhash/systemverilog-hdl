interface assertion_interface(input clk_osc_100k);

  // --------------------------------------------------------------------------
  // Wire Declarations (assumed connected to DUT in top module)
  // --------------------------------------------------------------------------
  wire soft_reset;
  wire porz;
  wire rst_otp;
  wire rstz_i2c_reg;
  wire rstz_otp_100k;
  wire otp_rdy;
  wire reset_timer_done;

  // --------------------------------------------------------------------------
  // Sequence 1: PORZ (Power-On Reset) goes low then high (assert then release)
  // Pattern: (!porz) -> (porz)
  // --------------------------------------------------------------------------
  sequence porz_seq;
    (!porz) ##1 (porz);
  endsequence

  // --------------------------------------------------------------------------
  // Sequence 2: After PORZ goes high, system stays in low-reset for 4 cycles,
  // then rst_otp goes high.
  // Pattern: All resets/flags low for 4 cycles -> rst_otp asserted
  // --------------------------------------------------------------------------
  sequence porz_rstz_otp_seq;
    (!rst_otp && !rstz_i2c_reg && !rstz_otp_100k && !otp_rdy && !reset_timer_done)[*4]
    ##1 (rst_otp);
  endsequence

  // --------------------------------------------------------------------------
  // Sequence 3: rst_otp remains high, other signals still low for 3 cycles,
  // then rstz_i2c_reg and rstz_otp_100k become high
  // --------------------------------------------------------------------------
  sequence rst_otp_rstz_i2c_reg_rstz_otp_100k;
    (rst_otp && !rstz_i2c_reg && !rstz_otp_100k && !otp_rdy && !reset_timer_done)[*3]
    ##1 (rstz_i2c_reg && rstz_otp_100k);
  endsequence

  // --------------------------------------------------------------------------
  // Sequence 4: All reset signals active except otp_rdy and reset_timer_done.
  // After 6 cycles in this state, otp_rdy becomes high
  // --------------------------------------------------------------------------
  sequence rstz_i2c_reg_rstz_otp_100k_otp_rdy;
    (rst_otp && rstz_i2c_reg && rstz_otp_100k && !otp_rdy && !reset_timer_done)[*6]
    ##1 (otp_rdy);
  endsequence

  // --------------------------------------------------------------------------
  // Sequence 5: All reset signals + otp_rdy active but reset_timer_done is low.
  // After 13 cycles in this state, reset_timer_done becomes high
  // --------------------------------------------------------------------------
  sequence otp_rdy_reset_timer_done;
    (rst_otp && rstz_i2c_reg && rstz_otp_100k && otp_rdy && !reset_timer_done)[*13]
    ##1 (reset_timer_done);
  endsequence

  // --------------------------------------------------------------------------
  // Assertion Property: Full boot/reset protocol check
  //
  // When porz goes high, it triggers the following sequences in order:
  // 1. Wait 4 cycles with all resets low -> rst_otp high
  // 2. Wait 3 cycles with only rst_otp high -> other rst signals high
  // 3. Wait 6 cycles -> otp_rdy becomes high
  // 4. Wait 13 cycles -> reset_timer_done becomes high
  // --------------------------------------------------------------------------
  porz_rst_otp_seq_chk: assert property
    (@(posedge clk_osc_100k)
      porz |-> porz_rstz_otp_seq
                |-> rst_otp_rstz_i2c_reg_rstz_otp_100k
                |-> rstz_i2c_reg_rstz_otp_100k_otp_rdy
                |-> otp_rdy_reset_timer_done
    )
    $display("[%0t] ✅ Porz-Reset-OTP Assertion Passed", $time);
    else
    $display("[%0t] ❌ Porz-Reset-OTP Assertion Failed", $time);

endinterface
