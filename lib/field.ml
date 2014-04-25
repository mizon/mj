open Core

type t = {
  wind         : Wind.t;
  kyoku        : int;
  honba        : int;
  n_riichi     : int;
  east_player  : Player.t;
  south_player : Player.t;
  west_player  : Player.t;
  north_player : Player.t;
}

let create ~init_score ~east_name ~south_name ~west_name ~north_name = {
  wind         = Wind.East;
  kyoku        = 1;
  honba        = 0;
  n_riichi     = 0;
  east_player  = Player.create east_name init_score;
  south_player = Player.create south_name init_score;
  west_player  = Player.create west_name init_score;
  north_player = Player.create north_name init_score;
}

let riichi t = {
  t with
  n_riichi = succ t.n_riichi
}

let rotate_players t = {
  t with
  east_player  = t.south_player;
  south_player = t.west_player;
  west_player  = t.north_player;
  north_player = t.east_player;
}

let get_players t = [
  t.east_player;
  t.south_player;
  t.west_player;
  t.north_player;
]

let get_player t name =
  let players = get_players t in
  match Core_list.find players (fun t -> t.Player.name = name) with
  | Some player -> player
  | None        -> assert false

let is_parent t name =
  name = t.east_player.Player.name

let iter_players t f =
  Core_list.iter (get_players t) f

let modify_each_player t f = {
  t with
  east_player  = f (t.east_player);
  south_player = f (t.south_player);
  west_player  = f (t.west_player);
  north_player = f (t.north_player);
}

let modify_player t name f =
  let f player =
    if player.Player.name = name then
      f player
    else
      player in
  modify_each_player t f
