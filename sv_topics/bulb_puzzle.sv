// ============================================================= //
// === 100 Prisoners and a Light Bulb Puzzle – SystemVerilog === //
// ============================================================= //
// Scenario:
// 100 prisoners are taken to a room one at a time. The room contains only a light bulb (initially OFF).
// At any point, one prisoner may declare that all 100 prisoners have visited the room.
// If correct, all are freed. If incorrect, all remain imprisoned forever.
//
// Goal:
// Design a strategy that guarantees success with 100% certainty.
//
// Strategy:
// - Designate one prisoner as "The Counter" (ID = 0)
// - Other prisoners (IDs 1–99) will turn ON the light once (only once in lifetime) if they find it OFF.
// - The Counter turns OFF the light every time they find it ON and increments their count.
// - Once the Counter has turned the light OFF 99 times, it means all other prisoners have been to the room.
//
// Assumptions:
// - Initial light state is OFF.
// - Prisoners are selected randomly but fairly over time.
// - The simulation is simplified and abstracted for illustration.
//

module PrisonerPuzzle;

  // --------------------------
  // Signal Declarations
  // --------------------------
  reg light = 0;              // Light bulb state: 0 = OFF, 1 = ON
  reg [6:0] count = 0;        // Counter's tally for prisoners who turned ON the light
  reg counter_done = 0;       // Flag to signal completion
  reg [6:0] prisoner_id = 1;  // Current prisoner ID (0 = Counter)

  // A register array to keep track of whether a non-counter prisoner has already turned on the light once
  reg turned_on_once[1:99];   // Boolean array: true if prisoner i has already turned on the light

  // --------------------------
  // Simulation Logic
  // --------------------------
  initial begin
    // Initialize flags for all non-counter prisoners
    for (int i = 1; i < 100; i++) begin
      turned_on_once[i] = 0;
    end

    // Main loop
    while (!counter_done) begin

      // Randomly pick a prisoner ID (0–99) for this turn
      prisoner_id = $urandom_range(0, 99);

      // --------------------------
      // If Counter is selected
      // --------------------------
      if (prisoner_id == 0) begin
        if (light == 1) begin
          // Turn off light and increment count
          count++;
          light = 0;
          $display("@[%0t] Counter turned OFF the light. Count = %0d", $time, count);
        end
      end

      // --------------------------
      // If a non-counter prisoner is selected
      // --------------------------
      else begin
        // If light is OFF and this prisoner hasn't turned it ON before
        if (light == 0 && !turned_on_once[prisoner_id]) begin
          light = 1;
          turned_on_once[prisoner_id] = 1;
          $display("@[%0t] Prisoner %0d turned ON the light", $time, prisoner_id);
        end
        else begin
          // Prisoner does nothing
          $display("@[%0t] Prisoner %0d did nothing", $time, prisoner_id);
        end
      end

      // --------------------------
      // Check if count reached 99
      // --------------------------
      if (count == 99) begin
        $display("\n✅ All 99 non-counter prisoners have turned on the light.");
        $display("✅ The Counter declares that all 100 prisoners have been in the room!");
        counter_done = 1;
      end

      // Wait before the next prisoner visit
      #10;
    end

    $finish; // End simulation
  end

endmodule
