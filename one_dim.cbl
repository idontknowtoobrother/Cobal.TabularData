       IDENTIFICATION DIVISION.
       PROGRAM-ID. ONE-DIM_TABLE.
       AUTHOR. 62160246.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-TABLE.
          05 WS-A   PIC X(10) VALUE "**BUU**" OCCURS 5 TIMES.
       01 WS-IDX    PIC 9(2).
       PROCEDURE DIVISION.
       BEGIN.
           DISPLAY "BUU TABLE" WS-TABLE
           DISPLAY WS-A(1)
           DISPLAY WS-A(2)
           DISPLAY WS-A(3)
           DISPLAY WS-A(4)
           DISPLAY WS-A(5)
           DISPLAY "========"
           PERFORM VARYING WS-IDX FROM 1 BY 1
              UNTIL WS-IDX = 5
                   DISPLAY WS-A(WS-IDX)
           END-PERFORM
           DISPLAY "========"
           PERFORM DO-DISPLAY
              VARYING WS-IDX FROM 1 BY 1
              UNTIL WS-IDX = 5
           .    
       DO-DISPLAY.
           DISPLAY WS-A(WS-IDX)
           .