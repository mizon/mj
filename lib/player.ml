type t = {
  name        : string;
  score       : int;
  is_riichied : bool;
}

let create name_ score_ = {
  name        = name_;
  score       = score_;
  is_riichied = false;
}

let modify_score delta t = {
  t with score = t.score + delta;
}
