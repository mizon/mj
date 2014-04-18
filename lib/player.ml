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

let riichi t =
  assert (not t.is_riichied);
  {
    t with
    score       = t.score - 1000;
    is_riichied = true;
  }
