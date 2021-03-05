// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

//pseudo-code:

    //  while(1){
    //    
    //      keyCode = getCurrentPressedKeyCode(keyboard);
    //      
    //       if(keyCode == 0 && screenColor == "black"){
    //          whitenScreen(screen);
    //          screenColor = "white";
    //
    //      }else if(keyCode != 0 && screenColor == "white") {
    //          blackenScreen(screen);
    //          screenColor = "black";
    //      }
    //
    //   }

//hack assembly code:
(MAIN)

    //initializing variables:

    @keyCode
    M = 0

    @screenColor
    M = 0

    @KBD
    D = A
    @SCREEN
    D = D - A
    @screenArraySize
    M = D

    @fillReturn
    M = 0

    (MAIN_LOOP)
       
        @i
        M = 0

        @KBD
        D = M
        @keyCode
        M = D              //keyCode = getCurrentPressedKeyCode(keyboard);

        @WHITEN_SCREEN
        D;JEQ             //if(keyCode == 0) goto WHITEN_SCREEN

        @BLACKEN_SCREEN
        0;JMP             //else goto BLACKEN_SCREEN


        (WHITEN_SCREEN)

            @screenColor
            D = M
            @WHITEN_SCREEN_END
            D-1;JLT             //if(screenColor == "white") got WHITEN_SCREEN_END

            @screenColor
            M = 0        //screenColor = "white";

            @WHITEN_SCREEN_END
            D = A
            @fillReturn
            M = D
            @FILL_SCREEN
            0;JMP

            (WHITEN_SCREEN_END)
                @MAIN_LOOP
                0;JMP

        (BLACKEN_SCREEN)

            @screenColor
            D = M
            @BLACKEN_SCREEN_END
            D-1;JEQ             //if(screenColor == "black") got BLACKEN_SCREEN_END
            
            @screenColor
            M = 1        //screenColor = "black";

            @BLACKEN_SCREEN_END
            D = A
            @fillReturn
            M = D
            @FILL_SCREEN
            0;JMP

            (BLACKEN_SCREEN_END)
                @MAIN_LOOP
                0;JMP


(FILL_SCREEN)

    (FILL_LOOP)
        @i
        D = M    
        @screenArraySize
        D = D - M
        @FILL_END
        D;JEQ            //if(i == screenArraySize) goto FILL_END
        
        @SCREEN
        D = A
        @i
        D = D + M       
        @currentScreenRegister
        M = D           //currentScreenRegister = SCREEN + i
        @screenColor
        D = -M
        @currentScreenRegister
        A = M;
        M = D;          //SCREEN[i] = screenColor;

        //i++
        @i
        M = M + 1

        @FILL_LOOP
        0;JMP

    (FILL_END)
        @fillReturn
        A = M 
        0;JMP