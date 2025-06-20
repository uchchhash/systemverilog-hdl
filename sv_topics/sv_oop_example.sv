
// Problem Statement: Audio Processing System
// You are tasked with designing an audio processing system in SystemVerilog using object-oriented programming (OOP) principles. The system should be capable of processing different types of audio sources, such as microphones and music players, applying various audio effects, and outputting the processed audio. The key requirements include encapsulation of audio source details, polymorphic processing of audio effects, and inheritance for different types of audio sources.

// Requirements:
// Audio Source Classes:

// Implement an abstract base class AudioSource with the following properties:

// sampleRate (integer): The sample rate of the audio source.
// numChannels (integer): The number of audio channels.
// Create two derived classes: Microphone and MusicPlayer that inherit from AudioSource.

// Microphone should have an additional property sensitivity (float).
// MusicPlayer should have an additional property playbackSpeed (float).
// Audio Effect Classes:

// Implement an abstract base class AudioEffect with a virtual method processAudio() that takes in audio samples as input and applies a generic audio effect.

// Create two derived classes: ReverbEffect and EqualizerEffect that inherit from AudioEffect.

// ReverbEffect should have an additional property reverbLevel (float).
// EqualizerEffect should have an additional property equalizerSettings (array of floats).
// Audio Processing System:

// Implement a class AudioProcessor that can take any AudioSource and apply a sequence of AudioEffect instances to process the audio.
// Use polymorphism to process the audio based on the specific effect types applied.
// Testbench:

// Create a SystemVerilog testbench that instantiates instances of Microphone and MusicPlayer.
// Configure and apply different audio effects to each source using the AudioProcessor.
// Verify that the processed audio meets the expected results.
// Constraints:
// Utilize encapsulation to hide the internal details of the classes.
// Leverage polymorphism to process audio sources using different audio effects.
// Use inheritance to create specialized classes for microphones, music players, and audio effects.
// Deliverables:
// Submit the SystemVerilog code for the AudioSource, AudioEffect, AudioProcessor classes, as well as the derived classes Microphone, MusicPlayer, ReverbEffect, and EqualizerEffect. Also, provide a testbench that demonstrates the correct functioning of the audio processing system.

// This problem statement encourages the use of encapsulation, polymorphism, and inheritance to model a modular and extensible audio processing system in SystemVerilog. It provides an opportunity to practice these OOP principles in the context of a real-world application.




//======================================================//
//====== SystemVerilog Audio Processing OOP Model ======//
//======================================================//

// Abstract base class for any audio source
class AudioSource;
  protected int sampleRate;    // Sample rate of the audio (Hz)
  protected int numChannels;   // Number of audio channels

  // Constructor
  function new(int sampleRate, int numChannels);
    this.sampleRate = sampleRate;
    this.numChannels = numChannels;
  endfunction

  // Virtual method to display info about the audio source
  virtual function void displayInfo();
    $display("Audio Source: Sample Rate = %0d Hz, Channels = %0d", sampleRate, numChannels);
  endfunction
endclass


// Derived class: Microphone
class Microphone extends AudioSource;
  protected real sensitivity;  // Microphone sensitivity in mV/Pa

  function new(int sampleRate, int numChannels, real sensitivity);
    super.new(sampleRate, numChannels);
    this.sensitivity = sensitivity;
  endfunction

  // Overridden method to include sensitivity info
  function void displayInfo();
    super.displayInfo();
    $display("Microphone: Sensitivity = %0.2f mV/Pa", sensitivity);
  endfunction
endclass


// Derived class: MusicPlayer
class MusicPlayer extends AudioSource;
  protected real playbackSpeed;  // Playback speed multiplier

  function new(int sampleRate, int numChannels, real playbackSpeed);
    super.new(sampleRate, numChannels);
    this.playbackSpeed = playbackSpeed;
  endfunction

  // Overridden method to include playback speed
  function void displayInfo();
    super.displayInfo();
    $display("Music Player: Playback Speed = %0.2fx", playbackSpeed);
  endfunction
endclass


// Abstract base class for any audio effect
class AudioEffect;
  // Virtual method that must be overridden in derived classes
  virtual function void processAudio();
  endfunction
endclass


// Derived class: ReverbEffect
class ReverbEffect extends AudioEffect;
  protected real reverbLevel;  // Reverb intensity (0.0 - 1.0)

  function new(real reverbLevel);
    this.reverbLevel = reverbLevel;
  endfunction

  // Override: Simulate applying reverb effect
  function void processAudio();
    $display("Applying Reverb Effect: Level = %0.2f", reverbLevel);
  endfunction
endclass


// Derived class: EqualizerEffect
class EqualizerEffect extends AudioEffect;
  protected real equalizerSettings[$];  // Array of EQ settings per band

  function new(real eq_array[]);
    this.equalizerSettings = eq_array;
  endfunction

  // Override: Simulate applying equalizer effect
  function void processAudio();
    $display("Applying Equalizer Effect: Settings = %p", equalizerSettings);
  endfunction
endclass


// AudioProcessor: Applies effects to any audio source using polymorphism
class AudioProcessor;

  // Accept any AudioSource and apply any array of AudioEffects
  function void process(AudioSource source, AudioEffect effects[$]);
    $display("\n--- Audio Processing Started ---");
    source.displayInfo();  // Display audio source info

    // Loop through each effect and apply it polymorphically
    foreach (effects[i]) begin
      effects[i].processAudio();
    end

    $display("--- Audio Processing Complete ---\n");
  endfunction

endclass


//====================== TESTBENCH ======================//
module tb;

  // Declare class handles
  Microphone mic;
  MusicPlayer player;
  ReverbEffect reverb;
  EqualizerEffect equalizer;
  AudioProcessor processor;
  AudioEffect mic_effects[$];
  AudioEffect music_effects[$];

  initial begin
    // Create audio sources
    mic = new(44100, 1, 0.85);       // Mono microphone with high sensitivity
    player = new(48000, 2, 1.25);    // Stereo music player with faster playback

    // Create effects
    reverb = new(0.65);                      // Moderate reverb level
    equalizer = new('{1.0, 0.9, 1.2, 0.8});  // Custom EQ settings

    // Create processor
    processor = new();

    // Apply reverb to mic
    mic_effects.push_back(reverb);
    processor.process(mic, mic_effects);

    // Apply equalizer to music player
    music_effects.push_back(equalizer);
    processor.process(player, music_effects);
  end

endmodule
