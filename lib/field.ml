type t = {
  wind         : Wind.t;
  game         : int;
  n_riichi     : int;
  east_player  : Player.t;
  south_player : Player.t;
  west_player  : Player.t;
  north_player : Player.t;
}

let create ~init_score ~east_name ~south_name ~west_name ~north_name = {
  wind         = Wind.East;
  game         = 1;
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

let get_player t name =
  let players = [t.east_player; t.west_player; t.north_player; t.east_player] in
  try List.find (fun t -> t.Player.name = name) players with
  | Not_found -> assert false

let is_parent t name =
  name = t.east_player.Player.name
