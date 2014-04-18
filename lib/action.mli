type t = Field.t -> Field.t

val tumo      : string -> int -> int -> t
val ron       : string -> string -> t
val riichi    : string -> t
val draw_game : string list -> t
