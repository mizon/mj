type t = {
  name        : string;
  score       : int;
  is_riichied : bool;
}

val create : string -> int -> t
