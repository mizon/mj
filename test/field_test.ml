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
  ]
