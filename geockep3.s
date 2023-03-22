    .data
    .text
main:
    DADDI R3,R0,8
    DADDI R1,R0,1024
    DADDI R2,R0,1024
Loop: 
    L.D F0,0(R1)
    MUL.D F0,F0,F2
    L.D F4,0(R2)
    ADD.D F0,F0,F4
    S.D F0,0(R2)
    DSUB R1,R1,R3
    DSUB R2,R2,R3
    BNEZ R1,Loop
    NOP
    HALT
