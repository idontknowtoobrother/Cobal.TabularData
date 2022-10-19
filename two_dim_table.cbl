       IDENTIFICATION DIVISION.
       PROGRAM-ID. TWO-DIM-TABLE.
       AUTHOR. 62160246.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-VALUE      PIC X(9) VALUE "123456789".
       01 WS-TABLE REDEFINES WS-VALUE.
          05 WS-ROW OCCURS 3 TIMES.
             10 WS-COL  PIC X OCCURS 3 TIMES
                                 VALUE "-".
       01 WS-IDX-ROW    PIC 9.
       01 WS-IDX-COL    PIC 9.
       PROCEDURE DIVISION.

       BEGIN.
           DISPLAY WS-TABLE
           PERFORM VARYING WS-IDX-ROW FROM 1 BY 1
              UNTIL WS-IDX-ROW > 3
                   PERFORM VARYING WS-IDX-COL FROM 1 BY 1
                      UNTIL WS-IDX-COL > 3
                           DISPLAY WS-COL(WS-IDX-ROW, WS-IDX-COL)
                   END-PERFORM
           END-PERFORM
           .