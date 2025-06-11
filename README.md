=LET(
  txt, A1,
  n, SEQUENCE(LEN(txt)-11),
  segment, MID(txt, n, 12),
  match, FILTER(segment, ISNUMBER(--segment)),
  INDEX(match, 1)
)
