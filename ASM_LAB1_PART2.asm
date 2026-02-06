; Lab 1 Part Two - LED Blinking in Assembly
; Course: 04-633 A Embedded Systems Development
; MCU: PIC16F877A
; Description: Blinks two LEDs alternately on PORTB (RB0 and RB1)

; Register Addresses
ADCON1      equ     9Fh     ; A/D control register (Bank 1)
STATUS      equ     03h     ; Status register for bank selection
PORTB       equ     06h     ; PORTB data register (Bank 0)
TRISB       equ     86h     ; PORTB direction register (Bank 1)

; Status register bits
RP0         equ     05h     ; Bank select bit 0
RP1         equ     06h     ; Bank select bit 1

; Delay counter variables stored in general purpose registers
COUNTER1    equ     20h     ; Inner loop counter
COUNTER2    equ     21h     ; Middle loop counter
COUNTER3    equ     22h     ; Outer loop counter

; LED bit masks for PORTB
LED1_MASK   equ     01h     ; LED1 on RB0 (pin 33)
LED2_MASK   equ     02h     ; LED2 on RB1 (pin 34)

; Program starts at reset vector address
            org     00h

; --- Initialization ---
; Clear registers and configure PORTB for output
            clrw                    ; Clear working register
            BCF     STATUS, RP0    ; Select Bank 0
            BCF     STATUS, RP1
            CLRF    PORTB          ; Clear PORTB, all LEDs off

; Switch to Bank 1 to configure I/O direction
            BSF     STATUS, RP0    ; Select Bank 1
            MOVLW   0x06
            MOVWF   ADCON1         ; Configure all pins as digital I/O
            MOVLW   0x00
            MOVWF   TRISB          ; Set all PORTB pins as output (0 = output)

; Return to Bank 0 for normal operation
            BCF     STATUS, RP0
            BCF     STATUS, RP1

; --- Main Loop ---
; Alternates LED1 and LED2 with a delay between each state
MAIN_LOOP
            MOVLW   LED1_MASK
            MOVWF   PORTB          ; Turn ON LED1 (RB0), turn OFF LED2 (RB1)

            ; Delay 1 - triple nested loop for visible delay
            ; Counts down: 10 x 255 x 255 iterations (~0.65s at 4MHz)
            MOVLW   0x0A
            MOVWF   COUNTER3       ; Set outer counter to 10

D1_OUTER    MOVLW   0xFF
            MOVWF   COUNTER2       ; Set middle counter to 255

D1_MIDDLE   MOVLW   0xFF
            MOVWF   COUNTER1       ; Set inner counter to 255

D1_INNER    DECFSZ  COUNTER1, 1   ; Decrement inner, skip if zero
            GOTO    D1_INNER       ; Inner loop not done
            DECFSZ  COUNTER2, 1   ; Decrement middle, skip if zero
            GOTO    D1_MIDDLE      ; Reload inner and repeat
            DECFSZ  COUNTER3, 1   ; Decrement outer, skip if zero
            GOTO    D1_OUTER       ; Reload middle and repeat

            ; Switch LEDs
            MOVLW   LED2_MASK
            MOVWF   PORTB          ; Turn OFF LED1 (RB0), turn ON LED2 (RB1)

            ; Delay 2 - same triple nested loop as Delay 1
            MOVLW   0x0A
            MOVWF   COUNTER3       ; Set outer counter to 10

D2_OUTER    MOVLW   0xFF
            MOVWF   COUNTER2       ; Set middle counter to 255

D2_MIDDLE   MOVLW   0xFF
            MOVWF   COUNTER1       ; Set inner counter to 255

D2_INNER    DECFSZ  COUNTER1, 1   ; Decrement inner, skip if zero
            GOTO    D2_INNER       ; Inner loop not done
            DECFSZ  COUNTER2, 1   ; Decrement middle, skip if zero
            GOTO    D2_MIDDLE      ; Reload inner and repeat
            DECFSZ  COUNTER3, 1   ; Decrement outer, skip if zero
            GOTO    D2_OUTER       ; Reload middle and repeat

            GOTO    MAIN_LOOP      ; Loop back, blink forever

            END