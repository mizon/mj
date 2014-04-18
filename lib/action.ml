open Core

type t = Field.t -> Field.t

let get_blocked_score han fu n_blocks field =
  Scoring.get_blocked_score (Scoring.get_base_score han fu)

let is_parent field player =
  Field.is_parent field player.Player.name

let tumo payee_name han fu field =
  let field =
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
        ) field
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
        ) field
  in
  Field.rotate_players field

let ron payee_name payer_name han fu field =
  let field =
    let delta =
      let n_blocks = if Field.is_parent field payee_name then 6 else 4 in
      Scoring.get_blocked_score (Scoring.get_base_score han fu) n_blocks
    in
    Field.modify_each_player (fun player ->
        if player.Player.name = payee_name then
          Player.modify_score delta player
        else if player.Player.name = payer_name then
          Player.modify_score (-delta) player
        else
          player
      ) field
  in
  field

let riichi player_name field =
  let field =
    Field.modify_each_player (fun player ->
        if player.Player.name = player_name then
          Player.riichi player
        else
          player
      ) field
  in
  Field.riichi field

let draw_game tenpai_player_names field =
  let n_players = Core_list.length tenpai_player_names in
  let payee_delta, payer_delta =
    if      n_players = 3 then 1000, -3000
    else if n_players = 2 then 1500, -1500
    else if n_players = 1 then 3000, -1000
    else assert false
  in
  let is_payee player =
    Option.is_some (Core_list.find tenpai_player_names ((=) player.Player.name))
  in
  Field.modify_each_player (fun player ->
      let delta = if is_payee player then payee_delta else payer_delta in
      Player.modify_score delta player
    ) field
