let get_base_score han hu =
  if han < 4 || (han = 4 && hu < 40) then hu * Utils.pow 2 (han + 2)
  else if han < 6  then 2000
  else if han < 8  then 3000
  else if han < 11 then 4000
  else if han < 13 then 6000
  else 8000

let get_blocked_score base_score nblocks =
  int_of_float (ceil (float_of_int (base_score * nblocks) /. 100.)) * 100
