// ====================================================
// Function : get_time
// Purpose  : Returns the current system time as a string
// Method   : Uses $system to call OS command, stores to temp file, reads back into SV
// ====================================================
function string get_time();
  
  int file_pointer; // File pointer for reading the temporary file
  
  // Step 1: Write the current system time into a temporary file called "sys_time"
  // %X --> time (HH:MM:SS) | %x --> date (MM/DD/YY)
  // Format: HH:MM:SS--MM/DD/YY
  void'($system("date +%X--%x > sys_time"));

  // Step 2: Open the file in read mode
  file_pointer = $fopen("sys_time", "r");

  // Step 3: Read the first string from the file and assign to return variable
  // Note: `get_time` is also the return variable here
  void'($fscanf(file_pointer, "%s", get_time));

  // Step 4: Close the file to avoid file handle leaks
  $fclose(file_pointer);

  // Step 5: Delete the temporary file to clean up
  void'($system("rm sys_time"));

endfunction
