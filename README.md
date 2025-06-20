# SystemVerilog OOP & Verification Examples

This repository contains practical SystemVerilog examples demonstrating key Object-Oriented Programming (OOP) principles, functional verification components, and common RTL testbench constructs. All code is extensively commented to help understand core concepts.

---

## 📁 Topics Covered

### 1. **Array Ordering Methods**
Demonstrates usage of:
- `reverse()`
- `sort()` and `rsort()`
- `shuffle()`

> **File:** `array_ordering_methods.sv`

---

### 2. **100 Prisoners Puzzle (Light Switch Problem)**
Simulation of the famous logic puzzle using registers and conditions to track light usage and prisoner visits.

> **File:** `prisoner_puzzle.sv`

---

### 3. **Deep vs Shallow Copy**
Illustrates the difference in behavior when copying objects with embedded handles.

> **File:** `deep_shallow_copy.sv`

---

### 4. **System Time Function**
Reads system time via `$system()` call and `$fscanf()`.

> **File:** `get_time_function.sv`

---

### 5. **Scoreboard with Report Phase**
Implements a UVM scoreboard showing:
- Use of report and pre_abort phases
- Display of pass/fail statistics
- ASCII art-based simulation summary

> **File:** `apb_spi_scoreboard.sv`

---

### 6. **Static Methods and Properties**
Demonstrates:
- Static variables shared across instances
- Static method calls via class name

> **File:** `static_methods.sv` and `static_properties.sv`

---

### 7. **Abstraction & Virtual Methods**
Uses:
- Virtual class with overridden method in a derived class
- Demonstrates method inheritance and polymorphism

> **File:** `abstraction_example.sv`

---

### 8. **Encapsulation & Data Hiding**
Demonstrates:
- `local` and `protected` visibility
- Calling hidden methods from a derived class

> **File:** `encapsulation.sv`

---

### 9. **SystemVerilog Bind Statement**
Explains:
- Purpose and syntax of `bind`
- Separation of design and verification

> **File:** `sv_bind_notes.sv`

---

### 10. **Control Flow Enhancements**
Shows usage of:
- `unique`, `unique0`, `priority` if constructs
- `unique` case for mutually exclusive decision making

> **File:** `control_flow_keywords.sv`

---

### 11. **Typed Constructor**
Instantiates a child class and assigns to base class handle using `Class::new()` syntax.

> **File:** `typed_constructor.sv`

---

### 12. **Queue Operations**
Demonstrates:
- Bounded and unbounded queues
- `insert()`, `delete()`, `push_back()`, etc.

> **File:** `queue_operations.sv`

---

### 13. **Tri-State Buffer & I2C Logic**
Shows:
- Use of `tri` net types
- Open-drain modeling
- Tri-state buffers in I2C context

> **File:** `tristate_i2c_model.sv`

---

### 14. **Extensive OOP Example: Audio Processing System**
Includes:
- Abstract base classes and inheritance
- Polymorphic method calls for `AudioSource` and `AudioEffect`
- `AudioProcessor` class applying effects to sources

> **File:** `audio_processing_system.sv`

---

## 🛠 Requirements
- SystemVerilog 2012 or later
- Any simulator (e.g., VCS, Xcelium, ModelSim)

---

## 📌 Structure
Organize your files as:
