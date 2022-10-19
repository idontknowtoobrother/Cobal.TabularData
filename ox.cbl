       IDENTIFICATION DIVISION.
       PROGRAM-ID. OX.
       AUTHOR. 62160246.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-ROW OCCURS 3 TIMES.
          05 WS-COL              PIC X OCCURS 3 TIMES
                                          VALUE "-".

       01 WS-IDX-ROW             PIC 9.
       01 WS-IDX-COL             PIC 9.
       01 WS-INPUT-ROW           PIC 9.
          88 WS-INPUT-ROW-VALID           VALUE 1 THRU 3.
       01 WS-INPUT-COL           PIC 9.
          88 WS-INPUT-COL-VALID           VALUE 1 THRU 3.
       01 WS-COUNT               PIC 9(2) VALUE ZERO.
       01 WS-PLAYER              PIC X    VALUE "X".
       PROCEDURE DIVISION.
       BEGIN.
           PERFORM UNTIL WS-COUNT > 9
                   PERFORM DISPLAY-TURN
                   PERFORM INPUT-ROW-COL
                   PERFORM PUT-TABLE
                   PERFORM DISPLAY-TABLE
                   PERFORM RESET-ROW-COL
           END-PERFORM
           GOBACK
           .
       PUT-TABLE.
           IF WS-COL(WS-INPUT-ROW, WS-INPUT-COL) = "-"
              MOVE WS-PLAYER TO WS-COL(WS-INPUT-ROW, WS-INPUT-COL)
              ADD 1 TO WS-COUNT
              PERFORM TURN-PLAYER
           ELSE
              DISPLAY "ERROR"
           END-IF
           .    
       DISPLAY-TURN.
           DISPLAY "TURN " WS-PLAYER
           .    
       TURN-PLAYER.
           IF WS-PLAYER = "X"
              MOVE "O" TO WS-PLAYER
           ELSE
              MOVE "X" TO WS-PLAYER
           END-IF
           .    
       RESET-ROW-COL.
           MOVE ZERO TO WS-INPUT-ROW, WS-INPUT-COL
           .
       INPUT-ROW-COL.
           PERFORM UNTIL WS-INPUT-ROW-VALID
                   DISPLAY "INPUT ROW -"
                   ACCEPT WS-INPUT-ROW
           END-PERFORM
           PERFORM UNTIL WS-INPUT-COL-VALID
                   DISPLAY "INPUT COL -"
                   ACCEPT WS-INPUT-COL
           END-PERFORM
           .    
       DISPLAY-TABLE.
           PERFORM VARYING WS-IDX-ROW FROM 1 BY 1
              UNTIL WS-IDX-ROW > 3
                   PERFORM VARYING WS-IDX-COL FROM 1 BY 1
                      UNTIL WS-IDX-COL > 3
                           DISPLAY WS-COL(WS-IDX-ROW, WS-IDX-COL)
                              WITH NO ADVANCING
                   END-PERFORM
                   DISPLAY " "
           END-PERFORM
           .