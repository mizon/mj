type t = Field.t -> Field.t

let get_blocked_score han fu n_blocks field =
  Scoring.get_blocked_score (Scoring.get_base_score han fu)

let is_parent field player =
  Field.is_parent field player.Player.name

let tumo payee_name han fu field =
  let modify =
    let get_score =
      Scoring.get_blocked_score (Scoring.get_base_score han fu)
    in
    if Field.is_parent field payee_name then
      Field.modify_each_player (fun player ->
          let delta =
            if is_parent field player then
              3 * get_score 2
            else
              -get_score 2
          in
          Player.modify_score delta player
        )
    else
      Field.modify_each_player (fun player ->
          let delta =
            if player.Player.name = payee_name then
              get_score 2 + (2 * get_score 1)
            else if is_parent field player then
              -get_score 2
            else
              -get_score 1
          in
          Player.modify_score delta player
        )
  in
  Field.rotate_players (modify field)

let ron payee_name payer_name field =
  let payee = Field.get_player field payee_name in
  let payer = Field.get_player field payer_name in
  field

let riichi player_name field =
  let player = Field.get_player field player_name in
  field

let draw_game tenpai_player_names field =
  let tenpai_players = List.map (Field.get_player field) tenpai_player_names in
  field
