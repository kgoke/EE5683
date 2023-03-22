    .data
msg1: .asciiz "Enter the total number of digits\n"
msg2: .asciiz "Enter the digit "
msg3: .asciiz "Entered Number: "
msg4: .asciiz "Sum of the Product: "
msg5: .asciiz "Armstrong number"
msg6: .asciiz "Not and Armstrong number"

CONTROL:    .word32 0x10000
DATA:       .word32 0x10008

    .text

main:
                                ; specifying the control/data register fro I/O
    lwu     r21,CONTROL(r0)     ; control register
    lwu     r22, DATA(r0)       ; data register
                                ; dispalying msg1 and getting num from user input
    daddi   r24,r0,4            ; output string
    daddi   r1,r0,msg1          ; load msg1 into r1
    sd      r1,(r22)            ; msg1 to out
    sd      r24,(r21)           ; to screen
    daddi   r24,r0,8            ; input int
    sd      r24,(r21)           ; from screen
    ld      r2,(r22)            ; r2 hold num

                                ; initialize sum, capture, and i to 0
    daddi   r3,r0,0             ; sum
    daddi   r4,r0,0             ; capture
    daddi   r13,r0,0            ; i

Loop:
                                ; get the digit from user input
    daddi   r24,r0,4            ; output string
    daddi   r1,r0,msg2          ; load msg2 into r1
    sd      r1,(r22)            ; msg2 to out
    sd      r24,(r21)           ; to screen
    daddi   r5,r13,1            ; i + 1
    daddi   r24,r0,1            ; output int
    sd      r5,(r22)            ; r5 to out
    sd      r24,(r21)           ; to screen
    daddi   r24,r0,8            ; input int
    sd      r24,(r21)           ; fromt screen
    ld      r6,(r22)            ; r6 hold digit
                                ; calculating the powered value
    daddi   r7,r0,1             ; r7 = powered = 1
    daddi   r8,r0, 0            ; r8 = j = 0

PowerLoop:
    dmul    r7,r7,r6            ; powered = powered * digit
    daddi   r8,r8,1             ; j++
    bne     r2,r8, PowerLoop    ; if r9 != 0, continue PowerLoop
                                ; updating sum and capture
    dadd    r3,r3,r7            ; sum = sum + powered
    daddi   r12,r0,10
    dmul    r4,r4,r12           ; capture = capture * 10
    dadd    r4,r4,r6            ; capture = capture + digit
                                ; increment loop counter and loop
    daddi   r13,r13,1           ; i++
    bne     r2,r13,Loop         ; if r10 != 0, continue Loop
                                ; display entered number and sum of products
    daddi   r24,r0,4            ; output string
    daddi   r1,r0,msg3          ; load msg3 into r1
    sd      r1,(r22)            ; msg3 to out
    sd      r24,(r21)           ; to screen
    daddi   r24, r0, 1          ; output int
    sd      r4,(r22)            ; capture to out
    sd      r24,(r21)           ; to screen
    daddi   r24, r0, 4          ; output string
    daddi   r1, r0, msg4        ; load msg4 into r1
    sd      r1, (r22)           ; msg4 to out
    sd      r24, (r21)          ; to screen
    daddi   r24, r0, 1          ; output int
    sd      r3, (r22)           ; sum to out
    sd      r24, (r21)          ; to screen
                                ; check if Armstrong number or not
    dsub    r11, r4, r3         ; r11 = capture - sum
    beq     r11, r0, Armstrong  ; if r11 == 0, branch to Armstrong

NotArmstrong:
    daddi   r24, r0, 4          ; output string
    daddi   r1, r0, msg6        ; load msg6 into r1
    sd      r1, (r22)           ; msg6 to out
    sd      r24, (r21)          ; to screen
    j       Exit                ; jump to Exit

Armstrong:
    daddi   r24, r0, 4          ; output string
    daddi   r1, r0, msg5        ; load msg5 into r1
    sd      r1, (r22)           ; msg5 to out
    sd      r24, (r21)          ; to screen

Exit:
    halt                        ; exit the program
