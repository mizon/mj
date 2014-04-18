type t = Field.t -> Field.t

val tumo      : string -> int -> int -> t
val ron       : string -> string -> int -> int -> t
val riichi    : string -> t
val draw_game : string list -> t
