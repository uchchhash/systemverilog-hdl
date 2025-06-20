// ============================================================ //
// === SystemVerilog Associative Array - Key Methods Demo    === //
// ============================================================ //

module test;

  // Declare an associative array indexed by `string`
  int a_team [string];

  // Temporary variables
  int val;         // Will hold values from array
  string s;        // Used as index for traversal

  initial begin
    // --------------------------
    // Initialize the associative array
    // --------------------------
    a_team = '{
      "AA" : 2,
      "DD" : 3,
      "BB" : 4,
      "CC" : 5
    };

    $display("Initial a_team = %p", a_team);

    // --------------------------
    // num() - returns number of entries
    // --------------------------
    $display("num() = %0d", a_team.num());

    // --------------------------
    // size() - same as num(), but returns int
    // --------------------------
    $display("size() = %0d", a_team.size());

    // --------------------------
    // first() - get first (lowest string lexicographically)
    // --------------------------
    if (a_team.first(s))
      $display("First index = %s => Value = %0d", s, a_team[s]);

    // --------------------------
    // last() - get last (highest string)
    // --------------------------
    if (a_team.last(s))
      $display("Last index = %s => Value = %0d", s, a_team[s]);

    // --------------------------
    // next() - find next key after "BB"
    // --------------------------
    s = "BB";
    if (a_team.next(s))
      $display("Next index after 'BB' = %s => Value = %0d", s, a_team[s]);

    // --------------------------
    // prev() - find previous key before "DD"
    // --------------------------
    s = "DD";
    if (a_team.prev(s))
      $display("Previous index before 'DD' = %s => Value = %0d", s, a_team[s]);

    // --------------------------
    // delete() - remove entry by key
    // --------------------------
    a_team.delete("CC");
    $display("After deleting 'CC': a_team = %p", a_team);

    // --------------------------
    // Traverse using `first` and `next`
    // --------------------------
    string idx;
    if (a_team.first(idx)) begin
      do begin
        $display("Traversal: [%s] => %0d", idx, a_team[idx]);
      end while (a_team.next(idx));
    end

  end

endmodule
