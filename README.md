=IFERROR(
  INDEX(Sheet2!A:A, MATCH(LOWER(A1), LOWER(Sheet2!A:A), 0)),
  ""
)
