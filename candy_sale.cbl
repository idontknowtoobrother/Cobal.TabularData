       IDENTIFICATION DIVISION.
       PROGRAM-ID. CANDY-SALE.
       AUTHOR. 62160246.
           
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT BRANCH-SALE-FILE ASSIGN TO "candy_sale.dat"
                 ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD BRANCH-SALE-FILE.
       01 BRANCH-SALE-REC.
          88 END-OF-SALES-FILE                     VALUE HIGH-VALUES.
       05 BRANCH-ID             PIC 9(7).
          05 STATE-NUM          PIC 99.
          05 CANDY-SALES        PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       01 STATE-SALES-TABLE.
          05 STATE-SALES-TOTAL  PIC 9(8)V99 OCCURS 50 TIMES.
       01 STATE-IDX             PIC 99.
       01 PRN-STATE-SALES       PIC $$$,$$$,$$9.99.
       PROCEDURE DIVISION.
       BEGIN.
           MOVE ZEROS TO STATE-SALES-TABLE
           OPEN INPUT BRANCH-SALE-FILE
           READ BRANCH-SALE-FILE
           AT END
              SET END-OF-SALES-FILE TO TRUE
           END-READ
           PERFORM UNTIL END-OF-SALES-FILE
                   ADD CANDY-SALES TO STATE-SALES-TOTAL(STATE-NUM)
                   READ BRANCH-SALE-FILE
                   AT END
                      SET END-OF-SALES-FILE TO TRUE
                   END-READ
           END-PERFORM
           DISPLAY "  YoreCandyShoppe Sales by State"
           DISPLAY "  ------------------------------"
           PERFORM VARYING STATE-IDX FROM 1 BY 1
              UNTIL STATE-IDX GREATER THAN 50
                   MOVE STATE-SALES-TOTAL(STATE-IDX) TO PRN-STATE-SALES
                   DISPLAY "State ",
                           STATE-IDX
                           " sales total is "
                           PRN-STATE-SALES
           END-PERFORM
           CLOSE BRANCH-SALE-FILE
           STOP RUN.