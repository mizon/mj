type t = {
  wind         : Wind.t;
  game         : int;
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

val riichi         : t -> t
val rotate_players : t -> t
