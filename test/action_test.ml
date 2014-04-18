open OUnit2
open Mj
open Mj.Field

let field =
  Field.create ~init_score:25000
               ~east_name: "A"
               ~south_name:"B"
               ~west_name: "C"
               ~north_name:"D"

let suite =
  "Action" >::: [
    "tumo" >::: [
      "1 30" >:: (fun _ ->
          let modified_field = Action.tumo "A" 1 30 field in
          let player_A = get_player modified_field "A" in
          assert_equal 26500 player_A.Player.score;
          let player_B = get_player modified_field "B" in
          assert_equal 24500 player_B.Player.score
        );
    ];
  ]
