    .data
msg1:       .asciiz "Enter the number of fibonacci numbers > 2: \n"
msg2:       .asciiz "The numbers are: \n"
newline:    .asciiz "\n"

CONTROL:    .word32 0x10000
DATA:       .word32 0x10008

    .text

main:

    lwu     r21,CONTROL(r0) ; specifying control register for I/O
    lwu     r22, DATA(r0)   ; specifying data register for I/O

    daddi   r24,r0,4        ; set data to address of string to be output
    daddi   r1,r0,msg1      ; adding the address of 'msg1' into reg r1
    sd      r1,(r22)        ; r1 to output
    sd      r24,(r21)       ; to screen

    daddi   r24,r0,8        ; read the DATA from keyboard
    sd      r24,(r21)       ; from screen
    ld      r2,(r22)        ; from input into r1 to be used for fibonacci

    daddi   r3,r0,0         ; x = 0
    daddi   r4,r0,1         ; y = 1
    daddi   r5,r0,2         ; count = 2;


    daddi   r24,r0,4        ; set data to address of string to be output
    daddi   r1,r0,msg2      ; adding the address of 'msg2' into reg r1
    sd      r1,(r22)        ; r1 to output
    sd      r24,(r21)       ; to screen
    
    slt     r7,r2,r5        ; check input greater than 2
    bne     r7,r0,onenum       ; if < 2 got to onenum

    daddi   r24,r0,1       ; set data to unsigned int to be output
    sd      r3,(r22)        ; storing content of r3 into data reg
    sd      r24,(r21)       ; to screen
    sd      r4,(r22)        ; stroring content of r4 into data reg
    sd      r24,(r21)       ; to screen

    j       loop            ; jumpt to loop

loop:

    beq     r5,r2,end       ; if (count == num) end
    dadd    r6,r4,r3        ; z = x + y
    sd      r6,(r22)        ; storing content of r6 into data reg
    sd      r24,(r21)       ; to screen
    dadd    r3,r0,r4        ; x = y
    dadd    r4,r0,r6        ; y = z
    daddi   r5,r5,1         ; count++
    j       loop            ; loop

end:
    halt                    ; end program

onenum:
    daddi   r24,r0,2        ; set data to unsinged int to be output
    sd      r3,(r22)        ; storing content of r3 int data reg
    sd      r24,(r21)       ; to screen
    halt                    ; end program