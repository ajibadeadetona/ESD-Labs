# Lab 1 Part Two - Assembly Language LED Blinking

## Course
04-633 A: Embedded Systems Development  
Carnegie Mellon University Africa

## Description
This project implements an alternating LED blink program written in Assembly Language for the **PIC16F877A** microcontroller. Two LEDs connected to PORTB pins RB0 and RB1 blink alternately using a triple-nested delay loop for visible timing.

## Components
- PIC16F877A Microcontroller
- 2x LEDs with 330Ω current-limiting resistors
- 16 MHz Crystal Oscillator with 22pF capacitors
- Power (5V) and Reset (MCLR) connections

## Files
- `blinkingLED.asm` — Assembly source code
- `aadetona_ASS1_ASM.pdsprj` — Proteus simulation design file

## How It Works
1. PORTB pins RB0 and RB1 are configured as digital outputs
2. LED1 (RB0) turns ON while LED2 (RB1) is OFF
3. A delay loop runs (~0.65 seconds at 4 MHz)
4. LED1 turns OFF and LED2 turns ON
5. Another delay loop runs
6. The cycle repeats indefinitely

## Tools Used
- MPLAB X IDE (MPASM assembler)
- Proteus Design Suite
