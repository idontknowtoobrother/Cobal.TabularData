       IDENTIFICATION DIVISION.
       PROGRAM-ID. BRANCH-SALE.
       AUTHOR. 62160246.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT BRANCH-SALE-FILE ASSIGN TO "branch_sales.dat"
                 ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD BRANCH-SALE-FILE.
       01 BRANCH-SALES-REC.
          88 END-OF-SALES-FILE                         VALUE HIGH-VALUES
           .
       05 BRANCH-ID                 PIC 9(7).
          05 STATE-NUM              PIC 99.
          05 CANDY-SALES            PIC 9(7)V99.

       WORKING-STORAGE SECTION.
       01 STATE-SALES-TABLE.
          05 STATE-TOTALS OCCURS 50 TIMES.
             10 STATE-SALES-TOTAL   PIC 9(8)V99.
             10 STATE-BRANCH-COUNT  PIC 9(5).
       01 STATE-IDX                 PIC 99.

       01 REPORT-HEADING1           PIC X(35)
                                                       VALUE
             "    YoreCandyShoppe Sales by State".
       01 REPORT-HEADING2           PIC X(35)
                                                       VALUE
             "    ------------------------------".
       01 REPORT-HEADING3           PIC X(47)
                                                       VALUE
             "State  Branches   StateSales  AverageSales".

       01 DETAIL-LINE.
          05 PRN-STATE-NUM          PIC BZ9.
          05 PRN-BRANCH-COUNT       PIC B(3)ZZ,ZZ9.
          05 PRN-STATE-SALES        PIC B(5)$$$,$$$,$$9.99.
          05 PRN-AVERAGE-SALES      PIC BB$$$,$$$,$$9.99.

       01 US-TOTALS.
          05 US-TOTAL-SALES         PIC 9(9)V99.
          05 US-BRANCH-COUNT        PIC 9(6).
          05 PRN-US-TOTAL-SALES     PIC $,$$$,$$$,$$9.99.
          05 PRN-US-BRANCH-COUNT    PIC B(9)ZZZ,ZZ9.
          05 PRN-US-AVERAGE-SALES   PIC BBBB$$$,$$$,$$9.99.

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
                      ,               US-TOTAL-SALES
                   ADD 1 TO STATE-BRANCH-COUNT(STATE-NUM)
                      ,     US-BRANCH-COUNT
                   READ BRANCH-SALE-FILE
                   AT END
                      SET END-OF-SALES-FILE TO TRUE
                   END-READ
           END-PERFORM
           PERFORM PRINT-RESULTS

           CLOSE BRANCH-SALE-FILE
           STOP RUN.

       PRINT-RESULTS.
           DISPLAY REPORT-HEADING1
           DISPLAY REPORT-HEADING2
           DISPLAY REPORT-HEADING3
           PERFORM VARYING STATE-IDX FROM 1 BY 1
              UNTIL STATE-IDX GREATER THAN 50
                   MOVE STATE-IDX TO PRN-STATE-NUM
                   MOVE STATE-SALES-TOTAL(STATE-IDX) TO PRN-STATE-SALES
                   MOVE STATE-BRANCH-COUNT(STATE-IDX) TO
                      PRN-BRANCH-COUNT
                   COMPUTE PRN-AVERAGE-SALES = STATE-SALES-TOTAL
                      (STATE-IDX)
                      / STATE-BRANCH-COUNT(STATE-IDX)
                   DISPLAY DETAIL-LINE
           END-PERFORM
           MOVE US-TOTAL-SALES TO PRN-US-TOTAL-SALES
           MOVE US-BRANCH-COUNT TO PRN-US-BRANCH-COUNT
           COMPUTE PRN-US-AVERAGE-SALES = US-TOTAL-SALES
              / US-BRANCH-COUNT
           DISPLAY "YoreCandyShop branches in the US = "
                   PRN-US-BRANCH-COUNT
           DISPLAY "YoreCandyShop sales in the US = "
                   PRN-US-TOTAL-SALES
           DISPLAY "YoreCandyShop average US sales = "
                   PRN-AVERAGE-SALES.