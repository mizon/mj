let pow base exp =
  let base = float_of_int base in
  let exp  = float_of_int exp in
  int_of_float (base ** exp)
