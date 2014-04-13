let get_base_score han hu =
  if han < 6  then
    let candidate = hu * Utils.pow 2 (han + 2) in
    min candidate 2000
  else if han < 8  then 3000
  else if han < 11 then 4000
  else if han < 13 then 6000
  else 8000

let get_blocked_score base_score n_blocks =
  let ceil100 n = int_of_float (ceil (float_of_int n /. 100.)) * 100 in
  ceil100 (base_score * n_blocks)
