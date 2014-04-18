type t = {
  wind         : Wind.t;
  game         : int;
  honba        : int;
  n_riichi     : int;
  east_player  : Player.t;
  south_player : Player.t;
  west_player  : Player.t;
  north_player : Player.t;
}

val create :
  init_score:int ->
  east_name:string ->
  south_name:string ->
  west_name:string ->
  north_name:string ->
  t

val riichi             : t -> t
val rotate_players     : t -> t
val get_players        : t -> Player.t list
val get_player         : t -> string -> Player.t
val is_parent          : t -> string -> bool
val iter_players       : t -> (Player.t -> unit) -> unit
val modify_each_player : t -> (Player.t -> Player.t) -> t
val modify_player      : t -> string -> (Player.t -> Player.t) -> t
