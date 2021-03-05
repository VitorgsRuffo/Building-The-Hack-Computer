// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)


//pseudo-code: multiplication logic example: 4 * 7 = 7 + 7 + 7 + 7 (sum of four sevens)

    // r0 = RAM[0];
    // r1 = RAM[1];
    // RAM[2] = 0;
    // result = 0;
    // i = 0;

    // for(i = 0; i<r0; i++){
    //     result += r1;
    // }

    // r2 = result;

//hack assembly code:

    //initializing variables:
    @R0
    D = M
    @r0
    M = D

    @R1
    D = M
    @r1
    M = D

    @result
    M = 0

    @i
    M = 0

    @R2
    M = 0
    
    (LOOP)
        //if(i == r0) goto SET_RESULT
        @i
        D = M
        @r0
        D = D - M    //i - r0
        @SET_RESULT
        D;JEQ

        @result
        D = M
        @r1 
        D = D + M   //result += r1
        @result
        M = D

        //i++
        @i
        M = M + 1

        @LOOP
        0;JMP

    (SET_RESULT)
        @result
        D = M
        @R2
        M = D

    (END)
        @END
        0;JMP