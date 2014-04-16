open OUnit2
open Mj
open Mj.Field

let field = Field.create ~init_score:25000
                         ~east_name: "A"
                         ~south_name:"B"
                         ~west_name: "C"
                         ~north_name:"D"

let suite =
  "Field" >::: [
    "riichi" >:: (fun _ ->
        let riichied1 = riichi field in
        assert_equal {field with n_riichi = 1} riichied1;
        let riichied2 = riichi riichied1 in
        assert_equal {field with n_riichi = 2} riichied2
      );

    "rotate_players" >:: (fun _ ->
        let rotated = {
          field with
          east_player  = field.south_player;
          south_player = field.west_player;
          west_player  = field.north_player;
          north_player = field.east_player;
        } in
        assert_equal rotated (rotate_players field);

        let rotated = rotate_players
                     (rotate_players
                     (rotate_players
                     (rotate_players field))) in
        assert_equal field rotated
      );

    "get_player" >:: (fun _ ->
        let player = get_player field "A" in
        assert_equal "A" player.Player.name;
        let player = get_player field "C" in
        assert_equal "C" player.Player.name
      );

    "is_parent" >:: (fun _ ->
        assert_bool "A is a parent" (is_parent field "A");
        assert_bool "B is not a parent" (not (is_parent field "B"));
        assert_bool "C is not a parent" (not (is_parent field "C"));
        assert_bool "D is not a parent" (not (is_parent field "D"))
      );

    "iter_players" >:: (fun _ ->
        let player_names = ref [] in
        iter_players field (fun player ->
            player_names := player.Player.name :: !player_names
          );
        assert_equal ["D"; "C"; "B"; "A"] !player_names
      );

    "modify_each_player" >:: (fun _ ->
        let expected_players =
          List.map (fun p -> {p with Player.score = 25500}) (get_players field)
        in
        let modified_players =
          let modified_field =
            modify_each_player (Player.modify_score 500) field
          in
          get_players modified_field
        in
        assert_equal expected_players modified_players
      );
  ]
