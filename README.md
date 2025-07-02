=LET(
  keywords, FILTER(Sheet2!B:B, Sheet2!B:B<>""), 
  found, FILTER(keywords, ISNUMBER(SEARCH(keywords, A1))),
  IFERROR(INDEX(found, 1), "")
)
